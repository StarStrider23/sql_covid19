# COVID-19 Analysis

Project by Alexsey Chernichenko.

## Project Background and Overview

The dataset used can be found in https://docs.owid.io/projects/etl/api/covid/

It contains various data (worldwide, per continent, per country) that was collected during the years of the COVID-19 pandemic and beyond. The table doesn't only contain essential information like number of infected, deceased and people vaccinated, but also how many patients were in ICU, total tests for COVID-19 and many more. Although, majority of these metrics aren't used. Overall, there are 61 columns and 491,818 rows.

## Relevant metrics

- country - name of a specific country
  
- date - YYYY-MM-DD
  
- total_cases - total confirmed cases of COVID-19 (cumulative)
  
- new_cases - new confirmed cases of COVID-19 counted each day
  
- total_deaths - total deaths attributed to COVID-19 (cumulative)
  
- new_deaths - new deaths attributed to COVID-19 counted each day
  
- people_vaccinated - total number of people who received at least one vaccine dose (cumulative)
  
- people_fully_vaccinated - total number of people who received all doses prescribed by the initial vaccination protocol (cumulative)
  
- population - population of a specific country
  
- continent - continent of a geographical location
  
- human_development_index - a composite index measuring average achievement in three basic dimensions of human development—a long and healthy life, knowledge and a decent standard of living (values range from 0 to 1)

## Project Goals

The goal of the project is to analyse COIVD-19 data by studying and answering the following question:

1. What was the probability of dying if a person is infected (worldwide, in each continent, in each country)?
   
2. How many people have died from COVID-19 (worldwide, in each continent, in each country)?

3. What are the countries with the highest infection and death percentage per continent?

4. What percentage of people have been vaccinated/fully vaccinated (worldwide, in each continent, in each country)?

5. What are the countries with the highest ratio of people vaccinated (or people fully vaccinated) and population per continent?

6. Are there any correlation between vaccinations and new cases of infected/deceased?

7. Are there any correlation between percentage of people infected/deceased and HDI (Human Development Index)?

## Results

### 1+2+3.

The worldwide numbers show that the total of 777,602,273 people (9.7% of the world's population) were infected and 7,092,419 of  people deceased (ca 0.09% of the population). One can also calculate the probability of dying once infected, which is simply the number of deceased divided by the number of infected. This value is 0.9%. 

<img width="638" alt="world_inf+dec" src="https://github.com/user-attachments/assets/4fbe747e-c4a0-4c1d-9e64-7d58e8400aaf" />

Now, it is interesting to break down the information by continents and countries.

<img width="652" alt="Снимок экрана 2025-04-23 в 15 15 46" src="https://github.com/user-attachments/assets/5ad41fc1-acc4-4fb1-be3f-50c78f0f6bc7" />

Interestingly enough, Africa had the lowest percentage of people infected and deceased, but had the highest probability of dying for people who got infected. 

Now, for obvious reasons, it's harder to show the full data for all countries. Therefore, I only show the top 5 countries in the 3 categories from each continent.

![Снимок экрана 2025-04-23 в 14 01 32-side](https://github.com/user-attachments/assets/cd746894-b9db-43e4-9d6e-00e6bdcdcf12)

One can also find out that there are no countries that are in all top 5s. However, including 10 countries makes a difference - there are now 12 countries: 2 from Africa (Tunisia, South Africa), 3 from Oceania (Guam, Northern Mariana Islands, Wallis and Futuna) and 7 from South America (Peru, Brazil, Chile, Paraguay, Argentina, Columbia, Suriname).

### 4+5. 

Now, let's look how many people were vaccinated and fully vaccinated. Here are the world's numbers, which are pretty high - 70% and 65% respectively.

<img width="331" alt="Снимок экрана 2025-04-23 в 15 14 32" src="https://github.com/user-attachments/assets/09054965-a547-4d44-abda-a0d009eca21b" />

The same metrics for the continents. We have Africa being the continent with the lowest numbers and South America with the highest.

<img width="348" alt="Снимок экрана 2025-04-23 в 15 18 16" src="https://github.com/user-attachments/assets/fa0b625d-a7f3-4870-b7b7-59f713184bcc" />

Similarly, here are top 5 countries in people vaccinated and people fully vaccinated from each continent. 

![Снимок экрана 2025-04-23 в 15 35 04-side](https://github.com/user-attachments/assets/eed08df8-e33f-4ff6-900b-28255d857336)

And majority of the countries are present in both top 5, as one can see. The only issue is that there are 3 countries (Nauru, Cook Islands, Gibraltar) that have more than 100% people vaccinated, which of course implies that there's something wrong with the data. 

### 6. 

But it's more interesting to study whether there's a correlation between people getting vaccinated and new cases of infected/deceased? I decided to study the data monthly. One could study the raw data, but it's hard to read and comprehend as the numbers are quite big. Alternatively, one could take a country with smaller population and study the question in the context of one country. But I've chosen to use Tableau and also calculate the Pearson correlation coefficient. First of all, the Pearson correlation coefficient is a measure of linear correlation and is defined as the covariance between a pair of variables divided by a product of their standard deviations, but it can also be written as

<img width="406" alt="Снимок экрана 2025-04-23 в 16 07 08" src="https://github.com/user-attachments/assets/0ea26197-6e2d-4483-b2b8-367423830d4f" />

and ranges from -1 (negative correlation) and +1 (positive correlation).

The correlation coefficient for new cases of infected vs total people vaccinated is 0.22 whereas the correlation coefficient for new cases of deaths vs total people vaccinated is -0.44, which is a bit surprising. First of all, a positive (negative) correlation coefficient implies that the variables are proportional (inversely proportional). In our case, it would mean that there exists a correlation between growth (decreas) of people infected/deceased and people vaccinated. The first value is quite low and the correlation is said to be low. On the other hand, the 2nd value suggests a moderate correltion and, what's even more important, it also says that the values are inversely proportional (i.e. the more people got vaccinated, the fewer people died). But of course it would be wrong to impose a connection between the variables simply based on this. 

Finally, let's visualise the data. 

<img width="1236" alt="Снимок экрана 2025-04-23 в 16 37 01" src="https://github.com/user-attachments/assets/78b73edf-ec0a-42d3-bb07-a6618974679d" />

Looking at the graphs, it appears to be clear why the correlations are not strong. On the upper graph, there are 2 peaks after majority of the population got vaccinated and it is just clear that the number of the new cases only started to decrease in the beginning of 2023, just after the 2nd peak. However, the lower graph tells another story and one could argue that the number of deceased people had gone down after people started to get vaccinations. 

### 7.

It's interesting to check if there are other sorts of correlations. Human development index (HDI) could be a good metric to test. After all, it includes a measure of standard of living. The correlation between HDI and share of infected people is 0.74 whereas it is 0.58 between HDI and percentage of people deceased. Both values are quite high, which is actually quite surprising! However, looking at the graphs below one can see why this is the case. 

<img width="1175" alt="Снимок экрана 2025-04-23 в 18 46 45" src="https://github.com/user-attachments/assets/189ae023-0daf-44e0-8c62-8ce52f71e038" />

The countries with bigger share of their population infected/deceased tend to locate themselves on the right side of the graph, where HDI is bigger. But of course, there are lots of exception to this - just look at the graphs!
