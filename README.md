# Бази от дании - задачи

* SELECT - извличане на данни 
* FROM - откъде извличаме данните
* OR, AND - И, ИЛИ
* WHERE - където, след него пишем условия
* IS NULL, IS NOT NULL - проверка за нулеви стойности 
* <, > - лексикографско сравняване на символни низове
* = - сравнение 
* LIKE - сравнение като =
* % - заместване на нула, един или повече символа, работи с LIKE
* _ - замества точно един символ, работи с LIKE
* ORDER BY - начина на подреждане, който връща една SELECT заявка.Сървърът подрежда резултата първо по първия признак, после по втория и т.н.  По подразбиране, подреждането става по възходящ ред, като това може и да се указва експлицитно. 
* ASC - възходящ ред
* DESC - низходящ ред
---------------------------------
* CROSS JOIN, , - таблицата резултат е декартово произведение на двете таблици 
* INNER JOIN - ред от едната таблица се комбинира с ред от другата таблица само ако е изпълнено някакво условие. JOIN ..ON..
* DISTINCT - премахване на еднакви редове
* INTERSECT - сечение на две таблици
* UNION - обединени на две таблици
* UNION ALL - връща всички + дубликати
* EXCEPT - разлика на две таблици
-------------------
* IN, NOT IN - изразът се съдържа/ не се съдържа в списъка на подзаявката
* ANY -резултатът от израза е в съответната релация с поне един елемент от списъка от стойности върнати от подзаявката
* ALL - в релация с всичкr
* EXISTS (subquery) - истина, ако подзавяката връща непразен резултат.
-------------------------
* LEFT OUTER JOIN или само LEFT JOIN - лявото външно свързване запазва редовете в лявата таблица, които не могат да се свържат с ред от дясната таблица. В крайния резултат присъстват като ред, в който колоните от дясната таблица са попълнени с NULL стойности
* RIGHT OUTER JOIN или само RIGHT JOIN - Дясното външно свързване запазва редовете в дясната таблица, които не могат да се свържат с ред от лявата таблица. В крайния резултат присъстват като ред, в който колоните от лявата таблица са попълнени с NULL стойности
* FULL OUTER JOIN или само FULL JOIN - Запазват както редовете от лявата таблица, които не могат да се свържат с ред от дясната, така и обратно
* Функцията COALESCE- приема списък от аргументи и връща първия, който е различен от NULL
* YEAR(date) - вадим само годината от датата
-------------------
* GROUP BY - групираме
* Агрегатни функции - Извършват пресмятане върху множество от стойности (например множеството от
стойности в някоя колона за група формирана чрез GROUP BY) и връщат скалар. Агрегатните функции игнорират NULL стойностите.
ALL е по подразбиране. С DISTINCT може да игнорираме повтарящи се стойности. Специален случай - COUNT(*) - NULL стойностите ще бъдат преброени, както и
повторенията.
* COUNT ([ ALL | DISTINCT ] expression)
* SUM ([ ALL | DISTINCT ] expression)
* AVG ([ ALL | DISTINCT ] expression)
* MIN (expression)
* MAX (expression)
* STRING_AGG (expression, delimiter)
(GROUP_CONCAT в MySQL; LISTAGG в Oracle и DB2)
* Групиране по 2 колони: GROUP BY s.CLASS, s.LAUNCHED - в една и съща група ще попаднат
кораби от един и същи клас, които са пуснати на вода в една и съща година.
* Групиране по израз: GROUP BY YEAR(BATTLES.DATE) - в една и съща група ще попаднат кораби,
които са участвали в битка в една и съща година
* HAVING - Аналогична на WHERE клаузата. Дава възможност да филтрираме, след като сме
извършили групиране.



> Логически ред на изпълнение на SQL заявка
> 1. Извършват се свързванията, описани във FROM клаузата от ляво надясно
> 2. Извършва се филтрирането на редове формирани след свързванията в WHERE клаузата
> 3. Извършва се групиране на останалите редове в групи на базата на GROUP BY клаузата.
Всяка група формира по един ред в крайния резултат.
> 4. Извършва се филтриране на редове след извършване на групирането в HAVING клаузата
> 5. Формират се колоните, описани във SELECT клаузата, които ще бъдат върнати на клиента
> 6. Извършва се сортирането описано в ORDER BY клаузата
> 7. Резултатът се връща на клиента, изпратил заявката

> ВАЖНО: След групиране, в SELECT, HAVING и ORDER BY може да използваме само колоните
или изразите, по които сме групирали или изрази формирани от такива колони и/или агрегатни функции.

* Оператор CASE - CASE връща стойност (SQL е декларативен език, не става въпрос за flow control). Може да се използва в заявки на местата, където се очаква скаларна стойност

**Примери:**

 ```python
1.1 SELECT * FROM CLASSES
```

 ```python
1.2  SELECT CLASS, COUNTRY, NUMGUNS FROM CLASSES
```

 ```python
1.3 SELECT TITLE, YEAR, STUDIONAME
     FROM MOVIE
     WHERE LENGTH > 60 OR TITLE = 'Titanic'
```
```python
1.4 SELECT TITLE, YEAR, STUDIONAME AS STUDIO
    FROM MOVIE
    WHERE LENGTH > 60 OR STUDIO = 'Disney'
```

