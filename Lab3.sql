-- Hannah Riedman Lab 3, 2-5-17

-- 1
select ordnumber, totalusd
from orders
order by ordnumber ASC;

-- 2
select name, city
from agents
where name='Smith';

-- 3
Select pid, name, priceusd
from products
where quantity>200100;

-- 4
Select name, city
from customers
where city='Duluth';

-- 5
Select name
from agents
where aid not in (select aid 
		          from agents
		          where city in ('New York','Duluth'));

-- 6
select *
from products
where priceUSD>=1
except 
select *
from products
where city in ('Dallas','Duluth');

-- 7
select *
from orders
where month in ('Feb','May');

-- 8
select *
from orders
where totalusd>=600
intersect 
select *
from orders
where month='Feb';

-- 9
select *
from orders
where cid='c005';