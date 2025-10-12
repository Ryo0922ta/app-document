# データベース設計テンプレート

このディレクトリには、データベース設計ドキュメントのテンプレートファイルが含まれています。

## ディレクトリ構成

```
template/
├── css/
│   └── table-style-template.css    # テーブル表示用CSSテンプレート
├── markdown/
│   ├── 概念設計-template.md        # 概念設計テンプレート
│   ├── 論理設計-template.md        # 論理設計テンプレート
│   └── 物理設計-template.md        # 物理設計テンプレート
└── README.md                       # このファイル
```

## 使用方法

### 1. 新しいプロジェクト用のディレクトリを作成

```bash
mkdir your-project-name
cd your-project-name
mkdir css テーブル定義
```

### 2. テンプレートファイルをコピー

```bash
# CSSファイルをコピー
cp ../template/css/table-style-template.css css/table-style.css

# Markdownファイルをコピー
cp ../template/markdown/概念設計-template.md テーブル定義/00_概念設計.md
cp ../template/markdown/論理設計-template.md テーブル定義/01_論理設計.md
cp ../template/markdown/物理設計-template.md テーブル定義/03_物理設計.md
```

### 3. プレースホルダーを置換

各ファイル内の `{{プレースホルダー}}` を実際の値に置き換えてください。

#### 主要なプレースホルダー

- `{{PROJECT_NAME}}`: プロジェクト名
- `{{REQUIREMENTS}}`: 要件定義
- `{{ENTITIES}}`: エンティティ一覧
- `{{TABLE_RELATIONSHIPS}}`: テーブル間の関係性
- `{{TABLE_X_NAME}}`: テーブル名（日本語）
- `{{TABLE_X_ENGLISH_NAME}}`: テーブル名（英語）
- `{{COLUMN_X_NAME}}`: カラム名
- `{{COLUMN_X_TYPE}}`: データ型
- `{{COLUMN_X_CONSTRAINT}}`: 制約
- `{{COLUMN_X_DESCRIPTION}}`: カラム説明

## CSSクラス説明

### 基本クラス

- `.er-style`: ER図のテーブルスタイル
- `.er-grid-container`: ER図のグリッドレイアウト
- `.pk`: 主キー行の背景色（薄い青）
- `.width100`: テーブル幅100%

### パディングクラス

- `.table-width-padding400`: 右パディング400px
- `.table-width-padding200`: 右パディング200px
- `.table-width-padding100`: 右パディング100px

## カスタマイズ

### CSSのカスタマイズ

`table-style-template.css` の `{{CUSTOM_STYLES}}` 部分にプロジェクト固有のスタイルを追加できます。

### テーブル構造の追加

各Markdownテンプレートのコメント部分を参考に、必要なテーブルやカラムを追加してください。

## 注意事項

1. CSSファイルのパスは `../css/table-style.css` に設定されています
2. プレースホルダーは大文字小文字を区別します
3. テーブル構造を変更する場合は、対応するCSSクラスも確認してください
4. マスターテーブルのデータは実際の値に置き換えてください

## サンプルプロジェクト

このテンプレートは「図書館管理システム」のサンプルプロジェクトから作成されています。
実際の使用例は親ディレクトリの `テーブル定義/` フォルダを参照してください。
