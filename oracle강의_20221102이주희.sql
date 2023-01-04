-- �ΰ����� ���� ������ ����
-- 2022.10.27 ~ 23.04.24
-- ���� ������
=================================
-- sqlplus ����
sqlplus hr/hr

-- �н��� ���̺� ��ȸ
select table_name from user_tables;

-- ���̺��� ���� ��ȸ
desc departments;
desc employees;

-- sqlplus ȯ�漳��
column department_name format a18;
column last_name format a18;

ed

show user;

-- �μ������� ��ȸ
select * from departments;
select * from employees;

select department_name from departments;

--------------------------------- 
-- DQL( Data Query Language)
--------------------------------- 
-- query ���� ��.�빮�ڸ� �������� �ʴ´�.
-- SELECT
-- FROM
-- [ WHERE
-- group BY
-- HAVING
-- order by ]
-- 1. select ���� ��� 
--  1) * : from ���� ����� ���̺��� ��� �׸� ��ȸ  
     select * from departments; -- ������
--	2) �÷��� : from ���� ����� ���̺� �����ϴ� �׸�  
     select department_name from departments;
     select department_id, department_name 
	   from departments;  -- �������
--	 - �������� �׸��� ����� ���� "," �� �����Ͽ� �����Ѵ�. 
	3)distinct : �ߺ��� �����Ѵ�.
	 select job_id from employees; 
	 select distinct job_id 
	   from employees; 
	 select department_id, job_id 
	   from employees; 
	 select distinct department_id, job_id 
	   from employees; 
--	4) ����(alias)
	 -- ������ �빮�ڷ� ǥ��.	
	 -- ���ڴ� ������, ���ڿ� ���ʿ� ����
	 -- ""�� ����Ҷ��� ""�ȿ� ���ڿ��� �״��(��.�빮�� ����)�������� �ȴ�.
	 select department_id as did , job_id as job
	   from employees; 
	 select department_id Did, job_id job
	   from employees; 

	 select department_id as "D id", job_id as "Job"
	   from employees; 
	 select department_id "Did", job_id "Job"
	   from employees; 
--	5) ������ �����ϴ�.(+,-,*,/)
     -- ���꿡�� �켱������ ����ȴ�.
	 select last_name, salary * 12
	   FROM EMPLOYEES;
	 select last_name, (salary * 12) as annsal
	   FROM EMPLOYEES;
--	6) NULL : ���꿡 �����Ҷ��� ����� null�̴�.
     select last_name, 
	        (salary * commission_pct) as bonus,
			((salary * commission_pct) + salary) as salbon
	   from employees;
-- 	7) ���ڿ��� ����: ||
	 select last_name, (first_name || last_name) as irum
	   from employees;
	 select last_name, (first_name || '-' ||last_name) as irum
	   from employees;

-- 2. From ���� ��� 
	1) ���̺��, �������� ���̺��(����)
	2) View ��
	3) ������ ��(Inline Query)
	4) ������ ���̺� Dual;
	  select 1+2 from dual;
	  select sysdate from dual;

