
--1. Напишете заявка, която извежда името на корабите с водоизместимост над 50000.

SELECT DISTINCT NAME
FROM SHIPS JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
WHERE DISPLACEMENT>50000
--2. Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на всички кораби, участвали в битката при Guadalcanal.

SELECT SHIPS.NAME,DISPLACEMENT,NUMGUNS
FROM SHIPS JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
     JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
	 WHERE BATTLE='Guadalcanal';
--3. Напишете заявка, която извежда имената на тези държави, които имат както бойни кораби, така и бойни крайцери.

SELECT CLASSES.COUNTRY
FROM CLASSES 
WHERE TYPE='bb'
INTERSECT
SELECT CLASSES.COUNTRY
FROM CLASSES
WHERE TYPE='bc'

--4. Напишете заявка, която извежда имената на тези кораби, които са били повредени в една битка, но по-късно са участвали в друга битка.


 SELECT  SHIP
 FROM OUTCOMES 
 WHERE RESULT='damaged'
 INTERSECT 
 SELECT SHIP 
 FROM OUTCOMES
 WHERE RESULT!='damaged'