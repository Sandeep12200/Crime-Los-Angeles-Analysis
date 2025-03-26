# Crime Analysis of Los Angeles crime reports

## Project description:
People all throughout Los Angeles are concerned about recent reports of crimes in numerous locations. The mayor of Los Angeles has established a new Criminal Investigation Division to study how and why crime is on the rise, as well as the elements that contribute to it, so that officials may take the necessary steps to keep the city's residents safe.

## Problem Statements:
* Which was the most frequent crime committed each week?
* Is crime more prevalent in areas with a higher population density, fewer police personnel, and a larger precinct area?
* At what points of the day is the crime rate at its peak? Group this by the type of crime.
* At what point in the day do more crimes occur in a different locality?
* Which age group of people is more likely to fall victim to crimes at certain points in the day?
* What is the status of reported crimes?
* Does the existence of CCTV cameras deter crimes from happening?
* How much footage has been recovered from the CCTV at the crime scene?
* What are the methods used by the public to report a crime?

## Process:
* Importing data in MySql
* Verify data for any missing values and anomalies.
* Perform queries listed in problem statement using sql.

## Insights:
* Most of the crimes are committed during the last week (4) with Battery-Simple assault & Burglary from vehicles having most reported crimes. 1st Week having least crime reports and 2nd and 3rd week having moderate number of reported crimes.
* Precinct 3 have highest crime reports while having 2 areas and 11 officers under it. while precinct 7 have lowest crime reports while having only 1 area and 5 officers under it. From this, we can say that having more areas & high population density results in more crime occurrence.
* Most of the crimes Occurs during Morning & Afternoon for crimes such as Burglary from Vehicle, Vehicle Stolen, Vandalism Kidnapping etc. while night & midnight having lowest reports. 
* Rampart & Hollenbeck areas having most crime reports (approx.31%) during Afternoon & Morning while Northeast having lowest crimes reports.
* Adults are most frequently victims in crimes (742), most likely due to increased exposure to potential risks stemming from their lifestyles and activities. While Kids & Teenagers having lower victims counts compared to other age-groups.
* Majority of the cases (1186 approx. 89%) having status code having IC which means case is still under investigation. While AA indicates Arrests are made in considerable number(94 approx. 7% ) & AO status code indicate that fewer cases result in outcomes other than arrest or continued investigation (38 approx. 3%).
* Having High number of CCTV in an area leads to lows Crimes, such as Hollywood, Newton, West Valley having approx. same number of CCTV in the area (around 270) while having moderate number of reported crimes (Highest crime count – 189 & lowest 45). While  Rampart having lowest number of CCTV (165 & 150) leads to highest Reported crimes in Rampart (233).This suggests a correlation between lower CCTV coverage and higher crime rates.
* Only  29% (382 out of 1318) total footages were recovered from CCTV at the crime scene. This indicates the delay in evidence collection by officers due to technical problems.
* Most of the Cases are reported through phones (approx. 61%). And email is least preferred method for reporting. Which means Phone calls are the most convenient method for reporting crimes, as they can be made quickly and easily from anywhere.

## Recommendations:
* Assigning Officer in a precinct according to area size &  Population Density can lead to lower crime rate.
* Increasing Patrols during Morning, Afternoon & at Night as  most crimes are committed during these day parts. most Crimes such as burglary, vehicle related, Kidnapping are committed during these day periods.
* Deploying more CCTV and Patrolling officers in area where Crime rate is high, as areas with less CCTV in have more crime reports.
* Governments and organizations should conduct public awareness campaigns focusing on crime prevention and safe behaviors tailored for different age-groups especially adult as adults faces higher risk due to certain professions (e.g., night-shift workers, delivery drivers) and activities.
* Introducing better technologies for faster evidence gathering, ensure redundant backup system for evidence in case of data loss, regular maintenance of CCTV for malfunction prevention. This can help in better evidence gathering for case procession.




