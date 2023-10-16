SELECT
    cf.project AS "Contract Amount:Float:100",
    cf.name AS "Contract No:Link/Contract Form:120",
    cf.contractor_name AS "Contractor Name:100",
    cff.for_which_task AS "Activity/Task:Link/Task:100",
    cff.quantity AS "Contract Quantity:Float:100",
    cff.amount AS "Contract Amount:Float:100",
    pr_cff.quantity AS "executed  Quantity:Float:100",
    pr_cff.amount AS "Executed Amount:Float:100",
	pr_cff.amount AS "Percentage of Work:Percent:100"
FROM
    `tabContract Form` cf
LEFT JOIN
    `tabCFF` cff ON cf.name = cff.parent
LEFT JOIN (
    SELECT
        cff.parent AS parent,
        cff.quantity AS quantity,
        cff.amount AS amount
    FROM
        `tabPayment Request For Contract` pr
    LEFT JOIN
        `tabCFF` cff ON pr.contract_no = cff.name
) pr_cff ON cf.name = pr_cff.parent;
