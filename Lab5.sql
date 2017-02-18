--1
select a.city
from orders o inner join agents a on o.aid = a.aid
	      inner join customers c on c.cid = o.cid
where o.cid='c006';

--2
select distinct p.pid
from orders o inner join agents a on o.aid = a.aid
	      inner join customers c on c.cid = o.cid
	      inner join products p on p.pid = o.pid
where c.city='Kyoto'
order by pid DESC;

--3
select name
from customers
where cid not in (select cid
	      	  from orders);

--4
select name
from customers c left outer join orders o on c.cid = o.cid
where o.ordNumber is null;

--5 
select distinct c.name as "Customer Name" , a.name as "Agent Name"
from customers c inner join orders o on c.cid = o.cid
                 inner join agents a on o.aid = a.aid
where c.city = a.city;

--6
select c.name as "Customer Name", a.name as "Agent Name", c.city
from customers c inner join agents a on c.city = a.city;
 
--7 
select name, city
from customers
where city = (select city
	      from products
	      group by city
	      order by count(*) 
	      limit 1 ); 
