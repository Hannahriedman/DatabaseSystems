-- Lab 10 

--1 Passed in course number, returns prereqs you need
DROP FUNCTION prereqsfor(integer);
create or replace function PreReqsFor(course_Num int) returns refcursor as 
$$
declare
   course_Num int       := $1;
   resultset  refcursor;
begin
   open resultset for 
      select prereqnum
      from   prerequisites
       where  coursenum = course_Num;
   return resultset;
end;
$$ language plpgsql


-- 2 Passed in prereq, returns the courses you can take with that
DROP FUNCTION isprereqsfor(integer);
create or replace function IsPreReqsFor(course_Num int) returns refcursor as 
$$
declare
   course_Num int       := $1;
   resultset   refcursor;
begin
   open resultset for 
      select coursenum
      from   prerequisites
       where  prereqnum = course_Num;
   return resultset;
end;
$$ language plpgsql
