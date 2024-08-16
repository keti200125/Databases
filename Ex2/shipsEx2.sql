-- 1.Напишете заявка, която извежда името на корабите, по-тежки (displacement) от 35000
SELECT s.NAME
FROM SHIPS s
    JOIN CLASSES c ON s.CLASS = c.CLASS
WHERE c.DISPLACEMENT > 35000


-- 2.Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на всички кораби, 
--   участвали в битката при 'Guadalcanal'
SELECT DISTINCT s.NAME, c.DISPLACEMENT, c.NUMGUNS
FROM SHIPS s
   JOIN CLASSES c ON s.CLASS = c.CLASS
   JOIN OUTCOMES o ON o.SHIP = s.NAME
WHERE o.BATTLE = 'Guadalcanal'


-- 3.Напишете заявка, която извежда имената на тези държави, които имат класове кораби от
--   тип 'bb' и 'bc' едновременно
-- a)
SELECT c.COUNTRY
FROM CLASSES c
WHERE c.TYPE = 'bb'
INTERSECT
SELECT c.COUNTRY
FROM CLASSES c
WHERE c.TYPE = 'bc'
-- b)
SELECT DISTINCT c1.COUNTRY
FROM CLASSES c1 
    JOIN CLASSES c2 ON c1.COUNTRY = c2.COUNTRY
WHERE c1.TYPE = 'bb' and c2.TYPE = 'bc'


-- 4.Напишете заявка, която извежда имената на тези кораби, които са били повредени в една битка,
--   но по-късно са участвали в друга битка
SELECT DISTINCT o1.SHIP 
FROM OUTCOMES o1 
  JOIN BATTLES b1 ON b1.NAME = o1.BATTLE
  JOIN OUTCOMES o2 ON o2.SHIP = o1.SHIP
  JOIN BATTLES b2 ON b2.NAME = o2.BATTLE 
WHERE o1.RESULT = 'damaged' AND b2.DATE > b1.DATE
