SELECT
    dp.project AS "Project:Link/Project:100",
    md.id_mat AS "Material Name:Link/Task:150",
    dp.task_name1 AS "Task:Link/Task:120",
	md.uom AS "Unit:Link/UOM",
    dp.date AS "Date:Date:100",
    md.qty AS "Planned Quantity:Float:120",
    md.unit_price AS "Unit Price:120",
    md.total_cost AS "Planned Amount:Currency:120"
FROM
    `tabDaily Plan` dp
JOIN
    `tabMaterial Detail` md ON dp.name = md.parent
WHERE  
    dp.date >= %(from_date)s AND dp.date <= %(to_date)s;
