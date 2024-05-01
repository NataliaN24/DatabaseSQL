--а) Нека създадем мини вариант на Facebook. Искаме да имаме следните
--релации (може да предложите и друг вариант):
-- Users: уникален номер (id), email, парола, дата на регистрация.
-- Friends: двойки от номера на потребители, напр. ако 12 е приятел на 21, 25 и
--40, ще има кортежи (12,21), (12,25), (12,40).
-- Walls: номер на потребител, номер на потребител написал съобщението,
--текст на съобщението, дата.
-- Groups: уникален номер, име, описание (по подразбиране - празен низ).
-- GroupMembers: двойки от вида номер на група - номер на потребител.
CREATE DATABASE FACEBOOK

CREATE TABLE USERS
(
ID INT PRIMARY KEY ,EMAIL VARCHAR (30),PASSWORD VARCHAR(30),REGISTRATION_DATE DATE);
CREATE TABLE FRIENDS(
USER1ID INT,
USER2ID INT,
FOREIGN KEY (USER1ID)REFERENCES USERS(ID),
FOREIGN KEY (USER2ID)REFERENCES USERS(ID),
PRIMARY KEY(USER1ID,USER2ID)
);

CREATE TABLE  WALLS
(
USERID INT,
AUTHORID INT,
MESSAGE  VARCHAR(150),
DATE_POSTED DATETIME,
FOREIGN KEY (USERID)REFERENCES USERS(ID),
FOREIGN KEY (AUTHORID)REFERENCES USERS(ID)
);

CREATE TABLE GROUPS
(
GROUPID INT PRIMARY KEY,
NAME VARCHAR(50),
DESCRIPTION VARCHAR(150) DEFAULT ' ');

CREATE TABLE GROUPMEMBERS
(
GROUP_ID INT,
USERID INT,
FOREIGN KEY (GROUP_ID)REFERENCES GROUPS(GROUPID),
FOREIGN KEY (USERID)REFERENCES USERS(ID),
PRIMARY KEY (GROUP_ID,USERID)
);

--б) Добавете кортежи с примерни данни към новосъздадените релации.

INSERT INTO USERS (ID, EMAIL, PASSWORD, REGISTRATION_DATE)
VALUES 
    (1, 'john@example.com', 'password123', '2024-04-30'),
    (2, 'jane@example.com', 'pass123', '2024-04-28'),
    (3, 'alice@example.com', 'abc123', '2024-04-25');

INSERT INTO FRIENDS (USER1ID, USER2ID)
VALUES 
    (1, 2), -- John is friend with Jane
    (1, 3); -- John is friend with Alice


INSERT INTO WALLS (USERID, AUTHORID, MESSAGE, DATE_POSTED)
VALUES 
    (1, 2, 'Hi John, nice to meet you!', '2024-04-30 09:00:00'),
    (2, 1, 'Hi Jane, good to see you too!', '2024-04-30 10:00:00'),
    (1, 3, 'Hey Alice, how are you?', '2024-04-30 11:00:00');


INSERT INTO GROUPS (GROUPID, NAME, DESCRIPTION)
VALUES 
    (1, 'SQL Enthusiasts', 'A group for SQL lovers'),
    (2, 'Book Club', 'Discussing favorite books');

INSERT INTO GROUPMEMBERS (GROUP_ID, USERID)
VALUES 
    (1, 1), -- John is a member of SQL Enthusiasts
    (1, 2), -- Jane is a member of SQL Enthusiasts
    (2, 2), -- Jane is also a member of Book Club
    (2, 3); -- Alice joins the Book Club too
