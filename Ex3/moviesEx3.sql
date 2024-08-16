-- 1.Напишете заявка, която извежда имената на актрисите, които са също и продуценти с нетна стойност по-голяма от 10 милиона.
SELECT NAME 
FROM MOVIESTAR
WHERE GENDER ='F' AND NAME IN ( SELECT NAME FROM MOVIEEXEC WHERE NETWORTH > 10000000)

-- 2.Напишете заявка, която извежда имената на тези актьори (мъже и жени), които не са продуценти.
SELECT NAME 
FROM MOVIESTAR
WHERE NAME NOT IN (SELECT NAME FROM MOVIEEXEC)

-- 3.Напишете заявка, която извежда имената на всички филми с дължина по-голяма от дължината на филма ‘Gone With the Wind’
-- TITLE не е достатъчно за уникално идентифициране на филм в таблицата MOVIE.
-- Необходима е двойка стойности (име на филм, година).
-- a): филмите с дължина по-голяма от дължината на 'Gone With The Wind',
-- правен през 1938
SELECT TITLE
FROM MOVIE
WHERE LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Gone With the Wind' AND YEAR = 1938)
-- b): филмите с дължина по-голяма от дължината всички филми със заглавие 
-- 'Gone With The Wind'
SELECT TITLE
FROM MOVIE
WHERE LENGTH > ALL (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Gone With the Wind')

-- 4.Напишете заявка, която извежда имената на продуцентите и имената на продукциите за които стойността 
-- им е по-голяма от продукциите на продуценти ‘Mery Griffin’ 
--      В базата MOVIES няма стойност на продукции и затова интерпретираме това 
--      условие като:
--      Имената на продуцентите и продукциите, правени от продуценти с NETWORTH
--      по-голям от NETWORTH-a на 'Merv Griffin'
SELECT me.NAME, m.TITLE
FROM MOVIE m
   JOIN MOVIEEXEC me ON m.PRODUCERC# = me.CERT#
WHERE me.NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC
                     WHERE NAME = 'Merv Griffin')

