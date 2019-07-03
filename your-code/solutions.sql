SELECT * FROM publications.titles;

SELECT tt.title_id AS TITLE_ID, tt.royalty AS ROYALTY, au_id AS AUTHOR_ID
FROM titles as tt
LEFT JOIN titleauthor