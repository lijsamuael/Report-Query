SELECT 
	e.project AS "Project:Link/Project:100",
	e.name AS "Employee:Link/Employee:80",
	e.employee_name AS "Employee Name:80",
	e.salary AS "Basic Salary:Float:80",
	30 AS "Working Days",
	e.taxable_all AS "Taxable Allowance:Float:80",
	e.non_taxable_allowance AS "Non Taxable Allowance:Float:80",
    COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) AS "Perdiem Payment:Float:80",
    COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) AS "OT Payment:Float:80",
	(
		COALESCE(e.salary, 0) +
		COALESCE(e.taxable_all, 0) +
		COAL4ESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) +
		COALESCE(e.non_taxable_transport_all, 0) +
		COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0)
	
	) AS "Gross Earning:Float:80",
	(
		COALESCE(e.salary, 0) +
		COALESCE(e.taxable_all, 0) +
COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
	)  AS "Taxable Earning:Float:80",
	CASE
		WHEN (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 601 AND (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 1650 THEN ((COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.1) - 60
		WHEN (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 1650 AND (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 3200 THEN ((COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.15) - 142.5
		WHEN (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 3200 AND (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 5250 THEN ((COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.2) - 302.5
		WHEN (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 5250 AND (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 7800 THEN ((COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.25) - 565
		WHEN (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 7800 AND (
			COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 10900 THEN ((COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.3) - 955
		ELSE ((COALESCE(e.salary, 0) +
			COALESCE(e.taxable_all, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.35) - 1500
	END AS "Income Tax:Float:80",
	(e.salary * 0.07) AS "Pension Fund:Float:80",
	((e.salary * 0.07) + (
		CASE
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
				) > 601 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 1650 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.1) - 60
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 1650 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 3200 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.15) - 142.5
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 3200 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 5250 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.2) - 302.5
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 5250 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 7800 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.25) - 565
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 7800 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 10900 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.3) - 955
			ELSE ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.35) - 1500
		END
	)) AS "Total Deduction:Float:80",
	(
		(
				(
		COALESCE(e.salary, 0) +
		COALESCE(e.taxable_all, 0) +
		COALESCE(e.non_taxable_transport_all, 0) +
		COALESCE(ass.perdiem_in_birr, 0) +
		COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
	)
		) - (
			((e.salary * 0.07) + (
		CASE
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
				) > 601 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 1650 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.1) - 60
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 1650 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 3200 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.15) - 142.5
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 3200 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 5250 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.2) - 302.5
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 5250 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 7800 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.25) - 565
			WHEN (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 7800 AND (
				COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 10900 THEN ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.3) - 955
			ELSE ((COALESCE(e.salary, 0) +
				COALESCE(e.taxable_all, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.35) - 1500
		END
	))
		)
	) AS "Net Pay:Float:80"
	-- 	ass.payroll_date AS "Payroll Date:Date:80",
	-- MONTHNAME(ass.payroll_date) AS "Month:Data:80"
FROM
	`tabEmployee` e
LEFT JOIN 	
	`tabAdditional Salary` ass ON e.name = ass.employee
WHERE 
	e.status = "Active"
GROUP BY
    e.name;