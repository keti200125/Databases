

-- 1.Напишете заявка, която извежда имената на актьорите мъже, участвали в 'Terms of Endearment'
-- a)
-- ползваме идентификатор на таблица, само когато две или повече таблици имат колона с еднакво име
SELECT DISTINCT NAME
FROM MOVIESTAR
     JOIN STARSIN ON NAME = STARNAME
WHERE GENDER = 'M' AND MOVIETITLE = 'Terms of Endearment'
-- b)
-- intersect намира общите данни в колоната от две sql заявки
SELECT STARNAME
FROM STARSIN
WHERE MOVIETITLE = 'Terms of Endearment'
INTERSECT                      
SELECT NAME FROM MOVIESTAR
WHERE GENDER = 'M';
-- c)
SELECT MOVIESTAR.NAME
FROM MOVIESTAR
     JOIN STARSIN ON MOVIESTAR.NAME = STARSIN.STARNAME
WHERE STARSIN.MOVIETITLE = 'Terms of Endearment' and MOVIESTAR.GENDER = 'M';

-- 2.Напишете заявка, която извежда имената на актьорите, участвали във филми, продуцирани от ‘MGM’ през 1995 г.
SELECT DISTINCT st.STARNAME
FROM STARSIN st
    JOIN MOVIE m ON m.TITLE = st.MOVIETITLE AND m.YEAR = st.MOVIEYEAR
WHERE m.STUDIONAME = 'MGM' AND m.YEAR=1995

-- 3.Напишете заявка, която извежда името на президента на ‘MGM’
SELECT me.NAME
FROM STUDIO s
	JOIN MOVIEEXEC me ON s.PRESC# = me.CERT#
WHERE s.NAME = 'MGM'


-- 4. Напишете заявка, която извежда имената на всички филми с дължина, по-голяма от дължината на филма ‘Star Wars’
-- (В таблицата MOVIE, може да има различни филми с едно и също име, ако са правени 
-- в различни години). Предвид, че в условието се говори за единствен филм - смятаме,
-- че става въпрос за този, който е сниман през 1977 и го указваме в заявката.
SELECT m1.TITLE
FROM MOVIE m1
   JOIN MOVIE m2 ON m2.TITLE = 'Star Wars' AND m2.YEAR = 1977
WHERE m1.LENGTH > m2.LENGTH