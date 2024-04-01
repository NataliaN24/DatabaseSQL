--1. Напишете заявка, която извежда всички модели лаптопи, за които се
--предлагат както разновидности с 15" екран, така и с 11" екран.
SELECT MODEL,CODE,SCREEN
FROM LAPTOP
WHERE SCREEN=15 OR SCREEN =11
	--OR
SELECT MODEL,CODE,SCREEN
FROM LAPTOP
GROUP BY MODEL,SCREEN,CODE
HAVING SCREEN =15 OR SCREEN=11;

--2. Да се изведат различните модели компютри, чиято цена е по-ниска от найевтиния лаптоп, произвеждан от същия производител.
--1st SOLUTION
SELECT  DISTINCT P.model
FROM PC P JOIN PRODUCT PR ON P.model=PR.model
WHERE P.PRICE< (SELECT  TOP 1  L.PRICE
                 FROM LAPTOP L JOIN PRODUCT PROD ON L.model=PROD.model
				 WHERE  PROD.MAKER=PR.MAKER );
--2nd SOLUTION
SELECT DISTINCT PC.MODEL AS MODEL
FROM PC JOIN PRODUCT  AS P1 ON PC.MODEL=P1.MODEL
GROUP BY PC.MODEL,PC.PRICE,P1.MAKER
HAVING PC.PRICE <(SELECT  TOP 1 LAPTOP.PRICE
               FROM LAPTOP JOIN PRODUCT AS P2 ON LAPTOP.MODEL=P2.MODEL
			   GROUP BY LAPTOP.MODEL,LAPTOP.PRICE,P2.MAKER
			   HAVING  P1.maker=P2.maker
			   ORDER BY LAPTOP.PRICE);
--3rd  solution 
SELECT DISTINCT PC.MODEL
FROM PC JOIN PRODUCT P ON PC.model=P.model
GROUP BY PC.MODEL,PC.PRICE,P.MAKER
HAVING PC.PRICE<(SELECT TOP 1 L.PRICE
                  FROM LAPTOP L JOIN PRODUCT P2 ON L.MODEL=P2.MODEL
				  WHERE P.MAKER=P2.MAKER)

--3. Един модел компютри може да се предлага в няколко разновидности с
--различна цена. Да се изведат тези модели компютри, чиято средна цена (на
--различните му разновидности) е по-ниска от най-евтиния лаптоп, произвеждан
--от същия производител.
SELECT DISTINCT PC.MODEL,AVG(PC.PRICE)AS AVGPRICE
FROM PC JOIN PRODUCT  P1 ON PC.MODEL=P1.MODEL
GROUP BY PC.MODEL,P1.MAKER
HAVING AVG(PRICE)<(SELECT TOP 1 PRICE
                   FROM LAPTOP JOIN PRODUCT P2 ON LAPTOP.MODEL=P2.MODEL
				   GROUP BY LAPTOP.MODEL,LAPTOP.PRICE,P2.MAKER
				   HAVING P2.MAKER=P1.MAKER
				   ORDER BY LAPTOP.PRICE );

--4. Напишете заявка, която извежда за всеки компютър код на продукта,
--производител и брой компютри, които имат цена, по-голяма или равна на
--неговата.

SELECT PC1.CODE,P.MAKER,(SELECT  COUNT(PC2.CODE)
                         FROM PC PC2 JOIN PRODUCT P2 ON PC2.MODEL=P2.MODEL
						 WHERE P2.MAKER=P.MAKER AND PC1.MODEL=PC2.MODEL AND  PC2.PRICE>=PC1.PRICE)AS COMP2
FROM PC PC1 JOIN PRODUCT P ON PC1.MODEL=P.MODEL
