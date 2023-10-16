SELECT
    dp.project AS "Project:Link/Project:100",
    md.id_mac AS "Material Name:Link/Machinery:150",
    dp.task_name1 AS "Task:Link/Task:120",
    dp.date AS "Date:Date:100",
    md.qty AS "Planned Quantity:Float:120",
    md.efficency AS "Rate:120",
    md.total_hourly_cost AS "Planned Amount:Currency:120"
FROM
    `tabDaily Plan` dp
JOIN
    `tabMachinery Detail2` md ON dp.name = md.parent
WHERE  
    dp.date >= %(from_date)s AND dp.date <= %(to_date)s;
