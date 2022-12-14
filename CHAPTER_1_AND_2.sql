DROP DATABASE IF EXISTS SQLCOOKBOOK;
CREATE DATABASE SQLCOOKBOOK;
USE SQLCOOKBOOK;

DROP TABLE IF EXISTS dept;
DROP TABLE IF EXISTS emp;

CREATE TABLE dept(deptno INT, dname VARCHAR(14), loc VARCHAR(13), constraint pk_dept primary key (deptno));
CREATE TABLE emp(empno INT,  ename VARCHAR(10), job VARCHAR(9), mgr INT, hiredate DATE, sal DECIMAL(7,2), comm DECIMAL(7,2),
	deptno INT, constraint pk_emp primary key (empno), constraint fk_deptno foreign key (deptno) references dept (deptno));
SHOW TABLES;

INSERT INTO dept(deptno, dname, loc) VALUES
	(10, 'ACCOUNTING', 'NEW YORK'),
	(20, 'RESEARCH', 'DALLAS'),
	(30, 'SALES', 'CHICAGO'),
	(40, 'OPERATIONS', 'BOSTON');
    
INSERT INTO emp VALUES
	(7839, 'KING', 'PRESIDENT', null, '1981-11-17', 5000, null, 10),
	(7698, 'BLAKE', 'MANAGER', 7839,'1981-05-01', 2850, null, 30),
	(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, null, 10),
	(7566, 'JONES', 'MANAGER', 7839, '1981-04-02',2975, null, 20),
	(7788, 'SCOTT', 'ANALYST', 7566, '1981-04-19',3000, null, 20),
	(7902, 'FORD', 'ANALYST', 7566, '1981-03-12', 3000, null, 20),
	(7369, 'SMITH', 'CLERK', 7902,'1980-12-17', 800, null, 20),
	(7499, 'ALLEN', 'SALESMAN', 7698,'1981-02-20', 1600, 300, 30),
	(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22',1250, 500, 30),
	(7654, 'MARTIN', 'SALESMAN', 7698,'1981-09-28',1250, 1400, 30),
	(7844, 'TURNER', 'SALESMAN', 7698,'1981-09-08',1500, 0, 30),
	(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23',1100, null, 20),
	(7900, 'JAMES', 'CLERK', 7698,'1981-03-12',950, null, 30),
	(7934, 'MILLER', 'CLERK', 7782,'1982-01-23',1300, null, 10); 

# ALL ROWS AND ALL COLUMNS
SELECT * FROM EMP;

# A SUBSET OF ROWS
SELECT SAL,COMM FROM EMP WHERE DEPTNO = 10;

# A SUBSET OF COLUMNS
SELECT SAL,COMM FROM EMP;

# PROVIDING MEANINGFUL NAMES FOR COLUMNS
SELECT SAL as SALARY, COMM AS COMMISION FROM EMP;
 
# REFERING AN ALIASED COLUMN IN THE WHERE CLAUSE
SELECT SAL AS SALARY, COMM AS COMMISION FROM EMP WHERE SAL >2000;
SELECT * FROM(
	SELECT SAL AS SALARY, COMM AS COMMISION FROM EMP ) X
WHERE SALARY >2000;
 
 # CONCATENATING COLUMN VALUES
 SELECT CONCAT(ENAME,' WORKS AS A ',JOB) AS MSG FROM EMP WHERE DEPTNO = 10;
 
 # CONDITIONAL LOGIC / IF-ELSE
 SELECT ENAME, SAL,
	CASE WHEN SAL <=2000 THEN 'UNDERPAY' 
		 WHEN SAL >= 4000 THEN 'OVERPAY'  
         ELSE 'OK' 
         END AS STATUS 
FROM EMP;

# RETURN 5 RANDOM RESULTS
SELECT ENAME, JOB FROM EMP ORDER BY RAND() LIMIT 5;

# TRANSFORMING NULL INTO REAL VALUES
SELECT COALESCE(COMM,0) FROM EMP;

# SEARCHING FOR PATTERN
 SELECT ENAME, JOB FROM EMP WHERE DEPTNO IN (10,20) 
	AND (ENAME LIKE '%I%' OR JOB LIKE '%ER');

 # SPECIFIED ORDER: COLUMN NAME OR NUMBER
 SELECT ENAME, JOB FROM EMP WHERE DEPTNO IN (10,20) ORDER BY SAL ASC, DEPTNO DESC;
 
 #SORTING BY SUBSTRING
 SELECT ENAME, JOB FROM EMP WHERE DEPTNO IN (10,20) ORDER BY substr(JOB, length(JOB)-1);
 
 # DEALING WITH NULLS WHEN SORTING /  COMM : ASC, ALL NULLS FIRST:
 SELECT ENAME, JOB, COMM FROM 
 (SELECT ENAME, JOB, COMM, 
	CASE WHEN COMM IS NULL THEN 0 ELSE 1 END AS IS_NULL FROM EMP)x
    ORDER BY IS_NULL DESC, COMM;
    
# SORTING BY CONDITION
SELECT ENAME,SAL, JOB, COMM FROM EMP ORDER BY CASE WHEN JOB = 'SALESMAN' THEN COMM ELSE SAL END;
 
 
 
