/* Last Updated By: Hannah Riedman on 5-1-17
   The following code is written in PostgresSQL by Hannah Riedman for the database HannahFlix.
   This is for a final project in Database Systems to illistrate a film and TV show streaming 
   service. It offers various features such as a Queue for each user, a five star rating system, 
   and a Recomendation function. The Documentation for this should be read before implimenting
   this system.
 */

DROP TABLE IF EXISTS Queues;
DROP TABLE IF EXISTS TitleRatings;
DROP TABLE IF EXISTS WatchedTitles;
DROP TABLE IF EXISTS WatchedEpisodes;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS ZipCodes;
DROP TABLE IF EXISTS Episodes;
DROP TABLE IF EXISTS Seasons;
DROP TABLE IF EXISTS TVshows;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Genres;

-- Zip Codes Table --
CREATE TABLE ZipCodes (
  zipcode int,
  state text,
  city text,
  unique(zipcode),
  PRIMARY KEY (zipcode)
);

-- Users Table --
CREATE TABLE Users (
  uid int not null,
  firstname text not null,
  lastname text not null,
  email text not null,
  subscriptionPK text not null,
  creditcardNum bigint not null,
  streetaddress text not null,
  zipcode int not null references ZipCodes(zipcode),
  unique(uid),
  PRIMARY KEY (uid)
);

-- Genres Table --
CREATE TABLE Genres (
  genreID int not null,
  genreName text not null,
  PRIMARY KEY (genreID)
);

-- Titles Table --
CREATE TABLE Titles (
tid int not null,
title text not null,
type text not null,
genreID int not null references Genres(genreID),
unique(tid),
PRIMARY KEY (tid)
);

-- Movies Table --
CREATE TABLE Movies (
  tid int not null references titles(tid),
  director text not null,
  unique(tid),
  PRIMARY KEY (tid)
);

-- TVshows Table --
CREATE TABLE TVshows (
  tid int not null references titles(tid),
  seasonNum int not null,
  unique(tid),
  PRIMARY KEY (tid)
);

-- Seasons Table --
CREATE TABLE Seasons (
  tid int not null references TVshows(tid),
  season int not null,
  episodeNum int not null,
  unique(tid,season),
  PRIMARY KEY (tid,season)
);

-- Episodes Table --
CREATE TABLE Episodes (
  tid int not null,
  season int not null,
  episode int not null,
  episodeTitle text not null,
  FOREIGN KEY(tid, season) REFERENCES Seasons(tid, season),
  PRIMARY KEY (tid, season, episode)
);

-- WatchedTitles Table --
CREATE TABLE WatchedTitles (
  uid int not null references Users(uid),
  tid int not null references Titles(tid),
  unique(uid, tid),
  PRIMARY KEY(uid, tid)
);

-- TitleRatings Table --
CREATE TABLE TitleRatings (
  uid int not null,
  tid int not null,
  rating int not null check (rating > 0 and rating < 6),
  FOREIGN KEY(uid, tid) REFERENCES WatchedTitles(uid, tid),
  PRIMARY KEY(uid, tid)
);

-- WatchedEpisodes Table --
CREATE TABLE WatchedEpisodes (
  uid int not null references Users(uid),
  tid int not null,
  season int not null,
  episode int not null,
  FOREIGN KEY(tid, season, episode) REFERENCES Episodes(tid, season, episode),
  PRIMARY KEY (uid, tid, season, episode)
);

-- Queues Table --
CREATE TABLE Queues (
  uid int not null references Users(uid),
  tid int not null references Titles(tid),
  unique(uid, tid),
  PRIMARY KEY(uid, tid)
);

-- INSERT STATEMENTS --
 
INSERT INTO ZipCodes(zipcode,state,city) 
VALUES(14424,'NY','Canandaigua'),
      (12601,'NY','Poughkeepsie'),
      (11201,'NY','Brooklyn'), 
      (10065,'NY','Manhattan');
      
