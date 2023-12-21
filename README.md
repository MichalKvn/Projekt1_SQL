# Projekt1_SQL

Cílem SQL projektu bylo vytvoření dvou klíčových tabulek (t_Michal_Kavan_project_SQL_primary_final a t_Michal_Kavan_project_SQL_secondary_final), pomocí kterých bude zodpovězeno následujících pět otátek.

Otázky:
- 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
- 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
- 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
- 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách  potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

Odpovědi:
- 1. Soubor Task_1 čerpá data z tabulky t_Michal_Kavan_project_SQL_primary_final a porovnává mezi sebou roky z hlediska růstu, popřípadě snižování průměrné mzdy v daném odvětví. Cílem úkolu bylo vytvořit nový sloupeček s hodnotami 'rise', 'fall', 'no_change' popřípadě 'no_data', podle roho jak se měnil plat. 
- Plat v průběhu let klesl v 23 případech (konkrétní hodnoty a názvy odvětví jsou uvedeny v Task_1)
-----------------------------------------------------------------------------------------------------------------------------------------

- 2. Soubor Task_2 čerpá data z tabulky t_Michal_Kavan_project_SQL_primary_final a vytváří tabulku prvního (rok 2006) a posledního (rok 2018) srovnávaného období. V každém srovnatelném období je uvedena potravina, plat profese za dané období a počet jednotky (kilogram, lirt) + hodnoty poukazující jaké množství lze za příslušný plat pořídit.  
-----------------------------------------------------------------------------------------------------------------------------------------

- 3. Soubor Task_3 čerpá data z tabulky t_Michal_Kavan_project_SQL_primary_final a poukazuje na tempo zdražování (popřípadě zlevňování potravin) v korunách (sloupec change_) a v procentech (sloupec average_percent_change). Cílem bylo najít kategorii potravin s nejnižším procentuálním meziročním nárůstem. 
- Výslednou kategorií potravin jsou rajská jablka červená kulatá, které v roce 2007 zlevnily o 17,51 Kč a jejich cena tak klesla o 43,43 procent
-----------------------------------------------------------------------------------------------------------------------------------------

- 4. Soubor Task_4 čerpá data z tabulky t_Michal_Kavan_project_SQL_primary_final a na základě dvou VIEW tabulek vytváří procentní změnu cen potravin a procentní změnu příjmu v pracovních odvětvích. Následně je vypsán SELECT, který pomocí agregační funkce avg. vytvoří průměrné hodnoty cen potravin a pracovních odvětví v jedotlvých letech díky příkazu GROUP BY. 
- Na základě výsledku a použití podmínky: HAVING avg(f.food_percent_change) - avg(s.salary_percent_change) > 10, lze konstatovat, že neexistuje rok ve kterém byl meziroční nárůst cen potravin větší než 10 %. (žádná data nejsou zobrazena)
-----------------------------------------------------------------------------------------------------------------------------------------

- 5. Soubor Task_5 čerpá data z tabulky t_Michal_Kavan_project_SQL_secondary_final a vytváří VIEW czechia_only, který vznikl spojením obou primárních tabulek. Pomocí WHERE country = 'Czech Republic' zobrazuje data pouze pro Českou republiku. Další VIEW overall_comparison mezi sebou porovnává roky z hlediska růstu platů, cen produktů a HDP. Následný SELECT vytváří v procentech hodnoty o GDP_percent_increase, salary_percent_increase a product_value_percent_increase.
- Výsledkem je tabulka s hodnotami na základě kterých lze uvažovat, že nárůst HDP má vliv na platy a ceny produktů.