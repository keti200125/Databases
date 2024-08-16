-- 1.Напишете заявка, която извежда производителя и честотата на процесора на тези лаптопи с размер на диска поне 9 GB
SELECT l.speed, p.maker
FROM laptop l
    JOIN product p ON p.model = l.model
WHERE l.hd >= 9


-- 2.Напишете заявка, която извежда номер на модел и цена на всички продукти, произведени от производител с име ‘B’. Сортирайте резултата така, че първо да се изведат най-скъпите продукти
-- a)
SELECT u.model, u.price
FROM product p
    JOIN (SELECT model, price FROM pc
          UNION
          SELECT model, price FROM laptop
          UNION
          SELECT model, price FROM printer) u ON p.model = u.model
WHERE p.maker = 'B'
ORDER BY price DESC
-- b)
SELECT pc.model, price 
FROM pc 
  JOIN product ON p.model = product.model 
WHERE product.maker = 'B'
UNION
SELECT laptop.model, price 
FROM laptop
  JOIN product ON laptop.model = product.model 
WHERE product.maker = 'B'
UNION
SELECT printer.model, price 
FROM printer 
   JOIN product ON printer.model = product.model 
WHERE product.maker = 'B'
ORDER BY price DESC


-- 3.Напишете заявка, която извежда размерите на тези дискове, които се предлагат в поне два компютъра
SELECT DISTINCT p1.hd
FROM pc p1
   JOIN pc p2 ON p1.code!=p2.code AND p1.hd=p2.hd


-- 4.Напишете заявка, която извежда всички двойки модели на компютри, които имат еднаква честота и памет. 
--   Двойките трябва да се показват само по веднъж, например само (i, j), но не и (j, i)
SELECT DISTINCT p1.model, p2.model
FROM pc p1
   JOIN pc p2 ON p1.model < p2.model
WHERE p1.speed = p2.speed AND p1.ram=p2.ram



-- 5.Напишете заявка, която извежда производителите на поне два различни компютъра с честота на процесора поне 500 MHz.
SELECT DISTINCT p1.maker
FROM pc pc1
  JOIN pc pc2 ON pc1.code != pc2.code 
  JOIN product p1 ON pc1.model = p1.model
  JOIN product p2 ON pc2.model = p2.model
WHERE pc1.speed >= 500 AND pc2.speed >= 500 AND p1.maker = p2.maker
