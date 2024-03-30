--1. Напишете заявка, която извежда името на продуцента и имената на
--филмите, продуцирани от продуцента на филма ‘Star Wars’.

SELECT MOVIEEXEC.NAME,MOVIE.TITLE
FROM MOVIEEXEC LEFT JOIN MOVIE ON MOVIEEXEC.CERT#=MOVIE.PRODUCERC#
WHERE MOVIEEXEC.CERT#=(SELECT  MOVIE.PRODUCERC#
                        FROM  MOVIE
						WHERE  TITLE='Star Wars');
--2. Напишете заявка, която извежда имената на продуцентите на филмите, в
--които е участвал ‘Harrison Ford’.
SELECT DISTINCT MOVIEEXEC.NAME
FROM MOVIEEXEC LEFT JOIN MOVIE ON MOVIEEXEC.CERT#=MOVIE.PRODUCERC#
WHERE  MOVIE.TITLE IN (SELECT MOVIETITLE
                    FROM STARSIN
					WHERE STARNAME='Harrison Ford');
--3. Напишете заявка, която извежда името на студиото и имената на
--актьорите, участвали във филми, произведени от това студио, подредени
--по име на студио.

SELECT DISTINCT STUDIO.NAME ,STARSIN.STARNAME
FROM STUDIO JOIN MOVIE ON STUDIO.NAME=MOVIE.STUDIONAME JOIN STARSIN ON MOVIE.TITLE=STARSIN.MOVIETITLE

--4. Напишете заявка, която извежда имената на актьорите, участвали във
--филми на продуценти с най-големи нетни активи.
SELECT DISTINCT STARSIN.STARNAME,MOVIEEXEC.NETWORTH,MOVIE.TITLE
FROM ( STARSIN JOIN MOVIE ON STARSIN.MOVIETITLE=MOVIE.TITLE AND STARSIN.MOVIEYEAR=MOVIE.YEAR ) JOIN MOVIEEXEC ON MOVIE.PRODUCERC#=MOVIEEXEC.CERT#
WHERE MOVIEEXEC.NETWORTH>=ALL(SELECT  MOVIEEXEC.NETWORTH
                          FROM MOVIEEXEC
						  )
--5. Напишете заявка, която извежда имената на актьорите, които не са
--участвали в нито един филм.SELECT MOVIESTAR.NAME,STARSIN.MOVIETITLEFROM  MOVIESTAR LEFT JOIN STARSIN  ON STARSIN.STARNAME=MOVIESTAR.NAMEWHERE STARSIN.MOVIETITLE  IS NULL;