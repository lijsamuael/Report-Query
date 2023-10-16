SELECT 
	dp.project AS "Project:Link/Project:120",
	dp.task_name1 AS "Task:Link/Task:120",
	dp.date AS "Date:Date:120",
	dp.unit AS "Unit:100",
	dp.quantity AS "Planned Quantity:100",
	dp.activity_total_cost AS "Planned Amount:100"
FROM 
	`tabDaily Plan` dp
WHERE 
	dp.date >= %(from_date)s AND dp.date <= %(to_date)s;