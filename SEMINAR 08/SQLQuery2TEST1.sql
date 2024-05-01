CREATE DATABASE TEST
/*а) Дефинирайте следните релации:
Product (maker, model, type), където:
 модел е низ от точно 4 символа,
 производител е низ от точно 1 символ,
 тип е низ до 7 символа;
Printer (code, model, price), където:
 код е цяло число,
 модел е низ от точно 4 символа,
 цена с точност до два знака след десетичната запетая;*/

CREATE TABLE PRODUCT
(MAKER CHAR(1),
MODEL CHAR(4),
TYPE  CHAR (7));
CREATE TABLE PRINTER(
CODE  INT,
MODEL CHAR(4),
PRICE DECIMAL (10,2));
--б) Добавете кортежи с примерни данни към новосъздадените релации.
--в) Добавете към релацията Printer атрибути:
-- type - низ до 6 символа (забележка: type може да приема
--стойност 'laser', 'matrix' или 'jet'),
-- color - низ от точно 1 символ, стойност по подразбиране 'n'
--(забележка: color може да приема стойност 'y' или 'n').

ALTER TABLE PRINTER 
ADD TYPE CHAR(6) CHECK (TYPE IN ('laser','matrix','jet')),
                        COLOR CHAR(1) DEFAULT 'n' CHECK (COLOR IN ('y','n'));*/

--г) Напишете заявка, която премахва атрибута price от релацията Printer.
ALTER  TABLE PRINTER
DROP COLUMN PRICE

--д) Изтрийте релациите, които сте създали в Задача 1.

DROP TABLE PRODUCT
DROP TABLE PRINTER
DROP DATABASE TEST


