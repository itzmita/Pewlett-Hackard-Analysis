# Pewlett-Hackard-Analysis

## Overview
The purpose of this project was to analyze employment data for a large corporation Pewlett Hackard. The focus was mainly on how many number of employees retiring as they reach retirement age and how it impacts the company and its teams. 
We used a tool named Quick DBD(Database Diagrams) to design the Entity Relationship Diagram based off of 6 csv files that were provided as input.
The file are as follows
* departments.csv
* dept_emp.csv
* dept_manager.csv
* employees.csv
* salaries.csv
* titles.csv

First we created a PHEmployee Database and loaded the above csv files in 6 tables in that Database. 
After specifying the data types appropriately and denoting the primary and foreign keys for each of the tables, we linked the tables with common data elements. 
Then we created the following Entity Relationship diagram which will help us with the next step of analysis.

![image](https://user-images.githubusercontent.com/3753839/169442968-4fdd124e-5738-4dea-915b-562645ce8323.png)

## Resources
Software:
* SQL
* PostgreSQL
* pgAdmin

## Results
### Deliverable1
We started creating queries which will fetch data pertaining to employees who are in the retirement age. We filtered the data using employees who have birth date in between 1952 and 1955. These are likely the employees who will retire. The output of the query is shown below. 
![image](https://user-images.githubusercontent.com/3753839/169443409-b0e370d2-f2b4-4c26-ac64-def6ad65bf70.png)



We exported the above output in a retirement_titles.csv files for later review.
Next we removed duplicate entries using DISTINCT ON to get only one occurrence of employee and further filtered down by considering only open ended (9999-01-01) timelines as the to_date. This ensures the data is filtered by employees who are currently working in the company. If the Employee is not working in the company then we would see an actual end date in that to_date column.  The output of that query is shown below.
![image](https://user-images.githubusercontent.com/3753839/169443020-77dfeeeb-edda-4ca6-bf5a-c4dd7b8581d8.png)

The above output was also exported into unique_titles.csv file.

Once that was done, we did a Group by on the title to see retirees by their title which is as shown below

![image](https://user-images.githubusercontent.com/3753839/169443049-d0f10b7f-4463-45a9-9a3d-1f56cd2d61ed.png)


From the above query we can see that there is a huge number of employees retiring. 

### Deliverable2
Here the task was to create a table with employees who can participate in Mentorship program.
The age criteria given was employees who were born between January 1, 1965 and December 31, 1965. We used DISTINCT ON and GROUP BY as we did in the prior task to get the following list of employees who are eligible for mentorship program.

![image](https://user-images.githubusercontent.com/3753839/169443551-e894675c-bc08-45f9-821a-54749692da00.png)


We exported the above output in a mentorship_eligibilty.csv files for later review.

* Total 72,458 employees are retiring which is a big loss for Pewlett Hackard.
* The largest numbers retiring are "Senior Engineer" (25%) and "Senior Staff"(22%). This group of employees will have a wealth of experience and knowledge which will be lost. Recruitment for this number and role needs to be done properly to get very experienced and talented new people who can fill in these shoes. 
* The query for the mentorship program shows there are 1549 employees eligible for mentorship program. 
* If we take the example of Senior Staff the mentor to new recruitment (mentee) ratio would be 1:44 which is showed a skewed ratio. 


## Summary
As we see the following employees are going to retire which is a big number and hence the silver tsunami name makes sense. 
So in total 72,458 many vacancies need to be filled by Pewlett Hackard.

![image](https://user-images.githubusercontent.com/3753839/169443106-c51ae9f0-9a03-44c8-9356-7080efde76ef.png)


Let's see the following query 

_select count(emp_no), title from mentorship_eligibilty group by title order by count;_

![image](https://user-images.githubusercontent.com/3753839/169443878-d4115dbe-cd45-4eca-8e41-65b982da3eff.png)



As per the above query we see that the ratio is approx 1:44 Mentor : Mentee for Senior Staff and Secior Engineer roles which means there are not enough mentors to guide the new employees. 

* We can also take a look at this query to see which department has the most impact. 
It’s the Development and Production where the core Engineers and Staff belong. 

_select count(u.emp_no), d.dept_no, d.dept_name
from unique_title u
inner join dept_emp de on de.emp_no = u.emp_no and de.to_date = '9999-01-01'
inner join departments d on de.dept_no = d.dept_no
group by d.dept_no, d.dept_name
order by count_

![image](https://user-images.githubusercontent.com/3753839/169443189-0bbe0bbf-9e24-4d12-8b4b-b516fcb66e1b.png)


* The total salary of the retirees is as shown below which is also a large number. Pewlett Hackard would definitely need to spend less money on recruitment to save money. 

_select sum(s.salary), u.title
from unique_title u
inner join salaries s on s.emp_no = u.emp_no 
group by u.title_

![image](https://user-images.githubusercontent.com/3753839/169443772-9e919e7d-51b9-4f15-8613-e28f307ead47.png)





The company can do some further analysis to see if really those huge number of Senior Engineer or Senior staff is required or not. They can see how many of these groups of employees were working independently. They might want to hire less Senior Engineer and Senior staff who has good leadership qualities and have them lead a group of Engineers/Staffs. So the company can hire more of Engineer/Staff instead. If the retiring Senior members had any responsibilities that can be shifted to existing employees in similar roles. Overall the company has to really work hard to counter the loss of highly experienced and talented employees. 
