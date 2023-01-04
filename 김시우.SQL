--접속
sqlplus hr/hr 계정으로 접속하는것
        id pw
--학습용 테이블 조회
select table_name from user_tables;

--테이블의 구조 조회
desc departments;
desc employees;

--sqlplus 환경설정

column deqartments_name format a18;
column last_name format a18;

ed = 전에 실행했던 명령어를 메모장으로 보여줌

show user = 내가 접속한 계정이 어떤계정인지 확인
--테이블 부서정보를 조회
select * from departments; = 
select * from employees; 
select department_name from departments;

-------------------------------------
--DQL( Data Query Language)
-------------------------------------
-- query 문은 소대문자를 구병하지 않는다.
-- select
-- from
-- 생략이 가능하다 [where
-- group by
-- having
-- order by]
-- 1. select 절의 사용
--  1) * :from 절에 지술한 테이블의 모든 항목조회
      select * from departments; -- 전체조회하는 것을 셀렉션 이라한다.
--	  2) 컬럼명 : from 절에 기술한 테이블에 존재하는 항목
	  select department_name 
	  from departments;
	  select department_id, department_name
	    from departments; --항목별로 조회하는것을 프로잭션 이라한다.
--		-여러개의 항목을 기술할 경우는 , 로 구분하여 나열한다.
      3)distinct : 중복을 제거 한다.
	  select job_id from employees; = 불러오기
	   select distinct job_id 
	   from employees; = job_id; 에있는 중복된 아이디를 제거
	   select department_id, job_id 
	   from employees; = department_id 와 job_id 중복된 아이디를 조회
	   select distinct department_id, job_id 
	   from employees; = department_id 와 job_id 중복된 아이디를 제거
--    4) 별명(alias)
--        열명은 대문자로 표기된다.
--        숫자는 오른쪽, 문자열은 왼쪽에 정렬된다.
--        테이블 명을 별명으로 보여지게 함 띄어쓰기 또는 as,""(대소문자구별가능,띄어쓰기도 가능) 로 별명을 줄수있다.
       select department_id as did, job_id as job 
	   from employees;
	   select department_id  did, job_id  job 
	   from employees;
       select department_id  "D id", job_id  "job" 
	   from employees;	   
--    5) 연산이 가능하다. (+,-,*,/)
       select last_name, salary * 12
         from employees;	   
	   select last_name, (salary * 12) as annsal
         from employees;			 
--	  6) null : 연산에 참여할때는 결과가 null 이다.			 
	   select last_name, (salary * commission_pct) as bonus
         from employees;	   
	   select last_name, 
	          (salary * commission_pct) as bonus,
	          ((salary * commission_pct) + salary) as salbon 
         from employees;	
--    7) 문자열의 연결
       select first_name || last_name
	   from employees;
       select (first_name ||'_'|| last_name)
	   from employees;		
	  
	  
--2. From 절의 사용
      1) 테이블명, 복수개의 테이블명(조인)
      2) view 명
      3) 데이터 셋(Inline Query)	  
	  4) 가상의 테이블 Dual;
	   select 1+2 from dual;
	   select sysdate from dual;
	   
--3. where(조건절) 절의 사용
      - 사용하는 비교연산자 : = , > , <, !=(<>), >=,<=
        irum !=(<>) 'inho' : inho가아닌것을 조회	 
      예) select department_id,last_name, salary
           from employees
           where salary < 10000
             and department_id = 50;	
         			 
      - 등식을 이용한다. (a=b)
      - 여러개의 등식은 and, or 로 연결한다.	  
       a=b and b=c , a>b or b<c 
      - 문자열, 날짜의 값을 비교할때는 홀따음표 ('')를 사용한다.
	  - 값을 비교할때는 대소문자를 구별한다.
	   SELECt = select , FROM = from
	   a = 'inho', a= 'INHO' 다르다
	  - 산술 연산이 가능하다.
	   
	   where salart * 12 > 150000
	  - 연결연산자도 사용가능
	   where first_name || last_name = 'SinInho'
	                                 이사람을 찾아줘라
	  - 연산자의 우선 순위가 있다.		(and, or);
      예) select last_name, job_id ,salary
          from employees
          where job_id = 'IT PROG'
             or job_id = 'AD PRES'
            and salary > 15000;			 
	  - 범위를 사용 2가지
	      select last_name, job_id ,salary
          from employees
		  where salary >= 5000
		  and salary <= 10000;
		 -- (=)
		  select last_name, job_id, salary
          from employees
		  where salary BETWEEN 5000 and 10000;
	 -- 소속 (포함)
	   -- 예) 
        select department_id, job_id ,salary
          from employees
		  where department_id = 10
		   or department_id = 30
		   or department_id = 70;
         -- (=)
          select last_name, last_name ,salary,department_id
          from employees
		  where department_id  in(10,30,70);
	  -- 비슷한 자료의 조회:like	
         select department_id, last_name ,salary
          from employees
		  where last_name like '%s%';
		  %s% : s가 들어가있는 문자열을 조회
		  %s : s로 끝나는 문자열을 조회 
          % : 다수의 문자열과 매칭
          _ : 한문자와 매칭		  
		  '%a__' : 끝에서 3번째가 a인 사람을 조회 
	 
	 -- null 의 비교
	  select  last_name, commission_pct 
          from employees
		  where commission_pct is not null;
		  
--    4. order by 절 : 정렬
       - 컬럼명 , 별명 [ asc || desc(반대로 정렬)]
	    기본값 asc
	   - 다중 컬럼명
	     col-1, col-2 desc, col-3
	 예) select  department_id,job_id,last_name, salary 
          from employees
		  order by last_name desc;
		  여러가지 섞어서 정렬
		  select  department_id,job_id,last_name, salary 
          from employees
		  order by department_id,job_id,salary desc;
