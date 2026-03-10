WITH job_id_name AS
(
SELECT job_id, skills_dim.skills
from skills_job_dim
INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id)
SELECT *
FROM job_id_name