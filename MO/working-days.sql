SELECT 
	(SELECT COUNT(*) + 0 FROM `tabEmployee` WHERE status = "Active" AND e.employee_name >= employee_name) AS "No.",
	e.employee_name AS "Employee Name:150",
	e.project AS "Project:200",
	e.designation AS "Designation:200",
	e.working_days AS "Working Days:200",
	"" AS "Remark:200"
FROM
	`tabEmployee` e
WHERE 
	e.status = "Active"
ORDER BY
	e.employee_name;