INSERT INTO Users(uid, firstname, lastname, email, subscriptionPK, creditcardnum,streetaddress,zipcode)
VALUES(1,'Hannah', 'Riedman', 'Hannah.riedman@marist.edu','Premium',5105105105105100,'2630 East St',14424),
      (2,'Alan','Labouseur', 'alan@labouseur.com','Basic',4012888888881881,'3399 North Rd',12601),
      (3,'Phobe','Robinson', 'PRobinson@gmail.com','Basic',5105675895105100,'600 45th St',11201),
      (4,'Charlie','Donner', 'Charliedon@yahoo.com','Basic',4012889988384881,'17 5th St',10065);

INSERT INTO Genres(genreID, genreName)
VALUES 	(1,'Thriller'),
	(2,'Romance'), 
	(3,'Epic'), 
	(4,'Mystery'),
	(5,'Science Fiction'),
	(6,'Action'), 
	(7,'Comedy'),
	(8,'Crime'), 
	(9,'Drama'), 
	(10,'Romantic Comedy'),
	(11,'Fantasy'),
	(12,'Documentary');
	
INSERT INTO Titles(tid, title,type, genreID)
VALUES (1,'The Walking Dead','TVshow',9),
	(2,'Cosmos','TVShow',12), 
	(3,'Arrested Development','TVshow',7), 
	(4,'The Office','TVShow',7),
	(5,'Parks and Rec','TVShow',7),
	(6,'Black Mirror','TVShow',1), 
	(7,'Rick and Morty','TVShow',7),
	(8,'Mr.Robot','TVShow',8), 
	(9,'Breaking Bad','TVShow',9),
	(10,'Do The Right Thing','Movie',9),
	(11, 'City of God','Movie',8), 
	(12, 'Back to the Future','Movie',5), 
	(13,'Monty Python and the Holy Grail', 'Movie',7),
	(14,'North by Northwest','Movie',1),
	(15,'Strangers on a Train','Movie',1),
	(16, 'Kill Bill Vol. 1','Movie',6),
	(17, 'Kill Bill Vol. 2','Movie',6), 
	(18, 'Forrest Gump','Movie',9), 
	(19, 'Edward Scissorhands','Movie',2),
	(20, 'American Psycho','Movie',1),
	(21,'Goldfinger','Movie',6);


INSERT INTO Movies(tid, director)
VALUES (10,'Spike Lee'),
	(11,'Fernando Meirelles and Kátia Lund'), 
	(12,'Robert Zemeckis'), 
	(13,'Terry Gilliam and Terry Jones'),
	(14,'Alfred Hitchcock'),
	(15,'Alfred Hitchcock'),
	(16,'Quentin Tarantino'),
	(17,'Quentin Tarantino'), 
	(18,'Robert Zemeckis'), 
	(19,'Tim Burton'),
	(20,'Mary Harron'),
	(21,'Guy Hamilton');
 

INSERT INTO TVshows(tid,seasonNum)
VALUES 	(1,7),
	(2,1), 
	(3,4), 
	(4,9),
	(5,7),
	(6,3), 
	(7,2),
	(8,2), 
	(9,5);

INSERT INTO Seasons(tid,season,episodeNum)
VALUES 	(1,1,6),(1,2,13),(1,3,16),(1,4,16),(1,5,16),(1,6,16),(1,7,16),
	(2,1,13),(3,1,22),(3,2,18),(3,3,13),(3,4,15),
	(4,1,6),(4,2,22),(4,3,25),(4,4,19),(4,5,28),(4,6,26),(4,7,26),(4,8,24),(4,9,25),
	(5,1,6),(5,2,24),(5,3,16),(5,4,22),(5,5,22),(5,6,22),(5,7,13),
	(6,1,3),(6,2,3),(6,3,6),
	(7,1,11),(7,2,10),
	(8,1,10),(8,2,12),
	(9,1,7),(9,2,13),(9,3,13),(9,4,13),(9,5,16);

-- The Walking Dead episodes 
INSERT INTO Episodes(tid,season,episode,episodeTitle)
VALUES 	(1,1,1,'Days Gone Bye'),(1,2,1,'What Lies Ahead'),(1,3,1,'Seed'),(1,4,1,'30 days without an accident'),
	(1,5,1,'No Sanctuary'),(1,6,1,'First Time Again'),(1,7,1,'The Day will come when you wont be');

