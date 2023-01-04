-- 인공지능 서비스 개발자 과정
-- 2022.10.27 ~ 23.04.24
-- 담인 이주희
=================================
-- sqlplus 접속
sqlplus hr/hr

-- 학습용 테이블 조회
select table_name from user_tables;

-- 테이블의 구조 조회
desc departments;
desc employees;

-- sqlplus 환경설정
column department_name format a18;
column last_name format a18;

ed

show user;

-- 부서정보를 조회
select * from departments;
select * from employees;

select department_name from departments;

--------------------------------- 
-- DQL( Data Query Language)
--------------------------------- 
-- query 문은 소.대문자를 구별하지 않는다.
-- SELECT
-- FROM
-- [ WHERE
-- group BY
-- HAVING
-- order by ]
-- 1. select 절의 사용 
--  1) * : from 절에 기술한 테이블의 모든 항목 조회  
     select * from departments; -- 셀렉션
--	2) 컬럼명 : from 절에 기술한 테이블에 존재하는 항목  
     select department_name from departments;
     select department_id, department_name 
	   from departments;  -- 프로잭션
--	 - 여러개의 항목을 기술할 경우는 "," 로 구분하여 나열한다. 
	3)distinct : 중복을 제거한다.
	 select job_id from employees; 
	 select distinct job_id 
	   from employees; 
	 select department_id, job_id 
	   from employees; 
	 select distinct department_id, job_id 
	   from employees; 
--	4) 별명(alias)
	 -- 열명은 대문자로 표기.	
	 -- 숫자는 오른쪽, 문자열 왼쪽에 정렬
	 -- ""를 사용할때는 ""안에 문자열이 그대로(소.대문자 구별)열제목이 된다.
	 select department_id as did , job_id as job
	   from employees; 
	 select department_id Did, job_id job
	   from employees; 

	 select department_id as "D id", job_id as "Job"
	   from employees; 
	 select department_id "Did", job_id "Job"
	   from employees; 
--	5) 연산이 가능하다.(+,-,*,/)
     -- 연산에서 우선순위가 적용된다.
	 select last_name, salary * 12
	   FROM EMPLOYEES;
	 select last_name, (salary * 12) as annsal
	   FROM EMPLOYEES;
--	6) NULL : 연산에 참여할때는 결과가 null이다.
     select last_name, 
	        (salary * commission_pct) as bonus,
			((salary * commission_pct) + salary) as salbon
	   from employees;
-- 	7) 문자열의 연결: ||
	 select last_name, (first_name || last_name) as irum
	   from employees;
	 select last_name, (first_name || '-' ||last_name) as irum
	   from employees;

-- 2. From 절의 사용 
	1) 테이블명, 복수개의 테이블명(조인)
	2) View 명
	3) 데이터 셋(Inline Query)
	4) 가상의 테이블 Dual;
	  select 1+2 from dual;
	  select sysdate from dual;

-- 3.Where(조건절) 절의 사용 
    -. 등식을 이용한다.(a=b)
	   등식에 사용하는 비교연산자: =, >, <, <>, >=, <=
	   irum <> 'inho' : inho가 아닌것을 조회.
	  예) select last_name, salary 
	       from employees
		  where salary < 10000; 
	-. 여러개의 등식은 and, or로 연결한다. 
	  a=b and b=c, a>b or b<c
	  예) select department_id, last_name, salary 
	       from employees
		  where salary > 10000
		    and department_id = 50; 
	-. 문자열, 날짜의 값을 비교할때는 홑따옴표('')를 사용한다.
	  예) select job_id, last_name, salary 
	       from employees
		  where job_id = 'IT_PROG';
	
	-. 값을 비교할때는 대소문자를 구별한다.
	  SELECT = select, FROM = from
	  a = 'inho' <> a='INHO'
	  예) select job_id, last_name, salary 
	       from employees
		  where job_id = 'iT_PROG';
	-.산술 연산이 가능하다  
	  예) select job_id, last_name, salary 
	       from employees
		  where salary *12 > 150000
	-.연결 연산자 사용 가능 
	  예) select first_name,last_name, salary 
	       from employees
		  where first_name || last_name	= 'PatFay';
	-. 연산자의 우선 순위가 있다.(and, or)  
	  예) select last_name, job_id, salary
			from employees
		   where job_id = 'IT_PROG'
			  or job_id = 'AD_PRES'
			 and salary > 15000;	
	-.범위를 사용 2가지
	  예) select last_name, job_id, salary
			from employees
		   where salary >= 5000 	
  		     and salary <= 10000;	
			(=) 
		  select last_name, job_id, salary
			from employees
		   where salary BETWEEN 5000 and 10000;
	-. 소속(포함)	   
	  예) select department_id, last_name, salary
			from employees
		   where department_id = 10
  		      or department_id = 30
  		      or department_id = 70;	
			(=)  
		 select department_id, last_name, salary
			from employees
		   where department_id in (10,30,70);   
	-. 비슷한 자료의 조회: like
	   % : 다수의 문자열과 매칭
	   _ : 한 문자와 매칭
	  예) select department_id, last_name, salary
			from employees
		   where last_name like 'H%';
		 select department_id, last_name, salary
			from employees
		   where last_name like '%a__'; 	
	-. Null의 비교
	  예) select last_name, salary, commission_pct
			from employees
		   where commission_pct is not null;
		   -- 잘못된 예
		   where commission_pct = '';

