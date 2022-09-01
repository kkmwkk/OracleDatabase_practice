-- 구월 일일

-- dept_02 테이블에서 20부서의 지역명을 40번 부서의 지역명으로 바꾸시오

UPDATE dept_02
SET loc = (select loc일 from dept_02 where deptno = 40)
WHERE deptno = 20;

select * 
from dept_02;

-- emp_02 테이블에서 'SALESMAN'의 급여는 2500 입사일은 그제 날짜로 바꾸시오
UPDATE emp_02
SET sal = 2500, hiredate = sysdate - 2
WHERE job = 'SALESMAN';

select * from emp_02;

-- emp_02 테이블의 사원이름에 'T'가 들어가는 사원의 월급을 7000원 인상하고 입사일을 모레로 바꾸세요
UPDATE emp_02
SET sal = sal + 7000, hiredate = sysdate + 2
WHERE ename like '%T%';

-- emp02 테이블에서 'CHICAGO' 근무하는 사원들의 입사일을 본인의 생일로 바꾸세요
UPDATE emp_02
SET hiredate = '98/04/29'
WHERE deptno = (select deptno from dept_02 where loc = 'CHICAGO');

-- emp_02 테이블의 사원들 중에서 '09' 월에 입사한 사원들의 월급을 천원 인상하시오

drop table emp_02 purge;

create table emp_02
AS
select * from emp;

-- substr을 활용해서 '09'월에 입사한 사원들의 월급 천원 인상.
UPDATE emp_02
SET sal = sal + 1000
WHERE substr(hiredate, 4, 2) = '09';

-- instr을 활용해서 '09'월에 입사한 사원들의 월급 천원 인상
UPDATE emp_02
SET sal = sal + 1000
WHERE instr(hiredate, '09' , 4, 1)  = 4;

-- to_char을 활용해서 '09'월에 입사한 사원들의 월급 천원 인상
UPDATE emp_02
SET sal = sal + 1000
WHERE to_char(hiredate, 'MM') = '09';

-- 근무지가 뉴욕인 사원들을 emp_02 에서 삭제하시오

DELETE FROM emp_02
WHERE deptno = (select deptno from dept where loc = 'NEW YORK');

-- comm이 null인 사원들을 삭제 하시오
DELETE FROM emp_02
WHERE COMM IS NULL;

-- emp_02 테이블에서 부서별로 가장 많은 급여를 받는 사원들을 삭제하시오
DELETE FROM emp_02
WHERE sal IN (select max(sal) from emp_02 group by deptno);

-- MERGE 실습


UPDATE EMP_03
SET JOB = 'BOSS';

INSERT INTO EMP_03
VALUES (8888, 'KOREA', 'TOP', '7568', sysdate, 4600, 10, 20);

INSERT INTO EMP_03
VALUES (9999, 'SEOUL', 'TOP', '7568', sysdate-3, 2400, 500, 20);

-- TABLE 병합
Merge INTO EMP_01 E
USING EMP_03 M
ON(E.empno = M.empno)
WHEN MATCHED THEN
UPDATE SET
E.ename = M.ename,
E.job = M.job,
E.mgr = M.mgr,
E.hiredate = M.hiredate,
E.sal = M.sal,
E.comm = M.comm,
E.deptno = M.deptno
WHEN NOT MATCHED THEN
INSERT VALUES(M.empno,M.ename,M.job,M.mgr,M.hiredate,M.sal,M.comm,M.deptno);

create table emp_02
AS
select * from emp;

select * from emp_02;

-- 제약조건 생성 후 테이블 생성(NOT NULL)

CREATE TABLE TABLE_NOTNULL(
LOGIN_ID VARCHAR2(20) NOT NULL,
LOGIN_PWD VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20));

-- NOT NULL 제약 조건 때문에 LOGIN_PWD는 NULL값이 될 수 없음.
INSERT INTO TABLE_NOTNULL(
LOGIN_ID, TEL)
VALUES('TEST_ID_01', '010-1234-1234');

select * from table_notnull;

-- UNIQUE 설정

ALTER TABLE TABLE_NOTNULL MODIFY LOGIN_ID UNIQUE;

-- UNIQUE 제약 조건 위배
INSERT INTO TABLE_NOTNULL(
LOGIN_ID, TEL)
VALUES('TEST_ID_01','1234', '010-1234-1234');

-- VALUES를 바꿔야함.
INSERT INTO TABLE_NOTNULL(
LOGIN_ID,LOGIN_PWD, TEL)
VALUES('TEST_ID_02','1234', '010-1234-1234');


-- TEL 컬럼 UNIQUE 설정
ALTER TABLE TABLE_NOTNULL MODIFY TEL UNIQUE;

-- VALUES를 바꿔야함.
INSERT INTO TABLE_NOTNULL(
LOGIN_ID,LOGIN_PWD, TEL)
VALUES('TEST_ID_03','1234', '010-1234-1235');

SELECT * FROM TABLE_NOTNULL;

-- 제약 조건의 종류를 파악할 수 있는 SQL문
-- C : Check, NOT NULL
-- P : PRIMARY KEY
-- R : FOREIGN KEY
select CONSTRAINT_NAME, CONSTRAINT_TYPE, r_constraint_name, table_name from USER_CONSTRAINTS;





-- 나만의 테이블 만들기
CREATE TABLE MY_TABLE(
NAME VARCHAR2(20) NOT NULL,
YEAR NUMBER(5) NOT NULL,
PHONE NUMBER(20));

INSERT INTO MY_TABLE(NAME, YEAR, PHONE)
VALUES('MINWOO', 25, 01022782357);

Alter table my_table modify phone unique;


INSERT INTO MY_TABLE(NAME, YEAR, PHONE)
VALUES('LEEGUN', 25, 01033223322);


select * from my_table;
















