--1. Напишете заявка, която извежда производителите на персонални
--компютри с честота над 500.
SELECT DISTINCT MAKER
FROM product  PR JOIN PC  P ON PR.MODEL=P.model 
WHERE P.speed>500;
--2. Напишете заявка, която извежда код, модел и цена на принтерите с найвисока цена.
SELECT P.code,P.MODEL,P.PRICE
FROM PRINTER P
WHERE P.PRICE>=ALL(SELECT  PRICE
FROM PRINTER
);

--3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
--честотата на всички персонални компютри.
SELECT *
FROM LAPTOP LAP
WHERE LAP.SPEED<ALL(SELECT  P.SPEED
FROM PC P
);
--4. Напишете заявка, която извежда модела и цената на продукта (PC,
--лаптоп или принтер) с най-висока цена.
SELECT PR.model,DEVICE.price
FROM PRODUCT AS PR ,((SELECT LAPTOP.model,LAPTOP.price
                    FROM LAPTOP)
					UNION
					(SELECT PC.model,PC.price
					FROM PC)
					UNION
					(SELECT PRINTER.MODEL,PRINTER.PRICE
					FROM PRINTER))AS DEVICE
WHERE PR.model=DEVICE.MODEL
AND DEVICE.price>=ALL((SELECT PRICE 
                     FROM PC)
					 UNION
					 (SELECT PRICE
					 FROM LAPTOP)
					 UNION
					 (SELECT PRICE
					 FROM PRINTER));

--5. Напишете заявка, която извежда производителя на цветния принтер с
--най-ниска цена.
SELECT P.maker
FROM PRODUCT P JOIN PRINTER PR ON P.model=PR.model
WHERE PR.price<=ALL(SELECT  PRICE
FROM PRINTER
WHERE COLOR='y')
AND PR.color='y';

--6. Напишете заявка, която извежда производителите на тези персонални
--компютри с най-малко RAM памет, които имат най-бързи процесори
SELECT  MAKER 
FROM product PR JOIN PC P ON  PR.model=P.model
WHERE P.ram<=ALL(SELECT  RAM
FROM PC)
AND P.speed>=ALL(SELECT TOP 1 speed
FROM PC
);
