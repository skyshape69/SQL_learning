WITH top_10 AS
(
SELECT job_id, company_id,job_title, salary_year_avg, job_via, job_no_degree_mention, job_country
from job_postings_fact
where job_work_from_home = TRUE and
      job_title_short = 'Data Analyst' and 
      salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC 
LIMIT 10
),job_id_name AS 
(
SELECT job_id, skills_dim.skills
from skills_job_dim
INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id)


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

/*Here are the results from 10 data analyst job postings:

Salary range: $184,000 - $650,000

Average salary: ~$265,000

Top skills: SQL (7 jobs), Python (6), Tableau (5), R (4)

Companies include: Meta, AT&T, Pinterest, SmartAsset, UCLA Health

Highest paying role: Mantys, Data Analyst at $650,000 (no skills listed)
[
  {
    "company_name": "AT&T",
    "job_title": "Associate Director- Data Insights",
    "salary_year_avg": "255829.5",
    "skills": "power bi, powerpoint, sql, python, r, azure, databricks, aws, pandas, pyspark, jupyter, excel, tableau"
  },
  {
    "company_name": "Get It Recruit - Information Technology",
    "job_title": "ERM Data Analyst",
    "salary_year_avg": "184000.0",
    "skills": "python, r, sql"
  },
  {
    "company_name": "Inclusively",
    "job_title": "Director, Data Analyst - HYBRID",
    "salary_year_avg": "189309.0",
    "skills": "python, confluence, jira, atlassian, bitbucket, jenkins, sap, power bi, tableau, snowflake, oracle, aws, azure, sql"
  },
  {
    "company_name": "Mantys",
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "skills": null
  },
  {
    "company_name": "Meta",
    "job_title": "Director of Analytics",
    "salary_year_avg": "336500.0",
    "skills": null
  },
  {
    "company_name": "Motional",
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "salary_year_avg": "189000.0",
    "skills": "python, sql, r, git, bitbucket, atlassian, jira, confluence"
  },
  {
    "company_name": "Pinterest Job Advertisements",
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "skills": "tableau, sql, python, r, hadoop"
  },
  {
    "company_name": "SmartAsset",
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "skills": "sql, excel, tableau, gitlab, numpy, pandas, snowflake, go, python"
  },
  {
    "company_name": "SmartAsset",
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "pandas, excel, tableau, gitlab, go, snowflake, sql, python, numpy"
  },
  {
    "company_name": "Uclahealthcareers",
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "skills": "oracle, flow, sql, crystal, tableau"
  }
]*/