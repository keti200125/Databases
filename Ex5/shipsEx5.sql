-- 1.Напишете заявка, която извежда броя на класовете кораби
SELECT COUNT(*) AS ClassCount
FROM CLASSES

-- 2.Напишете заявка, която извежда средния брой на оръжия за всички кораби, пуснати на вода
SELECT AVG(NUMGUNS) AS AVG_NUMGUNS
FROM CLASSES c
    JOIN SHIPS s ON c.CLASS = s.CLASS
  
-- 3.Напишете заявка, която извежда за всеки клас първата и последната година,
--   в която кораб от съответния клас е пуснат на вода
SELECT CLASS, MIN(LAUNCHED) AS FIRST_YEAR, MAX(LAUNCHED) AS LAST_YEAR
FROM SHIPS
GROUP BY CLASS

-- 4.Напишете заявка, която извежда броя на корабите потънали в битка според класа
-- a)
SELECT CLASS, COUNT(RESULT) AS SUNK_SHIPS
FROM SHIPS 
   JOIN OUTCOMES ON SHIP = NAME
WHERE RESULT = 'sunk'
GROUP BY CLASS
-- b)
SELECT s.CLASS, COUNT(*) AS SUNK_SHIPS
FROM SHIPS s
   JOIN OUTCOMES o ON s.NAME = o.SHIP
WHERE o.RESULT = 'sunk'
GROUP BY s.CLASS

-- 5.Напишете заявка, която извежда броя на корабите потънали в битка според класа, 
--   за тези класове с повече от 4 пуснати на вода кораба
-- a)
SELECT s.CLASS, COUNT(s.NAME) ShipCount
FROM SHIPS s
    JOIN OUTCOMES o ON s.NAME = o.SHIP
WHERE o.RESULT = 'sunk' AND s.CLASS IN (SELECT CLASS
                                        FROM SHIPS
                                        GROUP BY CLASS
                                        HAVING COUNT(*) > 4)
GROUP BY s.CLASS
-- b)
SELECT s.CLASS, SUM(CASE o.RESULT
                       WHEN 'sunk' THEN 1
                       ELSE 0
                    END) ShipCount
FROM SHIPS s
    LEFT OUTER JOIN OUTCOMES o ON s.NAME = o.SHIP
GROUP BY s.CLASS
HAVING COUNT(DISTINCT s.NAME) > 4


-- 6.Напишете заявка, която извежда средното тегло на корабите, за всяка страна
SELECT COUNTRY, AVG(DISPLACEMENT) AVG_WEIGHT
FROM CLASSES
GROUP BY COUNTRY
