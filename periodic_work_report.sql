SELECT 
    ts.project AS "Project:Link/Project:120",
    ts.task_name AS "Task:Link/Task:120",
    ts.date AS "Date:Date:120",
    ts.uom AS "Unit:Link/UOM:120",
    ts.executed_quantity AS "Executed Quantity:120",
    ts.activity_total_cost AS "Executed Amount:120"
FROM 
    `tabTimesheet` ts
WHERE  
    ts.date >= %(from_date)s AND ts.date <= %(to_date)s;