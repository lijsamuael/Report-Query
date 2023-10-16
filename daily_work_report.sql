SELECT 
	ts.project AS "Project:Link/Project:120",
	ts.task_name1 AS "Task:Link/Task:120",
	ts.unit AS "Unit:Link/UOM:120",
	ts.date AS "Date:120",
	ts.executed_quantity AS "Executed Quantity:120",
	ts.activity_total_cost AS "Executed Amount:120"
FROM 
	`tabDaily Plan` ts;


