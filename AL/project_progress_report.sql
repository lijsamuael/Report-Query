SELECT
    pr.name AS "Project:Link/Project:100",
    pr.total_consumed_material_cost AS "Agreement Amount:Currency:120",
    SUM(ts.total_cost) AS "Executed Amount:Currency:100",
	pr.total_consumed_material_cost - SUM(ts.total_cost) AS "Remaining Amount:Currency",
	(SUM(ts.total_cost)  /pr.total_consumed_material_cost ) * 100 AS "Percentage Completed:Percent"
FROM
    `tabProject` pr
JOIN
    `tabTimesheet` ts ON pr.name = ts.project
GROUP BY
    pr.name, pr.total_consumed_material_cost;
