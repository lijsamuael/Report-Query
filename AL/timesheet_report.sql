SELECT
    ts.project AS "Project:Link/Project:100",
    ts.date AS "Date:120",
	ts.task AS "Activity/Task:Link/Task:100",
	ts.contractor AS "Contractor Name:Link/Supplier:100",
	ts.quantity_executed AS "Executed Quantity:Float:100", 
	ts.uom AS "UOM:Link/UOM:100",
	ts.billing_rate AS "Rate:100",
	ts.total_project_amount AS "Amount:Float:100"
FROM
    `tabTimesheet` ts;