-- 5. query 의 실행 순서
        from > where > select > order by
       예) select department_id, job_id, 
	   last_name as irum , salary
	   from employees
	   where last_name like '%s'
       order by irum;
	   문제 1 사원번호가 176인 사원과 이름과 부서 번호를  출력
	   select last_name, department_id 
	   from employees
	   where employee_id = 176;
	   문제 2 연봉이 120000 이상되는 사원들의 이름 및 연봉출력
	   select last_name, salary*12
	   from employees
	   where salary*12 >= 120000;
	   문제3 30부서에서 근무하는 직원중 직종이 PU_MAN인 직원의
	   사원번호 , 이름 ,직종 ,급여 , 부서번호를 조회
	   select  last_name , job_id ,salary ,department_id
		from employees
		where department_id = 30
		and job_id = 'PU_MAN';
		문제4 연봉이 150000에서 200000의 범위 이외인 사원들의
		이름 및 변봉을  출력 단 연봉은 AnnSal로 출력하시오
		select last_name ,(salary *12) as "AnnSal"
		from employees
		where salary * 12 not between 150000 and 200000;
	    문제4 2003/01/01 일부터 2005/05/30 일 사이에 고용된 사원들의
		이름 사번 고용일자를 출력하시오 고용일자 역순으로 정력하시오
		select last_name,employee_id,hire_date
		from employees
		where hire_date  between'03/01/01'and'05/05/30'
		order by hire_date desc;
		문제5 20이나 50부서에서 근무하는 모든사원들의 이름 및 부서 번호를
		조회하고 이름을 알파벳 순으로 출력하시오
		select last_name,department_id
		from employees
		where department_id in ( 20 , 50)
		order by last_name asc;
		문제6 2006년도에 고용된 모든 사람들의 이름및 고용일을 조회
		select last_name, hire_date
		from employees
		where hire_date like '%06/__/__'; 또는 '06%'
		문제7 20 또는 50 부서에 근무하며 연봉이 20000~ 250000 사이인
		사원들의 이름 및 연봉 출력하시오
		select last_name ,salary*12
		from employees
		where department_id in (20,50)
		and salary*12 between '20000' and '250000';
		문제8 매니저가 없는 사람들의 이름 및 직종을 출력하시오
		select last_name , job_id
		from employees
		where manager_id is null;
		문제9 매니저가 있는 사람들의 이름 및 직종, 매니저번호를 조회한다
		select last_name , job_id , manager_id
		from employees
		where manager_id is not null;
		문제10 커미션을 받는 모든 사원들의 이름 연봉 및 커미션을 출력하시오
		-연봉을 역순으로 정렬하고 연봉은 ANNSAL로 출력하시오
		select last_name, salary as annsal, commission_pct
		from employees
		where commission_pct is not null
		order by  annsal desc;
		문제11 이름이 네번째 글자인 h인 사원의 이름을 조회하시오
		select last_name
		from employees
		where last_name like  '___h%';
		문제12 이름에 a와 e 글자가 있는 사원의 이름을 조회하시오
		select last_name
		from employees
		where last_name like '%a%'
		and last_name like '%e%';
		문제13 급여가 2500,3500,7000이 아니며 직업이 SA_REP
		나 ST_CLERK인 사원의 이름과 급여 직업을 출력하시오
		select last_name , salary , job_id
		from employees
		where  salary not in(2500,3500,7000)
		and job_id in ('SA_REP' , 'ST_CLERK');
		
		select last_name , salary , job_id
		from employees
		where  (salary <> 2500
		  and salary <> 3500
		  and salary <> 7000)
		and (job_id = 'SA_REP' 
         or job_id = 'ST_CLERK');
		
		MANAGER_ID  : 관리자번호
		salary : 급여
		job_id : 직종
		employee_id : 사원번호
		department_id : 부서번호
		EMAIL : 이메일
		COMMISSION_PCT : 보너스퍼센트
		PHONE_NUMBER : 폰넘버
		
-----------------------------------
-- 단일행 함수
-- 함수의 분류 : 내장함수 , 사용자 정의 함수의
-- 내장함수 종류 : 단일행 함수, 다중행 함수
-- 단일행 함수 : 문자, 숫자, 날짜
-- 문자 관련 함수 : lower, upper, initcap, concat
--             substr, length, instr, replace, trim
-- 숫자 관련 함수 : round, trunc, mod
-- 날짜 관련 함수 : sysdate, months_between, add_months, last_day		
-- 일반 함수 : nvl, case

select lower('sinhinho') from dual;	--lower 소문자로 해줌
select length('sinhinho') from dual; -- 문자열의 길이를 알려줌
select instr('sinhinho','i'), from dual; -- 문자열의 찾고싶은 단어가 몇번째에 있는지 알려줌
select substr('sinhinho',5,4) from dual; -- 5번째부터 4개의 문자열을 출력하겠다
select replace('sinhinho','h','*') from dual; -- h의 단어를 *로 바꿔서 출력하겠다

select last_name, substr(last_name,2,2) exirum
from employees; -- 이름에 2번재부터 2글자만 출력해라
select last_name, replace(last_name,'s','*') exirum,
length (last_name) len_irum -- 이름에 s를 *로표시하고 이름이 몇글자인지 출력해라
from employees;

--숫자 관련 함수
select round(12.345678,2) as ron2 from dual; -- 12.345678 소수를 2자리 소수까지 반올림해라
select trunc(12.345678,2) as trun2 from dual; -- 소수점 2자리까지 출력하고 나머지는 버려라
select mod(10,3) as mod2 from dual; -- 나머지가 1이다 자바로치면 % 임
select mod(10,3) as mod2,
round(10/3,2)  from dual; -- 나머지가 1이고 몫을 구했을때 소숫점 2자리까지만 출력해라