--  4.order by 절 : 정렬
	-. 컬럼명, 별명 [ asc || desc]		
	   기본값 asc
	-. 다중 컬럼명
	   col-1, col-2 desc, col-3 
	  예) select department_id, job_id, last_name, 
	            salary
			from employees
		   order by last_name desc;
		 select department_id, job_id, last_name, 
	            salary
			from employees
		   order by department_id, job_id,salary desc;
--	5.Query의 실행 순서
	  -.From > where > select > order by
	  예) select department_id, job_id, 
				last_name as irum, salary
			from employees
		  where last_name like '%s'
		  order by irum;	

--------------------------------- 
-- 단일행 함수
-- 함수의 분류 : 내장함수, 사용자 정의 함수  		   
-- 내장함수 종류 : 단일행 함수, 다중행 함수의
-- 단일행 함수 : 문자, 숫자, 날짜
-- 문자 관련함수 : Lower, Upper, Initcap, Concat
--  			substr, length, instr, replace, trim
-- 숫자 관련함수 : round, trunc, Mod
-- 날짜 관련함수 : sysdate, MONTHS_BETWEEN, ADD_MONTHS, LAST_DAY
-- 일반 함수   : nvl, case

-- 문자 관련함수 
select lower('SINHINHO') from dual;
select length('SINHINHO') from dual;
select instr('SINHINHO','I') from dual;
select substr('SINHINHO',5, 4) from dual;
select replace('SINHINHO','H', '*') from dual;

select lat_name, instr(last_name, 's') 
from employees;

select last_name, substr(last_name,2,2) exirum
  from employees;
select last_name, 
	   replace(last_name,'s','*') exirum,
	   length(last_name) len_irum
  from employees;

-- 숫자 관련함수 
select round(12.345678, 2) as ron2 from dual;
select trunc(12.345678, 2) as trun2 from dual;
select mod(10,3) as mod2, 
       round(10/3,2) as rnd2 
from dual;

-- 날짜 관련함수
select sysdate from dual;
select sysdate + 5 from dual;
select months_between('2022-12-31',sysdate) from dual;
select add_months(sysdate, 2) from dual;
select last_day(sysdate) from dual;
select last_day('2022-05-10') from dual;

-- 자료의 형변화 : 묵시적(암시적), 명시적 형변환
-- 묵시적 형변환 
select 100 + '200' from dual;
select '100' + '200', '200' as two from dual;
select 100 + '200', '200' as two from dual;
select 100 || 200, '200' as two from dual;
select 100 || 200, (100 || 200) + 100 from dual;
select 100 || 200, 100 || (200 + 100) from dual;

select '5', to_number('5') from dual;

-- 명시적 형변환
-- to_char, to_number, to_date 
select to_char(12345) char1,  from dual;
select to_number('12345') num1 from dual;
select to_date('2022-02-28') dat1 from dual;

select to_char(to_date('2022-02-28'), 'YYYY-MM') dat1 from dual;
select to_char(hire_date, 'YYYY-MM') dat1 from employees;

select to_char(hire_date, 'YYYY-MM') hire_date, 
       to_char(salary, '99,999') salary
  from employees;

-- 일반 함수 : nvl, case, decode
-- nvl(값, 기본값)
select last_name, salary * nvl(commission_pct,0)
  from employees;
  
