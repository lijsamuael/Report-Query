SELECT 
	e.project AS "Project:Link/Project:100",
	e.employee_name AS "Employee Name:80",
	COALESCE(
		CASE 
			WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
			THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s , e.date_of_joining))
			ELSE e.salary
		END, 0
	)AS "Basic Salary:Float:70",
	CASE WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) > 30 THEN 30 ELSE DATEDIFF(%(payroll_date)s, e.date_of_joining) END AS "Working Days:Int:20",
	e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance
	AS "Taxable Allowance:Float:70",
	(e.non_taxable_transport_all + e.hardship_all + e.cash_indemnity_all + e.desert_allowance ) AS "Non Taxable Allowance:Float:70",
	 COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0) AS "Perdiem:Float:50",
	(CASE WHEN e.has_loan = 1 THEN (e.loan_to_be_paid_per_month) ELSE 0 END) AS "Loan:Float:50",
	 COALESCE(SUM(CASE WHEN ass.salary_component = 'Other Deduction' THEN ass.amount ELSE 0 END), 0) AS "Other Deduction:Float:50",

    COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) AS "OT Payment:Float:50",
	(
		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
		COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
		COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) +
		COALESCE(e.non_taxable_transport_all + e.hardship_all + e.cash_indemnity_all + e.desert_allowance + COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0), 0)
	) AS "Gross Earning:Float:80",
	(
				COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
		COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
	)  AS "Taxable Earning:Float:70",
	CASE
		WHEN (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 601 AND (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 1650 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.1) - 60
		WHEN (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 1650 AND (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 3200 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.15) - 142.5
		WHEN (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 3200 AND (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 5250 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.2) - 302.5
		WHEN (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 5250 AND (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 7800 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.25) - 565
		WHEN (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) > 7800 AND (
					COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
		) <= 10900 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.3) - 955
		ELSE ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
			COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
			COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.35) - 1500
	END AS "Income Tax:Float:80",
	 CASE WHEN e.pension = 0 THEN (e.salary * 0.07) ELSE 0 END AS "Pension Fund:Float:50",
	( (CASE WHEN e.pension = 0 THEN (e.salary * 0.07) ELSE 0 END) + (CASE WHEN e.cost_sharing = 1 THEN (e.salary * 0.1) ELSE 0 END) + (CASE WHEN e.has_loan = 1 THEN (e.loan_to_be_paid_per_month) ELSE 0 END)  + (CASE WHEN ass.salary_component = 'Penality' THEN ass.amount ELSE 0 END) + COALESCE(SUM(CASE WHEN ass.salary_component = 'Other Deduction' THEN ass.amount ELSE 0 END), 0) + (
		CASE
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +

				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
				) > 601 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 1650 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.1) - 60
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 1650 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 3200 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.15) - 142.5
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 3200 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 5250 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.2) - 302.5
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 5250 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 7800 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.25) - 565
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 7800 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 10900 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.3) - 955
			ELSE ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.35) - 1500
		END
	)) AS "Total Deduction:Float:70",
	(
	(
		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
		COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
		COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) +
		COALESCE(e.non_taxable_transport_all + e.hardship_all + e.cash_indemnity_all + e.desert_allowance + COALESCE(SUM(CASE WHEN ass.salary_component = 'Perdiem' THEN ass.perdiem_in_birr ELSE 0 END), 0), 0)
	) - (
	( (CASE WHEN e.pension = 0 THEN (e.salary * 0.07) ELSE 0 END) + (CASE WHEN e.cost_sharing = 1 THEN (e.salary * 0.1) ELSE 0 END) + (CASE WHEN e.has_loan = 1 THEN (e.loan_to_be_paid_per_month) ELSE 0 END)  + (CASE WHEN ass.salary_component = 'Penality' THEN ass.amount ELSE 0 END) + COALESCE(SUM(CASE WHEN ass.salary_component = 'Other Deduction' THEN ass.amount ELSE 0 END), 0) + (
		CASE
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
				) > 601 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 1650 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.1) - 60
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 1650 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 3200 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.15) - 142.5
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 3200 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 5250 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.2) - 302.5
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 5250 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 7800 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.25) - 565
			WHEN (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) > 7800 AND (
						COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) 
			) <= 10900 THEN ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.3) - 955
			ELSE ((		COALESCE(
			CASE 
				WHEN DATEDIFF(%(payroll_date)s, e.date_of_joining) < 30 
				THEN (e.salary / 26 * DATEDIFF(%(payroll_date)s, e.date_of_joining))
				ELSE e.salary
			END, 0
		) +
				COALESCE(e.mobile_all + e.house_all + e.responsibility_all + e.professional_all + e.dislocation_allowance  + e.fuel_all + e.project_all + e.other_allowance, 0) +
				COALESCE(SUM(CASE WHEN ass.salary_component = 'Overtime' THEN ass.ot_normal_amount + ass.ot_knight_amount + ass.ot_weekend_amount + ass.ot_holiday_amount ELSE 0 END), 0) ) * 0.35) - 1500
		END
	))
	) ) AS "Net Pay:Float:80",
	CASE 
        WHEN ass.payroll_date BETWEEN %(from_date)s AND %(payroll_date)s 
            THEN ass.payroll_date
        ELSE NULL
    END AS "Payroll Date: 80",
	"..................." As "Signiture"
FROM
	`tabEmployee` e
LEFT JOIN 	
	`tabAdditional Salary` ass ON e.name = ass.employee
WHERE 
    e.status = "Active"
    -- AND (
    --     (ass.payroll_date IS NULL)
    --     OR (ass.payroll_date >= %(from_date)s AND ass.payroll_date <= %(payroll_date)s)
    -- )
GROUP BY 
	e.name;