
-- 1.Напишете заявка, която извежда адресът на студио ‘MGM’ --
SELECT NAME, ADDRESS
FROM STUDIO
WHERE NAME = 'MGM'


-- 2.Напишете заявка, която извежда рождената дата на актрисата Sandra Bullock --
SELECT NAME, BIRTHDATE
FROM MOVIESTAR
WHERE NAME = 'Sandra Bullock'


-- 3.Нaпишете заявка, която извежда имената на всички актьори, които са участвали във филм през 1980, в заглавието на които има думата ‘Empire’ --
SELECT STARNAME
FROM STARSIN
WHERE MOVIETITLE LIKE '%Empire%' AND MOVIEYEAR = 1980


-- 4.Напишете заявка, която извежда имената всички изпълнители на филми с нетна стойност над 10 000 000 долара --
SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > 10000000


-- 5.Напишете заявка, която извежда имената на всички актьори, които са мъже или живеят в Malibu --
SELECT NAME 
FROM MOVIESTAR
WHERE GENDER = 'M' OR ADDRESS LIKE '%Malibu%'