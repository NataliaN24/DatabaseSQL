--1. Напишете заявка, която извежда производителите на персонални компютри с честота над 500.

SELECT  MAKER
FROM PRODUCT
WHERE MODEL IN(SELECT  MODEL
FROM PC
WHERE SPEED>500);
--2. Напишете заявка, която извежда код, модел и цена на принтерите с найвисока цена.

SELECT CODE,MODEL,PRICE
FROM PRINTER 
WHERE PRICE >=ALL(SELECT P.PRICE
FROM PRINTER P
);
--3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от честотата на всички персонални компютри.
SELECT *
FROM LAPTOP
WHERE SPEED<ALL(SELECT speed
      FROM PC
	  );
--4. Напишете заявка, която извежда модела и цената на продукта (PC,лаптоп или принтер) с най-висока цена.
SELECT*
FROM PRODUCT
SELECT *
FROM PC 
SELECT*
FROM PRINTER

SELECT  P.model ,PR.price ,L.price , PRI.price
FROM PRODUCT P JOIN PC PR ON  P.model=PR.model JOIN laptop L ON P.model=L.model JOIN PRINTER PRI ON P.model=PRI.model
WHERE  PR.price>= ALL(SELECT TOP 1 price
FROM  laptop 
) AND PR.price>= ALL (SELECT TOP 1PRICE
FROM PRINTER) 
OR L.price>ALL(SELECT  TOP 1price
FROM  PC 
) AND PR.price>ALL (SELECT TOP 1 PRICE
FROM PRINTER) 
OR PRI .price>ALL (SELECT TOP 1 price
FROM  PC 
) AND PRI.price>ALL (SELECT TOP 1 PRICE
FROM LAPTOP) ;


--5. Напишете заявка, която извежда производителя на цветния принтер с най-ниска цена.
SELECT  maker
FROM PRODUCT P JOIN PRINTER PR ON P.model=PR.model
WHERE  PR.price< =ALL (SELECT price
FROM PRINTER 
WHERE color='y')
AND color='y';


--6. Напишете заявка, която извежда производителите на тези персонални компютри с най-малко RAM памет, които имат най-бързи процесори.

SELECT MAKER
FROM PRODUCT PR  JOIN PC COM ON  PR.model=COM.model
WHERE COM.ram<=ALL(SELECT  P.RAM
FROM PC P )
AND  COM.speed>=ALL(SELECT TOP 1 speed
FROM PC
);
