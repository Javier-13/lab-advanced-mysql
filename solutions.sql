USE publications;
SELECT a.au_id as AUTHOR_ID, au_lname as SURNAME, au_fname as F_NAME, t.title as TITLE, p.pub_name as PUBLISHER

FROM titleauthor tt
JOIN authors a 
on a.au_id = tt.au_id

JOIN titles as t
on tt.title_id = t.title_id

JOIN publishers as p
on t.pub_id = p.pub_id;
#-------------------------------------------------------------------------------------------------- CHALLENGE 2
USE publications;
SELECT a.au_id as AUTHOR_ID, au_lname as SURNAME, au_fname as F_NAME, p.pub_name as PUBLISHER, count(t.title_id) as TITLE_COUNT

FROM titleauthor tt
JOIN authors a 
on a.au_id = tt.au_id

JOIN titles as t
on tt.title_id = t.title_id

JOIN publishers as p
on t.pub_id = p.pub_id

group by t.pub_id, a.au_id;

#-------------------------------------------------------------------------------------------------- CHALLENGE 3
USE publications;
SELECT a.au_id as AUTHOR_ID, a.au_lname as LAST_NAME, a.au_fname as FIRST_NAME, SUM(qty) as SALES

from authors as a
join titleauthor as t
on a.au_id = t.au_id

join sales as s
on t.title_id = s.title_id

group by a.au_id;
#--------------------------------------------------------------------------------------------------- CHALLENGE 4
SELECT a.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, IFNULL(SUM(qty), 0) as QUANTITY
FROM authors as a
JOIN titleauthor as tt ON a.au_id = tt.au_id

JOIN titles as t ON tt.title_id = t.title_id

JOIN sales AS s ON t.title_id = s.title_id

GROUP BY AUTHOR_ID ORDER BY QUANTITY DESC;
#----------------------------------------------------------------------------------------------------- Step 1
USE publications;
SELECT a.au_id as AUTHOR_ID, t.title_id as TITLE_id, t.price * s.qty * t.royalty / 100 * tt.royaltyper / 100 as ROYALTY

FROM titleauthor tt
JOIN authors a 
on a.au_id = tt.au_id

JOIN titles as t
on tt.title_id = t.title_id

join sales as s
on t.title_id = s.title_id;
#------------------------------------------------------------------------------------------------------- Step 2
SELECT a.au_id as AUTHOR_ID, t.title_id as TITLE_ID, sum(t.price * s.qty * t.royalty / 100 * tt.royaltyper / 100) as ROYALTY

FROM titleauthor tt
JOIN authors a 
on a.au_id = tt.au_id

JOIN titles as t
on tt.title_id = t.title_id

join sales as s
on t.title_id = s.title_id

GROUP BY AUTHOR_ID, TITLE_ID;
#------------------------------------------------------------------------------------------------------- Step 3
SELECT AUTHOR_ID, sum(ROYALTY) as ROYALTY
FROM ( SELECT a.au_id as AUTHOR_ID, t.title_id as TITLE_ID, sum(t.price * s.qty * t.royalty / 100 * tt.royaltyper / 100) as ROYALTY

		FROM titleauthor tt
		JOIN authors a 
		on a.au_id = tt.au_id

		JOIN titles as t
		on tt.title_id = t.title_id

		join sales as s
		on t.title_id = s.title_id

		GROUP BY AUTHOR_ID, TITLE_ID) summary
        GROUP BY AUTHOR_ID
        order by ROYALTY desc;
SELECT a.au_id as AUTHOR_ID, t.title_id as TITLE_ID, sum(t.price * s.qty * t.royalty / 100 * tt.royaltyper / 100) as ROYALTY

FROM titleauthor tt
JOIN authors a 
on a.au_id = tt.au_id

JOIN titles as t
on tt.title_id = t.title_id

join sales as s
on t.title_id = s.title_id

GROUP BY AUTHOR_ID, TITLE_ID 
#---------------------------------------------------------------------------------------------------------- Challenge 2
CREATE TEMPORARY TABLE publications.aggregate_total_royalties
SELECT a.au_id as AUTHOR_ID, t.title_id as TITLE_ID, sum(t.price * s.qty * t.royalty / 100 * tt.royaltyper / 100) as ROYALTY

FROM titleauthor tt
JOIN authors a 
on a.au_id = tt.au_id

JOIN titles as t
on tt.title_id = t.title_id

join sales as s
on t.title_id = s.title_id

GROUP BY AUTHOR_ID, TITLE_ID;
CREATE TEMPORARY TABLE publications.Challenge2
SELECT AUTHOR_ID, sum(ROYALTY) as ROYALTY FROM aggregate_total_royalties
GROUP BY AUTHOR_ID
order by ROYALTY desc;

SELECT * FROM Challenge2;
#---------------------------------------------------------------------------------------------------------- Challenge 3
CREATE TEMPORARY TABLE publications.Profits1
SELECT a.au_id as AUTHOR_ID, t.title_id as TITLE_ID, sum(t.price * s.qty * t.royalty / 100 * tt.royaltyper / 100) as ROYALTY

FROM titleauthor tt
JOIN authors a 
on a.au_id = tt.au_id

JOIN titles as t
on tt.title_id = t.title_id

join sales as s
on t.title_id = s.title_id

GROUP BY AUTHOR_ID, TITLE_ID;

CREATE TABLE publications.Profits
SELECT AUTHOR_ID, sum(ROYALTY) as ROYALTY FROM Profits1
GROUP BY AUTHOR_ID
order by ROYALTY desc;

SELECT * FROM Profits