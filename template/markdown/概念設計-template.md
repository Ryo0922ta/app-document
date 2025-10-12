# {{PROJECT_NAME}} - 概念設計

<link rel="stylesheet" href="../css/table-style.css">

## 要件

```markdown
{{REQUIREMENTS}}
```

## エンティティ

```markdown
{{ENTITIES}}
```

## テーブル間の関係性(概要)

```markdown
{{TABLE_RELATIONSHIPS}}
```

## ER図

<div class="er-grid-container">
{{ER_DIAGRAM_TABLES}}
</div>

<!-- 
テンプレート使用時の置換項目:
- {{PROJECT_NAME}}: プロジェクト名
- {{REQUIREMENTS}}: 要件定義
- {{ENTITIES}}: エンティティ一覧
- {{TABLE_RELATIONSHIPS}}: テーブル間の関係性
- {{ER_DIAGRAM_TABLES}}: ER図のテーブル定義

ER図テーブルの例:
<table class="er-style">
    <tr>
        <th colspan="3">{{TABLE_NAME}}</th>
    </tr>
    <tr>
        <td colspan="3" class="pk">{{PRIMARY_KEY}}</td>
    </tr>
    <tr>
        <td colspan="3">{{COLUMN_1}}</td>
    </tr>
    <tr>
        <td colspan="3">{{COLUMN_2}}</td>
    </tr>
</table>
-->
