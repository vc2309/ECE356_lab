SELECT * FROM Department WHERE location = 'Waterloo';
SELECT job,COUNT(DISTINCT empName) FROM Employee GROUP BY job;
SELECT empName,salary FROM Employee WHERE job="engineer";
SELECT job, AVG(salary) FROM Employee GROUP BY job;
SELECT deptID,COUNT(DISTINCT empName) FROM Employee WHERE job="engineer" GROUP BY deptID;
#(F)?
SELECT empName,empID FROM Employee WHERE empID NOT IN( SELECT empID FROM Assigned);
SELECT empName,job,role FROM (SELECT * FROM Employee NATURAL JOIN Assigned) AS T WHERE job<>role;
SELECT job,COUNT(DISTINCT empID) FROM (SELECT job,empID FROM (SELECT * FROM Employee NATURAL JOIN Assigned) AS T WHERE job=role) AS J GROUP BY job;
SELECT projID,SUM(salary) FROM (SELECT * FROM Employee NATURAL JOIN (SELECT projID,empID FROM Assigned NATURAL JOIN Project) AS A) AS B GROUP BY projID;
SELECT projID,SUM(salary) FROM (SELECT * FROM Employee NATURAL JOIN (SELECT projID,empID FROM (SELECT * FROM Employee LEFT JOIN Assigned ON empID=empID) AS C NATURAL JOIN Project) AS A) AS B GROUP BY projID;
#e,f
UPDATE Employee SET salary=salary*1.1 WHERE empID IN (SELECT empID FROM(SELECT * FROM Assigned NATURAL JOIN Project) AS A WHERE title="compiler");
