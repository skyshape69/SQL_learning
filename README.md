# Introduction
This project explores the Data Analyst job market by analyzing job postings and required skills using SQL.
The goal is to identify:

- the most in-demand skills

- the highest-paying skills

- the highest-paying Data Analyst jobs



By analyzing job postings and salary information, this project provides insights into the skills that drive demand and salary in the data analytics field.

Project SQL folder : [Query 1 folder](/Query%201/)


# Background

The demand for Data Analysts has grown significantly as companies rely more on data-driven decision making. However, the skills required for these roles vary widely.

This project aims to answer three key questions:

 1- What are the most in-demand skills for Data Analysts?

 2- Which skills are associated with the highest salaries?

 3- What do the highest-paying Data Analyst jobs look like?

Understanding these trends can help aspiring data analysts focus on the most valuable technical skills in the market.

# Tools I used 

This project was completed using the following tools:

- **SQL** – for querying and analyzing job posting data

- **PostgreSQL** – database used to store and query the dataset

- **VS Code** – development environment for writing SQL queries

- **GitHub** – project version control and portfolio presentation
- **Microsoft Excel** – used to create visualizations of the analysis results  


Key SQL concepts used:

- **JOINs**

- **Aggregations (COUNT, AVG)**

- **Common Table Expressions (CTE)**

- **Filtering and grouping**

# The Analysis

## **1- Most In-Demand skill :**

To identify the most requested skills for Data Analysts, I counted how frequently each skill appeared in job postings.

```sql
SELECT skills,
COUNT(*) AS count

FROM job_postings_fact 

INNER JOIN skills_job_dim
ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY count DESC
LIMIT 5
```

### **Results**

| Skill    | Demand  |
| -------- | ------- |
| SQL      | 92,628  |
| Excel    | 67,031  |
| Python   | 57,326  |
| Tableau  | 46,554  |
| Power BI | 39,468  |

<img width="1652" height="992" alt="image" src="https://github.com/user-attachments/assets/4a205e2f-3916-4104-879f-4a2b5cb0f3f3" />


### **Insight:**

The results show that SQL remains the most essential skill for Data Analysts, followed by Excel and Python. Visualization tools such as Tableau and Power BI are also widely required.


## **2. Highest Paying Skills :**

Next, I analyzed which skills are associated with the highest average salaries.

```sql
SELECT skills,
ROUND(AVG(salary_year_avg), 0) AS avg_salary,
COUNT(*) AS demand
FROM job_postings_fact 
INNER JOIN skills_job_dim
ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND salary_year_avg IS NOT NULL
GROUP BY skills
HAVING COUNT(*) > 10
ORDER BY avg_salary DESC
```
![Highest_paying_skills](Images\Highest_paying_skills.jpg)
### **Key insight :**

Skills related to big data, cloud computing, and data engineering are associated with the highest salaries.

**Examples include:**

- **Apache Kafka**

- **Apache Spark**

- **Databricks**

- **Snowflake**

- **Apache Airflow**

These skills often push salaries into the $110k–$130k range.

However, traditional analytics tools like SQL, Python, Excel, Tableau, and Power BI still dominate job demand, even if their average salary is slightly lower.

This suggests that the most valuable analysts are those who combine core analytics skills with data engineering or cloud technologies.

## **3. Highest Paying Data Analyst Jobs :**

Finally, I analyzed the top 10 highest-paying Data Analyst roles.

```sql
WITH top_10 AS
(
SELECT job_id, company_id,job_title, salary_year_avg, job_via, job_no_degree_mention, job_country
from job_postings_fact
where job_work_from_home = TRUE and
      job_title_short = 'Data Analyst' and 
      salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC 
LIMIT 10
),
job_id_name AS 
(
SELECT job_id, skills_dim.skills
from skills_job_dim
INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
)

SELECT
company_dim.name AS company_name,
job_title,
salary_year_avg,
STRING_AGG(job_id_name.skills, ', ') AS skills
FROM top_10
LEFT JOIN company_dim
ON company_dim.company_id = top_10.company_id
LEFT JOIN job_id_name
ON job_id_name.job_id = top_10.job_id
GROUP BY
company_dim.name,
top_10.job_id,
job_title,
salary_year_avg;
```

### **Key findings:**

**Salary range: $184,000 – $650,000**

**Average salary: ~$265,000**

Companies in the top results include:

- **Meta**

- **AT&T**

- **Pinterest**

- **SmartAsset**

- **UCLA Health**

The most common skills among high-paying jobs were:

- **SQL**

- **Python**

- **Tableau**

- **R**

These findings highlight the importance of combining strong analytics foundations with technical versatility.



# What I Learned

Through this project, I developed several practical skills used in real-world data analysis workflows.

First, I strengthened my ability to work with relational databases, combining multiple tables using SQL joins to reconstruct meaningful datasets from normalized database structures.

Second, I improved my ability to perform analytical aggregations, using functions such as COUNT, AVG, and GROUP BY to transform raw job posting data into measurable indicators like skill demand and average salaries.

I also learned how to use Common Table Expressions (CTEs) to structure complex SQL queries in a clear and modular way, making the analysis easier to read and maintain.

Beyond technical SQL skills, this project helped me practice exploratory data analysis, identifying patterns in labor market data such as:

- which skills dominate the Data Analyst job market

- which skills command higher salaries

- how skill demand compares with salary potential

Finally, this project reinforced the importance of connecting technical analysis to business insights, translating query results into conclusions that can guide career decisions and skill development strategies in the data analytics field.

# Conclusion !

This analysis highlights two important trends in the Data Analyst job market.

First, **core analytical tools remain the foundation of the profession**. Skills such as SQL, Python, Excel, Tableau, and Power BI appear in the majority of job postings, confirming their importance for anyone pursuing a career in data analytics.

Second, the analysis shows **that higher salaries are often associated with more technical or hybrid skill sets**. Technologies related to cloud computing, big data processing, and data infrastructure such as Kafka, Spark, Databricks, and Snowflake—tend to appear in higher-paying roles. This suggests that Data Analysts who extend their skill set beyond traditional analytics and into areas closer to data engineering or machine learning may access better compensation opportunities.

Overall, the results indicate that the most competitive Data Analysts combine **strong analytical foundations with modern data infrastructure skills**. Developing expertise in both areas can significantly increase both career opportunities and earning potential in the evolving data job market.

# Closing Thoughts

This project provided a practical opportunity to explore how SQL can be used to analyze real-world labor market data. By combining multiple tables, performing aggregations, and visualizing key results, I was able to identify meaningful patterns in the Data Analyst job market.

The analysis highlights the importance of mastering core analytical tools such as SQL, Python, and data visualization platforms, while also showing that familiarity with modern data infrastructure technologies can lead to higher compensation opportunities.

Beyond the specific insights about skills and salaries, this project reinforced the value of using SQL not only to retrieve data, but also to transform raw information into actionable insights that can support career and business decisions.
