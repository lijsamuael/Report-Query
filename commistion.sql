SELECT
    so.sales_partner AS "Sales Partner:Link/Sales Partner:150",
    SUM(so.base_net_total) AS "Invoiced Amount (Exclusive Tax):Currency:210",
    SUM(so.total_commission) AS "Total Commission:Currency:150",
    SUM(so.total_commission) * 100 / SUM(so.base_net_total) AS "Average Commission Rate:Currency:170",
    GROUP_CONCAT(DISTINCT st.sales_person SEPARATOR ', ') AS "Sales Person:Link/Sales Person:100",
    GROUP_CONCAT(DISTINCT st.allocated_percentage SEPARATOR ', ') AS "Commission:100",
    GROUP_CONCAT(DISTINCT st.allocated_amount SEPARATOR ', ') AS "Contribution To Net Total:150"
FROM
    `tabSales Order` so
LEFT JOIN
    `tabSales Team` st ON so.name = st.parent
WHERE
    so.docstatus = 1
    AND IFNULL(so.base_net_total, 0) > 0
    AND IFNULL(so.total_commission, 0) > 0
GROUP BY
    so.sales_partner
ORDER BY
    "Total Commission:Currency:150";