-- 1
select * from products;

-- 2
select name from categories;

-- 3
select * from products order by price desc limit 1;

-- 4
select * from products order by price asc limit 1;

-- 5
select * from products where price > 50000;

-- 6
select * from sales order by sale_date limit 10;

-- 7
select * from sales where quantity > 3;

-- 8
select * from sales where total_amount > 100000;

-- 9
select * from products where name ilike '%книга%';

-- 10
select * from sales where sale_date::date = '2023-05-15';

-- 11
select count(*) as total_categories from categories;

-- 12
select count(*) as total_products from products;

-- 13
select avg(price) as average_price from products;

-- 14
select sum(total_amount) as total_revenue from sales;

-- 15
select max(total_amount) as max_check from sales;

-- 16
select min(total_amount) as min_check from sales;

-- 17
select sum(quantity) as total_quantity from sales;

-- 18
select product_id, sum(quantity) as total_sales
from sales
group by product_id;

-- 19
select product_id, sum(total_amount) as revenue
from sales
group by product_id;

-- 20
select product_id, sum(total_amount) as revenue
from sales
group by product_id
having sum(total_amount) > 1000000;

-- 21
select sale_date::date, count(*) as sales_count
from sales
group by sale_date::date
order by sale_date::date;

-- 22
select sale_date::date, sum(total_amount) as daily_revenue
from sales
group by sale_date::date
order by daily_revenue desc
limit 1;

-- 23
select p.name, c.name
from products p
join categories c on p.category_id = c.category_id;

-- 24
select s.sale_id, p.name, s.quantity, s.total_amount, s.sale_date
from sales s
join products p on s.product_id = p.product_id;

-- 25
select c.name, sum(s.total_amount) as total_revenue
from sales s
join products p on s.product_id = p.product_id
join categories c on p.category_id = c.category_id
group by c.name;

-- 26
select c.name, avg(s.total_amount) as avg_check
from sales s
join products p on s.product_id = p.product_id
join categories c on p.category_id = c.category_id
group by c.name
order by avg_check desc
limit 1;

-- 27
select s.sale_date, p.name, c.name, s.total_amount
from sales s
join products p on s.product_id = p.product_id
join categories c on p.category_id = c.category_id;

-- 28
select p.name
from products p
left join sales s on p.product_id = s.product_id
where s.sale_id is null;

-- 29
select *
from products
where price > (
select avg(price)
from products
);

-- 30
select p.name, c.name, sum(s.total_amount) as revenue
from sales s
join products p on s.product_id = p.product_id
join categories c on p.category_id = c.category_id
group by p.name, c.name
order by revenue desc
limit 3;