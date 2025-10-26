-- =============================
-- ユーザーテーブル
-- =============================
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,         -- 自動連番（ユーザーID）
    user_name VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);

-- =============================
-- タスクステイトテーブル（状態マスタ）
-- =============================
CREATE TABLE task_state (
    state_id SERIAL PRIMARY KEY,        -- 自動連番（状態ID）
    state_name VARCHAR(10) NOT NULL
);

-- =============================
-- タスクテーブル
-- =============================
CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,         -- 自動連番（タスクID）
    task_name VARCHAR(50) NOT NULL,
    importance INTEGER,
    urgency INTEGER,
    user_id INTEGER NOT NULL,
    state_id INTEGER NOT NULL,          -- 状態を必須とする（マスタが固定ならNULL不要）
    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,              -- 親のusersが削除されたら関連タスクも削除
    CONSTRAINT fk_state
        FOREIGN KEY (state_id)
        REFERENCES task_state(state_id)
        ON DELETE RESTRICT              -- 状態削除を禁止（マスタ固定）
);

-- =============================
-- 外部キー用のインデックス
-- =============================
CREATE INDEX idx_tasks_user_id  ON tasks(user_id);
CREATE INDEX idx_tasks_state_id ON tasks(state_id);

-- 外部キー制約があると親テーブルで参照元のデータが削除されたとき
-- 該当するキーで一覧検索やjoinを行いデータをセレクトしたとき
-- などに素早くデータの取得ができる。indexがないと該当データ全てから条件に合うものを探すことになる。