CREATE TABLE "departments" (
    "dept_no" VARCHAR NOT NULL,
    "dept_name" VARCHAR NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--hw question 1 code
--list the following details of each employee: employee number, last name, first name, gender, and salary
select employees.emp_no, employees.last_name, employees.first_name, salaries.salary, employees.gender
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

select first_name, last_name from employees
where first_name = 'Hercules' and last_name like 'B%';

-- HW question 6 code
-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.
-- DELETE later...Sales is d007

SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no in
	(select emp_no
     from dept_manager
  	 where dept_no in
  		(select dept_no
         from departments
    	 where dept_name = 'Sales'));
UNION ALL
SELECT id
FROM customer_list
WHERE city = 'London';
