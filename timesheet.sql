SELECT
    ts.task AS "Task:Link/Task:120",
    ts.name AS "Timesheet:Link/Timesheet:100",
    ts.project AS "Project:Link/Project:70",
    ts.start_date AS "Start Date:Date:100",
    ts.end_date AS "End Date:Date:100",
    FORMAT(tk.amount, 2) AS "Total Planned Amount:50",
    FORMAT(ts.manpower_total_cost + ts.material_total_cost + ts.machinery_total_cost, 2) AS "Total Actual Costs:50",
    FORMAT(ts.manpower_total_cost, 2) AS "Actual Man Power Total Cost:40",
    FORMAT(tk.total_man_power, 2) AS "Planed Man Power Total Amount:40",
    FORMAT(ts.machinery_total_cost, 2) AS "Actual Machinery Total Cost:40",
    FORMAT(tk.machinary_total_amount, 2) AS "Planed Machinery Total Amount:40",
    FORMAT(ts.material_total_cost, 2) AS "Actual Material Total Cost:40"

FROM
    `tabTimesheet` ts, `tabTask` tk
WHERE
    ts.task = tk.name;

-- UNION

-- SELECT
--     NULL,
--     NULL,
--     NULL,
--     NULL,
--     NULL,
--     FORMAT(SUM(tk.amount) OVER (), 2),
--     FORMAT(SUM(ts.manpower_total_cost + ts.material_total_cost + ts.machinery_total_cost) OVER (), 2),
--     FORMAT(SUM(ts.manpower_total_cost) OVER (), 2),
--     FORMAT(SUM(tk.total_man_power) OVER (), 2),
--     FORMAT(SUM(ts.machinery_total_cost) OVER (), 2),
--     FORMAT(SUM(tk.machinary_total_amount) OVER (), 2),
--     FORMAT(SUM(ts.material_total_cost) OVER (), 2)
-- FROM
--     `tabTimesheet` ts, `tabTask` tk
-- WHERE
--     ts.task = tk.name;
