#!/usr/bin/env bash

# このスクリプトと同じディレクトリにある対象リポジトリを、指定順に更新する。
TARGET_REPOS=("backend" "frontend" "command")

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P) || exit 1

declare -a original_branches results failure_reasons restore_results processed

for i in "${!TARGET_REPOS[@]}"; do
  original_branches[i]=""
  results[i]="未処理"
  failure_reasons[i]=""
  restore_results[i]="復帰対象なし"
  processed[i]=0
done

log_info() {
  printf '[INFO]  [%s] %s\n' "$1" "$2"
}

log_error() {
  printf '[ERROR] [%s] %s\n' "$1" "$2" >&2
}

current_branch() {
  local branch
  branch=$(git -C "$1" symbolic-ref --quiet --short HEAD 2>/dev/null) && [[ -n "$branch" ]] && {
    printf '%s' "$branch"
    return
  }
  printf '取得不可（detached HEADなど）'
}

add_failure() {
  local i=$1 message=$2
  results[i]="失敗"
  if [[ -n "${failure_reasons[i]}" ]]; then
    failure_reasons[i]+="／$message"
  else
    failure_reasons[i]="$message"
  fi
  log_error "${TARGET_REPOS[i]}" "$message"
}

restore_branch() {
  local i=$1 repo="$SCRIPT_DIR/${TARGET_REPOS[$1]}"
  local original="${original_branches[$1]}"

  if [[ -z "$original" || "$original" == main ]]; then
    return 0
  fi

  if [[ "$(current_branch "$repo")" == "$original" ]]; then
    restore_results[i]="元のブランチに復帰済み"
    return 0
  fi

  log_info "${TARGET_REPOS[i]}" "$original へ復帰"
  if git -C "$repo" checkout "$original"; then
    restore_results[i]="${original}へ復帰成功"
    log_info "${TARGET_REPOS[i]}" "${original}へ復帰成功"
    return 0
  fi

  restore_results[i]="復帰失敗"
  log_error "${TARGET_REPOS[i]}" "${original}への復帰失敗"
  return 1
}

print_summary() {
  local i success=0 failure=0 pending=0 repo

  for i in "${!TARGET_REPOS[@]}"; do
    case "${results[i]}" in
      成功) ((success += 1)) ;;
      失敗) ((failure += 1)) ;;
      *) ((pending += 1)) ;;
    esac
  done

  printf '\n成功（%d件）\n' "$success"
  for i in "${!TARGET_REPOS[@]}"; do
    [[ "${results[i]}" == 成功 ]] || continue
    printf '  %s  pull成功／%s\n' "${TARGET_REPOS[i]}" "${restore_results[i]}"
  done

  printf '\n失敗（%d件）\n' "$failure"
  for i in "${!TARGET_REPOS[@]}"; do
    [[ "${results[i]}" == 失敗 ]] || continue
    repo="$SCRIPT_DIR/${TARGET_REPOS[i]}"
    printf '  %s  %s／%s／終了時のブランチ: %s\n' \
      "${TARGET_REPOS[i]}" "${failure_reasons[i]}" \
      "${restore_results[i]}" "$(current_branch "$repo")"
  done

  if ((pending > 0)); then
    printf '\n未処理（%d件）\n' "$pending"
    for i in "${!TARGET_REPOS[@]}"; do
      [[ "${results[i]}" == 未処理 ]] && printf '  %s\n' "${TARGET_REPOS[i]}"
    done
  fi

  printf '\n作業ブランチに戻った一覧（mainの変更を取り込む場合は手動でmerge）\n'
  for i in "${!TARGET_REPOS[@]}"; do
    [[ "${original_branches[i]}" != "" && "${original_branches[i]}" != main ]] || continue
    [[ "${restore_results[i]}" == *復帰成功 || "${restore_results[i]}" == "元のブランチに復帰済み" ]] || continue
    printf '  %s  %s\n' "${TARGET_REPOS[i]}" "${original_branches[i]}"
  done
}

