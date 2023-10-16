SELECT
    pc.project AS "Project:Link/Project:160",
	pc.contractor AS "Contractor Name:Link/Supplier:160",
	pc.previous_payments AS "Previous Payment:Float:160",
	pc.ret AS "Retention:Float:160",
	pc.totall_deduction AS "Deductions:Float:160",
	pc.main_contract_before_vat AS "Net Amount Before Vat:Float:160",
	pc.main_contract_inc_vat AS "Net Amount After Vat:Float:160"
FROM
    `tabPayment Certificate` pc;
