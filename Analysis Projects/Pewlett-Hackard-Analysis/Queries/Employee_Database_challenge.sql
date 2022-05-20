
--Challenge queries
SELECT first_name, last_name FROM employees;
SELECT title, from_date, to_date FROM titles;
SELECT e.emp_no,
    e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_title
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

SELECT * FROM retirement_title;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT  ON (emp_no) emp_no,  first_name, last_name, title
INTO unique_title
FROM retirement_title
WHERE to_date  = '9999-01-01'
ORDER BY emp_no, to_date DESC
;
SELECT * FROM unique_title
--Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(title) as count, title
INTO retiring_title
FROM unique_title
GROUP BY title
ORDER BY count DESC


SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date  = '9999-01-01'
ORDER BY e.emp_no

--re
SELECT count(u.emp_no) , de.dept_no, d.dept_name, u.title
FROM unique_title u
INNER JOIN dept_emp as de
ON (u.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE  de.to_date  = '9999-01-01'
GROUP BY de.dept_no, d.dept_name, u.title
ORDER BY de.dept_no, d.dept_name, u.title