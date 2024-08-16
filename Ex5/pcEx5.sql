
-- 1.Напишете заявка, която извежда средната честота на компютрите
SELECT AVG(speed) AS avg_speed
FROM pc

-- 2. Напишете заявка, която извежда средния размер на екраните на лаптопите за всеки производител
SELECT maker, AVG(screen)
FROM laptop l
   JOIN product p ON p.model = l.model
GROUP BY maker

-- 3. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000
SELECT AVG(speed) as avg_speed_over_1000
FROM laptop
WHERE price > 1000

-- 4.Напишете заявка, която извежда средната цена на компютрите произведени от производител ‘A’
SELECT AVG(price)
FROM pc pc1
  JOIN product p ON p.model = pc1.model AND maker = 'A'

-- 5. Напишете заявка, която извежда средната цена на компютрите и лаптопите за производител ‘B’
-- a)
SELECT AVG(price)
FROM (SELECT price,model FROM pc
      UNION ALL
	  SELECT price, model FROM laptop) a
	JOIN product p ON p.model = a.model
WHERE maker = 'B'
-- b)
SELECT AVG(price) AveragePrice
FROM (SELECT price
      FROM product p 
          JOIN pc ON p.model = pc.model
      WHERE maker = 'B'
      UNION ALL
      SELECT price
      FROM product p 
          JOIN laptop ON p.model = laptop.model
      WHERE maker = 'B') u

-- 6. Напишете заявка, която извежда средната цена на компютрите според различните им честоти
SELECT speed, AVG(price) AS avg_price
FROM pc
GROUP BY speed

-- 7. Напишете заявка, която извежда производителите, които са произвели поне по 3 различни модела компютъра
-- a)
SELECT maker
FROM product 
WHERE type = 'pc'
GROUP BY maker
HAVING COUNT(model) >= 3  
-- b)
SELECT maker
FROM product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(*) >= 3

-- 8. Напишете заявка, която извежда производителите на компютрите с най-висока цена
SELECT DISTINCT maker 
FROM product p
  JOIN pc pc1 ON pc1.model = p.model
WHERE price = (SELECT MAX(price) FROM pc)

-- 9.Напишете заявка, която извежда средната цена на компютрите за всяка честота по-голяма от 800
SELECT speed, AVG(price) AveragePrice
FROM pc
WHERE speed > 800
GROUP BY speed

-- 10.Напишете заявка, която извежда средния размер на диска на тези компютри произведени от 
--    производители, които произвеждат и принтери
SELECT AVG(hd) AS avg_hd
FROM pc pc1
  JOIN product p ON pc1.model = p.model
WHERE maker IN (SELECT maker FROM product
                WHERE type = 'Printer')

-- 11.Напишете заявка, която за всеки размер на лаптоп намира разликата в цената 
--    на най-скъпия и най-евтиния лаптоп със същия размер
SELECT screen, MAX(price) - MIN(price) AS diff_in_price
FROM laptop
GROUP BY screen
