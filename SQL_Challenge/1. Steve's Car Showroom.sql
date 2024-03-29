select * from sales;
select * from cars;
select * from salespersons;
-- 1. What are the details of all cars purchased in the year 2022?
select  sales.purchase_date,cars.make, cars.type
from cars
inner join sales on cars.car_id = sales.car_id
where extract(YEAR from sales.purchase_date) = 2022;
  
---  What is the total number of cars sold by each salesperson?

select sp.name , count(cars.make) as car_sold
from salespersons as sp
inner join sales on sp.salesman_id = sales.salesman_id
inner join cars on cars.car_id = sales.car_id
group By sp.name;

---3. What is the total revenue generated by each salesperson?
select sp.name , sum(cars.cost_$) as total_revenue
from salespersons as sp
inner join sales on sp.salesman_id = sales.salesman_id
inner join cars on cars.car_id = sales.car_id
group By sp.name;

---4. What are the details of the cars sold by each salesperson?

select sp.name , cars.make as car_details
from salespersons as sp
inner join sales on sp.salesman_id = sales.salesman_id
inner join cars on cars.car_id = sales.car_id
group By sp.name, cars.make
order by sp.name;

--- 5. What is the total revenue generated by each car type?
select cars.type ,sum(cost_$) as total_revenue 
from cars
inner join sales on cars.car_id = sales.car_id
group by cars.type

---- 6. What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong'?

select sp.name , cars.type, cars.style
from salespersons as sp
inner join sales on sp.salesman_id = sales.salesman_id
inner join cars on cars.car_id = sales.car_id
where extract(year from sales.purchase_date) = 2021 and sp.name = 'Emily Wong'

----7. What is the total revenue generated by the sales of hatchback cars?
select cars.style , sum(cars.cost_$) as total_revenue
from cars
inner join sales on cars.car_id = sales.car_id
where cars.style = 'Hatchback'
group by cars.style;

----8. What is the total revenue generated by the sales of SUV cars in the year 2022?

SELECT cars.style, SUM(cars.cost_$) AS total_revenue
FROM cars
INNER JOIN sales ON cars.car_id = sales.car_id
WHERE cars.style = 'SUV' AND EXTRACT(YEAR FROM sales.purchase_date) = 2022
group by cars.style;

--- 9. What is the name and city of the salesperson who sold the most number of cars in the year 2023?
SELECT sp.name, sp.city
FROM salespersons AS sp
JOIN (
    SELECT salesman_id
    FROM sales
    WHERE EXTRACT(YEAR FROM purchase_date) = 2023
    GROUP BY salesman_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS top_salesperson ON sp.salesman_id = top_salesperson.salesman_id;

--- 10. What is the name and age of the salesperson who generated the highest revenue in the year 2022?

SELECT sp.name, sp.age, SUM(c.cost_$) AS total_revenue
FROM salespersons AS sp
INNER JOIN sales ON sp.salesman_id = sales.salesman_id
INNER JOIN cars AS c ON c.car_id = sales.car_id
WHERE EXTRACT(YEAR FROM sales.purchase_date) = 2022
GROUP BY sp.name, sp.age;






















