SELECT
    uc.employee_name AS "Employee:Link/Employee:120",
	uc.project AS "Project:Link/Project:120",
	uc.date AS "Date:120",
	uc.checked_by AS "Checked by:Link/Employee:120",
	uc.approved_by AS "Approved by:Link/Employee:120",
    uc.name1 AS "Full Name:250",
    uci.item AS "Item Name:Link/Item:100",
	uci.warehouse AS "Warehouse:Link/Warehouse:120",
    uc.card_code AS "Card Code:100",
    SUM(CASE WHEN uc.purpose = 'Take' THEN uci.qty ELSE 0 END) AS "Taken Quantity:100",
    SUM(CASE WHEN uc.purpose = 'Receive' THEN uci.qty ELSE 0 END) AS "Returned Quantity:100",
    SUM(CASE WHEN uc.purpose = 'Take' THEN uci.qty ELSE 0 END) - SUM(CASE WHEN uc.purpose = 'Receive' THEN uci.qty ELSE 0 END) AS "Remaining Quantity:100"
FROM
    `tabUser Card` uc
INNER JOIN
    `tabUser Card Item` uci ON uc.name = uci.parent
GROUP BY
    uc.card_code, uc.employee_name, uc.name1, uci.item
ORDER BY
    uc.card_code, uci.item;