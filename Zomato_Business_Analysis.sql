-- Creating new Database and importing Restaurants and Dishes Tables Data from CSV files:
CREATE DATABASE Zomato_Bangalore;

-- Activating the Database to Use it:
USE Zomato_Bangalore;

-- Checking the contents in Restaurants and Dishes table:
SELECT * FROM Restaurants;
SELECT * FROM Dishes;

-- Finding the Count of Restaurants in each Location:
SELECT Location, count(Restaurant_ID) as Rest_Count from Restaurants
GROUP BY 1
ORDER BY 2 DESC;

-- Cheapest Restaurants in Locations by Cost_for_2:
SELECT Location, Restaurant_ID, Restaurant_Name, Cost_for_2 from
(SELECT Location, Restaurant_ID, Restaurant_Name, Cost_for_2, dense_rank() over(partition by Location order by Cost_for_2 asc) as Rnk 
from Restaurants) as Restaurants_2
where Restaurants_2.Rnk = 1
order by 4;

-- Most Expensive Restaurants in Locations by Cost_for_2:
SELECT Location, Restaurant_ID, Restaurant_Name, Cost_for_2 from
(SELECT Location, Restaurant_ID, Restaurant_Name, Cost_for_2, dense_rank() over(partition by Location order by Cost_for_2 desc) as Rnk 
from Restaurants) as Restaurants_2
where Restaurants_2.Rnk = 1
order by 4 desc;

-- Count of Restaurants in Locations, having Delivery Review Score above or equal to 1000:
Select Location, count(distinct Restaurant_ID) as Rest_Count from Restaurants
where Delivery_review_score >= 1000
Group by 1
order by 2 desc;

-- Restaurants in each Location, having highest Ratings:
SELECT Location, Restaurant_ID, Restaurant_Name, Ratings from
(SELECT Location, Restaurant_ID, Restaurant_Name, Ratings, dense_rank() over(partition by Location order by Ratings desc) as Rnk 
from Restaurants) as Restaurants_2
where Restaurants_2.Rnk = 1
order by 4 desc;

-- Locations having highest number of low rated restaurants Ratings below 3:
SELECT Location, count(Restaurant_ID) as Rest_count from Restaurants
where Ratings < 3 
group by 1
order by 2 desc;

-- Count of Restaurants that serves a particular Cuisine:
SELECT Cusines, count(Restaurant_ID) as Rest_Count from Restaurants
GROUP BY 1
ORDER BY 2;

-- Cheapest Restaurant that serves a particular Cuisine by Cost_for_2:
SELECT Restaurant_ID, Restaurant_Name, Cusines, min(Cost_for_2) as Price_for_2 from Restaurants
Group by 3
Order by 3;











