-- 1
Select city
from agents
where aid in ( select aid
		from orders
		where cid='c006'
		);
		
-- 2
select distinct pid
from orders
where aid in ( select aid
		from orders
		where cid in ( select cid 
				from customers
				where city='Kyoto'
				)
		)
order by pid ASC;

-- 3
select cid, name
from customers
where cid in (select cid
	      from orders
	      where cid not in (select cid
				from orders
				where aid in ('a01')
			    )
);

--4
select cid 
from orders
where pid='p07'
AND cid in (select cid
	    from orders
	    where pid='p01'
	    ); 

-- 5
select pid
from products
where pid not in (select pid 
		  from orders
		  where aid='a08'
		  )
order by pid ASC;

-- 6
Select name, discount,city
from customers
where cid in (select cid
	      from orders
	      where aid in (select aid
			    from agents
			    where city in ('Tokyo', 'New York')
			    )
);

-- 7
select *
from customers
where discount in (select discount
		   from customers
		   where city in ('Duluth','London')
		   );
		  
-- 8
/*
Check constraints specify requrements that must be met by each row in a database table.
They are good for sorting out bad data that might not fit or be correct for that row. 
They can be useful in making your tables more strict and help them have less unconsistancy,.
A good example would be to create a check constranint for (id>0). That way all your ids will
start will something other than 0 because an ID of 0 doesn't really make much sense and you 
will be certain you wont get any negititve ID's since that also wouldn't make sense. A bad
example of a check constraint is making a (last_name = "Riedman"). This is bad beacause my
last name isnt very common and it is very specific, if it is for a school registrar then it
would be bad since there is likely not many people with that last name. It might be okay if 
I was creating a table for only my family but still some of my family has different last 
names as me so its not a very good check constraint. 
*/



