-- 1.Напишете заявка, която извежда страните, чиито кораби са с най-голям брой оръжия.
SELECT DISTINCT COUNTRY
FROM CLASSES
WHERE NUMGUNS >= ALL (SELECT NUMGUNS
                      FROM CLASSES)

-- 2.Напишете заявка, която извежда класовете, за които поне един от корабите им е потънал в битка.
SELECT DISTINCT CLASS
FROM SHIPS 
WHERE NAME IN (SELECT SHIP
               FROM OUTCOMES
			   WHERE RESULT = 'sunk')

-- 3.Напишете заявка, която извежда имената на корабите с 16 инчови оръдия (bore).
SELECT NAME
FROM SHIPS
WHERE CLASS IN (SELECT CLASS
                FROM CLASSES
				WHERE BORE ='16')

-- 4.Напишете заявка, която извежда имената на битките, в които са участвали кораби от клас ‘Kongo’.
SELECT DISTINCT BATTLE
FROM OUTCOMES
WHERE SHIP IN (SELECT NAME 
               FROM SHIPS
			   WHERE CLASS = 'Kongo')

-- 5.Напишете заявка, която извежда иманата на корабите, чиито брой оръдия е найголям в сравнение
--   с корабите със същия калибър оръдия (bore). 
-- a)
SELECT NAME
FROM SHIPS s
  JOIN CLASSES c ON s.CLASS = c.CLASS
WHERE c.NUMGUNS >= ALL (SELECT c2.NUMGUNS
                        FROM CLASSES c2
						WHERE c.BORE = c2.BORE)
-- b)
SELECT NAME
FROM SHIPS  
WHERE CLASS IN (SELECT CLASS
				FROM CLASSES c1
				WHERE c1.NUMGUNS >= ALL (SELECT NUMGUNS FROM CLASSES c2 WHERE c1.BORE = c2.BORE))