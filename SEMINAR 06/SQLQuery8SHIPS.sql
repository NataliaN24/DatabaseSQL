--1. Напишете заявка, която извежда имената на всички кораби без повторения,
--които са участвали в поне една битка и чиито имена започват с C или K.
SELECT DISTINCT SHIP 
FROM OUTCOMES
WHERE SHIP LIKE 'C%' OR SHIP LIKE  'K%'
--2. Напишете заявка, която извежда име и държава на всички кораби, които
--никога не са потъвали в битка (може и да не са участвали).
SELECT DISTINCT C.COUNTRY ,S.NAME
FROM CLASSES AS C JOIN SHIPS S ON S.CLASS=C.CLASS left JOIN OUTCOMES O ON O.SHIP=S.NAME
WHERE O.RESULT not like 'sunk' OR O.RESULT IS NULL
--3. Напишете заявка, която извежда държавата и броя на потъналите кораби за
--тази държава. Държави, които нямат кораби или имат кораб, но той не е
--участвал в битка, също да бъдат изведени.
SELECT DISTINCT C.COUNTRY,COUNT(O.RESULT) AS NO
FROM CLASSES C  LEFT JOIN SHIPS S ON C.CLASS=S.CLASS LEFT JOIN OUTCOMES O ON S.NAME=O.SHIP
WHERE O.RESULT ='sunk' OR O.RESULT IS NULL
GROUP BY  C.COUNTRY
--4. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи кораби) от битката при Guadalcanal.
	
SELECT B.NAME
FROM BATTLES B JOIN OUTCOMES O ON B.NAME=O.BATTLE
GROUP BY B.NAME 
HAVING COUNT(O.SHIP)>(SELECT COUNT(O2.SHIP)
                      FROM OUTCOMES O2
					  WHERE O2.BATTLE='Guadalcanal');
  --OR
SELECT BATTLE
FROM OUTCOMES 
GROUP BY BATTLE
HAVING COUNT(SHIP)>(SELECT COUNT(SHIP)
                   FROM OUTCOMES 
		    WHERE BATTLE='Guadalcanal');

--5. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи страни) от битката при Surigao Strait.
SELECT O.BATTLE
FROM  OUTCOMES O JOIN SHIPS S ON O.SHIP=S.NAME JOIN CLASSES C ON S.CLASS=C.CLASS
GROUP BY O.BATTLE,C.COUNTRY
HAVING COUNT(C.COUNTRY) >(SELECT COUNT(C2.COUNTRY)
                          FROM  CLASSES C2 JOIN SHIPS S2 ON S2.CLASS =C2.CLASS JOIN  OUTCOMES O2 ON O2.SHIP=S2.NAME
						  WHERE O2.BATTLE='Surigao Strait');
				
--6. Напишете заявка, която извежда имената на най-леките кораби с най-много
--оръдия.
SELECT SHIPS.NAME, CLASSES.DISPLACEMENT, CLASSES.NUMGUNS
FROM SHIPS
         JOIN CLASSES
              ON SHIPS.CLASS = CLASSES.CLASS
WHERE CLASSES.DISPLACEMENT <= ALL (SELECT CLASSES.DISPLACEMENT
                                   FROM CLASSES
                                            JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS)
  AND CLASSES.DISPLACEMENT >= ALL (SELECT CLASSES.NUMGUNS
                                   FROM CLASSES
                                            JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS)

--7. Изведете броя на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в друга битка.

SELECT COUNT(O.SHIP)
FROM OUTCOMES as O JOIN BATTLES AS B
                        ON O.BATTLE = B.NAME
WHERE O.RESULT = 'ok'
  AND O.SHIP IN
      (SELECT OUTCOMES.SHIP FROM OUTCOMES JOIN BATTLES ON OUTCOMES.BATTLE = BATTLES.NAME
       WHERE OUTCOMES.RESULT = 'damaged'
         AND OUTCOMES.SHIP = O.SHIP AND
               BATTLES.DATE < B.DATE)
--8. Изведете име на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в по-мащабна битка (с повече кораби).
SELECT O.SHIP
FROM OUTCOMES AS O
         JOIN BATTLES AS B
              ON O.BATTLE = B.NAME
GROUP BY O.SHIP, O.RESULT, B.DATE
HAVING O.RESULT = 'ok'
   AND B.DATE > (SELECT BATTLES.DATE
                 FROM OUTCOMES
                          JOIN BATTLES
                               ON OUTCOMES.BATTLE = BATTLES.NAME
                 WHERE OUTCOMES.SHIP = O.SHIP
                 GROUP BY OUTCOMES.SHIP, OUTCOMES.RESULT, BATTLES.DATE
                 HAVING OUTCOMES.RESULT = 'damaged')
   AND COUNT(O.SHIP) >= (SELECT COUNT(OUTCOMES.SHIP)
                         FROM OUTCOMES
                                  JOIN BATTLES
                                       ON OUTCOMES.BATTLE = BATTLES.NAME
                         WHERE OUTCOMES.SHIP = O.SHIP
                         GROUP BY OUTCOMES.BATTLE, OUTCOMES.RESULT, BATTLES.DATE
                         HAVING OUTCOMES.RESULT = 'damaged')
