# `update-main.sh` 簡易テストケース

参照：[cliの設計.md](cliの設計.md)（4.3、5.2、6章）、[update-main-手順別コード対応.md](update-main-手順別コード対応.md)  
対象：[update-main.sh](update-main.sh)

この文書は、スクリプト全体の動作を一時的な Git リポジトリで確かめるための手順書。各ケースは**共通準備から独立して**実施する。結果欄には実施後に確認した内容を記入する。

## 共通準備

1. `update-main.sh` があるディレクトリで、次を実行する。一時ディレクトリ内のローカル bare リポジトリを `origin` に使うため、ネットワーク接続や実際の対象リポジトリは不要。

   ```bash
   TEST_ROOT=$(mktemp -d)
   cp ./update-main.sh "$TEST_ROOT/update-main.sh"

   for name in backend frontend command; do
     git init -q --bare "$TEST_ROOT/$name-origin.git"
     git init -q "$TEST_ROOT/$name"
     git -C "$TEST_ROOT/$name" checkout -q -b main
     git -C "$TEST_ROOT/$name" config user.name 'Test User'
     git -C "$TEST_ROOT/$name" config user.email 'test@example.invalid'
     printf '%s\n' "$name" > "$TEST_ROOT/$name/file.txt"
     git -C "$TEST_ROOT/$name" add file.txt
     git -C "$TEST_ROOT/$name" commit -q -m initial
     git -C "$TEST_ROOT/$name" remote add origin "$TEST_ROOT/$name-origin.git"
     git -C "$TEST_ROOT/$name" push -q -u origin main
   done
   ```

2. 各ケースの「追加準備」を行い、次の形で実行する。`TEST_ROOT` は同じシェルで使う。

   ```bash
   bash "$TEST_ROOT/update-main.sh"
   result=$?
   printf '終了コード: %s\n' "$result"
   ```

3. ブランチは `git -C "$TEST_ROOT/backend" branch --show-current` のように確認する。別ケースへ進むときは、新しい一時ディレクトリで共通準備をやり直す。

## 基本ケース

| ID | 対応手順 | 追加準備と実行 | 期待結果 |
| --- | --- | --- | --- |
| T01 | ①③④⑥ | 3対象で `git -C "$TEST_ROOT/名前" checkout -q -b feature/test` を行ってから実行 | 指定順に3対象の `pull` が成功する。最後にすべて `feature/test` に戻る。「成功（3件）」、終了コード `0`。 |
| T02 | ③④ | 追加準備なし。3対象とも `main` のまま実行 | ブランチ切り替えをせず3対象の `pull` が成功する。「実行開始時からmain」が表示され、終了コード `0`。 |
| T03 | ① | 一時コピーの `TARGET_REPOS=(...)` を `TARGET_REPOS=()` に変更して実行 | 「対象リポジトリ一覧が空です」と表示して終了コード `1`。`pull` は行わない。 |
| T04 | ② | `mv "$TEST_ROOT/frontend" "$TEST_ROOT/frontend-hidden"` の後に実行 | `frontend` はディレクトリ不在として失敗する。`backend` と `command` は処理される。「成功（2件）」「失敗（1件）」、終了コード `1`。 |
| T05 | ② | `git -C "$TEST_ROOT/frontend" remote remove origin` の後に実行 | `frontend` は `origin` 不在として失敗し、ほかの2対象は更新される。終了コード `1`。 |
| T06 | ② | `frontend` で `git checkout -q -b feature/test`、次に `git branch -D main` を実行してからスクリプトを実行 | `frontend` はローカル `main` 不在として失敗する。`feature/test` は維持され、ほかの2対象は更新される。終了コード `1`。 |
| T07 | ⑤ | `frontend` で `git checkout -q -b feature/test`。空の bare リポジトリを `git init -q --bare "$TEST_ROOT/empty-origin.git"` で作り、`git -C "$TEST_ROOT/frontend" remote set-url origin "$TEST_ROOT/empty-origin.git"` を実行 | `frontend` の `pull` は失敗し、**次の対象を処理する前に** `feature/test` に戻る。`command` も処理される。「pull失敗／feature/testへ復帰成功」、終了コード `1`。Git の詳細エラーはターミナルで確認する。 |

T01 の「名前」には `backend`、`frontend`、`command` を順に入れる。T06 と T07 の追加準備は、共通準備直後の状態から行う。

## 要検証：未コミット変更

設計書は未コミット変更だけでは事前に失敗とせず、`stash` や変更の破棄を行わないとしている。次の2ケースでは、スクリプトの検証段階と Git の切り替え結果を分けて確認する。

| ID | 対応手順 | 追加準備と実行 | 期待結果 |
| --- | --- | --- | --- |
| T08 | ②③④⑥ | `backend` で `git checkout -q -b feature/test`。その後 `printf 'local\n' > "$TEST_ROOT/backend/local.txt"` で未追跡ファイルを作って実行 | 未追跡ファイルがあるだけでは事前に失敗しない。`checkout main` と `pull` が成功すれば `feature/test` に戻り、`local.txt` は残る。全対象成功なら終了コード `0`。 |
| T09 | ②③ | `backend` で `git checkout -q -b feature/test`、`file.txt` を変更してコミットする。さらに `file.txt` を別の内容に未コミットのまま変更して実行 | `checkout main` を Git が拒否した場合、`backend` は「mainへの切り替え失敗」となる。未コミット変更は残り、`backend` は `feature/test` のまま。ほかの対象を処理し、終了コード `1`。 |

T09 の準備例：`feature/test` で `printf 'feature\n' > file.txt`、`git add file.txt`、`git commit -m feature` の順に行い、最後に `printf 'local\n' > file.txt` とする。これらの Git コマンドは `backend` ディレクトリ内で実行する。

## 追加の仕込みが必要なケース

| ID | 対応手順 | 追加準備と実行 | 期待結果 |
| --- | --- | --- | --- |
| T10 | ⑥ | `backend` を `feature/test` で開始する。テスト用の `git` ラッパーを `PATH` の先頭に置き、`backend` の **復帰時だけ** `checkout feature/test` を終了コード `1` にし、それ以外は実際の `git` に委譲して実行 | `backend` の `pull` は成功しても、最終結果は「失敗」。結果一覧に「元のブランチへの復帰失敗」と終了時のブランチ `main` が表示され、終了コード `1`。強制切り替えは行われない。 |
| T11 | 6.3 割り込み | `backend` と `frontend` を `feature/test` で開始する。テスト用 `git` ラッパーで `frontend` の `pull` を一時停止し、その間にスクリプトへ `TERM` を送る | 新たに `command` の更新を始めない。必要なブランチ復帰を試み、「未処理（1件）」と `command` を表示する。復帰できた対象は元のブランチにいる。`TERM` による終了コードは `143`。 |

T10・T11 は失敗や中断の時点を制御するためのケース。ラッパーは一時ディレクトリ内に置き、実際の `git` コマンドや利用中のリポジトリを変更しない。T11 の割り込みで復帰を Git が拒否した場合は、失敗と終了時のブランチが表示されることも確認する。

## 実施記録

| ID | 結果（未実施／OK／NG） | メモ |
| --- | --- | --- |
| T01〜T07 | 未実施 | |
| T08〜T09（要検証） | 未実施 | |
| T10〜T11 | 未実施 | |
