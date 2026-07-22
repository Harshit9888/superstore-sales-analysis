<?xml version="1.0" encoding="UTF-8"?><sqlb_project><db path="superstore.db" readonly="0" foreign_keys="1" case_sensitive_like="0" temp_store="0" wal_autocheckpoint="1000" synchronous="2"/><attached/><window><main_tabs open="structure browser pragmas query" current="1"/></window><tab_structure><column_width id="0" width="300"/><column_width id="1" width="0"/><column_width id="2" width="100"/><column_width id="3" width="1836"/><column_width id="4" width="0"/><expanded_item id="0" parent="0"/><expanded_item id="0" parent="1"/><expanded_item id="1" parent="1"/><expanded_item id="2" parent="1"/><expanded_item id="3" parent="1"/></tab_structure><tab_browse><table title="superstore_db" custom_title="0" dock_id="1" table="4,13:mainsuperstore_db"/><dock_state state="000000ff00000000fd00000001000000020000037400000344fc0100000001fb000000160064006f0063006b00420072006f00770073006500310100000000000003740000012300ffffff000003740000000000000004000000040000000800000008fc00000000"/><default_encoding codec=""/><browse_table_settings><table schema="main" name="superstore_db" show_row_id="0" encoding="" plot_x_axis="" unlock_view_pk="_rowid_" freeze_columns="0"><sort><column index="0" mode="0"/></sort><column_widths><column index="0" value="93"/><column index="1" value="53"/><column index="2" value="93"/><column index="3" value="79"/><column index="4" value="71"/><column index="5" value="83"/><column index="6" value="89"/><column index="7" value="122"/><column index="8" value="68"/><column index="9" value="75"/><column index="10" value="98"/><column index="11" value="88"/><column index="12" value="86"/><column index="13" value="53"/><column index="14" value="104"/><column index="15" value="81"/><column index="16" value="93"/><column index="17" value="300"/><column index="18" value="65"/></column_widths><filter_values/><conditional_formats/><row_id_formats/><display_formats/><hidden_columns/><plot_y_axes/><global_filter/></table></browse_table_settings></tab_browse><tab_sql><sql name="SQL 1*">-- SUPER STORE : FURNITURE , OFFICE SUPPLIES , TECHNOLOGY  FROM 5/01/2015-30/12/2018



-- total number of coustomer we have ?
SELECT COUNT(DISTINCT &quot;customer id&quot;) AS total_customers
FROM superstore_db;

-- type of sub_category we are selling?
select &quot;Sub-Category&quot; from superstore_db group by  &quot;Sub-Category&quot;;

-- checking if we have any null values rows
SELECT *
FROM superstore_db
WHERE &quot;Order ID&quot; IS NULL
   OR &quot;Order Date&quot; IS NULL
   OR &quot;Ship Date&quot; IS NULL
   OR &quot;Ship Mode&quot; IS NULL
   OR &quot;Customer ID&quot; IS NULL
   OR &quot;Customer Name&quot; IS NULL
   OR &quot;Segment&quot; IS NULL
   OR &quot;Country&quot; IS NULL
   OR &quot;City&quot; IS NULL
   OR &quot;State&quot; IS NULL
   OR &quot;Postal Code&quot; IS NULL
   OR &quot;Region&quot; IS NULL
   OR &quot;Product ID&quot; IS NULL
   OR &quot;Category&quot; IS NULL
   OR &quot;Sub-Category&quot; IS NULL
   OR &quot;Product Name&quot; IS NULL
   OR Sales IS NULL;
   
  


-- Insghts QUERIES
--1 what are the total sales and profit by region?

select  region,sum(sales) as total_sales_byregion , sum(sales)* 25/100 as  profit
 from superstore_db GROUP by region order by profit desc;
 --assuming we always get 25% of profit from total Sales
 
 --profit by each states:
 select state, region , sum(sales) , sum(sales)* 25/100 as  profit from superstore_db group by state order by profit desc;

