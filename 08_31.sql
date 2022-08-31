-- 08월 31일 실습 내용.
select * from dept_02;

-- emp_10 테이블을 서브쿼리를 이용해서 복사 생성
create table emp_10
AS
SELECT Ename, sal, mgr
FROM EMP;

-- emp_10의 테이블명을 mbc_10으로 변경.
rename emp_10 to mbc_10;

-- 변경된 테이블명 확인
select * from tab;

-- dept_2 테이블 생성(dept 테이블의 컬럼만 복사)
create table dept_02
AS
SELECT * from dept
WHERE 1 = 0;

-- Insert 실습
INSERT INTO dept_02(deptno, dname, loc) VALUES(10, '영업부', '서울');

-- 3개의 컬럼에서 dname 컬럼에는 데이터를 집어 넣지 않았더니, NULL 값이 들어감.
INSERT INTO dept_02(deptno, loc) VALUES(20, '부산');

-- 컬럼의 수(2)와 VALUES(3)의 개수가 일치하지 않아 에러가 발생한다.
INSERT INTO dept_02(deptno, loc) VALUES(20, '부산', '대구');

-- 컬럼의 수(2)와 VALUES(1)의 개수가 일치하지 않아 에러가 발생한다.
INSERT INTO dept_02(deptno, loc) VALUES(20);

-- 컬럼의 수(3)와 VALUES(3)이 똑같다면 컬럼명은 생략이 가능하다.
INSERT INTO dept_02 VALUES(10, '운영부', '인천');

-- 비어있는 emp_11 테이블을 만들고 서브 쿼리를 사용하여 10번 부서의 사원들을 갖는 테이블을 만드시오

-- EMP 테이블에서 deptno = 10인 사원들을 바로 복사하여 EMP_12 테이블 생성
create table emp_12
AS
select deptno, ename
FROM emp
where deptno = 10;


-- EMP의 컬럼값만 복사해온 비어있는 테이블 EMP_13 생성
create table emp_13
AS
select deptno, ename
from emp
where 1 = 0;

-- 비어있는 컬럼에 EMP 테이블 참고해서 데이터 삽입.
INSERT INTO emp_13(deptno, ename) VALUES('10', 'CLARK');
INSERT INTO emp_13(deptno, ename) VALUES('10', 'KING');
INSERT INTO emp_13(deptno, ename) VALUES('10', 'MILLER');

-- 다중 테이블에 다중행 입력
create table emp_hir
AS
SELECT empno, ename, hiredate
FROM emp
WHERE 1 = 0;

create table emp_mgr
AS
SELECT empno, ename, mgr
FROM emp
WHERE 1 = 0;

-- 다중 테이블에 다중행을 삽입(INSERT)
INSERT ALL
INTO emp_hir VALUES(empno, ename, hiredate)
INTO emp_mgr VALUES(empno, ename, mgr)
SELECT empno, ename, hiredate,mgr
FROM emp
WHERE deptno = 20;

select * from emp_mgr;

-- 암묵적 NULL 값의 삽입
INSERT into emp_mgr(empno, mgr)
values(29, 6745);

-- ENAME (NULL)
select * from emp_mgr;

-- 명시적 NULL 값의 삽입
INSERT INTO emp_mgr(empno, ename, mgr)
VALUES(4444, NULL, 7544);

-- ENAME (NULL) 
select * from emp_mgr;

-- UPDATE 실습
UPDATE emp_hir
SET empno = 9999
WHERE ename = 'SMITH';

-- UPDATE 에서 WHERE을 쓰지 않으면 SET의 컬럼의 데이터값이 모두 바뀐다.
UPDATE emp_hir
SET empno = 4989;

-- 문제 emp_hir 테이블의 'scott'의 empno = 5555로 변경
UPDATE emp_hir
SET empno = 5555
WHERE ename = 'SCOTT';

-- emp_02 테이블의 사원들중 이름에 'T'가 들어 있는 사원들의 월급을 1300으로 바꾸세요.
UPDATE emp_02
SET sal = 1300
WHERE ename like'%T%';

-- emp_02 테이블의 'MANAGER'의 입사일을 어제 날짜로 바꾸시오.
UPDATE emp_02
SET hiredate = sysdate - 1
WHERE job = 'MANAGER';

-- emp_02 테이블의 사원중에 급여가 3000 이상인 사원들의 급여를 50% 인상하고 입사일을 '22/01/01'로 바꾸시오.
UPDATE emp_02
SET hiredate = '22/01/01' , sal = sal * 1.5
WHERE sal >= 3000;

-- '01' 월에 입사한 사원의 월급을 10000원 인상하시요.
UPDATE emp_02
SET sal = sal + 10000
WHERE substr(hiredate, 4, 2) = '01';

-- 'DALLAS'에 근무하는 사원들의 월급을 5000원 인상하시오
UPDATE emp_02
SET sal = sal + 5000
WHERE deptno = (select deptno from dept where loc = 'DALLAS');

-- 다중 테이블에 다중행을 삽입(INSERT)
INSERT ALL
INTO emp_hir VALUES(empno, ename, hiredate)
INTO emp_mgr VALUES(empno, ename, mgr)
SELECT empno, ename, hiredate,mgr
FROM emp
WHERE deptno = 20;

-- emp_02 테이블의 모든 사원의 급여와 입사일을 'KING' 사원의 입사일로 바꾸시오
UPDATE emp_02
SET (sal,hiredate) = (select sal,hiredate from emp_02 where ename = 'KING');

-- emp_02 테이블 완전 삭제
drop table emp_02 purge;

-- emp_02 테이블 재생성
create table emp_02
AS
SELECT *
FROM emp;








select * from emp_02;