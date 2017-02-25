-- Hannah Riedman Lab 6 2-25-17

-- 1
select name, city
from customers
where city = (select city
	      from products
	      group by city
	      order by count(*) DESC
	      limit 1 ); 
-- 2

select name
from products
where priceuSD > (select avg(priceUSD)
	from products)
group by name
order by name DESC;

--3
select customers.name as "Customer Name", orders.pid, sum(orders.totalUSD) as "TotalUSDperProduct"
from orders inner join customers on customers.cid = orders.cid
group by orders.pid, customers.name
order by sum(orders.totalUSD) ASC;

--4
select coalesce (customers.name,'Unknown name'), 
       coalesce (sum(orders.totalUSD),0)
from orders right outer join customers on customers.cid = orders.cid
group by customers.name
order by customers.name ASC;

--5
select customers.name, products.name, agents.name
from customers  inner join orders on customers.cid = orders.cid
		inner join products on orders.pid = products.pid
		inner join agents on orders.aid = agents.aid
where orders.pid in (select pid
		    from products
	            where city='Newark');
		
--6 
select orders.ordNumber, orders.month, orders.cid, orders.aid, orders.pid, orders.qty, orders.totalUSD, 
	(products.priceUSD * orders.qty * (1 - customers.discount/100)) as "Correct totalUSD"
from orders inner join customers on customers.cid = orders.cid
	    inner join products on orders.pid = products.pid
where totalUSD not in (products.priceUSD * orders.qty * (1 - customers.discount/100));

--7
 /* A left outer join and a right outer join will differ based on the order you join tables.
A left outer join will take all the rows from the left table or first table you write,
even if it doesn't match anything on the right table or the second table you write. The right outer
join will do the opposite. */

--Left outer join showing the total amount of money that each product has costed
-- if we used a right outer join here then we would not get the eraser since it has not
-- been ordered yet.
select products.name, coalesce (sum(orders.totalUSD),0) as "totalUSDperProduct"
from products left outer join orders on products.pid = orders.pid
group by products.name
order by products.name ASC;


