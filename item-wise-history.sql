SELECT
    so_item.item_code AS "Item Code:Link/Item:60",
    item.site AS "Site:Link/Real Estate Site Master:100",
    so.name AS "Sales Order:Link/Sales Order:60",
    so.customer AS "Customer:Link/Customer:130",
    so.base_grand_total AS "Grand Total Birr:Currency:130",
    CONCAT(so.currency, ' ', FORMAT(so.grand_total, 2)) AS "Total USD:140",
    so.currency AS "Currency:30",
	so.conversion_rate AS "Exchange Rate: 50",
    so.per_billed AS "Percent Amount Paid:Percent:50",
    CONCAT(so.currency, ' ', FORMAT(so.grand_total * (so.per_billed / 100), 2)) AS "Collected Amount:140",
    (so.conversion_rate * (so.grand_total * (so.per_billed / 100))) AS "Collected Amount in Bir:Currency:140",
    (100 - so.per_billed) AS "Remaining Amount in Percent:Percent:50",
    CONCAT(so.currency, ' ', FORMAT(so.grand_total - (so.grand_total * (so.per_billed / 100)), 2)) AS "Remaining Amount:140",
	CONCAT(so.currency, ' ', FORMAT((so.base_grand_total - (so.base_grand_total * (so.per_billed / 100))), 2)) AS "Remaining Amount in Birr:Currency:140",
    so.transaction_date AS "Transaction Date:Date:100"
FROM
    `tabSales Order` so
JOIN
    `tabSales Order Item` so_item ON so.name = so_item.parent
JOIN
    `tabCustomer` cu ON so.customer = cu.name
JOIN
    `tabItem` item ON so_item.item_code = item.item_code
WHERE
    so.docstatus = 1
ORDER BY so.name DESC;
