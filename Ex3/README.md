
## I. Подзаявки

> SELECT заявките могат да бъдат влагани в други SELECT заявки. Подзаявките се ограждат с кръгли скоби.

>В общия случай, резултатът от всяка SELECT заявка е таблица. Във FROM клаузата може да имаме подзаявки, вместо физически таблици от релационната база. Оградени със скоби и именувани с алиас (псевдоним), те се използват по същия начин като всяка друга таблица. Само колоните в SELECT списъка на подзавяката са видими от заявката, в която тя е вложена.

>SELECT завяки, от които резултатът е скалар (таблица с 1 ред и 1 колона) могат да бъдат използвани в SELECT списъка на друга завяка. За всеки ред от резултата, който идва от FROM клазуата на външната завяка (и след евентуалното филтриране с WHERE), се изпълнява подзаявката, която трябва да върне скалар, който да се използва в съответната колона на реда резултат на външната завяка.

>SELECT заявки, които връщат скалар или списък (таблица с 1 колона и произволен брой редове) могат да бъдат използвани в WHERE клазуата на други заявки.

## II. Скаларна подзаявка

Да се изведат заглавията на всички филми, които са по-дълги от Star Wars:
 ```python
SELECT TITLE
FROM MOVIE
WHERE LENGTH > (SELECT LENGTH
                FROM movie
                WHERE title = 'Star Wars' AND YEAR = 1977)
```
## III. Подзаявки, които връщат списъци

Такива подзаявки могат да се използват в комбинация със следните оператори:
 ```python
expression IN ( subquery )
expression NOT IN ( subquery )
expression { = | < > | ! = | > | > = | ! > | < | < = | ! < } ANY ( subquery )
expression { = | < > | ! = | > | > = | ! > | < | < = | ! < } ALL ( subquery )
 ```
>Резултатът от първата проверка е истина ако резултатът от израза отляво се съдържа в списъка, върнат от подзаявката. Съответно, втората е истина ако не е. Третата проверка е истина ако резултатът от израза е в съответната релация със поне един елемент от списъка от стойности върнати от подзаявката. Последната проверка - ако е в релация със всички.

Например: 

 ```python
 SELECT *
FROM STARSIN
WHERE STARNAME IN (SELECT NAME
                   FROM MOVIESTAR
                   WHERE GENDER = 'F')
  ```

## IV. Оператор EXISTS
> EXISTS (subquery) е истина, ако подзавяката връща непразен резултат.

Да се изведат имената на всички филмови звезди, които са играли във филм след навършване на 40-годишна възраст:


 ```python
SELECT NAME
FROM MOVIESTAR
WHERE EXISTS (SELECT *
              FROM STARSIN 
              WHERE MOVIESTAR.NAME = STARNAME
                 AND MOVIEYEAR >= YEAR(MOVIESTAR.BIRTHDATE) + 40)

 ```

## V. Корелативни подзаявки
> Това са подзаявки, които използват данни от заявката в която са вложени (както в примера по-горе).

Друг пример: Да се напише заявка, която извежда тези заглавия на филми, които са използвани в поне два филма.

Ще решим задачата, като намерим филмите, чиято година е по-малка от поне една от годините на всички филми със същото заглавие. Очевидно, когато един филм с някакво име е заснет в точно една година - тяхната година трябва да е по-малка от нея самата и съответно тези филми няма да участват в крайния резултат. Ако имаме N филма с еднакво заглавие (N > 1), тогава на това условие ще отговарят N-1 от тях. Това е достатъчно да може да извлечем съответното име. За N > 2, ще има дублицирани имена и трябва да използваме DISTINCT:

 ```python
SELECT DISTINCT TITLE
FROM MOVIE m
WHERE YEAR < ANY (SELECT YEAR
                  FROM MOVIE
                  WHERE TITLE = m.TITLE)
 ```

## VI. Подзаявки във FROM клаузата

>В този случай, вложената заявка може да връща всякаква таблица. Ако има колони, които са формирани чрез изрази - задължително трябва да им се даде име.

Да извлечеме жените актьори, филмите, в които са участвали и тяхната година на раждане. Ще решим задачата като свържем таблицата STARSIN с таблица-резултат от SELECT заявка, която извлича жените актьори и годината им на раждане:


 ```python
SELECT si.MOVIETITLE, si.STARNAME, fms.BIRTHYEAR
FROM STARSIN si JOIN (SELECT NAME, YEAR(BIRTHDATE) AS BIRTHYEAR
                      FROM MOVIESTAR
                      WHERE GENDER = 'F') fms ON si.STARNAME = fms.NAME

 ```

Колоната, в която извличаме годината на раждане (чрез фукнцията YEAR) задължително трябва да бъде именована, за да може да бъде достъпна от външната заявка.

## VII. Подзаявки в SELECT клаузата

Нека да извлечеме имената и годините на всички цветни филми, имената на студиата и адресите на последните. Вместо свързване на MOVIE и STUDIO (което е естественото решение на задачата), ще използваме подзаявка в SELECT, с която ще извлечеме адресите:

 ```python
SELECT m.TITLE, m.YEAR, m.STUDIONAME, (SELECT s.ADDRESS 
                                       FROM STUDIO s
                                       WHERE s.NAME = m.STUDIONAME)
FROM MOVIE m
WHERE INCOLOR = 'Y'
 ```

Тук подзаявката трябва да връща скалар. Ако е корелативна (както в случая), за всеки ред, в крайния резултат може да формира различна стойност. Ако не е - тогава всички редове, които връща външната заявка, ще имат една и съща стойност в колоната, която се формира от вложената заявка.

Последните два примера са неестествени решения на поставените задачи, но демонстрират съответните видове подзаявки. Смислени примери за подзаявки във FROM и SELECT ще видите в петото и шестото упражнение.