
-- ユーザーを指定してタスクを取得 --
SELECT task_id, task_name, importance, urgency, user_id, state_id,create_at,update_at
FROM public.tasks
WHERE user_id = 1;

-- emailからユーザーを取得 --
SELECT user_id, user_name, email, role
FROM public.users
WHERE email = 'taro123@example.com';

-- タスクテーブルとタスク状態テーブルをinner join して　タスクの状態を取得 --
SELECT task_id, task_name, importance, urgency, user_id,state_name,create_at,update_at
	FROM public.tasks
	INNER JOIN task_state on tasks.state_id = task_state.state_id
	WHERE user_id = 1;

