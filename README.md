# [Project 1: Covid Analyses as of January 2022](https://github.com/danihmoreno/Project-1-Covid-Analyses)
* Downloaded full Covid database from https://ourworldindata.org/covid-deaths  (Feb 15, 2020 to Jan 20, 2022) on Feb 21, 2020
* Converted file from CSV to XLSX and cleaned the data by changing values with periods (.) as decimal separators to commas (,) in order to be compatible with the Brazilian Excel format
* Separated the database into two different databases, one for Covid Deaths and the other for Covid Vaccinations and then imported them to the SQL Server
* Checked big numbers to validate if the data is coherent
* [Scripted main analyses](https://github.com/danihmoreno/Project-1-Covid-Analyses/blob/main/Project%201:%20Covid%20Analyses%20Scripts.sql)
* Copied and saved each scripts' resulting tables to different Excel files
* Imported each file to [Tableau](https://public.tableau.com/app/profile/daniel.moreno3206/viz/COVIDAnalyses/Dashboard1) and created the following data visualizations: 
* ### 1. Covid Global Numbers

![](/images/Covid%20Global%20Numbers.png)

* ### 2. Covid Deaths by Continent

![](/images/Total%20Death%20Count%20by%20Continent.png)

* ### 3. Percent of Population Infected by Covid per Country

![](/images/Percent%20of%20Population%20Infected%20by%20Covid%20per%20Country.png)

* ### 4. Percent of Population Infected by Covid

![](/images/Percent%20of%20Population%20Infected%20by%20Covid.png)

* ### 5. Total Vaccines Applied per Continent

![](/images/Total%20Vaccines%20Applied%20per%20Continent.png)

* ### 6. Total Vaccines Applied in Relation to Population

![](/images/Total%20Covid%20Vaccines%20Applied%20in%20Relation%20to%20Population.png)
