-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" varchar(30)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_no" varchar(30)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(30)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" char   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "Titles" (
    "title_id" varchar(20)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");
------------------------------------------------------------------------------------------------------

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT * FROM "Employees"; 

SELECT "Employees".emp_no, "Employees".first_name, "Employees".last_name,
"Employees".sex
FROM "Employees"
JOIN "Salaries" ON "Employees".emp_no = "Salaries".emp_no;


--2. List first name, last name, and hire date for employees who were hired in 1986.

SELECT "Employees".first_name, "Employees".last_name, "Employees".hire_date
FROM "Employees"
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

--Pull the tables that I need out and have them ready to run for checking data location.

SELECT * FROM "Departments";
SELECT * FROM "Dept_manager";
SELECT * FROM "Employees";

--Create the joins on the appropriate data from locations

SELECT "Employees".emp_no, "Employees".first_name, "Employees".last_name 
FROM "Employees"
-- Pulls the name and employee # info for all employees
INNER JOIN "Dept_manager"
ON "Employees".emp_no = "Dept_manager".emp_no;
SELECT "Dept_manager".dept_no  
FROM "Dept_manager"
INNER JOIN "Departments"
ON "Dept_manager".dept_no = "Department".dept_no;
-- Now I joined them on the data that I'm looking for which is the managers data


--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT "Employees".emp_no, "Employees".first_name, "Employees".last_name
FROM "Employees"
INNER JOIN "Dept_emp"
ON "Employees".emp_no = "Dept_emp".emp_no
INNER JOIN "Departments"
ON "Departments".dept_no = "Dept_emp".dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT "Employees".first_name, "Employees".last_name
FROM "Employees"
WHERE "Employees".first_name = 'Hercules'
AND "Employees".last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT "Dept_emp".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Dept_emp"
JOIN "Employees"
ON "Dept_emp".emp_no = "Employees".emp_no
JOIN "Departments"
ON "Dept_emp".dept_no = "Departments".dept_no
WHERE "Departments".dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT "Dept_emp".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Dept_emp"
JOIN "Employees"
ON "Dept_emp".emp_no = "Employees".emp_no
JOIN "Departments"
ON "Dept_emp".dept_no = "Departments".dept_no
WHERE "Departments".dept_name = 'Sales' 
OR "Departments".dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT "Employees".last_name
COUNT("Employees".last_name) AS "frequency"
FROM "Employees"
GROUP BY "Employees".last_name
ORDER BY
COUNT("Employees".last_name) DESC;

