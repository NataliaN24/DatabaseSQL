--1. Напишете заявка, която извежда страните, чиито кораби са с най-голям
--брой оръдия.
SELECT  DISTINCT C.COUNTRY
FROM CLASSES C JOIN SHIPS S ON C.CLASS= S.CLASS
WHERE  C.NUMGUNS>=ALL(SELECT  NUMGUNS
FROM CLASSES);

--2. Напишете заявка, която извежда класовете, за които поне един от
--корабите е потънал в битка.

SELECT DISTINCT CLASS
FROM SHIPS JOIN  OUTCOMES ON SHIPS.NAME= OUTCOMES.SHIP
WHERE OUTCOMES.RESULT='sunk';

--3. Напишете заявка, която извежда името и класа на корабите с 16 инчови
--оръдия.
SELECT DISTINCT S.NAME ,S.CLASS
FROM  SHIPS S JOIN CLASSES C ON S.CLASS=C.CLASS
WHERE C.BORE=16;

--4. Напишете заявка, която извежда имената на битките, в които са
--участвали кораби от клас ‘Kongo’
SELECT BATTLES.NAME
FROM  BATTLES JOIN OUTCOMES ON BATTLES.NAME=OUTCOMES.BATTLE
WHERE OUTCOMES.SHIP IN (SELECT  S.NAME
                 FROM SHIPS S
				 WHERE S.CLASS='Kongo')
--5. Напишете заявка, която извежда класа и името на корабите, чиито брой
--оръдия е по-голям или равен на този на корабите със същия калибър
--оръдия.
SELECT CLASS,NAME
FROM SHIPS
WHERE CLASS IN(
            SELECT   C.CLASS
			FROM CLASSES C
			WHERE C.NUMGUNS>=ALL(SELECT P.NUMGUNS
			                 FROM CLASSES P
							 WHERE P.BORE=C.BORE))
			ORDER BY CLASS;

SELECT SHIPS.CLASS,SHIPS.NAME
FROM  SHIPS JOIN CLASSES C ON SHIPS.CLASS=C.CLASS
WHERE C.NUMGUNS>=ALL(SELECT P.NUMGUNS
               FROM CLASSES P
			   WHERE C.BORE=P.BORE)
			   ORDER BY CLASS;