```python
1.5 SELECT TITLE, YEAR, LENGTH / 60.0 AS LENGTH_IN_HOURS
    FROM MOVIE
    WHERE LENGTH > 60 OR YEAR = 2001
```
```python
1.6 SELECT CLASS, COUNTRY, NUMGUNS 
    FROM CLASSES
    WHERE LENGTH IS NULL
```
```python
1.7  name LIKE 'a%'
```
```python
1.8.  SELECT TITLE, YEAR, STUDIONAME AS STUDIO
      FROM MOVIE
      WHERE TITLE LIKE '%Trek%'
```
```python
1.9.  SELECT CLASS, COUNTRY, NUMGUNS 
      FROM CLASSES
      WHERE NUMGUNS > 5 OR COUNTRY = 'USA'
      ORDER BY COUNTRY ASC, NUMGUNS DESC
```

-------------------------

```python
2.1  SELECT * FROM CLASSES CROSS JOIN SHIPS
```
```python
2.2  SELECT COUNTRY, NAME, LAUNCHED
     FROM CLASSES CROSS JOIN SHIPS
     WHERE CLASSES.CLASS = SHIPS.CLASS AND SHIPS.LAUNCHED > 1942
```
```python
2.3  SELECT COUNTRY, NAME, LAUNCHED
     FROM SHIPS
         JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
     WHERE LAUNCHED > 1942
```
```python
2.4 SELECT m1.TITLE, m1.YEAR
    FROM MOVIES m1
         JOIN MOVIES m2 ON m2.TITLE = 'Star Wars' AND m2.YEAR = 1977
    WHERE m1.length > m2.length
```
```python
2.5 SELECT DISTINCT ms.NAME
    FROM MOVIESTAR ms
          JOIN STARSIN si ON ms.NAME = si.STARNAME
          JOIN MOVIE m ON si.MOVIETITLE = m.TITLE AND si.MOVIEYEAR = m.YEAR
    WHERE ms.GENDER = 'F'
```
```python
2.6 SELECT NAME, ADDRESS
    FROM MOVIESTAR
    WHERE GENDER = 'F'
    INTERSECT
    SELECT NAME, ADDRESS
    FROM MOVIEEXEC
    WHERE NETWORTH > 10000000
```
```python
2.7 SELECT DISTINCT BATTLE
    FROM OUTCOMES
    WHERE RESULT = 'sunk'
```
-------------------
 ```python
3.1 SELECT TITLE
    FROM MOVIE
    WHERE LENGTH > (SELECT LENGTH
                    FROM movie
                    WHERE title = 'Star Wars' AND YEAR = 1977)
```
 ```python
3.2 expression IN ( subquery )
    expression NOT IN ( subquery )
    expression { = | < > | ! = | > | > = | ! > | < | < = | ! < } ANY ( subquery )
    expression { = | < > | ! = | > | > = | ! > | < | < = | ! < } ALL ( subquery )
 ```
  ```python
3.3 SELECT *
    FROM STARSIN
    WHERE STARNAME IN (SELECT NAME
                       FROM MOVIESTAR
                       WHERE GENDER = 'F')
  ```
 ```python
3.4 SELECT NAME
    FROM MOVIESTAR
    WHERE EXISTS (SELECT *
                  FROM STARSIN 
                  WHERE MOVIESTAR.NAME = STARNAME
                     AND MOVIEYEAR >= YEAR(MOVIESTAR.BIRTHDATE) + 40)

 ```
 
 ```python
3.5 SELECT DISTINCT TITLE
    FROM MOVIE m
    WHERE YEAR < ANY (SELECT YEAR
                      FROM MOVIE
                      WHERE TITLE = m.TITLE)
 ```
  ```python
3.6 SELECT m.TITLE, m.YEAR, m.STUDIONAME, (SELECT s.ADDRESS 
                                           FROM STUDIO s
                                           WHERE s.NAME = m.STUDIONAME)
      FROM MOVIE m
      WHERE INCOLOR = 'Y'
 ```
   ```python
  4.1  SELECT c.COUNTRY, s.NAME
        FROM CLASSES c
           JOIN SHIPS s ON c.CLASS = s.CLASS
           LEFT OUTER JOIN OUTCOMES o ON s.NAME = o.SHIP
         WHERE o.SHIP IS NULL
 ``` 
  ```python
   4.2 SELECT COALESCE(ms.NAME, me.NAME) AS NAME,
           ms.BIRTHDATE,
           me.NETWORTH
       FROM MOVIESTAR ms
         FULL OUTER JOIN MOVIEEXEC me ON ms.NAME = me.NAME
```
  ```python
5.1 SELECT c.CLASS, COUNT(s.NAME) AS NUMSHIPS
      FROM CLASSES c
         JOIN SHIPS s ON c.CLASS = s.CLASS
      GROUP BY c.CLASS
```
  ```python
5.2  Пример: Да се извлече броя корабите във всеки клас, който има повече от 2 кораба
SELECT c.CLASS, COUNT(s.NAME) AS NUMSHIPS
FROM CLASSES c
     JOIN SHIPS s ON c.CLASS = s.CLASS
GROUP BY c.CLASS
HAVING COUNT(s.NAME) > 2
```
  ```python
5.3  За всяко студио - името и сумата от дължините на всички негови филми
SELECT STUDIONAME, SUM(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME
```
 ```python
CASE input_expression
   WHEN when_expression THEN result_expression [ ...n ]
   [ ELSE else_result_expression ]
END
CASE
   WHEN бoolean_expression THEN result_expression [ ...n ]
   [ ELSE else_result_expression ]
END
 ```