# {{PROJECT_NAME}} - 論理設計

<link rel="stylesheet" href="../css/table-style.css">

## 1. {{TABLE_1_NAME}} ({{TABLE_1_ENGLISH_NAME}})

<div class="table-width-padding400">
<table class="er-style width100">
    <tr>
        <th>カラム名</th>
        <th>データ型</th>
        <th>制約</th>
        <th>説明</th>
    </tr>
    <tr class="pk">
        <td>{{COLUMN_1_NAME}}</td>
        <td>{{COLUMN_1_TYPE}}</td>
        <td>PK</td>
        <td>{{COLUMN_1_DESCRIPTION}}</td>
    </tr>
    <tr>
        <td>{{COLUMN_2_NAME}}</td>
        <td>{{COLUMN_2_TYPE}}</td>
        <td>{{COLUMN_2_CONSTRAINT}}</td>
        <td>{{COLUMN_2_DESCRIPTION}}</td>
    </tr>
    <!-- 追加カラムはここにコピーして編集 -->
</table>
</div>

## 2. {{TABLE_2_NAME}} ({{TABLE_2_ENGLISH_NAME}})

<div class="table-width-padding400">
<table class="er-style width100">
    <tr>
        <th>カラム名</th>
        <th>データ型</th>
        <th>制約</th>
        <th>説明</th>
    </tr>
    <tr class="pk">
        <td>{{COLUMN_3_NAME}}</td>
        <td>{{COLUMN_3_TYPE}}</td>
        <td>PK</td>
        <td>{{COLUMN_3_DESCRIPTION}}</td>
    </tr>
    <tr>
        <td>{{COLUMN_4_NAME}}</td>
        <td>{{COLUMN_4_TYPE}}</td>
        <td>{{COLUMN_4_CONSTRAINT}}</td>
        <td>{{COLUMN_4_DESCRIPTION}}</td>
    </tr>
    <!-- 追加カラムはここにコピーして編集 -->
</table>
<div>

## 3. {{TABLE_3_NAME}} ({{TABLE_3_ENGLISH_NAME}})

<div class="table-width-padding100">
<table class="er-style width100">
    <tr>
        <th>カラム名</th>
        <th>データ型</th>
        <th>制約</th>
        <th>説明</th>
    </tr>
    <tr class="pk">
        <td>{{COLUMN_5_NAME}}</td>
        <td>{{COLUMN_5_TYPE}}</td>
        <td>PK</td>
        <td>{{COLUMN_5_DESCRIPTION}}</td>
    </tr>
    <tr>
        <td>{{COLUMN_6_NAME}}</td>
        <td>{{COLUMN_6_TYPE}}</td>
        <td>{{COLUMN_6_CONSTRAINT}}</td>
        <td>{{COLUMN_6_DESCRIPTION}}</td>
    </tr>
    <!-- 追加カラムはここにコピーして編集 -->
</table>
</div>

## 4. {{TABLE_4_NAME}} ({{TABLE_4_ENGLISH_NAME}})

<div class="table-width-padding400">
<table class="er-style width100">
    <tr>
        <th>{{MASTER_COLUMN_1_NAME}}</th>
        <th>{{MASTER_COLUMN_2_NAME}}</th>
    </tr>
    <tr>
        <td>{{MASTER_DATA_1_ID}}</td>
        <td>{{MASTER_DATA_1_VALUE}}</td>
    </tr>
    <tr>
        <td>{{MASTER_DATA_2_ID}}</td>
        <td>{{MASTER_DATA_2_VALUE}}</td>
    </tr>
    <!-- 追加マスターデータはここにコピーして編集 -->
</table>
</div>

<!-- 
テンプレート使用時の置換項目:
- {{PROJECT_NAME}}: プロジェクト名
- {{TABLE_X_NAME}}: テーブル名（日本語）
- {{TABLE_X_ENGLISH_NAME}}: テーブル名（英語）
- {{COLUMN_X_NAME}}: カラム名
- {{COLUMN_X_TYPE}}: データ型（CHAR, VARCHAR, INTEGER, DATE, ENUM等）
- {{COLUMN_X_CONSTRAINT}}: 制約（NOT NULL, FK等）
- {{COLUMN_X_DESCRIPTION}}: カラム説明
- {{MASTER_COLUMN_X_NAME}}: マスターテーブルのカラム名
- {{MASTER_DATA_X_ID}}: マスターデータのID
- {{MASTER_DATA_X_VALUE}}: マスターデータの値
-->
