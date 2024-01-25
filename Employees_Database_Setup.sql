USE Employees --this is a formality to ensure queries are written in the right location

CREATE TABLE Employee(
 EmpID NUMERIC (5)  NOT NULL PRIMARY KEY,
 [Sin] NUMERIC NOT NULL,
 LastName VARCHAR (25) NOT NULL,
 FirstName VARCHAR (25),
 Street VARCHAR(30),
 City VARCHAR (25),
 Province CHAR(2),
 PostalCode VARCHAR(7),
 JobCode NUMERIC (4)NOT NULL,
 IncomeTax CHAR(1),
 BirthdDate DATE,
 HireDate DATE,
 JobCodeDate DATE,
 FOREIGN KEY (JobCode) REFERENCES Job(JobCode)
 );

 CREATE TABLE Job(
 JobCode NUMERIC (4) NOT NULL PRIMARY KEY,
 [Description] VARCHAR (25),
 PayRate NUMERIC (5,2),
 );

 CREATE TABLE Timesheet (
 EmpID NUMERIC (5),
 PayWeekEndDate DATE,
 RegHours NUMERIC(5,2),
 OTimeHours NUMERIC(5,2),
 PRIMARY KEY (EmpID, PayWeekEndDate),
 FOREIGN KEY (EmpID) REFERENCES Employee (EmpID));
 
 INSERT INTO Job VALUES (1000, 'Manager', 32.4);
 INSERT INTO Job VALUES (2000, 'Cashier', 11.63);
 INSERT INTO Job VALUES (3000, 'Stockperson', 8.89);
 INSERT INTO Job VALUES (4000, 'Baker', 18.91);
 INSERT INTO Job VALUES (5000, 'Butcher', 19.26);
 INSERT INTO Job VALUES (6000, 'cleaner', 6.75);
 INSERT INTO Job VALUES (7000, 'Pharmacist', 28.17);
 INSERT INTO Job VALUES (8000, 'Assitant Baker', 12.58);

 
 INSERT INTO Employee VALUES (97319, 516303417,	'Novak','Gerry','6803 Park Ave.','Moose Jaw','SK','S6H 1X7',3000,	'N','24-Aug-86',
 '07-Jul-03','07-Jul-03');
 INSERT INTO Employee VALUES (33982,867481381,'Boychuk','Robin','117 East Broadway','Moose Jaw','SK','S6H 3P5',5000,'Y','04-Mar-71','11-Oct-98','11-Oct-98');
 INSERT INTO Employee VALUES (51537,112893584,'Smith','Kim','9745 University Drive','Regina','SK','S4P 7A3',2000,'Y','29-Nov-82','02-Dec-01','02-Dec-01');
 INSERT INTO Employee VALUES (41822,717505366,'Miller','Chris','72 Railway Ave.','Pense','SK','S0T 1K4',2000,'Y','15-Nov-68','19-Feb-85','19-Feb-85');
 INSERT INTO Employee VALUES (3571,374853129,'Hashimoto','Jo','386 High Street','Tuxford','SK','S0L 8V6',1000,'Y','23-Jun-56','20-Mar-80','30-Aug-99');
 INSERT INTO Employee VALUES (85833,466128562,'Singh','Lindsey','1216 Willow Cres.','Pasqua','SK','S0H 5T8',7000,'Y','15-Mar-75','27-Jul-02','27-Jul-02');
 INSERT INTO Employee VALUES (81216,615917448,'Hansen','Jaimie','95 Lakeshore Blvd.','Caronport','SK','S0T 3S7',8000,'Y','04-Mar-83','21-May-02','21-May-02');
 INSERT INTO Employee VALUES (32177,306114858,'DaSilva','Robbie','4319 Main St.','Moose Jaw','SK','S6H 2M2',4000,'Y','18-Feb-51','07-Jul-83','15-Sep-92');
 INSERT INTO Employee VALUES (52421,936654021,'O''Day','Ashley','27 High St.','Tuxford','SK','S0L 8V6',6000,'Y','31-Jul-63','08-Nov-97','08-Nov-97');
 INSERT INTO Employee VALUES (72690,655971502,'Wong','Jodie','59 Oslo Square','Moose Jaw','SK','S6H 2H9',6000,'N','01-Jan-87','26-Aug-03','26-Aug-03');
 INSERT INTO Employee VALUES (72201,635111876,'Ramirez','Kelly','1015 Brunswick Lane','Moose Jaw','SK','S6H 4T5',3000,'N','29-Sep-86','26-Aug-03','26-Aug-03');

 

 INSERT INTO Timesheet VALUES (72690,'23-May-03',36,0);
 INSERT INTO Timesheet VALUES (52421,'23-May-03',22,0);
 INSERT INTO Timesheet VALUES (85833,'23-May-03',37.5,0.5);
 INSERT INTO Timesheet VALUES (81216,'23-May-03',40,0);
 INSERT INTO Timesheet VALUES (33982,'23-May-03',40,0);
 INSERT INTO Timesheet VALUES (32177,'23-May-03',40,3.75);
 INSERT INTO Timesheet VALUES (51537,'23-May-03',27,0);
 INSERT INTO Timesheet VALUES (41822,'23-May-03',40,0);
 INSERT INTO Timesheet VALUES (3571,'23-May-03',40,0);
 INSERT INTO Timesheet VALUES (72201,'30-May-03',18,0);
 INSERT INTO Timesheet VALUES (52421,'30-May-03',40,4.5);
 INSERT INTO Timesheet VALUES (85833,'30-May-03',22,0);
 INSERT INTO Timesheet VALUES (33982,'30-May-03',38.25,0);
 INSERT INTO Timesheet VALUES (32177,'30-May-03',40,2.25);
 INSERT INTO Timesheet VALUES (41822,'30-May-03',38,1.25);
 INSERT INTO Timesheet VALUES (3571,'30-May-03',40,0);

 

