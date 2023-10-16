--Original query
-- SELECT
--     so_item.item_code AS "Item Code:Link/Item:120",
--     so.customer AS "Customer:Link/Customer:130",
--     so.per_billed AS "Percent Amount Paid:Percent:100",
--     (100 - so.per_billed) AS "Remaining Amount in Percent:Percent:100",
--     so_item.base_amount AS "Amount:Currency:120",
--     so.base_grand_total AS "Grand Total:Currency:100",
--     so.base_grand_total * (so.per_billed / 100) AS "Collected Amount:Currency:100",
--     so.base_grand_total - (so.base_grand_total * (so.per_billed / 100)) AS "Remaining Amount:Currency:100",
--     so_item.qty AS "Qty:Data:100",
--     so_item.base_rate AS "Rate:Currency:120",
--     so.name AS "Sales Order:Link/Sales Order:120",
--     so.transaction_date AS "Transaction Date:Date:140",
--     so.grand_total AS "Total USD:Currency:100",
--     so.territory AS "Territory:Link/Territory:130",
--     so.project AS "Project:Link/Project:130",
--     IFNULL(so_item.delivered_qty, 0) AS "Delivered Qty:Float:120",
--     so.company AS "Company:Link/Company:"zz
-- FROM
--     `tabSales Order` so, `tabSales Order Item` so_item, `tabCustomer` cu
-- WHERE
--     so.name = so_item.parent AND so.customer = cu.name
--     AND so.docstatus = 1
-- ORDER BY so.name DESC;


-- SELECT
--     si.sales_partner as "Sales Partner:Link/Sales Partner:150",
-- 	sum(si.base_net_total) as "Invoiced Amount (Exclusive Tax):Currency:210",
-- 	sum(si.total_commission) as "Total Commission:Currency:150",
-- 	sum(si.total_commission)*100/sum(si.base_net_total) as "Average Commission Rate:Currency:170"
-- 	st.sales_partner as "Sales Person:Link/Sales Person:100",
-- 	st.allocated_percentage as "Commission(%):70",
-- 	st.allocated_amount as "Commission To Net Total:100"
  --  GROUP_CONCAT(DISTINCT st.allocated_percentage SEPARATOR ', ') AS "Commission(%):100"

-- FROM
-- 	`tabSales Invoice` si
-- WHERE
-- 	docstatus = 1 and ifnull(si.base_net_total, 0) > 0 and ifnull(si.total_commission, 0) > 0
-- GROUP BY
-- 	si.sales_partner
-- ORDER BY
-- 	"Total Commission:Currency:120"


SELECT
    so_item.item_code AS "Item Code:Link/Item:60",
    so.name AS "Sales Order:Link/Sales Order:60",
    so.customer AS "Customer:Link/Customer:130",
    so.base_grand_total AS "Grand Total Birr:Currency:130",
    CONCAT(so.currency, ' ', FORMAT(so.grand_total, 2)) AS "Total USD:140",
    so.currency AS "Currency:30",
    so.per_billed AS "Percent Amount Paid:Percent:50",
    CONCAT(so.currency, ' ', FORMAT(so.grand_total * (so.per_billed / 100), 2)) AS "Collected Amount:140",
    (100 - so.per_billed) AS "Remaining Amount in Percent:Percent:50",
    CONCAT(so.currency, ' ', FORMAT(so.grand_total - (so.grand_total * (so.per_billed / 100)), 2)) AS "Remaining Amount:140",
    so.transaction_date AS "Transaction Date:Date:100"
FROM
    `tabSales Order` so, `tabSales Order Item` so_item, `tabCustomer` cu
WHERE
    so.name = so_item.parent AND so.customer = cu.name
    AND so.docstatus = 1
ORDER BY so.name DESC;
