USE Employees
--Case Study

/*1. Display each employee’s surname, hire date, and the number of years 
that have elapsed between the system’s date and the hire date
for each employee. Show the number of years without any fractional
values. Do not round the number of years. Assume a year has
365.25 days to account for leap years. Use “Surname”, “Hire Date”, 
and “Years” as column headings.*/

SELECT LastName AS 'Surname' , HireDate AS 'Hire Date', 
DATEDIFF(YEAR, HireDate,GETDATE()) AS 'Years' FROM Employee

/*2. Show the current date and time using the 24-hour clock in a column labeled 
“Now”. Break this data down into 4 columns. One that
contains the current year, one for month, and one for time, in 12-hour format. */

SELECT GETDATE() AS 'Now', YEAR(GETDATE()) AS 'Year', MONTH(GETDATE()) AS 'Month', 
 FORMAT(CAST(GETDATE() AS TIME),N'hh\:mm') AS 'Time'

/*3. Write a SELECT statement that displays the following information in 4 columns: 
regular earnings, a second column labeled “Increase Regular” showing regular earnings 
after they’ve been increased by 4%, overtime earnings, and in the fourth column labeled 
“Increase Overtime” display the overtime earnings after they’ve been increased by 4%. Round
the increased regular and overtime earnings to two decimal places.*/


SELECT RegEarnings, CAST(RegEarnings * 0.04 AS DECIMAL(10,2)) AS 'Increase Regular', OTimeEarnings,
CAST(OTimeEarnings * 0.04 AS DECIMAL(10,2)) AS 'Increase OverTime' FROM Earnings

/*4. You have the task of arranging transportation for all the employees to the 
company’s picnic site. You have at your disposal a number of company-owned cars. 
Each car can seat 5 employees at the most. If the cars aren’t filled, the remaining
employees must take a taxi to the picnic. Display the total number of employees in 
the “Employees” column, the number of company cars required to transport the employees
in the “Cars” column, and the number of employees who will have to take a taxi in the “Taxi”
column. Do not round the number of employees and do not display any fractional values for the number of employees and cars */

SELECT COUNT(*) AS Employee, COUNT(*)/5 AS 'Cars',COUNT(*) % 5 AS Taxi FROM  Employee

/* 5. Display each employee’s surname and in the second column whether or not his or her 
phone number is local or long distance. Use the CASE Statement to display either
“Local Calling” for employees who live in Moose Jaw, or “Long Distance” for employees living
elsewhere. The second column should be labeled “Calling Area”. This question does not 
require you to add a Phone column to the Employee table.*/
SELECT LastName, CASE
 WHEN City = 'Moose Jaw' THEN 'Local Calling'
 ELSE 'Long Distance'
 END AS 'Calling Area'
 FROM Employee

 /* 6. Display the postal code in the Employee table in two parts with the & symbol between 
 the two parts of the postal code like this: S6H & 1X7. There should be a blank space on each
 side of the ampersand. Name this column “Break up”.*/
 SELECT CONCAT(LEFT(PostalCode,3),' ','&',' ',RIGHT(PostalCode,3)) AS 'Breakup' FROM Employee

/*7. Write a query that produces the following sentence for each employee: <Lastname> earns 
$<payrate> an hour but wants $<3 times payrate.> (omit the brackets but include the final
period). Label this column “Dream Pay”, include single spaces between each word, and
display the $ symbol in front of the figures for the pay rate and the dream pay*/

SELECT * FROM Earnings
SELECT * FROM Employee
SELECT * FROM Job
SELECT * FROM Timesheet

SELECT CONCAT(e.LastName,' earns ', FORMAT(j.PayRate, 'C'),' an hour but wants ', FORMAT(j.PayRate*3,'C')) AS 'Dream Pay'FROM Employee e, Job j
WHERE j.JobCode=e.JobCode

/*8. Suppose you are preparing a report and are having difficulty fitting columns within a limited
space on the report. You have only 6 characters to work with. Write the SQL code to find whether 
any surnames in the Employee table are more than 6 characters long. If there are any surnames like this, display them and their length */

SELECT LastName, LEN(LastName) AS 'Length' FROM Employee WHERE LEN(LastName) >6 

/*9. Find the ASCII values of the initial letters in your first and last names. 
The initial letters must be capitalized.*/

SELECT FirstName + ' ' + LastName AS 'FullName', 
CONCAT(ASCII (FirstName), ' & ',ASCII(LastName)) AS 'ASCII Value', 
LEFT(UPPER(FirstName), 1) AS'First Name initial', LEFT(UPPER(LastName), 1) 
AS'Last Name initial' FROM Employee

/* 10. Write a SELECT statement that replaces DB2 with SQL in the following sentence: 
“DB2 commands permit you to manipulate database data.”*/

SELECT REPLACE('DB2 commands permit you to manipulate database data.','DB2','SQL') AS 'Test Data'

/*11 In a single SQL statement using 2 columns, display the square root of 25 and the value 
of regular hours worked raised to the 4th power for Lindsey Singh during the pay period 
that ended on 30 May 2003. Assume that you do not know Lindsey’s employee ID*/

SELECT SQRT(25) AS '√25', POWER(RegHours, 4) AS 'Hours^4' FROM Timesheet
LEFT JOIN Employee ON Timesheet.EmpID=Employee.EmpID WHERE LastName='Singh' 
AND FirstName='Lindsey' AND PayWeekEndDate='30 May 2003'


