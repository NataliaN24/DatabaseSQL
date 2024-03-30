
--1. Напишете заявка, която извежда производителя и честотата на лаптопите с размер на диска поне 9 GB.

SELECT DISTINCT product.maker,laptop.speed
FROM   product JOIN laptop ON product.model=laptop.model
WHERE laptop.hd>=9
--2. Напишете заявка, която извежда модел и цена на продуктите, произведени от производител с име B.
SELECT  product.model ,printer.price
FROM product JOIN printer ON product.model=printer.model
WHERE product.maker='B'
UNION 
SELECT product.model,pc.price
FROM product JOIN pc ON product.model=pc.model
WHERE product.maker='B'
UNION
SELECT product.model,laptop.price
FROM product JOIN laptop ON product.model=laptop.model
WHERE product.maker='B'

--3. Напишете заявка, която извежда производителите, които произвеждат лаптопи, но не произвеждат персонални компютри.

SELECT product.maker
FROM PRODUCT 
WHERE product.type='laptop'
EXCEPT 
SELECT PRODUCT.maker
FROM PRODUCT
WHERE product.type='PC'
--4. Напишете заявка, която извежда размерите на тези дискове, които се предлагат в поне два различни персонални компютъра (два компютъра с различен код).

SELECT  DISTINCT PC.hd
FROM PC  JOIN PC AS PC1 ON PC.hd=PC1.hd AND PC.code<>PC1.code

--5. Напишете заявка, която извежда двойките модели на персонални компютри, които имат еднаква честота и памет. Двойките 
--трябва да се показват само по веднъж, например само (i, j), но не и (j, i).

SELECT DISTINCT PC.model AS MODEL ,PC1.model AS MODEL
FROM PC JOIN PC AS PC1 ON  PC.model<PC1.model AND PC.speed=PC1.speed  AND PC.ram=PC1.ram
--6. Напишете заявка, която извежда производителите на поне два различни персонални компютъра с честота поне 400.SELECT  DISTINCT PRODUCT.makerFROM product JOIN PC ON PRODUCT.model=PC.model              JOIN PC AS PC1 ON PRODUCT.model=PC1.model AND PC.code<>PC1.code WHERE PC.speed>=400 AND PC1.speed>=400;SELECT DISTINCT P.maker
FROM product AS P
JOIN PC AS PC1 ON P.model = PC1.model
JOIN PC AS PC2 ON P.model = PC2.model
WHERE PC1.speed >= 400 AND PC2.speed >= 400 AND PC1.code <> PC2.code;
