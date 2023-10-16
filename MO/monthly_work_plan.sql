SELECT
    op.name AS "Plan:Link/Operational Plan:150",
    op.project AS "Project:Link/Project:120",
    pone.activity AS "Work/Task:Link/Task:120",
    pone.m_1 AS "Month 1:Float:120",
    pone.m_2 AS "Month 2:Float:120",
    pone.m_3 AS "Month 3:Float:120",
    pone.m_4 AS "Month 4:Float:120",
    pone.m_5 AS "Month 5:Float:120",
    pone.m_6 AS "Month 6:Float:120",
    ptwo.m_7 AS "Month 7:Float:120",
    ptwo.m_8 AS "Month 8:Float:120",
    ptwo.m_9 AS "Month 9:Float:120",
    ptwo.m_10 AS "Month 10:Float:120",
    ptwo.m_11 AS "Month 11:Float:120",
    ptwo.m_12 AS "Month 12:Float:120"
FROM 
    `tabOperational Plan` op
JOIN
    `tabOperational Plan Detail One` pone ON op.name = pone.parent
JOIN
    `tabOperational Plan Detail Two` ptwo ON op.name = ptwo.parent
GROUP BY 
	op.project, pone.activity;
