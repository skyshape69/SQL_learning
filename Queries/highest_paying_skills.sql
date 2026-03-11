SELECT skills,
ROUND(AVG(salary_year_avg), 0) AS avg_salary,
COUNT(*) AS demand
FROM job_postings_fact 
INNER JOIN skills_job_dim
ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND 
salary_year_avg IS NOT NULL 

GROUP BY skills
HAVING COUNT(*) > 10
ORDER BY 
avg_salary DESC


/*
L’analyse des salaires moyens par compétence pour les Data Analysts montre que les compétences associées aux
technologies de big data, cloud et data engineering offrent les rémunérations les plus élevées. Des outils 
comme Apache Kafka, Apache Spark, Databricks, et Snowflake apparaissent parmi les compétences les mieux rémunérées
(environ 110k–130k USD en moyenne). Cela indique que les Data Analysts capables de travailler avec des
infrastructures de données avancées ou proches du data engineering sont particulièrement valorisés sur le marché.

En parallèle, les compétences analytiques fondamentales comme SQL, Python, Tableau, Microsoft Power BI, ou Microsoft 
Excel présentent une demande beaucoup plus élevée mais des salaires moyens légèrement inférieurs (environ 90k–100k USD). 
Ces compétences constituent donc le socle essentiel du métier, car elles sont présentes dans la majorité des offres d’emploi.

Globalement, les résultats suggèrent que le marché du travail pour les Data Analysts récompense particulièrement les profils 
hybrides, combinant les compétences analytiques classiques avec des outils de gestion et d’infrastructure de données à grande 
échelle. Cette combinaison permet d’accéder à des postes mieux rémunérés tout en restant pertinent dans un marché où les 
compétences fondamentales restent indispensables.
*/