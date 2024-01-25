USE Employees
--Case Study

--List the full names of the cashiers and what city each lives in. 
--Sort the results by city. Assume that you do not know the job code when
--formulating your SQL statement.

SELECT FirstName, LastName, City  FROM Employee, Job 
WHERE Employee.JobCode=Job.JobCode AND Job.[Description] ='Cashier'
ORDER BY City ASC

--Display the total amount of earnings for Ashley O’Day during the pay period 
--that ended on 30 May 2003. Assume that you do not know Ashley’s employee ID when 
--formulating your SQL statement. Don’t forget about her OT earnings too

SELECT  SUM(Earnings.RegEarnings) AS 'Regular Earnings' , SUM(Earnings.OTimeEarnings)
AS 'Sum of WorkHour' FROM Employee, Earnings 
WHERE  Earnings.EmpID=Employee.EmpID AND
LastName='O''Day' AND Earnings.PayWeekEndDate='2003-05-30'
 
--What are the social insurance number and employee ID of employees who paid more 
--than $150 income tax during the pay period that ended on 23 May 2003?
SELECT Employee.EmpID, Employee.[Sin], Deductions.IncomeTax FROM Employee, Deductions WHERE 
Deductions.EmpID=Employee.EmpID AND Deductions.IncomeTax > 150
AND Deductions.PayWeekEndDate = '2003-05-23'

--What are the full names of employees who have earned money? Eliminate duplicate names
SELECT DISTINCT Employee.FirstName +' '+ Employee.LastName AS 'Full Name'
 FROM Employee, Earnings WHERE 
 RegEarnings IS NOT NULL

--What are the job descriptions of employees who contributed more than $10 to the 
--pension plan during the pay period that ended on 23 May 2003?

SELECT Employee.EmpID, Job.[Description],Deductions.PensionPlan FROM 
Employee, Job, Deductions WHERE Deductions.EmpID =Employee.EmpID AND Deductions.PensionPlan>10 AND
Deductions.PayWeekEndDate='2003-05-23'

--List the full name of employees who received pay for the pay period that ended 
--on 23 May 2003 but did not pay any income tax
SELECT Employee.FirstName +' '+ Employee.LastName AS 'Full Name', Deductions.IncomeTax
FROM Employee, Deductions WHERE Deductions.EmpID =Employee.EmpID AND Deductions.IncomeTax IS NULL
AND Deductions.PayWeekEndDate='2003-05-23'

--Display each employee’s full name and net (ie. after deductions) 
--pay for the pay period that ended on 30 May 2003.
SELECT FirstName + ' ' + LastName AS 'Full Name',
SUM (Earnings.RegEarnings + Earnings.OTimeEarnings)
- SUM (Deductions.EI+Deductions.CPP+Deductions.UnionDues+Deductions.PensionPlan+ ISNULL(Deductions.IncomeTax,0)) AS 'Net Income'
FROM Employee,Earnings,Deductions WHERE Deductions.EmpID=Earnings.EmpID AND Employee.EmpID=Earnings.EmpID
AND Deductions.PayWeekEndDate='2003-05-30'
GROUP BY FirstName + ' ' + LastName 


SELECT * FROM Deductions
SELECT * FROM Earnings
SELECT * FROM Employee
SELECT * FROM Job
SELECT * FROM Timesheet
--List every single employee of our company and the pay period and number of regular hours he 
--or she worked each pay period. Sort your records according to employee surname
SELECT Employee.EmpID, Timesheet.PayWeekEndDate, Timesheet.RegHours FROM 
Employee, Timesheet WHERE Employee.EmpID= Timesheet.EmpID ORDER BY Employee.LastName ASC

--Create a view called RegEarningsVU. Use all the columns 
--in the Earnings table except the OtimeEarnings column

CREATE VIEW RegEarningsVU 
AS
	SELECT Earnings.EmpID , Earnings.PayWeekEndDate, Earnings.RegEarnings
	FROM Earnings

SELECT * FROM Deductions
SELECT * FROM Earnings
SELECT * FROM Employee
SELECT * FROM Job
SELECT * FROM Timesheet

--Show all the data in RegEarningsVU. Then insert a record into the Earnings table and display
--again all the data in RegEarningsVU. Did you notice any changes in the view’s data? Explain your answer.
SELECT* FROM RegEarningsVU
--RegEarningsVU was updated to store the new data entry



--Create a view called PayrollMay30VU that displays the following columns from the Earnings and
--the Deductions tables: Empid as “Employee ID” Regearnings as “Regular Earnings” 
--Otimeearnings as “Overtime Earnings” The sum of the EI, CPP, uniondues, pensionplan, 
--incometax columns as “Total Deductions”

CREATE VIEW PayrollMay30VU
AS
	SELECT d.EmpID AS 'Employee ID', e.RegEarnings AS 'Regular Earnings',e.OTimeEarnings 
	AS 'Overtime Earnings', d.EI + d.CPP + d.UnionDues + d.PensionPlan + ISNULL(IncomeTax,0) AS
	'Total Deductions' 
	FROM Earnings e, Deductions d
	WHERE e.EmpID=d.EmpID AND e.PayWeekEndDate=d.PayWeekEndDate AND d.PayWeekEndDate='2003-05-30'
	