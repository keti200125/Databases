-- 1.Напишете заявка, която за всеки кораб извежда името му, държавата, броя оръдия и годината на пускане (launched).
SELECT NAME, COUNTRY, NUMGUNS, LAUNCHED
FROM SHIPS s
  LEFT JOIN CLASSES c ON s.CLASS = c.CLASS

-- 2.Напишете заявка, която извежда имената на корабите, участвали в битка от 1942г.
SELECT DISTINCT SHIP 
FROM OUTCOMES
 JOIN BATTLES ON NAME = BATTLE
 WHERE YEAR(DATE) = 1942

-- 3.За всяка страна изведете имената на корабите, които никога не са участвали в битка.
SELECT COUNTRY, NAME
FROM CLASSES c 
   JOIN SHIPS s ON c.CLASS = s.CLASS
   LEFT JOIN OUTCOMES ON NAME = SHIP
WHERE BATTLE IS NULL

-- 4.Допълнителна задача
-- Имената на класовете, за които няма кораб, пуснат на вода
-- (launched) след 1921 г. Ако за класа няма пуснат никакъв кораб,
-- той също трябва да излезе в резултата.
-- a)
SELECT DISTINCT CLASS
FROM SHIPS 
WHERE CLASS NOT IN (SELECT CLASS 
                    FROM SHIPS 
					WHERE LAUNCHED >1921) 
-- b)
