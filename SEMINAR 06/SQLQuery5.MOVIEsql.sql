--1. Напишете заявка, която извежда заглавие и година на всички филми, които са
--по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е
--неизвестна, заглавието и годината на този филм също да се изведат.

SELECT TITLE,YEAR,LENGTH
FROM MOVIE
WHERE LENGTH>120 OR LENGTH IS NULL  AND YEAR<2000

--2. Напишете заявка, която извежда име и пол на всички актьори (мъже и жени),
--чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде
--подреден по име в намаляващ ред.

SELECT NAME,GENDER,BIRTHDATE
FROM MOVIESTAR
WHERE NAME LIKE 'J%' AND BIRTHDATE>1948 
ORDER BY NAME DESC

--3. Напишете заявка, която извежда име на студио и брой на актьорите,
--участвали във филми, които са създадени от това студио.

SELECT COUNT(DISTINCT STARNAME)AS NO,STUDIONAME AS STUDIONAME
FROM MOVIE JOIN STARSIN ON MOVIE.TITLE=STARSIN.MOVIETITLE
GROUP BY STUDIONAME
--4. Напишете заявка, която за всеки актьор извежда име на актьора и броя на
--филмите, в които актьорът е участвал.

SELECT distinct  STARNAME,COUNT(DISTINCT MOVIETITLE) AS NO
FROM STARSIN
GROUP BY STARNAME

--5. Напишете заявка, която за всяко студио извежда име на студиото и заглавие
--на филма, излязъл последно на екран за това студио.

SELECT  STUDIONAME ,TITLE,YEAR
FROM MOVIE MM
WHERE YEAR>=ALL(SELECT YEAR
                FROM MOVIE M
				WHERE MM.STUDIONAME=M.STUDIONAME)
				ORDER BY STUDIONAME DESC;

--6. Напишете заявка, която извежда името на най-младия актьор (мъж).
SELECT NAME
FROM MOVIESTAR M1
WHERE GENDER='M' AND BIRTHDATE >=ALL(SELECT  BIRTHDATE
                                FROM MOVIESTAR M2
				WHERE GENDER='M' );
--or
SELECT NAME
FROM MOVIESTAR
WHERE GENDER='M'
GROUP BY NAME,BIRTHDATE
HAVING BIRTHDATE=   (  SELECT MAX(BIRTHDATE)
                        FROM MOVIESTAR
		        WHERE GENDER='M')
						
						
--7. Напишете заявка, която извежда име на актьор и име на студио за тези
--актьори, участвали в най-много филми на това студио.

SELECT M1.STUDIONAME AS STUDIONAME,S1.STARNAME AS NAME,COUNT(M1.TITLE) AS NO
FROM  STARSIN S1 JOIN MOVIE M1 ON  S1.MOVIETITLE=M1.TITLE
GROUP BY M1.STUDIONAME,S1.STARNAME 
HAVING COUNT(M1.TITLE)>=ALL(SELECT COUNT(M2.TITLE)
                       FROM MOVIE M2 JOIN STARSIN S2 ON M2.TITLE=S2.MOVIETITLE
					   WHERE M1.STUDIONAME=M2.STUDIONAME
					   GROUP BY M2.STUDIONAME,S2.STARNAME);
--8. Напишете заявка, която извежда заглавие и година на филма, и брой на
--актьорите, участвали в този филм за тези филми с повече от двама актьори
SELECT M.TITLE ,M.YEAR,COUNT(S.STARNAME) AS NO
FROM MOVIE AS M JOIN STARSIN S ON M.TITLE=S.MOVIETITLE
GROUP BY M.TITLE,M.YEAR
HAVING COUNT(S.STARNAME)>2;