-- Cosmos & Arrested Development episodes
INSERT INTO Episodes(tid,season,episode,episodeTitle)
VALUES	(2,1,1,'The Shores of the Cosmic Ocean'),(2,1,13,'Who Speaks for Earth?'),(3,1,1,'Pilot'),
	(3,2,1,'The One Where Michael Leaves'),(3,3,1,'The Cabin Show'),(3,4,1,'Flight of the Phoenix');

--The Office & Parks and Rec episodes
INSERT INTO Episodes(tid,season,episode,episodeTitle)
VALUES (4,1,1,'Pilot'),(4,2,1,'The Dundies'),(4,3,1,'Gay Witch Hunt'),(4,4,1,'Fun Run'),(4,5,1,'Weight Loss'),
       (4,6,1,'Gossip'),(4,7,1,'Nepotism'),(4,8,1,'The List'),(4,9,1,'New Guys'),(5,1,1,'Pilot'),(5,2,1,'Pawnee Zoo'),
       (5,3,1,'Go Big or Go Home'),(5,4,1,'Im Leslie Knope'),(5,5,1,'Ms.Knope Goes to Washington'),
       (5,6,1,'London'),(5,7,1,'2017');
-- Black Mirror & Rick and Morty & Mr.Robot episodes
INSERT INTO Episodes(tid,season,episode,episodeTitle)
VALUES 	(6,1,1,'The National Anthem'),(6,2,1,'Be Right Back'),(6,3,1,'NoseDive'),(6,3,6,'Hated in a Nation'),
	(7,1,1,'Pilot'),(7,2,1,'A Rickle in Time'),(7,2,5,'Get Schwifty'),(8,1,1,'eps1.0_hellofriend.mov'),
	(8,2,1,'eps2.0_unm4sk-pt1.tc');
-- Breaking Bad episodes
INSERT INTO Episodes(tid,season,episode,episodeTitle)
VALUES 	(9,1,1,'Pilot'),(9,2,1,'Seven Thirty-Seven'),(9,3,1,'No Más'),
	(9,4,1,'Box Cutter'),(9,5,1,'Live Free or Die');

INSERT INTO WatchedTitles(uid,tid)
VALUES 	(1,1),(1,3),(1,4),(1,5),(1,10),(1,11),(1,14),
	(2,2),(2,6),(2,12),(2,21),
	(3,5),(3,7),(3,18),(3,15),
	(4,6),(4,20),(4,18),(4,14);	

INSERT INTO WatchedEpisodes(uid,tid,season,episode)
VALUES 	(1,1,1,1),(1,1,2,1),(1,1,3,1),(1,3,3,1),(1,4,4,1),(1,5,4,1),
	(2,2,1,1),(2,2,1,13),(2,6,1,1),(2,6,3,6);

INSERT INTO TitleRatings(uid,tid,rating)
VALUES 	(1,3,5),(1,10,5),(1,11,5),
	(2,21,4),
	(3,5,4),(3,7,5),
	(4,6,5),(4,20,5),(4,18,2);

INSERT INTO Queues(uid,tid)
VALUES (1,9),(1,19),(1,14),(1,15),(2,10),(2,11);

-- Basic Queries to view all tables --

SELECT * FROM TitleRatings;
SELECT * FROM Queue;
SELECT * FROM WatchedTitles;
SELECT * FROM WatchedEpisodes;
SELECT * FROM titles;
SELECT * FROM ZipCodes;
SELECT * FROM Users;
SELECT * FROM Seasons;
SELECT * FROM Episodes;
SELECT * FROM TVshows;
SELECT * FROM Movies;
SELECT * FROM Genres;

-- VIEWS --

-- Views: View all Movies --
CREATE VIEW view_all_movies
AS
SELECT t.tid, title as "Movie title", director
FROM movies m INNER JOIN titles t ON m.tid = t.tid;

-- Views: View all TVshow episodes --
CREATE VIEW view_all_tvshow_episodes
AS
SELECT t.tid, title as "TV show title", season, episode, episodetitle
FROM episodes e INNER JOIN titles t ON e.tid = t.tid;

-- Views: View most popular titles --
CREATE VIEW most_popular_titles
AS
SELECT t.tid, title, type, count(*) as "Users Watched"
FROM titles t INNER JOIN watchedtitles wt ON t.tid = wt.tid
GROUP BY t.tid
ORDER BY count(*) DESC, t.tid;