--날짜 관련함수
select sysdate from dual; -- 오늘 날짜를 출력해라
select months_between ( '2022-1231',sysdate)from dual; -- 입력한 날짜와 몇정도 남았는지 출력시 1.8개월 나옴
select sysdate +5 from dual; -- 오늘 날짜부터 5일뒤 날짜를 출력해라
select add_months(sysdate,2) from dual; -- 오늘날짜부터 2개월 뒤를 출력해라
select last_day(sysdate) from dual; -- 이번달의 마지막 날짜가 언제인지 출력해라
select last_day('2022-05-10') from dual; --입력한 날짜의 마지막 날짜가 언제인지 출력해라

-- 자료의 형변환 : 묵시적 , 명시적 형변환이 있다
-- 묵시적 형변환 예)
select 1 + '2' from dual; -- '2' 는 무자열이지만 1이 숫자이기때문에 자동형변환되서 숫자로됨
select 1 || 2 from dual; -- ||가 문자열이기때문에 숫자여도 문자로 나옴
 -- 우선순위가 산술연산자이기때문에 + or || 이 우선이됨
 
-- To_char : 숫자 또는 날짜 데이터를 문자로바꿀때쓴다 형변환
-- to_number : 숫자로 바꿀때
-- to_date : 날짜로바꿀때
select to_char(12345) num1 from dual; -- 숫자를 문자로 바꾼것
select to_number('12345') name from dual; -- 숫자이지만 문자열로된것을 숫자로 바꾸는것
select to_date('2022.11.04') day1 from dual; -- 문자열로된 날짜를 날짜형 데이터로 형변환

select to_char(to_date('2022-02-28'),'yyyy-mm') dat1 from dual;
select to_char(hire_date ,'yyyy-mm') dat1 from employees; -- 입사일을 년 월만 출력하겠다

select to_char(hire_date ,'yyyy-mm') hire_date,
       to_char(salary,'99,999') salary
	   from employees;  -- 입사일은 년월만 출력하고 월급은 3자리마다 ,를 찍겠다.

--일반 함수 : nvl, case, decode
-- uvl(값, 기본값)
select last_name, salary * nvl (commission_pct,0)
from employees; -- 보너스가 null 이라면 0을 넣어라

--case
-- 직종이 IT_PROG 인사람은 10% , ST_CLERK 인사람은 15%
--SA_REP 인사람은 20% 보너스를 지급하고
--이름 직종 급여 보너스 금액을 조회하시오
SELECT last_name, job_id, salary, 
      (case job_id
          when 'IT_PROG' then salary *1.10
          when 'ST_CLERK' then salary *1.15
          when 'SA_REP' then salary *1.20
		  else salary
		  end) as bonsal
		  from employees;
		  
    문제1
	직원들의 이름에서 3번째 부터 2자를 추출 하여 열명을
	sub_irum 으로 사용하여, 이름과 같이 조회하시오
	select last_name ,substr(last_name,3,2) sub_irum
    from employees;
    문제2
	직원들의 이름중에 s가 포함되어 있는 직원의 이름 직종 급여를 조회하시오
    select last_name,job_id,salary 
	from employees
	where  instr(last_name,'s')  > 0 ;
    문제4
	직원들의 전화번호에 '.' 를 - 로 변경하고 열명을 re_phone으로 하고
	이름과 함께 조회하시오
	select replace(phone_number,'.','-') re_phone, 
	last_name
    from employees;	
    문제5 직원들의 이름 이 5자 이상인 직원의 부서 id 이름 직종
	급여를 조회하시오
	select department_id, last_name ,job_id ,salary
	from employees
	where length(last_name) >= 5;
    문제6 직원들의 이름 급여 보너스 보너스를 포함한연봉 annsal 을 조회하고
	모든 금액은 3자리마다 ","로 구분하여 조회한다.
	select last_name,salary,to_char(salary * commission_pct,'99,999') as bonus,
	to_char(salary  * (1+ nvl(commission_pct,0))* 12,'999,999') as Annsal
	from employees;
    
-- 다중행 함수(그룹, 집계함수)
-- 종류 : sum(), avg(), count(), min(), max()
-- 숫자에 사용되는 함수 : sum(), avg()
-- 문자,숫자 같이사용되는 함수 : max(), min(), count()
-----------------------------------------
-- group by 절의 컬럼은, 동일하게 select절에 기술한다.
select department_id,
         sum(salary) as sum_salary, avg(salary) as avg_salary,
         count(salary) as count_salary, max(salary) as max_salary,
         min(salary) as min_salary
from employees
group by department_id 
order by department_id;

-- where절은 select 절에 data를 제한하고
-- having절은 group by 절의 data를 제한 한다
select department_id,job_id,
         sum(salary) as sum_salary, avg(salary) as avg_salary
from employees
group by department_id,job_id
having avg(salary) > 8000;

select department_id,job_id,
         sum(salary) as sum_salary, avg(salary) as avg_salary
from employees
where department_id in (50,60,70,80)
group by department_id,job_id
having avg(salary) > 5000;
-- 중첩한 집계함수의 사용.
-- 부서별 평균 급여가 가장 많은 금액은 얼마인가요?
select max(avg(salary))
from employees
where department_id in(50,60,70)
group by department_id;

