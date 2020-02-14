--hw question 1 code
--list the following details of each employee: employee number, last name, first name, gender, and salary
select employees.emp_no, employees.last_name, employees.first_name, salaries.salary as "Salary ($)", employees.gender
From salaries
Inner join employees on
salaries.emp_no = employees.emp_no;

-- HW question 2 code
-- List employees who were hired in 1986
select emp_no, last_name, first_name, hire_date 
from employees
where
	hire_date >= '19860101' and
	hire_date <= '19861231'; 
	
-- HW question 3 code
-- List the manager of each department with the following information: 
-- Department number, department name, the manager's employee number, last name, first name, and 
-- Start and end employment dates. 

select departments.dept_no as "Dept No", departments.dept_name as "Dept Name", dept_manager.emp_no as
	"Emp No", employees.last_name as "Last Name", employees.first_name as "First Name", 
	dept_manager.from_date as "Start Date", dept_manager.to_date as "End Date"
from departments
inner join dept_manager on
departments.dept_no = dept_manager.dept_no
inner join employees on
dept_manager.emp_no = employees.emp_no;

-- HW question 4 code
-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

select employees.emp_no as "Emp No", employees.last_name as "Last Name", 
	employees.first_name as "First Name", departments.dept_name as "Dept Name"
from employees
inner join dept_emp on
employees.emp_no = dept_emp.emp_no
inner join departments on
dept_emp.dept_no = departments.dept_no;

-- HW question 5 code
-- List all employees whose first name is "Hercules" and last names begin with "B."

select first_name as "First Name", last_name as "Last Name" from employees
where first_name = 'Hercules' and last_name like 'B%';

-- HW question 6 code
-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.

--first, query to see if dept managers are also listed under dept employees
--if they are, it will return nothing
select emp_no from dept_manager
where emp_no NOT IN (select distinct emp_no from dept_emp);

select departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
from departments
inner join dept_emp on
departments.dept_no = dept_emp.dept_no
inner join employees on
dept_emp.emp_no = employees.emp_no
where dept_name = 'Sales';

-- HW question 7 code
-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

select departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
from departments
inner join dept_emp on
departments.dept_no = dept_emp.dept_no
inner join employees on
dept_emp.emp_no = employees.emp_no
where dept_name IN ('Sales', 'Development');