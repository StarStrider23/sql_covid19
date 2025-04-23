# COVID-19 Analysis

Project by Alexsey Chernichenko.

## Project Background and Overview

The dataset used can be found in https://docs.owid.io/projects/etl/api/covid/

It contains various data (worldwide, per continent, per country) that was collected during the years of the COVID-19 pandemic and beyond. The table doesn't only contain essential information like number of infected, deceased and people vaccinated, but also how many patients were in ICU, total tests for COVID-19 and many more. Although, majority of these metrics aren't used. Overall, there are 61 columns and 491818 rows.

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

The worldwide numbers show that the total of 777,602,273 (9.7% of the world's population) of people were infected and 7,092,419 of people deceased (ca 0.09% of the population). One can also calculate the probability of dying once infected, which is simply the number of deceased divided by the number of infected. This value is 0.9%. 


Now, it is interesting to break down the information by continents and countries. 

