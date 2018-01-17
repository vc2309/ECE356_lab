SELECT * FROM Department WHERE location = 'Waterloo';
SELECT job,COUNT(DISTINCT empID) FROM Employee GROUP BY job;
SELECT empName,salary FROM Employee WHERE job="engineer";
SELECT job, AVG(salary) FROM Employee GROUP BY job;
SELECT deptID,COUNT(DISTINCT empName) AS C FROM Employee WHERE job="engineer" GROUP BY deptID ORDER BY C DESC LIMIT 1;
SELECT tall.deptID, teng.cee/tall.ced AS percentage 
FROM (SELECT deptID, COUNT(*) as ced  from Employee group by deptID ) as tall 
INNER JOIN (SELECT deptID, COUNT(*) as cee from Employee  where job = "engineer"  group by deptID ) as teng 
ON tall.deptID = teng.deptID 
ORDER BY teng.cee/tall.ced DESC 
LIMIT 1;

SELECT empName,empID FROM Employee WHERE empID NOT IN( SELECT empID FROM Assigned);
SELECT empName,job,role FROM (SELECT * FROM Employee NATURAL JOIN Assigned) AS T WHERE job<>role;
SELECT job,COUNT(DISTINCT empID) FROM (SELECT job,empID FROM (SELECT * FROM Employee NATURAL JOIN Assigned) AS T WHERE job=role) AS J GROUP BY job;
SELECT projID,SUM(salary) FROM (SELECT * FROM Employee NATURAL JOIN (SELECT projID,empID FROM Assigned NATURAL JOIN Project) AS A) AS B GROUP BY projID;
#SELECT projID,SUM(salary) FROM (SELECT * FROM Employee NATURAL JOIN (SELECT projID,empID FROM (SELECT * FROM Employee LEFT JOIN Assigned ON empID=empID) AS C NATURAL JOIN Project) AS A) AS B GROUP BY projID;
SELECT title, SUM(salary) FROM (SELECT empID, title, projID FROM Assigned NATURAL JOIN Project) pa RIGHT JOIN Employee ON Employee.empID = pa.empID GROUP BY projID;
SELECT empName, empID FROM Assigned NATURAL JOIN Employee GROUP BY Assigned.empID HAVING COUNT(*) > 1;

UPDATE Employee SET salary=salary*1.1 WHERE empID IN (SELECT empID FROM(SELECT * FROM Assigned NATURAL JOIN Project) AS A WHERE title="compiler");
UPDATE Employee SET salary=
(CASE
	WHEN deptID IN (SELECT deptID FROM Department WHERE location = 'Waterloo') THEN salary*1.08
	ELSE salary*1.05
END) WHERE job = 'janitor' OR deptID IN (SELECT deptID FROM Department WHERE location = 'Waterloo');