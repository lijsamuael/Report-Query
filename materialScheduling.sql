SELECT
	dp.project AS "Project:Link/Project:120",
    dp.task_name1 AS "Task:Link/Task:120",
	dp.date AS "From Date:100",
	dp.date AS "To Date:100",
    dp.name AS "Daily Plan:Link/Daily Plan:120",
    ts.task_name AS "Task:Link/Task:100",
    dp_md.item1 AS "Item:Link/Item:120",
    dp_md.uom AS "UOM:Link/UOM:120",
    dp_md.unit_price AS "Unit Price:Currency:120",
    dp_md.qaty AS "Planned Quantity (DP):Float:120",
    ts_md.qaty AS "Actual Quantity (TS):Float:120",
    (dp_md.qaty - ts_md.qaty) AS "Remaining Quantity:Float:120",
    dp_md.total_cost AS "Planned Total Cost (DP):Currency:120",
    ts_md.total_cost AS "Actual Total Cost (TS):Currency:120",
    (dp_md.total_cost - ts_md.total_cost) AS "Remaining Cost:Currency:120"

FROM
    `tabDaily Plan` dp
INNER JOIN
    `tabTimesheet` ts ON dp.date = ts.date
LEFT JOIN
    (SELECT parent, uom, unit_price, item1, qaty, total_cost FROM `tabMaterial Detail`) dp_md ON dp.name = dp_md.parent
LEFT JOIN
    (SELECT parent, uom, unit_price, item1, qaty, total_cost FROM `tabMaterial Detail`) ts_md ON ts.name = ts_md.parent AND dp_md.item1 = ts_md.item1;