--문제 직종별, 평균급여, 최고급여를 조회하시오
select job_id, 
avg(salary) as "avg_salary" , max(salary) as "max_salary"
from employees
group by job_id;
--문제 직종별, 평균급여, 최고급여를 조회하시오
--(단 평균급여가 5000이하인 직종을 조회)
select job_id, 
avg(salary) as "avg_salary" , max(salary) as "max_salary"
from employees
group by job_id
having avg(salary) <= 5000;
--우리 회사의 직원의 최고 급여와 최저 급여, 최저,최고급여의 차이를 조회하시오
select job_id,
       max(salary), min(salary),
       (max(salary) - min(salary)) as sla_cha
from employees
group by job_id
having (max(salary) - min(salary)) > 1000;

-- 우리회사의 직원의 가장 오랜 근속년수, 최저 근속년수, 근속년수(년)의 차이를 조회하시오
select 
       max(hire_date),min(hire_date) as max_hrie,
        max(hire_date)- min(hire_date) as cha_day,
       round((max(hire_date) - min(hire_date))/ 365,0) as max_cha,
       to_char(max(hire_date),'yy') - to_char(min(hire_date),'yy') as cha_yy
from employees;

------------------------------
--조인
--컬럼을 가로로 연결하는 효과가 있다.
--조인 조건이 없는 경우는 카티션 곱의 효과발생(오류)
--카티션곱(cartesisan prodeuct)
--두개의 테이블의 데이터 개수(107*27)를 곱하는 결과

select *
from employees, departments;

--조인한 테이블에 같은 이름의 컬럼이 있는 경우,
해당 테이블을 기술한다.
select employees.employee_id, employees.last_name, 
departments.department_name,
employees.department_id as did1, 
departments.department_id as did2
from employees, departments;

--조인한 테이블은 별명(alias)을 사용할수 있다
select e.employee_id, e.last_name, 
d.department_name,
e.department_id as did1, 
d.department_id as did2
from employees e, departments d;
-- 조인 조건
-- 최소테이블의수 - 한개의 조인 조건이 필요.
select e.employee_id, e.last_name, 
d.department_name,
e.department_id as did1, 
d.department_id as did2
from employees e, departments d
where e.department_id = d.department_id;
-- 직원테이블(employees) 부서정보(department_id)를 참조하는 부서코드
select distinct department_id
from employees;

--조인의 종류
--등가(=):inner,비등가조인,자체조인,외부조인(outer join):left, right ,full)

--등가조인(=)
select e.employee_id, e.last_name, 
e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.department_id = 50;

-- 비등가조인(between, >, < 비교연산자 사용 =을 제외한)
select e.last_name, e.salary, grade_level
from employees e, job_grades j
where e.salary between j.lowest_sal and j.highest_sal;

--자체 조인
--직원의 이름,급여,상관의 이름을 조회하시오
select e.employee_id, e.last_name, e.salary, e.manager_id, m.last_name 
from employees e, employees m
where e.manager_id = m.employee_id;

--외부조인
select e.employee_id, e.last_name, 
e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
--표준쿼리
select e.employee_id, e.last_name, 
e.department_id, d.department_name
from employees e left join departments d
where e.department_id = d.department_id;
--
select e.employee_id, e.last_name, 
e.department_id, d.department_name
from employees e, departments d
  on e.department_id = d.department_id(+);
--표준쿼리
select e.employee_id, e.last_name, 
e.department_id, d.department_name
from employees e right join departments d
  on e.department_id = d.department_id;
  
  select e.employee_id, e.last_name, 
e.department_id, d.department_name
from employees e full join departments d
  on e.department_id = d.department_id;

----------------------------------------
--서브쿼리
--서브쿼리 : 쿼리안에 쿼리가있다.
--조회하고자 하는 값을 모르는 경우 활용
--종류 : 단일행 , 다중행 반환쿼리
--단일행 : =, >, <, >=,<=,!=,<>
--다중행 : in, <any, >all,exist
select avg(salary)
from employees; -- 회사의 평균급여

--회사의 평균급여 이상 받는직원의 이름 급여를 조회.
select last_name, salary
from employees
where salary <= (select avg(salary)
from employees);

--문제1 회사의 최고 급여를 받는 직원의 이름 급여를 조회
select max(salary)
from employees;

select last_name, salary
from employees
where salary >= (select max(salary)
from employees);

--문제2 회사의 직원중 IT_PROG 직종의 평균 급여보다 많이 받는
--직원의 이름 직종 급여를 조회하시오
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                    from employees
                    where job_id = 'IT_PROG');
                    
--문제3 Chen 과 같은 직종의 직원의 이름, 직종 ,급여를 조회하시오
select last_name, job_id, salary
from employees
where job_id in (select job_id
                 from employees
                 where last_name = 'Chen');
                 
--문제4 영업부서 80의 최소 급여보다 많이 받는 부서의 부서id
--부서이름 최소급여를 조회하시오
select e.department_id,d.department_name,min(e.salary) as min_sal
from employees e,departments d
where e.department_id = d.department_id
group by e.department_id,d.department_name
having min(e.salary)> (select min(salary)
                         from employees
                         where department_id = 80);
   
--다중행 연산자의 사용                     
--다중행 : in, <any, >all,exist
--in (or)   : 모든 행의 값에 대응 하는 값
--(9000,6000,4800,4200)
--any (or)  : <any 최대값보다 적은값(9000), >any 최소값보다 큰값(4200)
--all (and) : <all 최소값보다 적은값(4200), >all 최대값 보다 큰값(9000);

select employee_id, last_name, job_id, department_id, salary
  from employees
where salary in (select salary
                     from employees
                    where department_id =60);
--60부서에는 9000 4800 6000 4200 의 급여를 받는직원만 있기떄문에
--급여가 같은 거만 출력됨
select employee_id, last_name, job_id, department_id, salary
  from employees
