CREATE TABLE departments (
dept_no VARCHAR,
dept_name VARCHAR,
PRIMARY KEY (dept_no));

CREATE TABLE dept_emp (
emp_no INTEGER,
dept_no VARCHAR,
from_date DATE,
to_date DATE,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE employees (
emp_no INTEGER, 
birth_date DATE, 
first_name VARCHAR, 
last_name VARCHAR, 
gender VARCHAR, 
hire_date DATE,
PRIMARY KEY (emp_no));

CREATE TABLE manager (
dept_no VARCHAR, 
emp_no INTEGER,
from_date DATE, 
to_date DATE,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no));

CREATE TABLE salaries(
emp_no INTEGER, 
salary INTEGER, 
from_date DATE, 
to_date DATE,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no));

CREATE TABLE titles (
emp_no INTEGER, 
title VARCHAR, 
from_date DATE, 
to_date DATE,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no));

-----------------------------------------------------
--List the following details of each employee: employee number, last name, first name, gender, and salary

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- List employees who were hired in 1986

SELECT * FROM
employees
WHERE hire_date BETWEEN to_date('1986-01-01','YYYY-MM-DD') 
                    AND to_date('1986-12-31','YYYY-MM-DD');
					
--List the manager of each department with the following information: department number, department name, the manager's employee number,
-- last name, first name, and start and end employment dates.

SELECT manager.dept_no, departments.dept_name, manager.emp_no, employees.last_name, employees.first_name, manager.from_date, manager.to_date
FROM manager
JOIN employees
ON manager.emp_no = employees.emp_no
JOIN departments
ON manager.dept_no = departments.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM
employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT departments.dept_name, dept_emp.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN employees
ON employees.emp_no = dept_emp.emp_no
WHERE departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT departments.dept_name, dept_emp.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN employees
ON employees.emp_no = dept_emp.emp_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(*)
FROM employees
GROUP BY 1
ORDER BY 1 DESC;