-- REPORTS --

-- Reports: Percent of Users that are Basic --
SELECT  round( 
( (count(*) filter (WHERE subscriptionPK = 'Basic')::numeric
/ count(*)::numeric) * 100)::numeric, 2
) as "Percent Basic Users"
FROM users; 

-- Reports: The most popular genre --
SELECT genreName as "Most Popular Genre"
FROM genres
WHERE genreID = (SELECT genreID
		 FROM (SELECT genreID,count(*)
		       FROM watchedtitles wt INNER JOIN titles t ON wt.tid = t.tid
		       GROUP BY genreID
		       ORDER BY count(*) DESC
		       limit 1) as "GenreID");

-- Reports: The most popular Director
SELECT director as "Most Popular Director"
FROM (SELECT director, count(*)
      FROM watchedtitles wt INNER JOIN movies m ON wt.tid = m.tid
      GROUP BY director
      ORDER BY count(*) DESC
      limit 1) as "director";
	       

-- STORED PROCEDURES --

-- Recommendations Stored Procedue --
DROP FUNCTION recommendations(theuser integer,resultSet refcursor);
CREATE or REPLACE function recommendations(theuser int,resultSet refcursor) returns refcursor as 
$$
DECLARE
   theuser int := $1;
   resultSet  refcursor := $2;
BEGIN
   open resultset for 
      SELECT title as "Recommended Titles"
      FROM titles 
      WHERE genreID = (SELECT genreID
		       FROM(select genreID,count(*)
			    FROM watchedtitles wt INNER JOIN titles t ON wt.tid = t.tid
			    WHERE uid = theuser
			    GROUP BY genreID
		            ORDER BY count(*) DESC
		            LIMIT 1) as "genreID" )
      AND title not in (SELECT title
			FROM watchedtitles wt INNER JOIN titles t ON wt.tid = t.tid
			WHERE uid = theuser);
   return resultset;
END;
$$ language plpgsql

-- Example result for user id 2 --
SELECT recommendations(2,'data');
fetch all in data; 


-- View by Genre Stored Procedure --
DROP FUNCTION viewbygenre(genre text,resultSet refcursor);
CREATE or REPLACE function viewbygenre(genre text,resultSet refcursor) returns refcursor as 
$$
DECLARE
   genre text := $1;
   resultSet  refcursor := $2;
BEGIN
   open resultset for 
      SELECT title, type 
      FROM titles 
      WHERE genreID = (SELECT genreID
		       FROM genres
		       WHERE genreName = genre);
     
   return resultset;
END;
$$ language plpgsql

-- Example result for Genre "Drama" --
SELECT viewbygenre('Drama','data');
fetch all in data; 

-- TRIGGERS --

-- creditcard_num() funciton for trigger creditcard_check --
CREATE OR REPLACE FUNCTION creditcard_num() RETURNS TRIGGER AS
$$
DECLARE
       creditcard text := cast(new.creditcardnum as text);
BEGIN 
    IF creditcard is NULL THEN 
	RAISE EXCEPTION 'creditcard cannot be null';
    END IF;
    IF (SELECT length(creditcard) 
         FROM Users
         WHERE Uid = new.uid) <> 16 THEN
         RAISE EXCEPTION 'creditcard must be valid';
    END IF;
    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

-- credit card check trigger --
CREATE TRIGGER creditcard_check
  AFTER INSERT  
  ON Users 
  FOR EACH ROW  
  EXECUTE PROCEDURE creditcard_num(); 

-- SECURITY --

-- Admin Role --
CREATE ROLE Admin;
GRANT ALL 
ON ALL TABLES IN SCHEMA PUBLIC
TO Admin;

-- Film Curator Role --
CREATE ROLE FilmCurator;
GRANT SELECT, INSERT, DELETE
ON Genres, Titles, Movies, most_popular_titles
TO FilmCurator;

-- Show Specialist Role --
CREATE ROLE ShowSpecialist;
GRANT SELECT, INSERT, UPDATE, DELETE
ON Genres, Titles, TVshows, Seasons, Episodes, most_popular_titles
TO ShowSpecialist;		    