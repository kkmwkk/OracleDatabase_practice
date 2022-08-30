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


select rownum, ename, sal
from emp;