-- (case when then else end)
-- 직종이 IT_PROG: 10%, ST_CLERK:15%, SA_REP:20% 보너스를 지급하고
-- 이름, 직종, 급여, 보너스금액을 조회하시오..
select last_name, job_id, salary,
      (case job_id  
		 when 'IT_PROG'  then salary * 1.10
		 when 'ST_CLERK' then salary * 1.15
		 when 'SA_REP'   then salary * 1.20
		else salary 
	    end ) as bonsal
  from employees;
  
select to_char(salary * nvl(commission_pct, 0), '99,999') as salary
from employees;

-- sqldeveloper 설치
--  1)sqldeveloper 압축파일 풀기
--  2)개인 컴의 자바 경로 확인:
--   C:\Program Files\Java\jdk1.8.0_202

--------------------------------- 
-- 다중행 함수(그룹, 집계함수)
-- 종류 : sum(), avg(), count(), min(), max()
-- 숫자 : sum(), avg()
-- 문자, 숫자 : max(), min, count()
--------------------------------- 

-- group by 절의 컬럼은, 동일하게 select절에 기술한다.
select department_id,
       sum(salary) as sum_salary, avg(salary) as avg_salary,
       count(salary) as cnt_salary, max(salary) as max_salary,
       min(salary) as min_salary
from employees
group by department_id
order by department_id;     
-- 집합함수에서 null값의 연산참여
select max(commission_pct),
        count(commission_pct)as cnt_comm,
        count(nvl(commission_pct,1))as cnt_nvl,
        count(*)as cnt_comm,
        count(employee_id)as cnt_emp,
        count(department_id)as cnt_dpt,
        avg(commission_pct),
        sum(commission_pct)
from employees;
-- where절은 select 절에 data를 제한하고
-- Having절은 Group by 절의 data를 제한 한다.
select department_id, JOB_ID,
       sum(salary) as sum_salary, avg(salary) as avg_salary
from employees
group by department_id, JOB_ID
HAVING AVG(SALary) > 8000
;
select department_id, JOB_ID,
       sum(salary) as sum_salary, avg(salary) as avg_salary
from employees
where department_id in (50,60,70,80)
group by department_id, JOB_ID
HAVING AVG(SALary) > 5000
;
--중첩 집계함수의 사용...
--부서별 평균 급여가 가장 많은 금액은 얼마인가요?
select max(avg(salary))
from employees
where department_id in (50,60,70)
group by department_id;
-- 직종별, 평균급여, 최고급여를 조회하시오..?
select job_id, max(salary), avg(salary)
from employees
group by job_id;
-- 직종별, 평균급여, 최고급여를 조회하시오..?
-- (단 평균급여가 5000이하인 직종을 조회)
select job_id, max(salary), avg(salary)
from employees
group by job_id
having avg(salary) <= 5000;
-- 우리회사의 직원의 최고급여와 최저급여, 최저,최고 급여의 차이를 조회하시오.
select job_id,
       max(salary) as max_sal, min(salary) as min_sal,
       (max(salary) - min(salary)) as sal_cha
from employees
group by job_id
having (max(salary) - min(salary)) > 1000;
       
-- 우리회사의 직원의 가장 오랜 근속년수, 최저근속년수, 근속년수(년)의 차이를 조회하시오.
select min(hire_date) as min_hire, max(hire_date) as max_hire,
       max(hire_date)- min(hire_date) as cha_day,
       to_char(max(hire_date),'yy') - to_char(min(hire_date),'yy') as cha_yy,
       round((max(hire_date)-min(hire_date))/ 365,0) as max_cha
from employees       
;

--------------------------------- 
-- 조인
-- 컬럼을 가로로 연결하는 효과가 있다...
-- 조인 조건이 없는 경우는 카티션 곱의 효과발생(오류)
-- 카디션곱(cartesisan Prodeuct))
--  두개의 테이블의 데이터 갯수(107x 27)를 곱하는 결과 

select * 
from employees, departments;
-- 조인한 테이블에 같은 이름의 컬럼이 있는 경우, 행당 테이블을 기술한다.
select employees.employee_id, employees.last_name, 
      employees.department_id as did1, 
      departments.department_id as did2,
      departments.department_name 
from employees, departments;

-- 조인한 테이블은 별명(alias)을 사용할수 있다.
select e.employee_id, e.last_name, 
      e.department_id as did1, 
      d.department_id as did2,
      d.department_name 
