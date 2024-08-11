--HUMAN RESOURCES ANALYSIS BY MAHMOUD OSAMA

--Definition of the database we are working on
use AdventureWorks2022
--Explore the table
select *
from HumanResources.Department
-----------------------------
select *
from HumanResources.Employee
-----------------------------
select *
from HumanResources.EmployeeDepartmentHistory
-----------------------------
select *
from HumanResources.EmployeePayHistory
-----------------------------
select *
from HumanResources.JobCandidate
-----------------------------
select *
from HumanResources.Shift
-----------------------------
-- how many employees
SELECT COUNT(*) Employeescount
FROM HumanResources.Employee
------------------------------
--Number of department
select COUNT(*) Departmentcount
from HumanResources.Department
-------------------------------
--Number of employees in each department
SELECT dept.Name  DepartmentName,
COUNT(emb.BusinessEntityID) Employeescount
FROM HumanResources.Employee  emb
JOIN HumanResources.EmployeeDepartmentHistory  edh 
ON emb.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department  dept
ON edh.DepartmentID = dept.DepartmentID
GROUP BY dept.Name
ORDER BY Employeescount desc
--------------------------------
--number of employees at levels
SELECT OrganizationLevel, COUNT(BusinessEntityID)  Employeescount
FROM HumanResources.Employee
GROUP BY OrganizationLevel
ORDER BY OrganizationLevel
-------------------------------
--Number of employees in each shift
SELECT sh.Name  ShiftName, COUNT(edh.BusinessEntityID)  Employeescount
FROM HumanResources.EmployeeDepartmentHistory  edh
JOIN HumanResources.Shift  sh
ON edh.ShiftID = sh.ShiftID
GROUP BY sh.Name
ORDER BY Employeescount DESC
---------------------------------
--Average age
SELECT 
AVG(DATEDIFF(YEAR, emb.BirthDate, GETDATE())) AS AverageAge
FROM 
HumanResources.Employee emb
---------------------------------
--Years of experience with salary
SELECT emb.BusinessEntityID,concat(p.FirstName ,' ' ,p.LastName)  EmployeeName,
DATEDIFF(YEAR, emb.HireDate, GETDATE())  Employeeexperience,eph.Rate  Salary
FROM 
HumanResources.Employee  emb
JOIN 
Person.Person  p
ON emb.BusinessEntityID = p.BusinessEntityID
JOIN 
HumanResources.EmployeePayHistory  eph
ON emb.BusinessEntityID = eph.BusinessEntityID
WHERE 
eph.PayFrequency = 2  or eph.PayFrequency =1
ORDER BY 
Employeeexperience DESC
------------------------------------
--Divide it into monthly and semi-monthly
SELECT  CASE  WHEN eph.PayFrequency = 1 THEN 'monthly'
WHEN eph.PayFrequency = 2 THEN 'semimonthly'
END AS PayType,
COUNT(emb.BusinessEntityID)  Employeescount
FROM 
HumanResources.EmployeePayHistory  eph
JOIN  HumanResources.Employee  emb
ON eph.BusinessEntityID = emb.BusinessEntityID
GROUP BY  eph.PayFrequency
ORDER BY PayType
---------------------------------------------
--- arrange level with most sick hours
select sum(sickleavehours) 'total sick hours ',OrganizationLevel
from HumanResources.Employee
where OrganizationLevel is not null
group by OrganizationLevel
------------------------------------------
--Distribution of men and women at all levels in the company
SELECT emb.OrganizationLevel,emb.Gender,COUNT(emb.BusinessEntityID)  Employeescount
FROM HumanResources.Employee  emb
GROUP BY emb.OrganizationLevel,emb.Gender
ORDER BY emb.OrganizationLevel, emb.Gender
---------------------------------------------------
--There is a salary distribution according to the job
SELECT emb.JobTitle,AVG(esh.Rate)  AverageSalary,MIN(esh.Rate)  MinimumSalary,
MAX(esh.Rate)  MaximumSalary,COUNT(emb.BusinessEntityID)  Employeescount
FROM  HumanResources.Employee emb
JOIN  HumanResources.EmployeePayHistory esh 
ON emb.BusinessEntityID = esh.BusinessEntityID
GROUP BY emb.JobTitle
ORDER BY AverageSalary DESC
-----------------------------
--Salary distribution at the organization level
SELECT  emb.OrganizationLevel,AVG(esh.Rate)  AverageSalary,
MIN(esh.Rate)  MinimumSalary, MAX(esh.Rate)  MaximumSalary,
 COUNT(emb.BusinessEntityID) Employeescount
FROM HumanResources.Employee emb
JOIN HumanResources.EmployeePayHistory esh 
ON emb.BusinessEntityID = esh.BusinessEntityID
GROUP BY emb.OrganizationLevel
ORDER BY AverageSalary DESC