handle_signal() {
  local exit_code=$1 i repo
  trap - INT TERM HUP
  printf '\n' >&2
  log_error script '割り込みを受けました。ブランチの復帰を試みます'

  for i in "${!TARGET_REPOS[@]}"; do
    [[ "${processed[i]}" == 1 ]] || continue
    repo="$SCRIPT_DIR/${TARGET_REPOS[i]}"
    if [[ -n "${original_branches[i]}" && "${original_branches[i]}" != main ]]; then
      if [[ "$(current_branch "$repo")" != "${original_branches[i]}" ]]; then
        restore_branch "$i" || add_failure "$i" '割り込み後の復帰失敗'
      elif [[ "${restore_results[i]}" == 復帰待ち ]]; then
        restore_results[i]="元のブランチに復帰済み"
      fi
    fi
    if [[ "${results[i]}" == 処理中 ]]; then
      add_failure "$i" '割り込みにより更新未完了'
    fi
  done

  print_summary
  exit "$exit_code"
}

trap 'handle_signal 130' INT
trap 'handle_signal 143' TERM
trap 'handle_signal 129' HUP

if ((${#TARGET_REPOS[@]} == 0)); then
  log_error script '対象リポジトリ一覧が空です'
  exit 1
fi

for i in "${!TARGET_REPOS[@]}"; do
  repo="$SCRIPT_DIR/${TARGET_REPOS[i]}"
  processed[i]=1
  results[i]="処理中"
  log_info "${TARGET_REPOS[i]}" '確認を開始'

  if [[ ! -d "$repo" ]]; then
    add_failure "$i" '対象ディレクトリが存在しません'
    continue
  fi

  top=$(git -C "$repo" rev-parse --show-toplevel 2>/dev/null)
  if [[ -z "$top" || "$(cd "$top" 2>/dev/null && pwd -P)" != "$(cd "$repo" && pwd -P)" ]]; then
    add_failure "$i" '対象ディレクトリはGitリポジトリのルートではありません'
    continue
  fi

  original=$(git -C "$repo" symbolic-ref --quiet --short HEAD 2>/dev/null)
  if [[ -z "$original" ]]; then
    add_failure "$i" '現在のブランチを記録できません（detached HEADなど）'
    continue
  fi
  original_branches[i]="$original"

  if ! git -C "$repo" show-ref --verify --quiet refs/heads/main; then
    add_failure "$i" 'ローカルのmainブランチがありません'
    continue
  fi
  if ! git -C "$repo" remote get-url origin >/dev/null 2>&1; then
    add_failure "$i" 'originリモートがありません'
    continue
  fi

  if [[ "$original" == main ]]; then
    restore_results[i]="実行開始時からmain"
  else
    log_info "${TARGET_REPOS[i]}" 'mainへ切り替え'
    if ! git -C "$repo" checkout main; then
      add_failure "$i" 'mainへの切り替え失敗'
      if [[ "$(current_branch "$repo")" != "$original" ]]; then
        restore_branch "$i" || add_failure "$i" '元のブランチへの復帰失敗'
      else
        restore_results[i]="元のブランチを維持"
      fi
      continue
    fi
    restore_results[i]="復帰待ち"
  fi

  log_info "${TARGET_REPOS[i]}" 'git pull origin main'
  if git -C "$repo" pull origin main; then
    results[i]="成功"
    log_info "${TARGET_REPOS[i]}" 'pull成功'
  else
    add_failure "$i" 'pull失敗'
    if [[ "$original" != main ]]; then
      restore_branch "$i" || add_failure "$i" '元のブランチへの復帰失敗'
    fi
  fi
done

for i in "${!TARGET_REPOS[@]}"; do
  [[ "${results[i]}" == 成功 && "${original_branches[i]}" != main ]] || continue
  restore_branch "$i" || add_failure "$i" '元のブランチへの復帰失敗'
done

print_summary
for i in "${!TARGET_REPOS[@]}"; do
  [[ "${results[i]}" == 成功 ]] || exit 1
done
exit 0
