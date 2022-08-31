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
















