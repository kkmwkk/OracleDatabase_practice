-- 08.30 database 실습

-- 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하는 사원들의 이름과 사원번호를 출력하시오
select ename, empno, deptno
from emp
where deptno IN (select deptno from emp where ename like '%T%');


select ename, empno, deptno
from emp
where deptno IN (select deptno from emp where INSTR(ename, 'T') <> 0);

-- 급여가 평균 급여보다 많고 이름에 'S'가 들어가는 사원과 동일한 부서에서 근무하는 모든 사원의 이름, 급여를 출력하시오.

select ename, sal, deptno
from emp
where deptno IN (select deptno from emp where ename like '%S') AND sal > (select avg(sal) from emp);

select ename, sal, deptno
from emp
where deptno IN(select deptno from emp where sal > (select avg(sal) from emp) AND ename like '%S%');

-- 영업 사원들보다 급여를 많이 받는 사람들의 이름과 직급, 급여를 출력하시오
select ename, job, sal
from emp
where sal > all (select sal from emp where job = 'SALESMAN')
order by sal;

select ename, job, sal
from emp
where sal > (select max(sal) from emp where job = 'SALESMAN')
order by sal;

-- 10과 20번 부서에서 근무하는 사원들의 평균 급여보다 많이 받는 사람들의 이름, 급여, 부서번호를 출력 하시오
select ename, sal, deptno
from emp
where sal > (select avg(sal) from emp where deptno IN(10,20));

-- 'WARD' 와 동일한 직급을 가진 사원의 이름과 직급을 출력 하시오 ( 단일행 서브 쿼리 이용)
select ename, job
from emp
where job = (select job from emp where ename = 'WARD') AND ename <> 'WARD';

-- 다중 컬럼 서브 쿼리
select *
from emp
where (deptno, sal) IN (select deptno, max(sal) from emp group by deptno);

-- exists
select *
from emp
where exists(select ename from emp where ename = 'WARD');

-- 직급이 'MANAGER'인 사원들이 받는 급여의 최소 급여보다 많이 받는 사원들의 이름과 급여, 부서번호를 출력하되 부서 번호가 20번인 사원은 제외한다.
select ename, sal, deptno, job
from emp
where sal > (select min(sal) from emp where job = 'MANAGER') AND deptno <> 20 AND job <> 'MANAGER';

select ename , sal, deptno, job
from emp
where sal > any(select sal from emp where job = 'MANAGER') AND deptno <> 20;


-- EMP 테이블에서 최상위 소득자 3명의 이름과 급여를 표시 하시오
select rownum as rank, ename, sal
from (select ename, sal from emp order by sal desc)
where rownum <= 3;

-- 'SALES' 부서의 모든 사원의 이름과 급여를 출력하되 월급이 높은 사람이 먼저 나오고 거기에 순번을 붙이시오.

select rownum as rank, ename, sal
from (select * from emp order by sal desc)
where deptno = (select deptno from dept where dname = 'SALES');


-- 테이블명 EMP_08
-- 컬럼  EMPNO number(4)
--      ENAME varchar2(20)
--      JOB varchar2(16)
--      DEPTNO number(2)
       
-- 테이블 생성
create table EMP_08(
    EMPNO number(4),
    ENAME varchar2(20),
    JOB varchar2(16),
    DEPTNO number(2));

-- 테이블 속성 보기
desc emp_08;

-- 테이블 컬럼 추가하기
alter table emp_08
ADD (sal number(5));

-- 테이블 컬럼 수정하기
alter table emp_08
MODIFY (sal NUMBER(8, 3));

-- 테이블 컬럼 삭제하기
alter table emp_08
DROP column sal;

-- 데이터가 들어가 있는 테이블의 컬럼을 삭제해보자 !
select * from emp_01;
desc emp_01;

-- 데이터가 들어가 있는 테이블의 컬럼을 변경 => 확대(number(8, 3)은 가능하나 축소(number(2))은 불가능하다.
alter table emp_01
MODIFY (sal number(8, 3));

alter table emp_01
MODIFY (ename varchar2(5));

-- 데이터가 들어가 있는 테이블의 컬럼을 삭제 => 삭제(DROP)는 데이터가 들어가 있어서 삭제(DROP)가 가능하다
alter table emp_01
DROP COLUMN sal;

-- 데이터가 들어가 있는 테이블의 컬럼을 추가 => 컬럼은 ADD되지만 컬럼 속의 데이터는 null 값으로 유지된다.
alter table emp_01
ADD (MGR2 number(4));
select * from emp_01;