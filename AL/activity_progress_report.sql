SELECT
    tk.name AS "Task:Link/Task:150",
    tk.project AS "Project:Link/Project:150",
    ts.name AS "Timesheet:Link/Timesheet:150",
    tk.amount AS "Agreement Amount:Currency:120",
    SUM(ts.total_cost) AS "Executed Amount:Currency:100",
    tk.amount - SUM(ts.total_cost) AS "Remaining Amount:Currency:100",
    (SUM(ts.total_cost) / tk.amount) * 100 AS "Percentage Completed:Percent"
FROM
    `tabTask` tk
LEFT JOIN
    `tabTimesheet` ts ON tk.name = ts.task
GROUP BY
    tk.name
ORDER BY
    (SUM(ts.total_cost) / tk.amount) DESC,
    tk.project;
