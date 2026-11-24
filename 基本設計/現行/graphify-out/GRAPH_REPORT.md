# Graph Report - 10_private-dev  (2026-11-23)

## Corpus Check
- 9 files · ~5,888 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 121 nodes · 248 edges · 10 communities (9 shown, 1 thin omitted)
- Extraction: 76% EXTRACTED · 24% INFERRED · 0% AMBIGUOUS · INFERRED: 60 edges (avg confidence: 0.94)
- Token cost: 未計測（エージェントの実トークン数は取得できず）

## Community Hubs (Navigation)
- 画面要素と編集状態
- 初期データと日付形式
- 機能一覧とファイル入出力
- 交通費明細の業務フロー
- 表の表示と編集履歴
- 現行の構成と仕様
- テンプレート管理画面
- セルと列名の直接編集
- 行と列の追加
- テンプレートの検証と識別子

## God Nodes (most connected - your core abstractions)
1. `renderGrid()` - 18 edges
2. `現行機能一覧` - 13 edges
3. `CSV Editor README` - 11 edges
4. `現行業務フロー` - 11 edges
5. `setStatus()` - 10 edges
6. `現行基本設計` - 10 edges
7. `F07 テンプレートによる複数行追加` - 10 edges
8. `F08 テンプレート管理` - 9 edges
9. `saveState()` - 8 edges
10. `明細を確認・編集` - 8 edges

## Surprising Connections (you probably didn't know these)
- `テンプレートJSON形式` --semantically_similar_to--> `行追加テンプレートの構造`  [INFERRED] [semantically similar]
  csv-editor/csv_editor_app/README.md → app-document-practice/app-document/基本設計/現行/基本設計.md
- `openTemplateManager()` --implements--> `F08 テンプレート管理`  [INFERRED]
  csv-editor/csv_editor_app/web_csv_editor.html → app-document-practice/app-document/基本設計/現行/機能一覧.md
- `formatDateInputValue()` --implements--> `F07 テンプレートによる複数行追加`  [INFERRED]
  csv-editor/csv_editor_app/web_csv_editor.html → app-document-practice/app-document/基本設計/現行/機能一覧.md
- `parseDateInput()` --implements--> `F07 テンプレートによる複数行追加`  [INFERRED]
  csv-editor/csv_editor_app/web_csv_editor.html → app-document-practice/app-document/基本設計/現行/機能一覧.md
- `renderGrid()` --implements--> `F05 検索`  [INFERRED]
  csv-editor/csv_editor_app/web_csv_editor.html → app-document-practice/app-document/基本設計/現行/機能一覧.md

## Import Cycles
- None detected.

## Communities (10 total, 1 thin omitted)

### Community 0 - "画面要素と編集状態"
Cohesion: 0.08
Nodes (22): btnRedo, btnUndo, bulkColSelect, bulkModal, dataStats, dropzone, editingCell, exportModal (+14 more)

### Community 1 - "初期データと日付形式"
Cohesion: 0.13
Nodes (16): 初期CSVの列構成, 同梱の入力ルール資料, F01 初期データ読み込み, 通勤費（在宅）, 通勤費（通常勤務地）, 起動時のJSONファイル探索, 自動生成の日付形式 YYYY-MM-DD, CSV／TSVをダウンロード (+8 more)

### Community 2 - "機能一覧とファイル入出力"
Cohesion: 0.14
Nodes (17): 画面構成と機能ID, 現行機能一覧, F02 ファイル読み込み, F05 検索, F06 列の一括編集, F09 表の初期化, F11 CSV／TSV書き出し, CSV／TSV書き出し手順 (+9 more)

### Community 3 - "交通費明細の業務フロー"
Cohesion: 0.22
Nodes (16): 明細を追加, 期間入力の修正, 現行業務フロー, ファイルを書き出す, 明細を確認・編集, 日付列がない場合の再開, テンプレートがない場合の代替手順, 表を開く (+8 more)

