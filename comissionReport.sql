SELECT
    sales_partner as "Sales Partner:Link/Sales Partner:150",
	sum(base_net_total) as "Invoiced Amount (Exclusive Tax):Currency:210",
	sum(total_commission) as "Total Commission:Currency:150",
	sum(total_commission)*100/sum(base_net_total) as "Average Commission Rate:Currency:170"
FROM
	`tabSales Invoice`
WHERE
	docstatus = 1 and ifnull(base_net_total, 0) > 0 and ifnull(total_commission, 0) > 0
GROUP BY
	sales_partner
ORDER BY
	"Total Commission:Currency:120"