-- 3.Where(������) ���� ��� 
    -. ����� �̿��Ѵ�.(a=b)
	   ��Ŀ� ����ϴ� �񱳿�����: =, >, <, <>, >=, <=
	   irum <> 'inho' : inho�� �ƴѰ��� ��ȸ.
	  ��) select last_name, salary 
	       from employees
		  where salary < 10000; 
	-. �������� ����� and, or�� �����Ѵ�. 
	  a=b and b=c, a>b or b<c
	  ��) select department_id, last_name, salary 
	       from employees
		  where salary > 10000
		    and department_id = 50; 
	-. ���ڿ�, ��¥�� ���� ���Ҷ��� Ȭ����ǥ('')�� ����Ѵ�.
	  ��) select job_id, last_name, salary 
	       from employees
		  where job_id = 'IT_PROG';
	
	-. ���� ���Ҷ��� ��ҹ��ڸ� �����Ѵ�.
	  SELECT = select, FROM = from
	  a = 'inho' <> a='INHO'
	  ��) select job_id, last_name, salary 
	       from employees
		  where job_id = 'iT_PROG';
	-.��� ������ �����ϴ�  
	  ��) select job_id, last_name, salary 
	       from employees
		  where salary *12 > 150000
	-.���� ������ ��� ���� 
	  ��) select first_name,last_name, salary 
	       from employees
		  where first_name || last_name	= 'PatFay';
	-. �������� �켱 ������ �ִ�.(and, or)  
	  ��) select last_name, job_id, salary
			from employees
		   where job_id = 'IT_PROG'
			  or job_id = 'AD_PRES'
			 and salary > 15000;	
	-.������ ��� 2����
	  ��) select last_name, job_id, salary
			from employees
		   where salary >= 5000 	
  		     and salary <= 10000;	
			(=) 
		  select last_name, job_id, salary
			from employees
		   where salary BETWEEN 5000 and 10000;
	-. �Ҽ�(����)	   
	  ��) select department_id, last_name, salary
			from employees
		   where department_id = 10
  		      or department_id = 30
  		      or department_id = 70;	
			(=)  
		 select department_id, last_name, salary
			from employees
		   where department_id in (10,30,70);   
	-. ����� �ڷ��� ��ȸ: like
	   % : �ټ��� ���ڿ��� ��Ī
	   _ : �� ���ڿ� ��Ī
	  ��) select department_id, last_name, salary
			from employees
		   where last_name like 'H%';
		 select department_id, last_name, salary
			from employees
		   where last_name like '%a__'; 	
	-. Null�� ��
	  ��) select last_name, salary, commission_pct
			from employees
		   where commission_pct is not null;
		   -- �߸��� ��
		   where commission_pct = '';

--  4.order by �� : ����
	-. �÷���, ���� [ asc || desc]		
	   �⺻�� asc
	-. ���� �÷���
	   col-1, col-2 desc, col-3 
	  ��) select department_id, job_id, last_name, 
	            salary
			from employees
		   order by last_name desc;
		 select department_id, job_id, last_name, 
	            salary
			from employees
		   order by department_id, job_id,salary desc;
--	5.Query�� ���� ����
	  -.From > where > select > order by
	  ��) select department_id, job_id, 
				last_name as irum, salary
			from employees
		  where last_name like '%s'
		  order by irum;	

--------------------------------- 
-- ������ �Լ�
-- �Լ��� �з� : �����Լ�, ����� ���� �Լ�  		   
-- �����Լ� ���� : ������ �Լ�, ������ �Լ���
-- ������ �Լ� : ����, ����, ��¥
-- ���� �����Լ� : Lower, Upper, Initcap, Concat
--  			substr, length, instr, replace, trim
-- ���� �����Լ� : round, trunc, Mod
-- ��¥ �����Լ� : sysdate, MONTHS_BETWEEN, ADD_MONTHS, LAST_DAY
-- �Ϲ� �Լ�   : nvl, case

-- ���� �����Լ� 
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

-- ���� �����Լ� 
select round(12.345678, 2) as ron2 from dual;
select trunc(12.345678, 2) as trun2 from dual;
select mod(10,3) as mod2, 
       round(10/3,2) as rnd2 
from dual;

-- ��¥ �����Լ�
select sysdate from dual;
select sysdate + 5 from dual;
select months_between('2022-12-31',sysdate) from dual;
select add_months(sysdate, 2) from dual;
select last_day(sysdate) from dual;
select last_day('2022-05-10') from dual;

-- �ڷ��� ����ȭ : ������(�Ͻ���), ����� ����ȯ
-- ������ ����ȯ 
select 100 + '200' from dual;
select '100' + '200', '200' as two from dual;
select 100 + '200', '200' as two from dual;
select 100 || 200, '200' as two from dual;
select 100 || 200, (100 || 200) + 100 from dual;
select 100 || 200, 100 || (200 + 100) from dual;

select '5', to_number('5') from dual;

-- ����� ����ȯ
-- to_char, to_number, to_date 
select to_char(12345) char1,  from dual;
select to_number('12345') num1 from dual;
select to_date('2022-02-28') dat1 from dual;

select to_char(to_date('2022-02-28'), 'YYYY-MM') dat1 from dual;
select to_char(hire_date, 'YYYY-MM') dat1 from employees;

