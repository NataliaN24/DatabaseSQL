﻿
/*1. Напишете заявка, която извежда имената на актрисите, които са също и
продуценти с нетни активи над 10 милиона.*/SELECT MS.NAMEFROM MOVIESTAR MS WHERE MS.NAME IN (SELECT NAMEFROM MOVIEEXECWHERE NETWORTH>10000000)AND MS.GENDER='F';--2.Напишете заявка, която извежда имената на тези актьори (мъже и жени),
--които не са продуценти.
SELECT MS.NAME 
FROM MOVIESTAR MS
WHERE MS.NAME NOT IN (SELECT NAME
FROM MOVIEEXEC
);
--3. Напишете заявка, която извежда имената на всички филми с дължина,
--по-голяма от дължината на филма ‘Star Wars’
SELECT TITLE
FROM MOVIE
WHERE LENGTH >(SELECT LENGTH
FROM MOVIE
WHERE TITLE='Star Wars'
)
--4. Напишете заявка, която извежда имената на продуцентите и имената на
--филмите за всички филми, които са продуцирани от продуценти с нетни
--активи по-големи от тези на ‘Merv Griffin’


SELECT M.NAME,MO.TITLE
FROM MOVIEEXEC M JOIN MOVIE MO ON M.CERT#=MO.PRODUCERC#
WHERE M.NETWORTH> ALL(SELECT NETWORTH
FROM MOVIEEXEC
WHERE NAME='Merv Griffin');
