﻿--10. Два британски бойни кораба от класа Nelson - Nelson и Rodney - са били пуснати на вода
--едновременно през 1927 г. Имали са девет 16-инчови оръдия (bore) и водоизместимост от 34000
--тона (displacement). Добавете тези факти към базата от данни.
INSERT INTO SHIPS 
VALUES ('Nelson','Nelson',1927),('Rodney','Nelson',1927)
INSERT INTO CLASSES
VALUES ('Nelson','bb','Gt.Britain',9,16,3400)

--11. Изтрийте от таблицата Ships всички кораби, които са потънали в битка.
DELETE FROM SHIPS
WHERE NAME IN (SELECT SHIP
 FROM OUTCOMES 
WHERE RESULT='sunk');

--12. Променете данните в релацията Classes така, че калибърът (bore) да се измерва в сантиметри (в
--момента е в инчове, 1 инч ~ 2.5 см) и водоизместимостта да се измерва в метрични тонове (1 м.т.
--= 1.1 т.)
UPDATE CLASSES
SET BORE=BORE*2.5,DISPLACEMENT=DISPLACEMENT*1.1;