select to_char(hire_date, 'YYYY-MM') hire_date, 
       to_char(salary, '99,999') salary
  from employees;

-- �Ϲ� �Լ� : nvl, case, decode
-- nvl(��, �⺻��)
select last_name, salary * nvl(commission_pct,0)
  from employees;
  
-- (case when then else end)
-- ������ IT_PROG: 10%, ST_CLERK:15%, SA_REP:20% ���ʽ��� �����ϰ�
-- �̸�, ����, �޿�, ���ʽ��ݾ��� ��ȸ�Ͻÿ�..
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

-- sqldeveloper ��ġ
--  1)sqldeveloper �������� Ǯ��
--  2)���� ���� �ڹ� ��� Ȯ��:
--   C:\Program Files\Java\jdk1.8.0_202

--------------------------------- 
-- ������ �Լ�(�׷�, �����Լ�)
-- ���� : sum(), avg(), count(), min(), max()
-- ���� : sum(), avg()
-- ����, ���� : max(), min, count()
--------------------------------- 

-- group by ���� �÷���, �����ϰ� select���� ����Ѵ�.
select department_id,
       sum(salary) as sum_salary, avg(salary) as avg_salary,
       count(salary) as cnt_salary, max(salary) as max_salary,
       min(salary) as min_salary
from employees
group by department_id
order by department_id;     
-- �����Լ����� null���� ��������
select max(commission_pct),
        count(commission_pct)as cnt_comm,
        count(nvl(commission_pct,1))as cnt_nvl,
        count(*)as cnt_comm,
        count(employee_id)as cnt_emp,
        count(department_id)as cnt_dpt,
        avg(commission_pct),
        sum(commission_pct)
from employees;
-- where���� select ���� data�� �����ϰ�
-- Having���� Group by ���� data�� ���� �Ѵ�.
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
--��ø �����Լ��� ���...
--�μ��� ��� �޿��� ���� ���� �ݾ��� ���ΰ���?
select max(avg(salary))
from employees
where department_id in (50,60,70)
group by department_id;
-- ������, ��ձ޿�, �ְ�޿��� ��ȸ�Ͻÿ�..?
select job_id, max(salary), avg(salary)
from employees
group by job_id;
-- ������, ��ձ޿�, �ְ�޿��� ��ȸ�Ͻÿ�..?
-- (�� ��ձ޿��� 5000������ ������ ��ȸ)
select job_id, max(salary), avg(salary)
from employees
group by job_id
having avg(salary) <= 5000;
-- �츮ȸ���� ������ �ְ�޿��� �����޿�, ����,�ְ� �޿��� ���̸� ��ȸ�Ͻÿ�.
select job_id,
       max(salary) as max_sal, min(salary) as min_sal,
       (max(salary) - min(salary)) as sal_cha
from employees
group by job_id
having (max(salary) - min(salary)) > 1000;
       
-- �츮ȸ���� ������ ���� ���� �ټӳ��, �����ټӳ��, �ټӳ��(��)�� ���̸� ��ȸ�Ͻÿ�.
select min(hire_date) as min_hire, max(hire_date) as max_hire,
       max(hire_date)- min(hire_date) as cha_day,
       to_char(max(hire_date),'yy') - to_char(min(hire_date),'yy') as cha_yy,
       round((max(hire_date)-min(hire_date))/ 365,0) as max_cha
from employees       
;

--------------------------------- 
-- ����
-- �÷��� ���η� �����ϴ� ȿ���� �ִ�...
-- ���� ������ ���� ���� īƼ�� ���� ȿ���߻�(����)
-- ī��ǰ�(cartesisan Prodeuct))
--  �ΰ��� ���̺��� ������ ����(107x 27)�� ���ϴ� ��� 

select * 
from employees, departments;
-- ������ ���̺� ���� �̸��� �÷��� �ִ� ���, ��� ���̺��� ����Ѵ�.
select employees.employee_id, employees.last_name, 
      employees.department_id as did1, 
      departments.department_id as did2,
      departments.department_name 
from employees, departments;

-- ������ ���̺��� ����(alias)�� ����Ҽ� �ִ�.
select e.employee_id, e.last_name, 
      e.department_id as did1, 
      d.department_id as did2,
      d.department_name 
