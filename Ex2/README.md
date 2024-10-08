
## I. Заявки рефериращи повече от една таблица

> В практиката, много рядко SELECT заявките използват само една таблица, за да удовлетворят клиентско запитване. Обикновено, търсената информация се намира в две и повече физически таблици от релационната база от данни. Сега ще разгледаме т.нар вътрешно свързване на таблици (INNER JOIN), CROSS JOIN, както и операциите обединение, сечение и разлика (UNION, INTERSECT, EXCEPT).


## II. CROSS JOIN

> Това е свързване на таблици, при което таблицата резултат съдържа всички комбинации на ред от първата таблица с ред от втората. Т.е. ако разгледаме двете таблици, които се свързват, като множества от редове, резултатът е декартовото произведение на тези множества. (Множеството от колоните на таблицата резултат е обединение от множеството колони на първата таблица с множеството от колони на втората).

Например:

```python
SELECT * FROM CLASSES CROSS JOIN SHIPS
```

Алтернативно, това свързване може да се запише и по следния начин:

```python
SELECT * FROM CLASSES,SHIPS
```

Нека да се опитаме по този начин да решим следната задача:

 За всеки кораб, който е пуснат на вода след 1942 година, да изведем името на кораба, годината на пускане на вода и държавата на кораба. 

Имената на корабите и годината на пускане на вода се намират в таблицата SHIPS. Държавата е атрибут на класа и се пази в таблицата CLASSES. На нас не са ни нужни всички двойки клас <-> кораб, а само тези, които се отнасят за един и същи клас (тоест всеки кораб да е свързан само веднъж и то с реда от таблица CLASS, който се отнася за неговия клас в колоната SHIPS.CLASS). Това може да го постигнеме, чрез условие в WHERE клауза:

```python
SELECT COUNTRY, NAME, LAUNCHED
FROM CLASSES CROSS JOIN SHIPS
WHERE CLASSES.CLASS = SHIPS.CLASS AND SHIPS.LAUNCHED > 1942
```

Както казахме същото може да се запише и като отделим двете таблици със запетая:

```python
SELECT COUNTRY, NAME, LAUNCHED
FROM CLASSES, SHIPS
WHERE CLASSES.CLASS = SHIPS.CLASS AND SHIPS.LAUNCHED > 1942
```

И в двете таблици, колоната съхраняваща името на класа има едно и също име. Затова в заявката използваме нотацията <име на таблица>.<име на колона>, за да няма двусмислие.


## III. INNER JOIN (Вътрешно свързване)

> Вътрешното свързване е такова съединение на две таблици, при което ред от едната таблица се комбинира с ред от другата таблица само ако е изпълнено някакво условие. Ако в една от двете таблици има редове за които няма съответни в другата таблица - те не участват в резултата.

Естественото решение на задачата по-горе е именно с използването на вътрешно свързване на таблиците SHIPS и CLASSES. Там искаме именно кораби от таблицата SHIPS да се свържат със съответния за тях клас от таблицата CLASSES. Това може да се укаже като условие на вътрешното свързване и да не се тръгва от по неестествен начин от декартово произведение и в последствие да се филтрират чрез WHERE клауза свързани редове които не са нужни за решението на задачата. 

Ето как става това:

```python
SELECT COUNTRY, NAME, LAUNCHED
FROM SHIPS
     JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE LAUNCHED > 1942
```

Така в WHERE клаузата остава само условието за пускане на вода след 1942г.

При този запис още от дефиницията на свързването е ясно на базата на какво условие се извършва то и самата заявка е доста по-четима.

За съвременните сървъри не е проблем дали ще се използва единия запис или другия. Те са в състояние да изберат най-оптималния начин за изпълнение на заявката. 

## IV. Свързване на таблица със самата нея

Нека да разгледаме следната задача: заявка, която извежда заглавията на всички филми с дължина, по-голяма от дължината на филма Star Wars. 

За да решим задачата, бихме могли да свържем таблицата MOVIES със самата нея, като условието нагласим така, че всеки филм от MOVIES да се свърже с един и същи ред отдясно - редът съответстващ на филма 'Star Wars'. Така ще може да сравняваме дължината на всеки филм с дължината на 'Star Wars' от 1977г.. Ето как може да се запише това:

```python
SELECT m1.TITLE, m1.YEAR
FROM MOVIES m1
     JOIN MOVIES m2 ON m2.TITLE = 'Star Wars' AND m2.YEAR = 1977
WHERE m1.length > m2.length
```

Забележете, че зададохме спомагателно име (alias) за двата екземпляра на MOVIES в заявката. Така може да ги различаваме и да избираме колони от всяка една от тях.

## V. Съединия на повече от две таблици

Нека да разгледаме следната задача: заявка, извеждаща имената на всички актриси, които са се снимали във филм на 'MGM'.

```python
SELECT DISTINCT ms.NAME
FROM MOVIESTAR ms
     JOIN STARSIN si ON ms.NAME = si.STARNAME
     JOIN MOVIE m ON si.MOVIETITLE = m.TITLE AND si.MOVIEYEAR = m.YEAR
WHERE ms.GENDER = 'F'
```

## VI. Обединение, сечение, разлика

>Може да разглеждаме резултата от всяка една SELECT заявка като мултимножество от редове. Върху тях може да извършваме множествени операции - обединение, сечение, разлика. 

>Разбира се е нужно завяките да са съвместими, така, че резултатът от операцията да може да бъде представен в таблица. Тоест нужно е броят на колоните да е еднакъв и техните типове да са съвместими. Не е необходимо имената на колоните да са еднакви.

Пример със сечение (INTERSECT): Напишете заявка, която връща звездите, които са от женски пол и също са продуценти с NETWORTH по-голям от 10000000:

```python
SELECT NAME, ADDRESS
FROM MOVIESTAR
WHERE GENDER = 'F'
INTERSECT
SELECT NAME, ADDRESS
FROM MOVIEEXEC
WHERE NETWORTH > 10000000
```

>UNION, INTERSECT и EXCEPT автоматично премахват повтарящите се редове. Ако искаме да ги запазим може да използваме UNION ALL, INTERSECT ALL, EXCEPT ALL. Не всички сървъри поддържат ALL за INTERSECT и EXCEPT.

От резултата на една SELECT заявка може да премахваме еднакви редове също като използваме DISTINCT. Например: Да се напише заявка, която извежда имената на всички битки, в които има потънал кораб.

```python
SELECT DISTINCT BATTLE
FROM OUTCOMES
WHERE RESULT = 'sunk'
```