-- 1.Напишете заявка, която за всеки филм, по-дълъг от 120 минути, извежда заглавие, година, име и адрес на студио.
SELECT TITLE,YEAR, STUDIONAME, ADDRESS
FROM MOVIE
  LEFT JOIN STUDIO ON NAME = STUDIONAME
WHERE LENGTH > 120

-- 2.Напишете заявка, която извежда името на студиото и имената на актьорите, участвали във филми, произведени 
-- от това студио, подредени по име на студио.
SELECT STUDIONAME, STARNAME
FROM MOVIE
   JOIN STARSIN ON TITLE = MOVIETITLE AND YEAR = MOVIEYEAR
 ORDER BY STUDIONAME

-- 3.Напишете заявка, която извежда имената на продуцентите на филмите, в които е играл Harrison Ford.
SELECT DISTINCT NAME
FROM MOVIEEXEC
  JOIN MOVIE ON CERT# = PRODUCERC#
  JOIN STARSIN ON MOVIETITLE = TITLE AND MOVIEYEAR = YEAR
WHERE STARNAME = 'Harrison Ford'

-- 4.Напишете заявка, която извежда имената на актрисите, играли във филми на MGM.
SELECT DISTINCT STARNAME
FROM STARSIN
 JOIN MOVIESTAR ON NAME = STARNAME
 JOIN MOVIE ON TITLE = MOVIETITLE AND  YEAR = MOVIEYEAR
WHERE GENDER ='F' AND STUDIONAME = 'MGM'

-- 5.Напишете заявка, която извежда името на продуцента и имената на филмите, продуцирани от продуцента на ‘Star Wars’
-- a)
SELECT TITLE, NAME
FROM MOVIE
  JOIN MOVIEEXEC ON CERT# = PRODUCERC#
WHERE PRODUCERC# = (SELECT PRODUCERC#
                    FROM MOVIE 
					WHERE TITLE = 'Star Wars' AND YEAR = 1977)
-- b)
SELECT e.NAME, m.TITLE
FROM MOVIE m
    JOIN MOVIEEXEC e ON e.CERT# = m.PRODUCERC#
    JOIN MOVIE m2 ON m2.TITLE = 'Star Wars' AND m2.YEAR = 1977
WHERE m.PRODUCERC# = m2.PRODUCERC#

-- 6.Напишете заявка, която извежда имената на актьорите не участвали в нито един филм
SELECT NAME
FROM MOVIESTAR
 LEFT JOIN  STARSIN ON STARNAME = NAME
WHERE STARNAME IS NULL
