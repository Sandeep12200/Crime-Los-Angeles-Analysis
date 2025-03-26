/*
-----------------------------------------------------------------------------------------------------------------------------------
													    Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

Please read the instructions carefully before starting the project.
This is a sql file in which all the instructions and tasks to be performed are mentioned. Read along carefully to complete the project.

-----------------------------------------------------------------------------------------------------------------------------------
                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CRIME
-- [Q1] Which was the most frequent crime committed each week? 
-- Hint: Use a subquery and the windows function to find out the number of crimes reported each week and assign a rank. 
Then find the highest crime committed each week
*/
select week_number, 
	   crime_type, 
	   count(*) as crime_count, 
	   dense_rank() over (partition by week_number order by count(*) desc ) as crime_rank 
from crime.report_t 
group  by week_number, crime_type
order by crime_rank asc limit 4 ;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q2] Is crime more prevalent in areas with a higher population density, fewer police personnel, and a larger precinct area? 
-- Hint: Add the population density, count the total areas, total officers and cases reported in each precinct code and check the trend*/

select 
	   t3.precinct_code,
       round(AVG(t2.population_density)) AS avg_population_density,
	   count( distinct t1.area_code) as Area_Count, 
       count(distinct t1.officer_code) as Officer_count, 
       count(*) as crimecount 
from crime.report_t t1
left join crime.location_t t2 on t1.area_code = t2.area_code 
left join crime.officer_t t3 on t1.officer_code = t3.officer_code
group by t3.precinct_code
order by precinct_code ;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q3] At what points of the day is the crime rate at its peak? Group this by the type of crime.
-- Hint: 
time day parts
[1] 00:00:00 to 05:00:00 = Midnight, 
[2] 05:01:00 to 12:00:00 = Morning, 
[3] 12:01:00 to 18:00:00 = Afternoon,
[4] 18:01:00 to 21:00:00 = Evening, 
[5] 21:00:00 to 24:00:00 = Night

Use a subquery, windows function to find the number of crimes reported each week and assign the rank.
Then find out at what points of the day the crime rate is at its peak.
*/
alter table report_t add Time_Day_Parts varchar(255);
UPDATE report_t SET Time_Day_Parts = incident_time;
update crime.report_t set Time_Day_Parts= 
case
when Time_Day_Parts between '00:00:00' and '05:00:00' then "Midnight"
when Time_Day_Parts between '05:01:00' and '12:00:00' then "Morning"
when Time_Day_Parts between '12:01:00' and '18:00:00' then "Afternoon"
when Time_Day_Parts between '18:01:00' and '21:00:00' then "Evening"
when Time_Day_Parts between '21:00:00' and '24:00:00' then "Night"
else Time_Day_Parts
end;

select  
	   crime_type, 
	   count(*) as crime_count,Time_Day_Parts,
	   row_number() over (partition by crime_type order by count(*) desc  ) as crime_rank 
from crime.report_t 
group  by Time_Day_Parts, crime_type
order by crime_rank asc limit 62 ;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q4] At what point in the day do more crimes occur in a different locality?
-- Hint: 
time day parts
[1] 00:00 to 05:00 = Midnight, 
[2] 05:01 to 12:00 = Morning, 
[3] 12:01 to 18:00 = Afternoon,
[4] 18:01 to 21:00 = Evening, 
[5] 21:00 to 24:00 = Night

Use a subquery and the windows function to find the number of crimes reported in each area and assign the rank.
Then find out at what point in the day more crimes occur in a different locality.*/
  
with CrimeByLocality_Time_part as (select area_code,
                                          Time_Day_Parts, 
										  count(*) as crime_count, 
										  dense_rank() over (partition by area_code order by count(*) desc)as crime_rank 
								   from crime.report_t
                                   group by area_code, Time_Day_Parts)
select t1.area_code, t2.area_name, Time_Day_Parts, crime_count from CrimeByLocality_Time_part t1
join crime.location_t t2
on t1.area_code =t2.area_code
where crime_rank = 1 ;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q5] Which age group of people is more likely to fall victim to crimes at certain points in the day?
-- Hint: Age 0 to 12 kids, 13 to 23 teenage, 24 to 35 Middle age, 36 to 55 Adults, 56 to 120 old.*/

alter table victim_t add Age_group varchar(255);
UPDATE victim_t SET Age_group = victim_age;
update crime.victim_t set Age_group = 
case
when Age_group between 0 and 12 then "Kids"
when Age_group between 13 and 23 then "Teenagers"
when Age_group between 24 and 35 then "Middel Age"
when Age_group between 36 and 55 then "Adults"
when Age_group between 56 and 120 then "Old"
else Age_group
end;
select t2.Age_group, 
       count(t1.report_no) as Victim_Count 
from crime.report_t t1
join crime.victim_t t2
on t1.victim_code = t2.victim_code
group by t2.Age_group
order by Victim_count desc ;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q6] What is the status of reported crimes?.
-- Hint: Count the number of crimes for different case statuses. */

select case_status_code , count(report_no) from crime.report_t
group by case_status_code
order by count(report_no) desc ;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q7] Does the existence of CCTV cameras deter crimes from happening?
-- Hint: Check if there is a correlation between the number of CCTVs in each area and the crime rate.*/

SELECT 
    t2.area_name,
    t2.cctv_count,
    COUNT(*) AS report_count
FROM crime.report_t t1
JOIN crime.location_t t2 ON t1.area_code = t2.area_code
GROUP BY t2.area_name, t2.cctv_count
order by report_count desc;
 
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q8] How much footage has been recovered from the CCTV at the crime scene?
-- Hint: Use the case when function, add separately when cctv_flag is true and false and check whether in particular area how many cctv is there,
How much CCTV footage is available? How much CCTV footage is not available? */
select  count(case when cctv_flag =  "TRUE" then 1 end) as cctv_available_count,
        count(case when cctv_flag =  "FALSE" then 0 end) as cctv_not_available_count
from crime.report_t ;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q10] What are the methods used by the public to report a crime? 
-- Hint: Find the complaint type along with the count of crime.*/
select complaint_type, count(complaint_type) as Complaint_Count from crime.report_t
group by complaint_type ;


-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



