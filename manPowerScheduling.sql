SELECT
    dp.project AS "Project:Link/Project:100",
    dp.task_name1 AS "Task:Link/Task:120",
    dp.date AS "Date:Date:100",
    dp.name AS "Daily Plan:Link/Daily Plan:100",
    ts.name AS "Timesheet:Link/Timesheet:100",
    dp_md.id_map AS "Man Power:Link/Manpower:100",
    dp_md.job_title AS "Job Title:Link/Task:100",
    dp_md.qty AS "Planned Quantity:Float:120",
    ts_md.qty AS "Actual Quantity:Float:120",
    (dp_md.qty - ts_md.qty) AS "Remaining Quantity:Float:120",
    dp_md.total_hourly_cost AS "Planned Total Cost:Currency:120",
    ts_md.total_hourly_cost AS "Actual Total Cost:Currency:120",
    (dp_md.total_hourly_cost - ts_md.total_hourly_cost) AS "Remaining Cost:Currency:120",
    (CASE
        WHEN dp_md.total_hourly_cost != 0 THEN ((dp_md.total_hourly_cost - ts_md.total_hourly_cost) / dp_md.total_hourly_cost) * 100
        ELSE 0
    END) AS "Remaining Percentage:Percent:120"

FROM
    `tabDaily Plan` dp
INNER JOIN
    `tabTimesheet` ts ON dp.date = ts.date
LEFT JOIN
    `tabManpower Detail` dp_md ON dp.name = dp_md.parent
LEFT JOIN
    `tabManpower Detail` ts_md ON ts.name = ts_md.parent AND dp_md.job_title = ts_md.job_title;

