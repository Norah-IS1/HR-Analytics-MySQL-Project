/*
Project Name: HR Analytics Database

Technology:
MySQL

Description:
Database designed to manage employees,
performance records, promotions and salary increases.
*/

CREATE DATABASE IF NOT EXISTS hr_analytics_pro;
USE hr_analytics_pro;

-- نحذف لو موجود (عشان ما يطلع Error)
DROP TABLE IF EXISTS Salary_Increase_Pro;
DROP TABLE IF EXISTS Promotions_Pro;
DROP TABLE IF EXISTS Performance_Pro;
DROP TABLE IF EXISTS Employees_Pro;

-- جدول الموظفين
CREATE TABLE Employees_Pro (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(50),
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- جدول التقييم
CREATE TABLE Performance_Pro (
    perf_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    review_date DATE,
    rating INT,
    FOREIGN KEY (emp_id) REFERENCES Employees_Pro(emp_id)
);

-- جدول الترقيات
CREATE TABLE Promotions_Pro (
    promo_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_job VARCHAR(50),
    new_job VARCHAR(50),
    promotion_date DATE,
    FOREIGN KEY (emp_id) REFERENCES Employees_Pro(emp_id)
);

-- جدول العلاوات
CREATE TABLE Salary_Increase_Pro (
    inc_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    increase_date DATE,
    FOREIGN KEY (emp_id) REFERENCES Employees_Pro(emp_id)
);
-- موظفين
INSERT INTO Employees_Pro (name, department, job_title, salary, hire_date) VALUES
('Ahmed Ali', 'IT', 'Developer', 8000, '2022-01-10'),
('Sara Khalid', 'HR', 'HR Specialist', 7000, '2023-03-15'),
('Mohammed Saleh', 'Finance', 'Accountant', 7500, '2021-07-20'),
('Laila Hassan', 'IT', 'System Analyst', 9000, '2020-05-12'),
('Fahad Omar', 'HR', 'Recruiter', 6000, '2022-09-01');

-- تقييم
INSERT INTO Performance_Pro (emp_id, review_date, rating) VALUES
(1, '2024-01-01', 5),
(1, '2024-03-01', 4),
(2, '2024-02-01', 3),
(3, '2024-01-15', 4),
(4, '2024-02-20', 5),
(5, '2024-03-10', 2);

-- ترقيات
INSERT INTO Promotions_Pro (emp_id, old_job, new_job, promotion_date) VALUES
(1, 'Junior Developer', 'Developer', '2023-01-01'),
(4, 'Junior Analyst', 'System Analyst', '2022-06-01');

-- علاوات
INSERT INTO Salary_Increase_Pro (emp_id, old_salary, new_salary, increase_date) VALUES
(1, 7000, 8000, '2023-01-01'),
(4, 8000, 9000, '2022-06-01');
select * from employees_pro;
select * from performance_pro;
select * from promotions_pro;
select * from salary_increase_pro;
select 
e.name , e.department, e.job_title, e.salary, p.rating, pr.new_job,s.new_salary 
from employees_pro e
LEFT JOIN Performance_Pro p ON e.emp_id = p.emp_id
LEFT JOIN Promotions_Pro pr ON e.emp_id = pr.emp_id
LEFT JOIN Salary_Increase_Pro s ON e.emp_id = s.emp_id;
SELECT 
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM Employees_Pro;
SELECT AVG(salary) AS avg_salary
FROM employees_pro;
SELECT COUNT(*) AS total_employees
FROM employees_pro;
SELECT name, salary
FROM employees_pro
WHERE salary = (SELECT MAX(salary) FROM employees_pro);
SELECT e.name, pr.promotion_date
FROM employees_pro e
JOIN promotions_pro pr ON e.emp_id = pr.emp_id;
SELECT * FROM salary_increase_pro;
SELECT e.name, 
       s.old_salary,
       s.new_salary,
       (s.new_salary - s.old_salary) AS increase_amount,
       s.increase_date
FROM employees_pro e
JOIN salary_increase_pro s 
ON e.emp_id = s.emp_id;
SELECT 
    e.name,
    e.salary,
    e.department,
    CASE 
        WHEN pr.emp_id IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS has_promotion,
    
    CASE 
        WHEN s.emp_id IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS has_increase

FROM employees_pro e

LEFT JOIN promotions_pro pr 
ON e.emp_id = pr.emp_id

LEFT JOIN salary_increase_pro s 
ON e.emp_id = s.emp_id;
select * from employees_pro;

-- View all employees
SELECT * FROM Employees;

-- Count employees
SELECT COUNT(*) FROM Employees;