where salary <all (select salary
                     from employees
                    where department_id =60);
--60부서에 최소값은 4200이기떄문에 4200이하의 급여를받는 직원을출력
select employee_id, last_name, job_id, department_id, salary
  from employees
where salary <any (select salary
                     from employees
                    where department_id =60);
--60부서의 최대급여는 9000이므로 9000보다 작은 급여를 받는직원이 출력됨                    

--서브쿼리에 between의 사용
select employee_id, last_name, job_id, department_id, salary
  from employees
where salary between (select min(salary)
                       from employees
                       where department_id =60)
                      and (select max(salary)
                       from employees
                       where department_id =60);
                       
--문제 회사 전체의 최대 급여, 최소급여, 급여총합 및 평균급여를 출력
select max(salary),min(salary),sum(salary),avg(salary)
from employees;
--문제 각 직업별 최대급여 최소 급여 급여 총합 및 평균 급여를 출력하시오
--단 최대급여는 max 최소급여는min 급여 총합은sum 및 평균급여는
--avg로 출력하고 직업을 오름차순으로 정렬하시오
select job_id, max(salary) as max_,min(salary) as min_
,sum(salary)as sum_,avg(salary) as avg_ 
from employees
group by job_id
order by job_id;

문제 동일한 직종을 가진 사원들의 총수를 출력하시오
select job_id,count(employee_id)
from employees
group by job_id;

select job_id,count(*)
from employees
group by job_id;

문제 매니저로 근무하는 직원의 총수를 출력하시오
select  count(distinct manager_id)
from employees;

문제 사내의 최대 급여 및 최소 급여의 차이를 출력하시오
select max(salary) - min(salary)
from employees;

문제 매니저의 사번 및 그매니저 밑 사원들중 최소 급여를 받는 사원의
급여를 출력하시오
-매니저가 없는 사람들은 제외
-최소 급여가 5000 미만인 경우는 제외
-급여기준 역순으로 조회
select manager_id , min(salary)
from employees
where manager_id is not null
group by manager_id 
having min(salary) >= 5000
order by min(salary) desc;

문제 급여합계가 10000보다 많은 직원의
-부서, 직종별 급여합계 , 평균급여 , 직원수를출력하시오
-급여 sum_sal는 3자리마다 ","형식으로
-평균급여 avg_sal는 소수점이하 2자리까지 출력하시오
select department_id , job_id , 
to_char(sum(salary),'999,999') as sum_sal , 
to_char(avg(salary),'99,999.99')as avg_sal, 
count(*)
from employees
group by department_id , job_id
having sum(salary) > 10000
order by department_id , job_id;

문제 모든사원들의 이름 부서 이름 및 부서 번호를 출력하시오
select e.last_name, d.department_name, e.department_id
from employees e, departments d
where e.department_id = d.department_id;

문제 커미션을 받는 모든 사람들의 이름 부서명 지역 id 및 도시명을 
출력하시오
select e.last_name, d.department_name, l.location_id, l.city
from employees e, departments d ,locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.commission_pct is not null;

문제 Zlotkey와 동일한 부서에 근무하는 모든 사원들의 사번 및
고용날짜를 출력하시오.
select employee_id, hire_date
from employees
where department_id in (select department_id
                 from employees
                 where last_name = 'Zlotkey')
and last_name != 'Zlotkey';

문제 회사 전체 평균 급여보다 더 급여를 많이 받는 사원들의
사번 및 이름을 출력하시오.
select last_name,employee_id
from employees
where salary > (select avg(salary)
                 from employees);
                 
문제 이름에 u가 포함되는 사원들과 동일 부서에 근무하는 사원들의
사번 및 이름을 출력하시오
select last_name , employee_id
from employees
where department_id in (select distinct department_id
                       from employees
                       where last_name like '%u%')
and last_name not like '%u%';

문제 이름이 Davies 인 사람보다 후에 고용된 사원들의 이름 및
고용일자를 출력하시오 고용일자를 역순으로 출력하시오
select last_name,hire_date
from employees
where hire_date >all (select hire_date
                    from employees
                    where last_name = 'Davies')
order by hire_date;

문제 king 을 매니저로 두고있는 모든 사원들의 이름 및 급여를 출력하시오
select last_name, salary, manager_id
from employees
where manager_id in (select employee_id
                     from employees
                    where last_name = 'King');
                    
---------------------------------------------------
-- DML(Date Manipulation langeage)
-- 종류 : lnsert, update,delete
---------------------------------------------------
-- insert 문
-- 테이블에 새로운 행을 추가한다. 행단위의 처리
-- 문법
-- 1. 컬럼의 순서 ,속성, 갯수가 1:1로 대응되어야 한다.
-- 사용예1.)
  insert into departments values(300,'AI big data',114,1400);
--300 = department_id  (숫자)                  
--AI big data = department_name   (문자)  
--114 = manager_id (문자)
--1400 = location_id (숫자)
-- 사용예2.)
  insert into departments (
  DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
  values(301,'AI big data',114,1400); 
  select* from departments;
-- 사용예3.)
  insert into departments (
  department_id, department_name)
  values(302,'AI big data');
-- 사용예4.)
  insert into departments (
  DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
  values(303,'AI big data',null,null); 
  select* from departments;
-- 사용예5.)  
  insert into departments (
  DEPARTMENT_NAME,DEPARTMENT_ID)
  values('AI big data',304); 
  select* from departments;

-- subquery를 이용한 데이터의 삽입
create table tmp_emp01(
   empid number,
   lname varchar(30),
   sal number,
   bonus number(5,2),
   cdate date);
   
   select * from tmp_emp01;
 -------  
  insert into tmp_emp01 (
  select employee_id, last_name, salary, commission_pct,sysdate
  from employees);

