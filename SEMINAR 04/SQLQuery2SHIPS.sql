--1. Напишете заявка, която извежда цялата налична информация за всеки 
--кораб, включително и данните за неговия клас. В резултата не трябва да 
--се включват тези класове, които нямат кораби.
SELECT DISTINCT *
FROM SHIPS  LEFT JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
--2. Повторете горната заявка, като този път включите в резултата и 
--класовете, които нямат кораби, но съществуват кораби със същото име 
--като тяхното.
SELECT *
FROM SHIPS FULL JOIN CLASSES ON SHIPS.CLASS =CLASSES.CLASS

--3. За всяка страна изведете имената на корабите, които никога не са 
--участвали в битка.

SELECT DISTINCT C.COUNTRY,S.NAME
FROM CLASSES C  JOIN SHIPS S ON C.CLASS = S.CLASS 
WHERE S.NAME NOT IN (SELECT SHIP
                    FROM OUTCOMES)
					ORDER BY  C.COUNTRY ASC;

--4. Намерете имената на всички кораби с поне 7 оръдия, пуснати на вода 
--през 1916, но наречете резултатната колона Ship Name.
SELECT SHIPS.NAME AS SHIP_NAME
FROM SHIPS   JOIN  CLASSES ON SHIPS.CLASS=CLASSES.CLASS 
WHERE CLASSES.NUMGUNS >=7 AND LAUNCHED =1916;
--5. Изведете имената на всички потънали в битка кораби, името и дата на 
--провеждане на битките, в които те са потънали. Подредете резултата по 
--име на битката.

SELECT O.SHIP,B.NAME,B.DATE
FROM OUTCOMES O  JOIN BATTLES B ON O.BATTLE=B.NAME
WHERE O.RESULT='sunk' ORDER BY B.NAME ASC;

--6. Намерете името, водоизместимостта и годината на пускане на вода на 
--всички кораби, които имат същото име като техния клас.
SELECT S.NAME,C.DISPLACEMENT,S.LAUNCHED
FROM CLASSES C JOIN SHIPS S ON C.CLASS=S.CLASS
WHERE S.NAME =C.CLASS
--7. Намерете всички класове кораби, от които няма пуснат на вода нито един 
--кораб.
SELECT *
FROM  CLASSES C 
WHERE C.CLASS NOT IN(SELECT CLASS 
                   FROM SHIPS);

--8. Изведете името, водоизместимостта и броя оръдия на корабите,
--участвали в битката ‘North Atlantic’, а също и резултата от битката
SELECT S.NAME,C.DISPLACEMENT,C.NUMGUNS
FROM  SHIPS S JOIN CLASSES C ON S.CLASS=C.CLASS JOIN OUTCOMES O ON S.NAME=O.SHIP
WHERE O.BATTLE='North Atlantic';