--2. What is the total  REVENUE(In OUR CASE its  SALES)  of each Category?
SELECT Category, SUM(Sales) AS TOTAL_REVENUE FROM superstore_db
 GROUP BY Category ORDER BY TOTAL_REVENUE DESC;

--3. WHICH Category SELLING MOST  in which region?
SELECT Region, Category, SUM(Sales) AS Total_Sales
FROM superstore_db
GROUP BY Region, Category
ORDER BY Region, Total_Sales DESC;

--4. WHO ARE THE TOP 10 Customer BY SALES ?
SELECT &quot;Customer name&quot; , sum(sales) as top_10_sales from superstore_db 
group by &quot;Customer name&quot; order by top_10_sales DESC limit 10 ;

--5.MONTHLY SALES OF 2017  ?
 SELECT substr(&quot;Order DATE&quot; , 4,2) AS MONTH  , SUM(SALES) AS TOTAL_SALES 
 FROM superstore_db WHERE  &quot;Order DATE&quot; LIKE &quot;%2017&quot; 
 GROUP BY MONTH ORDER BY TOTAL_SALES  limit 5;
 --SAME THING WHILE USING SUBSTR() IN CASE FUNCTION
 SELECT CASE SUBSTR(&quot;ORDER DATE&quot;,4,2)  
 WHEN '01' THEN 'JAN'
 WHEN &quot;02&quot; THEN &quot;FEB&quot;
 WHEN &quot;03&quot; THEN &quot;MARCH&quot;
 WHEN &quot;04&quot; THEN &quot;APR&quot;
 WHEN &quot;05&quot; THEN &quot;MAY&quot;
 WHEN &quot;06&quot; THEN &quot;JUN&quot;
 WHEN &quot;07&quot; THEN &quot;JULY&quot;
 WHEN &quot;08&quot; THEN &quot;AUG&quot;
 WHEN &quot;09&quot; THEN &quot;SEP&quot;
 WHEN &quot;10&quot; THEN &quot;OCT&quot;
 WHEN &quot;11&quot; THEN &quot;NOV&quot;
 WHEN &quot;12&quot; THEN &quot;DEC&quot;
 END AS MONTH, SUM(SALES) AS TOTAL_SALES
 FROM superstore_db WHERE  &quot;order date&quot;  like '%2017' 
 GROUP BY SUBSTR(&quot;ORDER DATE&quot; , 4,2) ORDER BY SUBSTR(&quot;ORDER DATE&quot; , 4,2);
 
 --6. WHAT IS THE TOTAL YAERLY SALES?
  SELECT SUBSTR(&quot;ORDER DATE&quot; ,7, 4) AS YEAR ,
  SUM(SALES) AS TOTAL_YEAR_SALES
  FROM superstore_db GROUP BY YEAR 
  ORDER BY year;
  --SAME THING in months WHILE USING SUBSTR() IN CASE FUNCTION
SELECT CASE SUBSTR(&quot;ORDER DATE&quot;  , 4, 2)
WHEN &quot;01&quot; THEN &quot;JAN&quot;
WHEN &quot;02&quot; THEN &quot;FEB&quot;
WHEN &quot;03&quot; THEN &quot;MAR&quot;
WHEN &quot;04&quot; THEN &quot;APR&quot;
WHEN &quot;05&quot; THEN &quot;MAY&quot;
WHEN &quot;06&quot; THEN &quot;JUN&quot;
WHEN &quot;07&quot; THEN &quot;JUL&quot;
WHEN &quot;08&quot; THEN &quot;AUG&quot;
WHEN &quot;09&quot; THEN &quot;SEP&quot;
WHEN &quot;10&quot; THEN &quot;OCT&quot;
WHEN &quot;11&quot; THEN &quot;NOV&quot;
WHEN &quot;12&quot; THEN &quot;DEC&quot;
END AS MONTHS ,
SUM(CASE WHEN SUBSTR(&quot;ORDER DATE&quot;, 7,4)= &quot;2015&quot; THEN SALES END ) AS SALES_2015, 
SUM(CASE WHEN SUBSTR(&quot;ORDER DATE&quot;, 7,4)= &quot;2016&quot;THEN SALES END) AS SALES_2016,
SUM(CASE WHEN SUBSTR(&quot;ORDER DATE&quot;, 7,4)= &quot;2017&quot; THEN SALES END) AS SALES_2017,
SUM(CASE WHEN SUBSTR(&quot;ORDER DATE&quot;, 7,4)= &quot;2018&quot; THEN SALES END) AS SALES_2018
from superstore_db 
group by substr(&quot;ORDER DATE&quot;  , 4, 2) 
order by substr(&quot;ORDER DATE&quot;  , 4, 2) ;