--update 문
-- 컬럼단위의 수정이 가능하다.
update table명
  set col01 = val0l,
      col02 = val02,
      col03 = val03
[ where 조건식 ];
select * from departments;
  
update departments         --302번의 직원의
   set manager_id = 108,   --매니저아이디를 108번으로 바꾸겟다
       location_id = 1800  --나라번호를 1800번으로 바꾸겟다
where department_id = 302;       
-- tmp_emp01에 전체 직원의 평균 급여보다 적은 직원의 급여를 5%인상하시오
-- subQuery를 이용한 데이터의 수정
select empid,lname, sal
   from tmp_emp01
 where sal < (select avg(sal) from tmp_emp01);

update tmp_emp01
   set sal = sal + (sal * 0.05)
 where sal < (select avg(sal) from tmp_emp01);  
  
-- delete 문
-- 행단위의 작업
delete [from] table명 --[]는 생략가능 
[where 조건식];  
select * from departments;
delete departments
where department_id >= 300;

-- tmp_emp01에 전체 직원의 평균 급여 이상 받는 직원의 정보 삭제
-- subQuery를 이용한 데이터 삭제
select empid, lname, sal
from tmp_emp01
 where sal >= (select avg(sal) from tmp_emp01);  
  
delete tmp_emp1
 where sal >= (select avg(sal) from tmp_emp01);   
  
delete from tmp_emp1;

-- TCL(Transaction Control Language)
-- DML 작업을 하면 트랜잭션이 발생한다.
-- 여러 작업들을 하나로 묶는 단위이다.
-- ACID : 원자성(A), 일관성(C), 격리성(I),영속성(D)
-- Trasaction의 종료 : 명시적, 묵시적
-- 명시적종료 : commit, rollback , rollback to
-- 묵시적종료(commit) : 세션을 종료, DDL작업
-- 명령어 : commit, rollback , savepoint , lock , unlock

-- lock 실험
update departments
set department_name = 'ai progrm'
where department_id = 300;

commit;
rollback;
CREATE TABLE my_employee
( id	 NUMBER(4) not NULL,
 last_name VARCHAR2(25),
 first_name VARCHAR2(25),
 userid VARCHAR2(8),
 salary	 NUMBER(9,2)
);

--ID	LAST_NAME	FIRST_NAME, USERID	salary
--1,	Patel,	Ralph,	rpatel,	895
--2,	Dancs,	Betty,	bdancs,	860
--3,	Biri,	Ben,	bbiri,	1100
--4,	Newman,	Chad,	cnewman,	750
--5,	Ropeburn,	Audrey,	aropebur,	1550

--문제 my_employee 테이블을 생성하십시오
CREATE TABLE my_employee1
( id	 NUMBER(4) not NULL,
 last_name VARCHAR2(25),
 first_name VARCHAR2(25),
 userid VARCHAR2(8),
 salary	 NUMBER(9,2)
);
--문제 1,2행에 insert절을 이용해 my_employee에 추가하시오
insert into my_employee 
values(1, 'Pater', 'Ralph', 'rpater', 895);
insert into my_employee 
values(2, 'Dancs', 'Betty', 'bdancs', 860);
--문제 데이터의 3,4행을 my_employee 테이블에 추가하십시오
--insert절에 열을 명시적으로 나열하십시오.
insert into my_employee 
(ID,LAST_NAME,FIRST_NAME,USERID,salary)
values(3, 'Biri', 'Ben', 'bbiri', 1100);
insert into my_employee 
(ID,LAST_NAME,FIRST_NAME,USERID,salary)
values(4, 'Newman', 'Chad', 'cnewman', 750);


--문제 사원 3의 성을 Drexler로 변경하십시오
update my_employee
set first_name = 'Drexler'
where id = 3;

--문제 급여가 900 미만인 모든 사원의 급여를 1000으로 변경하십시오
update my_employee
set salary = 1000
where salary < 1000;

--문제 my_employee 테이블에서 betty dancs를 삭제하십시오
delete my_employee
where id = 2 ;

--문제 영구 보관되지 않고 보류중인 변경내용을 모두 영구 보관하시오
commit;

--문제 예제 데이터의 5행을 my_employee테이블에 추가하십시오
--userid 컬럼을 제외하고 데이터를 추가하시오
insert into my_employee 
(ID,LAST_NAME,FIRST_NAME,salary)
values(5, 'Dancs', 'Betty', 860);

--dml수행중 발생한 드랜잭션의 현재위체에 save 저장점을 표시하시오
savepoint save ;

--문제 테이블의 내용을 모두 삭제하십시오
delete from my_employee;
--문제 테이블의 내용을 확인하십시오
select * from my_employee;
--문제 이전의 insert 작업은 버리지말고 최근의 delete 작업만버립십시오
rollback to save;

---------------------------------------------------
--DDl(Data Definition Language)
--ddl의 종류 : create--삽입,alter--수정,drop--삭제,
--           truncate--테이블삭제, rename--이름변경, comment--주석
--컬럼의 속성
--문자 : char, varchar, varchar2
--숫자 : number, number(5),number(5,2)--소수점까지
--날짜 : date, timestmp-- 1000/1초까지나옴
--------------------------------------------------
--테이블의 생성
create table tmp_emp (
  empid  number,
  laname varchar(30),
  sal    number,
  bouns  number(5,2),
  cdate  date
);
-- 서브쿼리를 이용한 테이블의 복사
-- 전체복사(data+컬럼)
create table tmp_emp10 as
  select * from employees;