from employees e, departments d;
-- 조인 조건
-- 최소 테이블의수-1개의 조인 조건이 필요..
select e.employee_id, e.last_name, 
      e.department_id as did1, 
      d.department_id as did2,
      d.department_name 
from employees e, departments d
where d.department_id = e.department_id;

-- 직원테이블에서 부서정보를 참조하는 부서코드
select distinct department_id
from employees;

-- 조인의 종류
-- 등가(=): inner,비등가 조인, 자체조인, 외부조인(outer join): left, right, full)

-- 등가조인(=)
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e, departments d
where d.department_id = e.department_id
  and e.department_id = 10;

-- 비 등가조인(between, '='를 제외한 비교연산자의 사용))
select e.last_name, e.salary, j.grade_level
from employees e, JOB_GRADES j
where e.salary between j.lowest_sal and j.highest_sal;

-- 자체 조인
-- 직원의 이름, 급여,상관의 이름을 조회하시오
select e.employee_id, e.last_name, e.salary, e.manager_id , m.last_name 
from employees e, employees m
where e.manager_id = m.employee_id;

-- 외부조인(outer join)
-- 107건
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e, departments d
where d.department_id(+) = e.department_id;
-- 표준쿼리
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e left join departments d
  on d.department_id = e.department_id;
-- 122건
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e, departments d
where d.department_id = e.department_id(+);
-- 표준쿼리
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e right join departments d
  on d.department_id = e.department_id;
-- 표준쿼리 223건
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e full join departments d
  on d.department_id = e.department_id;

--------------------------------- 
-- 서브쿼리
-- 서브쿼리 :쿼리 안에 쿼리가 있다.
-- 조회하고자 하는 값을 모르는 경우 활용
-- 종류 : 단일행, 다중행 반환쿼리
-- 단일행 : =, >,<,>=,<=, !=, <>
-- 다중행 :  in, <any, >all,exist

select avg(salary)
  from employees;
  
-- 회사의 평균급여 이상 받는 직원의 이름, 급여를 조회..  
select last_name, salary
from employees
where salary >= (select avg(salary)
  from employees);
  
-- 회사의 최고급여를 받는 직원의 이름, 급여를 조회..
select last_name, salary
from employees
where salary = (select max(salary)
  from employees);

-- 연습문제
-- 1)회사의 직원중 'IT_PROG'직종의 평균 급여보다 많이 받는 직원의
-- 이름, 직종, 급여를 조회하시오..
select last_name,job_id, salary
from employees
where salary > (select  avg(salary)
                 from employees
                where job_id = 'IT_PROG')
; 
-- 2)Chen 과 같은 직종의 직원의 이름, 직종, 급여를 조회하시오.
select last_name,job_id, salary
from employees
where job_id in (select  job_id
                 from employees
                where last_name = 'Chen')
;
-- 3)영업부서(80)의 최소급여보다 많이 받는 부서의 
--   부서ID, 부서이름, 최소급여를 조회..
-- join, group by, having..
select e.department_id, d.department_name, min(salary) as min_sal
  from employees e, departments d
 where e.department_id = d.department_id 
group by e.department_id, d.department_name
having min(salary) > (select min(salary) 
                        from employees 
                       where department_id = 80)
;                       

-- 다중행 연사자의 사용
-- 다중행 :  in, <any, <all, >any, >all
-- in (or) : 모든 행의 값에 대응하는 값
--(9000,6000,4800,4200)
-- any(or)  : <any 최대값보다 적은값(9000), >any 최소값보다 큰값(4200)
-- all(and) : <all 최소값보다 적은값(4200), >all 최대값보다 큰값(9000)
select employee_id, department_id, job_id, last_name, salary
  FROM employees
 where salary in (select salary
                     from employees
                    where department_id = 60)
;                    
select employee_id, last_name, job_id, salary
  FROM employees
 where salary <all (select salary
                     from employees
                    where department_id = 60)
;                    
select employee_id, last_name, job_id, salary
  FROM employees
 where salary <any (select salary
                     from employees
                    where department_id = 60)
;  
-- 서브쿼리에 Between의 사용
select employee_id, last_name, job_id, salary
  FROM employees
 where salary between (select min(salary)
                     from employees
                    where department_id = 60) 
                  and (select max(salary)
                     from employees
                    where department_id = 60)
;
