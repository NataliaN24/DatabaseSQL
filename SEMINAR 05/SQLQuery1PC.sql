--1Напишете заявка, която извежда средната честота на персоналните компютри.
SELECT AVG(SPEED) AS AVG_SPEED
FROM PC
--2. Напишете заявка, която извежда средния размер на екраните на лаптопите за 
--всеки производител.
SELECT AVG(SCREEN) AS AVG_SCREEN,PRODUCT.MAKER   AS MAKER
FROM LAPTOP JOIN PRODUCT ON LAPTOP.MODEL=PRODUCT.model
GROUP BY  PRODUCT.maker;
--3. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.
SELECT AVG(SPEED)
FROM LAPTOP
WHERE PRICE>1000
--4. Напишете заявка, която извежда средната цена на персоналните компютри,
--произведени от производител ‘A’.
SELECT AVG(PRICE)
FROM PC JOIN product ON PC.MODEL=PRODUCT.model
WHERE MAKER='A';
--5. Напишете заявка, която извежда средната цена на персоналните компютри и 
--лаптопите за производител ‘B’
SELECT AVG(PRICE)
FROM  (SELECT  L.MODEL ,L.PRICE
       FROM LAPTOP AS L
	   UNION ALL 
	   SELECT  P.model,P.price
	   FROM  PC AS P)AS T JOIN PRODUCT ON PRODUCT.MODEL=T.MODEL
	   WHERE PRODUCT.maker='B';
--6. Напишете заявка, която извежда средната цена на персоналните компютри
--според различните им честоти.
SELECT AVG(PRICE),SPEED
FROM PC 
GROUP BY SPEED
--7. Напишете заявка, която извежда производителите, които са произвели поне 3 
--различни персонални компютъра (с различен код).
SELECT PRODUCT.MAKER,COUNT(CODE)
FROM PC JOIN PRODUCT ON PC.MODEL=PRODUCT.MODEL
GROUP BY PRODUCT.maker
HAVING COUNT(PC.code)>=3

--8. Напишете заявка, която извежда производителите с най-висока цена на 
--персонален компютър.
SELECT PRODUCT.MAKER
FROM PC JOIN PRODUCT ON PC.MODEL=PRODUCT.MODEL
WHERE PC.PRICE=(SELECT  MAX(PC.PRICE)
                FROM PC);

--9. Напишете заявка, която извежда средната цена на персоналните компютри за
--всяка честота по-голяма от 800.
SELECT AVG(PC.PRICE) AS AVERAGE
FROM PC
WHERE PC.speed>800
--10.Напишете заявка, която извежда средния размер на диска на тези персонални 
--компютри, произведени от производители, които произвеждат и принтери.
--Резултатът да се изведе за всеки отделен производител.
---???????????????????????????????????????????????
SELECT PRODUCT.MAKER, AVG(PC.HD)
FROM PC JOIN PRODUCT ON PC.MODEL = PRODUCT.MODEL
WHERE MAKER IN (SELECT DISTINCT MAKER
                FROM PRODUCT JOIN PC
                                  ON PRODUCT.MODEL = PC.MODEL

                INTERSECT

                SELECT DISTINCT MAKER
                FROM PRODUCT JOIN PRINTER
                                  ON PRODUCT.MODEL = PRINTER.MODEL)
GROUP BY PRODUCT.MAKER