-- 일부 항목 복사 및 열명(머리글)을 복사 (일부컬럼 + 전체data)
create table tmp_emp20 as
  select employee_id empid, last_name lname, salary sal, commission_pct bonus,sysdate cdate
  from employees;
-- 빈 테이블의 생성 (전체 컬럼 복사)
create table tmp_emp30 as
  select * 
  from employees
  where 1<> 1;

-----------------------
--테이블의 변경(alter)
--테이블에 열(column) 추가 add
alter table tmp_emp11
 add(udate date);
--열(column)의 자료형을 변경 modify 
alter table tmp_emp11
 modify(lname varchar2(30)); 
--테이블 열(column) 이름을 변경 rename
alter table tmp_emp11
 rename column lname to last_nm;
--테이블 열(column)을 삭제 drop
alter table tmp_emp11
  drop (udate);
--테이블 열(column)에 주석달기  
comment on column tmp_emp11.empid is '사원번호'; 
comment on column tmp_emp11.last_nm is '직원이름'; 
comment on column tmp_emp11.sal is '급여'; 
comment on column tmp_emp11.bonus is '보너스';

--테이블에 주석달기
comment on table tmp_emp11 is '직원정보';
--세부정보에서 볼수있음
--테이블에 이름변경
rename tmp_emp11 to tmp_emp21;

-- truncate : 전체 data를 삭제한다.
-- truncate는 롤백 안됨
select * from tmp_emp10;
delete  from tmp_emp10;
rollback;
truncate table tmp_emp10;

-- drop : 테이블을 삭제한다
drop table tmp_emp;
drop table tmp_emp21;
drop table tmp_emp30;

-- 제약조건
-- 제약조건은 데이터의 무결성을 보장하기 위해 사용한다.
--   무결성 : 데이터의 정확성과 일관성을 유지
--    (영역, 개체, 참조무결성)
-- 종류 : primary key, unique, not null, foreign key, check
-- primary key : 중복 과 null 값이 허용이 안된다.
-- not null : 값이 있어야 한다
-- unique : 중복이 허용안됨,null값은 허용
-- foreign key : 외부키를 참조
-- check : 입력되는 값의 범위를 검증

-- 제약조건을 주는 방법
  --. 열 수준에서 부여
  --. 테이블 수준에서 부여.
  --. 제약조건의 이름은 유일해야한다.
------------------------------------
-- sys_c007022
select * from user_constraints
where table_name = upper('emp_10');
  
-- 열단위의 제약조건 부여
drop table emp_10;
create table emp_10 (
    emp_id number(4) constraint emp_pk primary key,
    lname varchar2(20) constraint emp_lname_nn not null,
    email varchar2(30) unique,
    hdate date default sysdate,
    job_id varchar(15),
    sal number(8) constraint emp_sal_ck check(sal between 1000 and 20000),
    bonus number(5,2),
    mgr_id number(4),
    dept_id number(4) references departments(department_id)
);
select * from emp_10;
insert into emp_10 (emp_id, lname, email)
values (10, 'kim siwoo', '1m10d@naver,com');
insert into emp_10 (emp_id, lname, email)
values (20, 'kim siwoo', '1m10d1@naver,com');
insert into emp_10 (emp_id, lname, email)
values (30, 'kim siwoo', '1m10d2@naver,com');
insert into emp_10 (emp_id, lname, email,sal)
values (40, 'kim siwoo', '1m10d3@naver,com',19000);

--테이블 수준에서의 제약조건 부여..
select * from emp_20;
drop table emp_20;
create table emp_20 (
    emp_id number(4)
    ,lname varchar2(20) num null
    ,email varchar2(30)
    ,hdate date default sysdate
    ,job_id varchar(15)
    ,sal number(8)
    ,bonus number(5,2)
    ,mgr_id number(4)
    ,dept_id number(4)
    ,constraint emp20_pk primary key(emp_id)
    ,constraint emp20_sal_ck check (sal between 1000 and 20000)
    ,foreign key (dept_id) references departments(department_id)
);    
insert into emp_20 (emp_id, lname, email)
values (10, 'kim siwoo', '1m10d@naver,com');
insert into emp_20 (emp_id, lname, email)
values (20, 'kim siwoo', '1m10d1@naver,com');
insert into emp_20 (emp_id, lname, email)
values (30, 'kim siwoo', '1m10d2@naver,com');
insert into emp_20 (emp_id, lname, email,sal)
values (40, 'kim siwoo', '1m10d3@naver,com',19000);

create table dept (
    deptno number(2) constraint dept_pk primary key,
    dname varchar2(14) constraint dept_lname_nn not null,
    loc varchar2(13)
    );
insert into dept (deptno, dname, loc)
values (10,'Adminstration',1700); 
insert into dept (deptno, dname, loc)
values (20,'Maketing',1800); 
insert into dept (deptno, dname, loc)
values (30,'Purchasing',1700); 
insert into dept (deptno, dname, loc)
values (40,'Human',2400); 
insert into dept (deptno, dname, loc)
values (50,'Shipping',1500); 
select * from dept;
drop table emp_10;
create table emp_10 (
    empno number(4) primary key,
    ename varchar2(10) not null,
    job1 varchar2(9) not null,
    mgr number(4),
    hiredate date,
    sal number(7,2) not null,
    comm number(7,2),
    deptno number(7,2)
    );

insert into emp
values (100,'king','ad_pres',null,'1987/1/17',24000,null,10);
insert into emp
values (101,'kochar','ad_vp',null,'1989/9/21',24000,null,50);
insert into emp
values (102,'de haen','ad_vp',null,'1993/1/13',24000,null,50);
insert into emp
values (103,'hunold','it_prog',null,'1990/7/3',24000,null,40);
insert into emp
values (104,'ernst','it_prog',null,'1997/7/25',24000,null,40);

