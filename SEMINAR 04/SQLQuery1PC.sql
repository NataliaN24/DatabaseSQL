--1. Напишете заявка, която извежда производител, модел и тип на продукт 
--за тези производители, за които съответният продукт не се продава 
--(няма го в таблиците PC, Laptop или Printer)

SELECT PRODUCT.model,PRODUCT.maker,PRODUCT.type
FROM PRODUCT
WHERE PRODUCT.model  NOT IN(SELECT PC.model
                             FROM PC)
	INTERSECT
               (SELECT PRODUCT.model,PRODUCT.maker,PRODUCT.type
                FROM PRODUCT
                WHERE PRODUCT.model  NOT IN (SELECT PRINTER.model
                       FROM PRINTER))
    INTERSECT
		      (SELECT  PRODUCT.model,PRODUCT.maker,PRODUCT.type
		       FROM PRODUCT
			    WHERE PRODUCT.model  NOT IN (SELECT LAPTOP.model
                       FROM LAPTOP));

--2. Намерете всички производители, които правят както лаптопи, така и 
--принтери.
SELECT MAKER
FROM PRODUCT JOIN LAPTOP ON PRODUCT.model=LAPTOP.model
INTERSECT (
SELECT MAKER
FROM PRODUCT JOIN PRINTER ON PRODUCT.model=PRINTER.model);

--3. Намерете размерите на тези твърди дискове, които се появяват в два 
--или повече модела лаптопи.

SELECT  DISTINCT LAPTOP.hd
FROM LAPTOP   CROSS  JOIN LAPTOP L 
WHERE LAPTOP.hd=L.hd  AND LAPTOP.model!= L.model
--4. Намерете всички модели персонални компютри, които нямат регистриран 
--производител.
	
SELECT MODEL
FROM PC
WHERE PC.model NOT IN(SELECT model
FROM PRODUCT
);

SELECT  PRODUCT.MODEL
FROM PRODUCT LEFT JOIN PC ON PRODUCT.model=PC.model
WHERE  PRODUCT.maker IS NULL