--7.WHICH MONTHS HAVE THE LOWEST SALES IN 2018 
--AS COMPARE TO THE AVERAGE OF YEARLY SALES 2018 ?

 SELECT  *
 FROM(
 SELECT  SUBSTR(&quot;ORDER DATE&quot;, 4,2) AS MONTH ,
 SUM(SALES)AS MONTHLY_SALES
 FROM superstore_db
 WHERE SUBSTR(&quot;ORDER DATE&quot;, 7,4)='2018' 
 GROUP BY  SUBSTR(&quot;ORDER DATE&quot;, 4,2))
 WHERE MONTHLY_SALES &lt;(
 SELECT AVG(MONTHLY_SALES)
 FROM(SELECT  SUBSTR(&quot;ORDER DATE&quot;, 4,2) AS MONTH ,
 SUM(SALES)AS MONTHLY_SALES
 FROM superstore_db
 WHERE SUBSTR(&quot;ORDER DATE&quot;, 7,4)='2018' 
 GROUP BY  SUBSTR(&quot;ORDER DATE&quot;, 4,2)));
 
 --8.Identify months where monthly sales were below the average monthly sales of that year?(USING WINDOW FUNCTIONS)
 -- GET MONTHLY SALES FOR EVERY YEAR
 SELECT SUBSTR(&quot;ORDER DATE&quot;, 7, 4) AS year , SUBSTR(&quot;ORDER DATE&quot;,4,2) AS MONTH,
 SUM(SALES) AS MONTHLY_SALES FROM superstore_db
 GROUP BY SUBSTR(&quot;ORDER DATE&quot;, 7, 4),SUBSTR(&quot;ORDER DATE&quot;,4,2) ;
 --NOW USING THIS TEST DATA IN WINDOW FUNCTION WE CAN HAVE IT
 SELECT YEAR, MONTH,MONTHLY_SALES,
AVG(MONTHLY_SALES) OVER(PARTITION BY YEAR)  AS AVG_YEAR_SALES
FROM( SELECT SUBSTR(&quot;ORDER DATE&quot;, 7, 4) AS Year , SUBSTR(&quot;ORDER DATE&quot;,4,2) AS MONTH,
 SUM(SALES) AS MONTHLY_SALES FROM superstore_db
 GROUP BY SUBSTR(&quot;ORDER DATE&quot;, 7, 4),SUBSTR(&quot;ORDER DATE&quot;,4,2));


--9.Impact of Ship Mode on Sales?
SELECT &quot;Ship Mode&quot;,
       COUNT(&quot;Order ID&quot;) AS Orders,
       ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_db
GROUP BY &quot;Ship Mode&quot;
ORDER BY Total_Sales DESC;

--10. Top 10  Cities and most used ship modes of them 
SELECT *from(
SELECT city, &quot;ship mode&quot;, count(*) as orders , 
row_number() over(PARTITION by city order by count(*) desc) as top_shipmode
from superstore_db 
where city in ( select city from superstore_db group by city order by sum(sales) 
desc limit 10) 
group by city , &quot;Ship mode&quot;
) where top_shipmode = 1;



 
 











   

 
 
 











 









</sql><current_tab id="0"/></tab_sql></sqlb_project>
