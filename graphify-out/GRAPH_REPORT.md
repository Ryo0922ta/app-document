# Graph Report - app-document  (2026-11-22)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 17 nodes · 18 edges · 5 communities (4 shown, 1 thin omitted)
- Extraction: 89% EXTRACTED · 11% INFERRED · 0% AMBIGUOUS · INFERRED: 2 edges (avg confidence: 0.9)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `ba7e9ea0`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Community 0
- Community 1
- Community 2
- Community 3
- Community 4

## God Nodes (most connected - your core abstractions)
1. `解答用紙GAS 基本設計` - 7 edges
2. `解答用紙エディタ 基本設計` - 6 edges
3. `解答用紙GAS 操作手順` - 4 edges
4. `解答用紙作成アプリのドキュメント` - 3 edges
5. `問題文解析と配置` - 3 edges
6. `問題文から大問を追加` - 2 edges
7. `問題文からの自動取込` - 2 edges
8. `パーツ編集パネル` - 1 edges
9. `出力シート` - 1 edges
10. `配置と削除時の照合` - 1 edges

## Surprising Connections (you probably didn't know these)
- `解答用紙作成アプリのドキュメント` --references--> `解答用紙GAS 基本設計`  [EXTRACTED]
  index.md → 基本設計/GAS/解答用紙GAS_基本設計.md
- `解答用紙作成アプリのドキュメント` --references--> `解答用紙エディタ 基本設計`  [EXTRACTED]
  index.md → 基本設計/next.js/解答用紙エディタ_基本設計.md
- `解答用紙作成アプリのドキュメント` --references--> `解答用紙GAS 操作手順`  [EXTRACTED]
  index.md → 基本設計/GAS/解答用紙GAS_操作手順.md
- `問題文から大問を追加` --semantically_similar_to--> `問題文解析と配置`  [INFERRED] [semantically similar]
  基本設計/GAS/解答用紙GAS_操作手順.md → 基本設計/GAS/解答用紙GAS_基本設計.md
- `問題文からの自動取込` --semantically_similar_to--> `問題文解析と配置`  [INFERRED] [semantically similar]
  基本設計/next.js/解答用紙エディタ_基本設計.md → 基本設計/GAS/解答用紙GAS_基本設計.md

## Communities (5 total, 1 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.40
Nodes (5): パーツ編集パネル, 出力シート, 解答用紙GAS 基本設計, 配置と削除時の照合, 配置データ

### Community 1 - "Community 1"
Cohesion: 0.40
Nodes (5): Fabricキャンバス, PDF出力, Word文書出力, レイアウトの永続化制約, 解答用紙エディタ 基本設計

### Community 2 - "Community 2"
Cohesion: 0.67
Nodes (3): 解答用紙作成アプリのドキュメント, 別シートで仕上げて印刷, 解答用紙GAS 操作手順

### Community 3 - "Community 3"
Cohesion: 0.67
Nodes (3): 問題文解析と配置, 問題文から大問を追加, 問題文からの自動取込

## Knowledge Gaps
- **10 isolated node(s):** `パーツ編集パネル`, `出力シート`, `配置と削除時の照合`, `配置データ`, `Fabricキャンバス` (+5 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 10 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `解答用紙GAS 基本設計` connect `Community 0` to `Community 2`, `Community 3`?**
  _High betweenness centrality (0.439) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `問題文解析と配置` (e.g. with `問題文から大問を追加` and `問題文からの自動取込`) actually correct?**
  _`問題文解析と配置` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `パーツ編集パネル`, `出力シート`, `配置と削除時の照合` to the rest of the system?**
  _10 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Why does `解答用紙エディタ 基本設計` connect `Community 1` to `Community 2`, `Community 3`?**
  _High betweenness centrality (0.431) - this node is a cross-community bridge._
- **Why does `解答用紙作成アプリのドキュメント` connect `Community 2` to `Community 0`, `Community 1`?**
  _High betweenness centrality (0.318) - this node is a cross-community bridge._