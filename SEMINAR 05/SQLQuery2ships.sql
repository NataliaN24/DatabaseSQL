--1. Напишете заявка, която извежда броя на класовете бойни кораби.

SELECT DISTINCT COUNT(CLASS) as NUMBER
FROM CLASSES 
GROUP BY TYPE
HAVING TYPE='bb'

--2. Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.

SELECT AVG(NUMGUNS) AS NOGUNS,CLASS
FROM CLASSES
GROUP BY CLASS,TYPE
HAVING TYPE='bb'

--3. Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.
SELECT AVG(NUMGUNS)AS NUMGUNS
FROM  CLASSES
GROUP BY TYPE
HAVING TYPE='bb'

--4. Напишете заявка, която извежда за всеки клас първата и последната година, в
--която кораб от съответния клас е пуснат на вода.
SELECT DISTINCT CLASS ,MIN(LAUNCHED)AS FIRSTYEAR ,MAX(LAUNCHED)AS LASTYEAR
FROM SHIPS
GROUP BY CLASS

--5. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа.
SELECT COUNT(S.NAME) AS SHIPSNUMBER,S.CLASS
FROM SHIPS S JOIN OUTCOMES O ON S.NAME=O.SHIP
WHERE O.RESULT='sunk'
GROUP BY S.CLASS

--6. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа, за тези класове с повече от 2 кораба.
SELECT COUNT(S.NAME) AS NUMBER,S.CLASS
FROM SHIPS S JOIN OUTCOMES O ON S.NAME=O.SHIP
WHERE O.RESULT='sunk' 
AND S.CLASS IN
               (SELECT CLASS 
			   FROM SHIPS 
			   GROUP BY CLASS 
			   HAVING COUNT(NAME)>2)
GROUP BY S.CLASS
	--OR
SELECT COUNT(S.NAME)AS NO,S.CLASS
FROM SHIPS S JOIN OUTCOMES O ON  S.NAME=O.SHIP
GROUP BY S.CLASS,O.RESULT
HAVING S.CLASS IN (SELECT  CLASS
                  FROM SHIPS 
		  GROUP BY CLASS
		   HAVING COUNT(NAME)>2 )
 AND O.RESULT='SUNK';

--7. Напишете заявка, която извежда средния калибър на оръдията на корабите за
--всяка страна.
SELECT DISTINCT AVG(BORE) AS AVGBORE,COUNTRY
FROM CLASSES  JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS
GROUP BY COUNTRY
