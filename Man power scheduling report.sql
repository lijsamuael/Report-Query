SELECT
    dp.project AS "Project:Link/Project:100",
    md.job_title AS "Man Power Title:Link/Task:150",
    dp.task_name1 AS "Task:Link/Task:120",
    dp.date AS "Date:Date:100",
    md.qty AS "Planned Quantity:Float:120",
    dp.man_power_unit_rate AS "Rate:120",
    md.total_hourly_cost AS "Planned Amount:Currency:120"
FROM
    `tabDaily Plan` dp
JOIN
    `tabManpower Detail` md ON dp.name = md.parent
WHERE  
    dp.date >= %(from_date)s AND dp.date <= %(to_date)s;
