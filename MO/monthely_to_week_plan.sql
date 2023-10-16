SELECT 
	mp.project AS "Project:Link/Project:120",
	wp.activity AS "Work/Task:Link/Task:120",
	wp.uom AS "UOM:Link/UOM:50",
	wp.planned_this_month AS "Planned Amount:Float:120",
	wp.w_1 AS "Week 1 Amount:Float:100",
	wp.w_2 AS "Week 2 Amount:Float:100",
	wp.w_3 AS "Week 3 Amount:Float:100",
	wp.w_4 AS "Week 4 Amount:Float:100"
FROM 
	`tabMonthly Plan` mp
JOIN
	`tabMonthly Plan Detail Week View` wp ON mp.name = wp.parent;