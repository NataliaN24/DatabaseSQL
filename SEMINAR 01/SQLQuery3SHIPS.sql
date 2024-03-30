﻿
--1. Напишете заявка, която извежда класа и страната за всички класове с помалко от 10 оръдия.
SELECT*
FROM CLASSES

 SELECT CLASS, COUNTRY
 FROM CLASSES
 WHERE NUMGUNS<10
--2. Напишете заявка, която извежда имената на корабите, пуснати на вода преди 1918. Задайте псевдоним shipName на колоната.
SELECT *
FROM SHIPS

SELECT NAME AS shipName
FROM SHIPS
WHERE LAUNCHED<1918

--3. Напишете заявка, която извежда имената на корабите потънали в битка и имената на съответните битки.
SELECT *
FROM OUTCOMES

SELECT SHIP
FROM OUTCOMES
WHERE RESULT='sunk'
--4. Напишете заявка, която извежда имената на корабите с име, съвпадащо с името на техния клас.
SELECT *
FROM  SHIPS

SELECT NAME
FROM SHIPS
WHERE NAME=CLASS

--5. Напишете заявка, която извежда имената на корабите, които започват с буквата R.
SELECT NAME 
FROM SHIPS
WHERE NAME LIKE'R%'
--6. Напишете заявка, която извежда имената на корабите, които съдържат 2 или повече думи.
SELECT NAME
FROM SHIPS
WHERE NAME LIKE'% %'