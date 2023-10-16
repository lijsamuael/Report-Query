SELECT
    cf.project AS "Project:Link/Project:100",
    cf.name AS "Contract No:Link/Contract Form:120",
	cf.contractor_name AS "Contractor Name:100",
	cf.start_date AS "Start Date:100",
	cf.end_date AS "End Date:100",
	cff.for_which_task AS "Activity/Task:Link/Task:100",
	cff.quantity AS "Quantity:Float:100",
	cff.rate AS "Rate:100",
	cff.amount AS "Amount:Float:100"	
FROM
    `tabContract Form` cf
LEFT JOIN
	`tabCFF` cff ON cf.name = cff.parent; 
