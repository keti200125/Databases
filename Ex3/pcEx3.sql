-- 1.Напишете заявка, която извежда производителите на персонални компютри с честота поне 500.
-- a)
SELECT DISTINCT p.maker
FROM product p
   JOIN pc pc1 ON pc1.model = p.model
WHERE pc1.speed >= 500
-- b)
SELECT DISTINCT maker
FROM product
WHERE model IN (SELECT model FROM pc WHERE speed >= 500)

-- 2.Напишете заявка, която извежда принтерите с най-висока цена.
SELECT * 
FROM printer
WHERE price >= ALL (SELECT price FROM printer)

-- 3.Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от честотата на който и да е персонален компютър.
SELECT *
FROM laptop 
WHERE speed < ANY (SELECT speed FROM pc)
-- по-ниска от тази на всички pc-та:
SELECT *
FROM laptop
WHERE speed < ALL (SELECT speed FROM pc)

-- 4.Напишете заявка, която извежда модела на продукта (PC, лап топ или принтер) с най-висока цена.
SELECT DISTINCT u.model
FROM (SELECT model, price FROM pc
      UNION 
	  SELECT model,price FROM laptop
	  UNION 
	  SELECT model, price FROM printer) u 
WHERE price >= ALL (SELECT price FROM pc
                    UNION
                    SELECT price FROM laptop
                    UNION
                    SELECT price FROM printer)

-- 5.Напишете заявка, която извежда производителя на цветния принтер с най-ниска цена.
-- a)
SELECT DISTINCT maker
FROM product
WHERE model IN (SELECT model FROM printer
                WHERE color ='y'
				AND price <= ALL  (SELECT price FROM printer WHERE color = 'y'))
-- b) 
SELECT DISTINCT maker
FROM product p 
	JOIN (SELECT model
          FROM printer
          WHERE color = 'y' 
		     AND price <= ALL (SELECT price FROM printer WHERE color = 'y')
			 ) cm ON p.model = cm.model

-- 6.Напишете заявка, която извежда производителите на тези персонални компютри с най-малко RAM памет, които имат най-бързи процесори. 
SELECT DISTINCT maker
FROM product
WHERE model IN 
	(SELECT model
     FROM pc p1
     WHERE ram <= ALL (SELECT ram FROM pc)
           AND speed >= ALL (SELECT speed FROM pc p2 WHERE p1.ram = p2.ram))