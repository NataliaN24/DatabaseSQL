--1Напишете заявка, която извежда имената на актьорите мъже, участвали във филма The Usual Suspects.

SELECT MOVIESTAR.NAME
FROM MOVIESTAR JOIN STARSIN ON MOVIESTAR.NAME=STARSIN.STARNAME
WHERE  MOVIESTAR.GENDER='M' AND STARSIN.MOVIETITLE='The Usual Suspects';
--2. Напишете заявка, която извежда имената на актьорите, участвали във филми от 1995, продуцирани от студио MGM.


SELECT STARSIN.STARNAME
FROM MOVIE INNER JOIN STARSIN ON MOVIE.YEAR=STARSIN.MOVIEYEAR
WHERE MOVIE.YEAR>=1995 AND MOVIE.STUDIONAME='MGM';
--3. Напишете заявка, която извежда имената на продуцентите, които са продуцирали филми на студио MGM.


SELECT DISTINCT MOVIEEXEC.NAME
FROM MOVIEEXEC JOIN MOVIE ON CERT#=PRODUCERC#
WHERE STUDIONAME='MGM'
--4. Напишете заявка, която извежда имената на всички филми с дължина, поголяма от дължината на филма Star Wars.
SELECT MOVIE.TITLE
FROM MOVIE  CROSS JOIN MOVIE AS M2
WHERE M2.TITLE='Star Wars' AND M2.LENGTH<MOVIE.LENGTH

--5. Напишете заявка, която извежда имената на продуцентите с нетни активи поголеми от тези на Stephen Spielberg.

--1 MANNER
SELECT MOVIEEXEC.NAME
FROM MOVIEEXEC
WHERE NETWORTH>(
     SELECT NETWORTH
  FROM MOVIEEXEC
   WHERE MOVIEEXEC.NAME='Stephen Spielberg'
)
--2 MANNER
SELECT MOVIEEXEC.NAME
FROM MOVIEEXEC JOIN MOVIEEXEC AS M2 ON M2.NETWORTH<MOVIEEXEC.NETWORTH
WHERE  M2.NAME='Stephen Spielberg'
