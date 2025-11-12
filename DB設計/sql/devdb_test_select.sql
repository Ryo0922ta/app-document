
-- ユーザーを指定してタスクを取得 --
SELECT task_id, task_name, importance, urgency, user_id, state_id,create_at,update_at
FROM public.tasks
WHERE user_id = 1;

-- タスクテーブルとタスク状態テーブルをinner join して　タスクの状態を取得 --
SELECT task_id, task_name, importance, urgency, user_id,state_name,create_at,update_at
	FROM public.tasks
	INNER JOIN task_state on tasks.state_id = task_state.state_id
	WHERE user_id = 1;

