-- 1.Напишете заявка, която извежда производител, модел и тип на продукт за тези производители,
--   за които съответния продукт не се продава (няма го в таблиците PC, лаптоп или принтер).
-- a)
SELECT a.maker, a.model, a.type
FROM product a
 LEFT JOIN (SELECT model FROM printer
            UNION 
			SELECT model FROM pc
			UNION 
			SELECT model FROM laptop) u ON u.model = a.model
WHERE u.model IS NULL
-- b)
SELECT maker, model, type
FROM product
WHERE model NOT IN (SELECT model FROM pc)
    AND model NOT IN (SELECT model FROM laptop)
    AND model NOT IN (SELECT model FROM printer)