### Community 4 - "表の表示と編集履歴"
Cohesion: 0.27
Nodes (16): F10 元に戻す・やり直す, createEmptySheet(), getColLetter(), importCSVFile(), loadSampleData(), onCellClick(), redo(), renameHeader() (+8 more)

### Community 5 - "現行の構成と仕様"
Cohesion: 0.21
Nodes (11): ブラウザアプリの構成とCDN依存, 現行基本設計, 期間指定の行生成条件, 編集中の表と履歴, 行追加テンプレートの構造, CSV Editor README, テンプレートJSON形式, 既存テンプレートでの行追加手順 (+3 more)

### Community 6 - "テンプレート管理画面"
Cohesion: 0.40
Nodes (5): addTemplateField(), escapeHTML(), openTemplateManager(), renderTemplateFields(), renderTemplateSelects()

### Community 7 - "セルと列名の直接編集"
Cohesion: 0.50
Nodes (4): Enterの画面表示と実装の差異, F03 セル・列名の編集, セル編集の確定・キー操作と列名変更, startInlineEdit()

### Community 8 - "行と列の追加"
Cohesion: 0.50
Nodes (4): F04 行・列の追加, 列追加ボタン, 行追加ボタン, 空行・空列の挿入

## Knowledge Gaps
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **F07 の複数行追加はどこで日付を生成し、入力ルールCSVや実際の出力形式とどう関係するか？**
  _現行仕様、日付生成の実装、同梱CSVの入力ルールを比較できる。_
- **Why does `現行業務フロー` connect `交通費明細の業務フロー` to `画面要素と編集状態`, `現行の構成と仕様`?**
  _High betweenness centrality (0.107) - this node is a cross-community bridge._
- **Should `画面要素と編集状態` be split into smaller, more focused modules?**
  _Cohesion score 0.08333333333333333 - nodes in this community are weakly interconnected._
- **Why does `現行基本設計` connect `現行の構成と仕様` to `画面要素と編集状態`, `初期データと日付形式`, `機能一覧とファイル入出力`, `セルと列名の直接編集`?**
  _High betweenness centrality (0.094) - this node is a cross-community bridge._
- **Should `初期データと日付形式` be split into smaller, more focused modules?**
  _Cohesion score 0.12631578947368421 - nodes in this community are weakly interconnected._
- **Why does `CSV Editor README` connect `現行の構成と仕様` to `画面要素と編集状態`, `初期データと日付形式`, `機能一覧とファイル入出力`, `交通費明細の業務フロー`?**
  _High betweenness centrality (0.086) - this node is a cross-community bridge._
- **Should `機能一覧とファイル入出力` be split into smaller, more focused modules?**
  _Cohesion score 0.13970588235294118 - nodes in this community are weakly interconnected._

## 抽出範囲と検証

- 指定された現行設計資料のフォルダとアプリのフォルダを解析した。参照パスは共通の親ディレクトリ `10_private-dev` からの相対パス。
- HTML 内の JavaScript を元の行番号のまま構文解析し、Markdown・HTML の意味抽出と統合した。標準検出に含まれない CSV 2 件と、AST がノードを生成しなかったテンプレート JSON 2 件は、列構成・入力ルール・テンプレート定義を元ファイルから追加した。
- 機能IDと実装の対応は、両方を比較した推定として記録した。実行時の動作は検証していない。
- 診断では欠落・未解決の端点は0件。同じノード対に複数の関係がある箇所は、可視化の集計で 31 本に相当する関係が重なる。JSON には元の関係を個別に保存した。自己ループは 1 件。
- 意味抽出はホストのエージェントで実行した。エージェントの実トークン数が取得できない場合、Graphify 集計の 0 は未計測を示す。
- 入力ルール CSV の日付指定は `yyyy/MM/dd`、複数行追加の生成値は `YYYY-MM-DD`。入力ルールが実行時の検証に使われる参照は確認できていない。
- 成果物は Git の作業ツリー内の `基本設計/現行/graphify-out/` に置くため、未追跡のファイルとして `git status` に表示される。
