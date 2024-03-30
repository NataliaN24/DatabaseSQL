
--1. Напишете заявка, която извежда модел, честота и размер на диска за всички персонални компютри с цена под 1200 долара. Задайте псевдоними за атрибутите честота и 
--размер на диска, съответно MHz и GB

SELECT *
FROM PC 
SELECT MODEL,SPEED AS MHz,CD  as  GB
FROM PC
WHERE PRICE<1200

--2. Напишете заявка, която извежда производителите на принтери без повторения
SELECT*
FROM product
SELECT DISTINCT  maker
FROM  PRODUCT
WHERE TYPE='PRINTER'
--3. Напишете заявка, която извежда модел, размер на паметта, размер на екран за лаптопите, чиято цена е над 1000 долара
SELECT*
FROM laptop
--..
SELECT MODEL,RAM,screen
FROM LAPTOP
WHERE PRICE>1000
--4. Напишете заявка, която извежда всички цветни принтери

SELECT*
FROM PRINTER
SELECT CODE
FROM printer
WHERE COLOR!='n'
--5. Напишете заявка, която извежда модел, честота и размер на диска за тези персонални компютри със CD 12x или 16x и цена под 2000 долара.
SELECT model,speed,cd
FROM PC
WHERE CD='12x' OR CD='16x' AND price<2000

