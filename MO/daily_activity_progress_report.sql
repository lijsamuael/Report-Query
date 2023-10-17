SELECT 
	dpd.activity AS "Task:Link/Task:120",
	dpd.subject AS "Description:120",
	dp.date AS "Date:Date:120",
	dpd.uom AS "Unit:Link/UOM:50",
	tsk.quantity AS "Total Volume of Work:Float:150",
	tsk.quantity AS "Volume of work remaining:Float:150",
	tsk.quantity AS "Daily Minimum Target:Float:150",
	tsk.duration AS "Planned Duration:Float:150",
	dpd.planned_qty AS "Daily Volume of work Planned:Float:200",
	dpd.executed_qty AS "Daily Volume of work Executed:Float:200",
	dpd.percentage_executed AS "Percentage of Execution:Percent:200",
	"......" AS "Remarks:200"



FROM 
	`tabNew Daily Plan Detail` dpd
LEFT JOIN 
	`tabNew Daily Plan` dp ON dp.name = dpd.parent
LEFT JOIN 
	`tabTask` tsk ON tsk.name = dpd.activity;