-- The tables were created in the Job, Employee, Timesheet order because it
 --is a relational database. Without the job table, the employee table cannot be set up 
 --properly and without the employee table the timesheet table cannot be set up properly.
 
 --The job table was first created, then the employee table and the timesheet last. This 
 --is because the employee table requires the job code which is on the job table
 --and the timesheet table requires the employee id. Its a relational database.


--2. The order in which tables are dropped are important because we are working with referential integrity
--an instance of an employee variable is on the timesheet and an instance of a job variable is listed 
--on the job table. 
CREATE TABLE Earnings(
EmpID NUMERIC (5),
PayWeekEndDate DATE,
RegEarnings NUMERIC (6,2),
OTimeEarnings NUMERIC (6,2),
PRIMARY KEY(EmpID, PayWeekEndDate),
FOREIGN KEY(EmpID,PayWeekEndDate) REFERENCES Timesheet (EmpID,PayWeekEndDate)
);

CREATE TABLE Deductions(
EmpID NUMERIC (5),
PayWeekEndDate DATE,
EI NUMERIC(5,2),
CPP NUMERIC(5,2),
UnionDues NUMERIC(5,2),
PensionPlan NUMERIC (5,2),
IncomeTax NUMERIC (6,2),
PRIMARY KEY(EmpID,PayWeekEndDate ),
FOREIGN KEY(EmpID,PayWeekEndDate) REFERENCES Timesheet (EmpID,PayWeekEndDate)
);
--The earnings table was first created then the deductions. the order of the table wasnt important
-- The three intital table, job, employee, timesheet needed to be created to be able to create 
--the earnings and the deductions table because the empid and the payweekenddate needed to be refernced
--from the timesheet table.

-- Insert records into Earnings table
INSERT INTO earnings VALUES (33982,'23-May-03',770.4,0);
INSERT INTO earnings VALUES (33982,'30-May-03',736.7,0);
INSERT INTO earnings VALUES (51537,'23-May-03',314.01,0);
INSERT INTO earnings VALUES (41822,'23-May-03',465.2,0);
INSERT INTO earnings VALUES (41822,'30-May-03',441.94,29.08);
INSERT INTO earnings VALUES (3571,'23-May-03',1296,0);
INSERT INTO earnings VALUES (3571,'30-May-03',1296,0);
INSERT INTO earnings VALUES (85833,'23-May-03',1056.38,28.17);
INSERT INTO earnings VALUES (85833,'30-May-03',619.74,0);
INSERT INTO earnings VALUES (81216,'23-May-03',503.2,0);
INSERT INTO earnings VALUES (32177,'23-May-03',756.4,141.83);
INSERT INTO earnings VALUES (32177,'30-May-03',756.4,85.1);
INSERT INTO earnings VALUES (52421,'23-May-03',148.5,0);
INSERT INTO earnings VALUES (52421,'30-May-03',270,60.75);
INSERT INTO earnings VALUES (72690,'23-May-03',243,0);
INSERT INTO earnings VALUES (72201,'30-May-03',160.02,0);

-- Insert records into Deductions table

INSERT INTO Deductions VALUES (33982,'23-May-03',11.56,19.26,38.52,7.7,130.97);
INSERT INTO Deductions VALUES (33982,'30-May-03',11.05,18.42,36.84,7.37,125.24);
INSERT INTO Deductions VALUES (51537,'23-May-03',4.71,7.85,15.7,3.14,53.38);
INSERT INTO Deductions VALUES (41822,'23-May-03',6.98,11.63,23.26,4.65,79.08);
INSERT INTO Deductions VALUES (41822,'30-May-03',7.07,11.78,23.55,4.71,80.07);
INSERT INTO Deductions VALUES (3571,'23-May-03',19.44,32.4,64.8,12.96,220.32);
INSERT INTO Deductions VALUES (3571,'30-May-03',19.44,32.4,64.8,12.96,220.32);
INSERT INTO Deductions VALUES (85833,'23-May-03',16.27,27.11,54.23,10.85,184.37);
INSERT INTO Deductions VALUES (85833,'30-May-03',9.3,15.49,30.99,6.2,105.36);
INSERT INTO Deductions VALUES (81216,'23-May-03',7.55,12.58,25.16,5.03,85.54);
INSERT INTO Deductions VALUES (32177,'23-May-03',13.47,22.46,44.91,8.98,152.7);
INSERT INTO Deductions VALUES (32177,'30-May-03',12.62,21.04,42.08,8.42,143.06);
INSERT INTO Deductions VALUES (52421,'23-May-03',2.23,3.71,7.43,1.49,25.25);
INSERT INTO Deductions VALUES (52421,'30-May-03',4.96,8.27,16.54,3.31,56.23);
INSERT INTO Deductions VALUES (72690,'23-May-03',3.65,6.08,12.15,2.43,null);
INSERT INTO Deductions VALUES (72201,'30-May-03',2.4,4,8,1.6,null);
 
