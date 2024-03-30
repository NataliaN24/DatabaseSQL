--1. Напишете заявка, която извежда имената на актрисите, които са също и продуценти с нетни активи над 10 милиона.SELECT  N.NAME FROM  MOVIEEXEC NWHERE N.NAME IN   (SELECT STARNAME             FROM STARSIN			 )			 AND NETWORTH>10000000;--2Напишете заявка, която извежда имената на тези актьори (мъже и жени), които не са продуценти.

SELECT NAME 
FROM MOVIESTAR
WHERE NAME NOT IN (SELECT N.NAME
               FROM MOVIEEXEC N
                          );
--3. Напишете заявка, която извежда имената на всички филми с дължина, по-голяма от дължината на филма ‘Star Wars’
SELECT TITLE
FROM MOVIE 
WHERE LENGTH>ALL(SELECT  M.LENGTH
FROM MOVIE M
WHERE M.TITLE='Star Wars');

--4. Напишете заявка, която извежда имената на продуцентите и имената на филмите за всички филми, които са продуцирани от продуценти с нетни активи--по-големи от тези на ‘Merv Griffin’SELECT   NAME ,M.TITLEFROM MOVIEEXEC  JOIN MOVIE AS M ON CERT#=PRODUCERC#WHERE NETWORTH > (SELECT  ME.NETWORTH                  FROM MOVIEEXEC ME				  WHERE ME.NAME='Merv Griffin');