drop table emp;

select * from emp;
--------------------------------------------
-- 데이터 사전
-- user_xxxx, all_xxxx
select table_name, num_rows from user_tables;
select owner,table_name, num_rows from all_tables;
select * from all_tables
where owner = 'HR';
select object_name from user_objects
where object_type = 'TABLE';

-------------------------------
-- 객체의 생성
-- create 객체종류명(table,view..)

-- view 
-- 보안상 데이터를 부분적으로 접근할때 사용
-- 복잡한 질의를 쉽게 접근할때
-- 데이터의 독립성을 보장

-- 뷰의 생성
create view vw_emp5080 as (
    select last_name, job_id, (salary*12) annsal
    from employees
    where department_id in(50, 80)
);
-- 생성한 뷰를 조회
select * from vw_emp5080;
-- 생성한 뷰를 삭제
drop view emp5080;
-- 데이터 사전을 통한 조회
select object_name from user_objects
where object_type = 'VIEW';

create view vw_emp50 as (
    select last_name, job_id, 
    to_char(hire_date, 'yyyy-mm-dd') as hire_date,
    (salary*12) annsal
    from employees
    where department_id in(50)
);
select * from vw_emp50;

--inLine 뷰
-- 상위 급여 5명을 조회
select rownum, emp.*
from (select last_name, salary
from employees
order by salary desc) emp
where rownum <= 3;
--시험문제 냈다고함

-- 2.index
-- 검색속도를 높인다.
-- 물리적인 저장 곤간이 차지
-- 검색의 속도를 높이는 반면, DML insert, delete 
--                                작업속도를 저하시킨다
-- index 생성시 고려사항
-- 1) 열의 정보가 광범위하게 포함된경우
-- 2) 조건절, 조인이 자주 일어나는경우
-- 3) 대부분의 질의 경과가 2-4%미만의 경우
--시험문제
 select ename, job, sal
from employees
where department_id  in(select distinct department_id
                         from employees
                         where department_id = 40');
create index tmp_emp20_idx
    on tmp_emp20 (lname);
    
    select object_name from user_objects
where object_type = 'INDEX';

 select * from tmp_emp20
where lname like 'L%';
drop index tmp_emp20_idx;
-- 3.시퀀스(sequence)
-- 고유의 번호를 자동으로 생성한다.
-- 공유가 가능하다
-- 일반적으로 pk에 많이 사용한다

create sequence emp10_seq
    increment by 10
    start with 100
    maxvalue 9999999
    nocache
    nocycle;

select emp10_seq.nextval from dual;
select emp10_seq.currval from dual;

insert into tmp_emp20(empid,lname)
values (emp10_seq.nextval,'kim siwoo');
시험문제
select * from tmp_emp20;

-- 4.동의어(synonym)

create synonym emps for employees;
select * from emps;

-- 5. 함수(function)
-- 내장함수, 사용자 함수
create or replace function fn_dname (dept_id in int)
    return varchar
    is
    dnm varchar2(30);
begin
  select department_name into dnm
  from departments
  where department_id = dept_id;
  return dnm;
  end;
  /
  
select fn_dname(50) from dual;

select last_name, fn_dname(department_id) as deptnm, salary
from employees;

drop function fn_dname;
시험문제

-- 6. 트리거(trigger)
-- 백업테이블의 생성
create table tmp_emp20bak as
    select * from tmp_emp20 where 1 != 1;
    
select * from tmp_emp20bak;

-- 트리거의 생성
drop trigger emp_del;
create or replace trigger emp_del
    before delete on tmp_emp20 for each row
begin
 insert into tmp_emp20bak values (
 :old.empid,:old.lname,:old.sal,:old.bonus,sysdate);
end;
/
-- emp20이 삭제가되면 emp20bak에 자동저장되는지 조회
select * from tmp_emp20
where empid = 200;

select * from tmp_emp20bak
where empid = 200;

delete tmp_emp20
where empid = 200;
------------------------------------------
commit;

create table emp_tmp20 (
empno number(4) constraint empbak_pk primary key);
index ename_idx
on emp (ename)
);

-- DCL(Data controll language)
-- system 계정에서  실행
show user;
-- 사용자의 생성
create user siwoo identified by siwoo;
alter user siwoo identified by siwoo account unlock;
-- 연결 권한 부여
GRANT create session to siwoo;
-- 테이블 생성 권한
GRANT create table to siwoo;
-- 자원사용 권한
GRANT RESOURCE to siwoo;
--암호 변경
alter user siwoo identified by siwoo; 
-- 권한 회수
revoke create table from siwoo;

-- 사용자 계정이서 실행
select *from user_sys_privs;

create table tmp_emp (
empno number(4) primary key
,ename varchar2(10) not null
,job varchar2(9) not null
,mgr number(4)
,hiredate date
,sal number(7,2)
,comm number(7,2)
,deptno number(2)
);

create table emp_20 (
empno number(4) primary key
,ename varchar2(10) not null
,job varchar2(9) not null
,mgr number(4)
,hiredate date
,sal number(7,2)
,comm number(7,2)
,deptno number(2)
);
create table dept_10 (
deptno number(2) primary key
,dname varchar2(14) not null
,loc varchar2(13)
);

select last_name,job_id,salary,department_id
from employees
where job_id = (select distinct job_id
                    from employees
                    where department_id = 50
                    )
                    and department_id <> 50;
                    
select employee_id, hire_date
from employees
where department_id in (select department_id
                 from employees
                 where last_name = 'Zlotkey')
and last_name != 'Zlotkey';                    