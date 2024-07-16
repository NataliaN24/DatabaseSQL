--1.Създайте изглед, който извежда име на авиокомпания оператор на полета, номер на полет
--и брой пътници, потвърдили резервация за този полет. Тествайте изгледa.
CREATE VIEW INFO
AS
SELECT F.AIRLINE_OPERATOR,F.FNUMBER,COUNT(B.CUSTOMER_ID) AS NUMBER
FROM FLIGHTS F JOIN BOOKINGS B ON F.FNUMBER=B.FLIGHT_NUMBER 
GROUP BY F.AIRLINE_OPERATOR,F.FNUMBER;

SELECT* FROM INFO 

--2. Създайте изглед, който за всяка агенция извежда името на клиента с най-много
--резервации. Тествайте изгледa.
CREATE VIEW  AGENCY_INFO_CLIENT
AS
SELECT  C.FNAME,C.LNAME,C.ID
FROM CUSTOMER C 
WHERE C.ID IN (SELECT  B.CUSTOMER_ID
FROM BOOKINGS B 
GROUP BY B.AGENCY,B.CUSTOMER_ID
HAVING COUNT(B.CUSTOMER_ID)>=(SELECT TOP 1 COUNT(CUSTOMER_ID)
                              FROM BOOKINGS WHERE BOOKINGS.AGENCY=B.AGENCY
							  GROUP BY BOOKINGS.AGENCY,CUSTOMER_ID
							  ORDER BY COUNT(CUSTOMER_ID)DESC));*/
 SELECT*
FROM AGENCY_INFO_CLIENT
							  
--3. Създайте изглед за таблицата Agencies, който извежда всички данни за агенциите от град
--София. Дефинирайте изгледa с CHECK OPTION. Тествайте изгледa.
CREATE VIEW SOFIA
AS
SELECT *
FROM AGENCIES A
WHERE A.CITY='Sofia'
WITH CHECK OPTION

SELECT*
FROM SOFIA

--4. Създайте изглед за таблицата Agencies, който извежда всички данни за агенциите, такива
--че телефонните номера на тези агенции да имат стойност NULL. Дефинирайте изгледa с
--CHECK OPTION. Тествайте изгледa.
CREATE VIEW FORNULL
AS
SELECT *
FROM AGENCIES
WHERE PHONE IS NULL
WITH CHECK OPTION;

SELECT*
FROM FORNULL

--Изтрийте създадените изгледи.
DROP VIEW INFO;
DROP VIEW AGENCY_INFO_CLIENT;
DROP VIEW SOFIA;
DROP VIEW FORNULL;

--Създайте подходящ/и индекс/и върху таблицата Product от базата от данни PC.
CREATE INDEX indexpc ON PRODUCT(MAKER);

--10. Изтрийте създадените индекси.
DROP INDEX IF EXISTS indexpc ON PRODUCT ;
