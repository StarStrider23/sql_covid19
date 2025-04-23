# COVID-19 Analysis

Project by Alexsey Chernichenko.

## Project Background and Overview

The dataset used can be found in https://docs.owid.io/projects/etl/api/covid/

It contains various data (worldwide, per continent, per country) that was collected during the years of the COVID-19 pandemic and beyond. The table doesn't only contain essential information like number of infected, deceased and people vaccinated, but also how many patients were in ICU, total tests for COVID-19 and many more. Although, majority of these metrics aren't used. Overall, there are 61 columns and 491,818 rows.

## Project Goals

The goal of the project is to analyse COIVD-19 data by studying and answering the following question:

1. What was the probability of dying if a person is infected (worldwide, in each continent, in each country)?
   
2. How many people have died from COVID-19 (worldwide, in each continent, in each country)?

3. What are the countries with the highest infection and death percentage per continent?

4. What percentage of people have been vaccinated/fully vaccinated (worldwide, in each continent, in each country)?

5. What are the countries with the highest ratio of people vaccinated (or people fully vaccinated) and population per continent?

6. Are there any correlation between vaccinations and new cases of infected/deceased?

7. Are there any correlation between percentage of people infected/deceased and HDI (Human Development Index)?

8. Are there any correltaion between percentage of people infected(deceased and share of the population with basic handwashing facilities on premises?

## Results

### 1+2+3.

The worldwide numbers show that the total of 777,602,273 people (9.7% of the world's population) were infected and 7,092,419 of  people deceased (ca 0.09% of the population). One can also calculate the probability of dying once infected, which is simply the number of deceased divided by the number of infected. This value is 0.9%. 

<img width="638" alt="world_inf+dec" src="https://github.com/user-attachments/assets/4fbe747e-c4a0-4c1d-9e64-7d58e8400aaf" />

Now, it is interesting to break down the information by continents and countries.

<img width="681" alt="Снимок экрана 2025-04-23 в 13 51 03" src="https://github.com/user-attachments/assets/9af345c1-e982-4ce3-9ef2-f9548c2906b7" />

Interestingly enough, Africa had the lowest percentage of people infected and deceased, but had the highest probability of dying for people who got infected. Now, for obvious reasons, it's harder to show the full data for all countries. Therefore, I only show the top 5 countries in the 3 categories from each continent.

![Снимок экрана 2025-04-23 в 14 01 32-side](https://github.com/user-attachments/assets/cd746894-b9db-43e4-9d6e-00e6bdcdcf12)

One can also find out that there are no countries that are in all top 5s. However, including 10 countries makes a difference - there are now 12 countries: 2 from Africa (Tunisia, South Africa), 3 from Oceania (Guam, Northern Mariana Islands, Wallis and Futuna) and 7 from South America (Peru, Brazil, Chile, Paraguay, Argentina, Columbia, Suriname).

### 4. 