from employees e, departments d;
-- ���� ����
-- �ּ� ���̺��Ǽ�-1���� ���� ������ �ʿ�..
select e.employee_id, e.last_name, 
      e.department_id as did1, 
      d.department_id as did2,
      d.department_name 
from employees e, departments d
where d.department_id = e.department_id;

-- �������̺��� �μ������� �����ϴ� �μ��ڵ�
select distinct department_id
from employees;

-- ������ ����
-- �(=): inner,�� ����, ��ü����, �ܺ�����(outer join): left, right, full)

-- �����(=)
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e, departments d
where d.department_id = e.department_id
  and e.department_id = 10;

-- �� �����(between, '='�� ������ �񱳿������� ���))
select e.last_name, e.salary, j.grade_level
from employees e, JOB_GRADES j
where e.salary between j.lowest_sal and j.highest_sal;

-- ��ü ����
-- ������ �̸�, �޿�,����� �̸��� ��ȸ�Ͻÿ�
select e.employee_id, e.last_name, e.salary, e.manager_id , m.last_name 
from employees e, employees m
where e.manager_id = m.employee_id;

-- �ܺ�����(outer join)
-- 107��
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e, departments d
where d.department_id(+) = e.department_id;
-- ǥ������
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e left join departments d
  on d.department_id = e.department_id;
-- 122��
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e, departments d
where d.department_id = e.department_id(+);
-- ǥ������
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e right join departments d
  on d.department_id = e.department_id;
-- ǥ������ 223��
select e.employee_id, e.last_name, 
      e.department_id, d.department_name 
from employees e full join departments d
  on d.department_id = e.department_id;

--------------------------------- 
-- ��������
-- �������� :���� �ȿ� ������ �ִ�.
-- ��ȸ�ϰ��� �ϴ� ���� �𸣴� ��� Ȱ��
-- ���� : ������, ������ ��ȯ����
-- ������ : =, >,<,>=,<=, !=, <>
-- ������ :  in, <any, >all,exist

select avg(salary)
  from employees;
  
-- ȸ���� ��ձ޿� �̻� �޴� ������ �̸�, �޿��� ��ȸ..  
select last_name, salary
from employees
where salary >= (select avg(salary)
  from employees);
  
-- ȸ���� �ְ�޿��� �޴� ������ �̸�, �޿��� ��ȸ..
select last_name, salary
from employees
where salary = (select max(salary)
  from employees);

-- ��������
-- 1)ȸ���� ������ 'IT_PROG'������ ��� �޿����� ���� �޴� ������
-- �̸�, ����, �޿��� ��ȸ�Ͻÿ�..
select last_name,job_id, salary
from employees
where salary > (select  avg(salary)
                 from employees
                where job_id = 'IT_PROG')
; 
-- 2)Chen �� ���� ������ ������ �̸�, ����, �޿��� ��ȸ�Ͻÿ�.
select last_name,job_id, salary
from employees
where job_id in (select  job_id
                 from employees
                where last_name = 'Chen')
;
-- 3)�����μ�(80)�� �ּұ޿����� ���� �޴� �μ��� 
--   �μ�ID, �μ��̸�, �ּұ޿��� ��ȸ..
-- join, group by, having..
select e.department_id, d.department_name, min(salary) as min_sal
  from employees e, departments d
 where e.department_id = d.department_id 
group by e.department_id, d.department_name
having min(salary) > (select min(salary) 
                        from employees 
                       where department_id = 80)
;                       

-- ������ �������� ���
-- ������ :  in, <any, <all, >any, >all
-- in (or) : ��� ���� ���� �����ϴ� ��
--(9000,6000,4800,4200)
-- any(or)  : <any �ִ밪���� ������(9000), >any �ּҰ����� ū��(4200)
-- all(and) : <all �ּҰ����� ������(4200), >all �ִ밪���� ū��(9000)
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
-- ���������� Between�� ���
select employee_id, last_name, job_id, salary
  FROM employees
 where salary between (select min(salary)
                     from employees
                    where department_id = 60) 
                  and (select max(salary)
                     from employees
                    where department_id = 60)
;
