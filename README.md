
# Podstawy języka SQL i jego zastosowanie na bazach danych.

## 1. Czym jest SQL?
**SQL**, czyli _Structured Query Language_ jest językiem programowania używanym do zarządzania relacyjnymi bazami danych.
Powstał on, aby uprościć i ustandardyzować sposób w jaki dane są pozyskiwane.


## 2. Czemu SQL?
Przed powstaniem języka SQL, bazy danych  były głównie [nawigacyjne](https://en.wikipedia.org/wiki/Navigational_database), które w porównaniu do dzisiejszych __relacyjnych__ baz danych miało kilka wad, m.in. brak wsparcia dla skalowalności oraz proceduralny dostęp do danych.

W roku 1970, [Edgar F. Codd](https://en.wikipedia.org/wiki/Edgar_F._Codd) opublikował pracę naukową, w której zaproponował inną metodę przechowywania danych, którą był **model relacyjny**. Sposób przechowywania danych polegał na zastąpieniu wskaźnikowego wyszukiwania danych i zastąpienie ich tabelami zwanymi "relacjami", które mogą łączyć się ze sobą za pomocą wspólnych wartości (tzw. klucze).

Kluczową ideą SQL jest jego deklaratywność, która w porównaniu do języków imperatywnych (t.j. `C++` lub `Java`) skupia się na danych, które chcemy uzyskać niż na sposobie w jaki je zdobędziemy.

Rezultatem takiego paradygmatu jest brak odpowiedzialności za optymalizację oraz algorytmikę związaną z uzyskaniem danych.

## 3. Idea relacyjnej bazy danych.

Idea relacyjnej bazy danych opiera się na teorii zbiorów. Dane zorganizowane są w dwuwymiarowe tabele, składające się z atrybutów (`kolumn`) oraz rekordów (`wierszy`).

Istotą tego modelu są **relacje**: zamiast przechowywać wszystkie informacje w jednym miejscu, dzieli się je na mniejsze, logiczne zbiory. Powiązania między tabelami tworzone są za pomocą ww. kluczy, co eliminuje redundancję (powtarzalność) informacji oraz gwarantuje integralność danych, gdzie każda modyfikacja jest natychmiast uwzględniana we wszystkich powiązanych elementach systemu.
## 4. Funkcjonalność SQL

Język SQL będąc jednolitym standardem, dzieli się na 4 grupy poleceń, odpowiedzialne za inny aspekt zarządzania bazą danych.
Tymi grupami są:
    
- **DQL** (Data Query Language), służy do pobierania danych z tabeli, a jej fundamentalną komendą jest `SELECT`.
- **DML** (Data Manipulation Language), umożliwia zarządzanie konkretnymi danymi wewnątrz tabeli, kluczowe komendy dla tej grupy to:
    
    - `INSERT` służąca do dodawania rekordów,
    - `DELETE` służąca do usuwania rekordów,
    - `UPDATE` służąca do aktualizacji istniejących rekordów.
- **DDL** (Data Definition Language), pozwala na definiowanie struktury (tzw. "szkieletu") lub poszczególnych tabel wewnątrz bazy danych. Kluczowe komendy to:

    - `CREATE` tworząca tabele, bądź bazę danych.
    - `ALTER` modyfikującą istniejące tabele, bądź bazy danych,
    - `DROP` usuwająca tabele lub bazy danych.

- **DCL** (Data Control Language), odpowiada za bezpieczeństwo i zarządzanie dostępem do danych, Kluczowymi komendami są `GRANT`oraz `REVOKE`, które odpowiedzialne są za nadawanie lub odbieranie uprawnień użytkownikom wewnątrz bazy.
## 5. Składnia i struktura zapytań SQL

Kwerendy języka SQL przyjmują formę "bloku" zdania, które trzymają się swoich zasad składniowych, gdzie zapytania mają następujący format:
```sql
KOMENDA co_chcę_zrobić          - np. SELECT `imie`
SKĄD źródło_danych              - np. FROM `pracownicy`
WARUNEK filtr_danych;           - np. WHERE id = 7312
```

Warto dodać, że klauzula filtrująca `WHERE` nie jest wymagana do zapytania i jej brak będzie skutkować wykonaniem operacji na wszystkich rekordach w tabeli. 


## 6. Warunki zapytań SQL
W pliku `dummy.sql` znajdują się przykładowe dane, dzięki którym możemy stworzyć bazę danych i wypełnić ją gotowymi danymi. Struktura naszej** bazy danych będzie składać się z dwóch tabel: `Departments` oraz `Employees` z następującymi atrybutami:
    
          Departments (Tabela A)               Employees (Tabela B)
    +----------------+-----------------+    +--------------+-----------+
    |  DepartmentID  | DepartmentName  |    | DepartmentID | LastName  |
    +----------------+-----------------+    +--------------+-----------+
    | 31             | Sales           |    | 33           | Smith     |
    | 32             | Engineering     |    | 33           | Jones     |
    | 33             | Marketing       |    | 31           | Brown     |
    | ...            | ...             |    | ...          | ...       |
    +----------------+-----------------+    +--------------+-----------+

Widzimy, że wspólnym atrybutem obu tabel jest kolumna `DepartmentID`, która w tym wypadku jest naszym kluczem, który pozwala na łączenie danych ze sobą (np. uzyskanie nazwisk wszystkich pracowników z działu `Sales`). Łączenie wyników z kilku tabel odbywa się za pomocą klauzury `JOIN`, która ma 3 **główne** formy m.in. 


- `INNER JOIN` będący iloczynem zbioru **A** oraz **B**.
- `RIGHT JOIN` będący całością zbioru **B**, do którego dołączamy pasujące elementy ze zbioru **A**.
- `LEFT JOIN` będący całością zbioru **A**, do którego dołączamy pasujące elementy ze zbioru **B**.

Istnieją również `CROSS JOIN` czy `FULL JOIN`, natomiast nie są one powszechnie stosowane.

#### Przykład:


Kwerenda zwracająca wartości `LastName` dla wszystkich pracowników bedących w działach `Sales` oraz `Engineering`.

```sql
SELECT      Employees.LastName
FROM        Employees
INNER JOIN  Departments 
ON          Departments.DepartmentID = Employees.DepartmentID
WHERE       Departments.DepartmentID = 31 OR Departments.DepartmentID = 32;
```
## 7. Formatowanie i organizacja wyników 
Gdy pobierzemy i połączymy dane, często musimy je uporządkować lub ograniczyć ich ilość. Służą do tego słowa kluczowe umieszczane na samym końcu zapytania SQL.

#### 7.1. Eliminacja duplikatów (`DISTINCT`)

Jeśli chcemy zobaczyć tylko unikalne wartości (np. sprawdzić, z jakich miast pochodzą klienci, bez powtórzeń), używamy `DISTINCT` zaraz po `SELECT`.

```sql
-- Zwróci listę ID działów bez powtórzeń
SELECT DISTINCT DepartmentID 
FROM            Employees;
```

#### 7.2 Sortowanie (`ORDERY BY`)
Definiuje kolejność wyświetlania wierszy.
- `ASC` sortuj (domyślnie) rosnąco (A-Z, 0-9).
- `DESC` sortuj malejąco (Z-A, 9-0).
```sql
-- Pracownicy posortowani alfabetycznie od Z do A
SELECT      LastName 
FROM        Employees
ORDER BY    LastName DESC;
```

#### 7.3. Limitowanie wyników (`LIMIT` i `OFFSET`)

Służy do ograniczenia liczby zwracanych wierszy (np. "Top 5") lub stronicowania wyników.

- `LIMIT X` pokaż **X** wierszy.
- `OFFSET Y` pomiń pierwsze **Y** wierszy.

```sql
-- Pokaż 5 pracowników, ale pomiń pierwszych 10
SELECT LastName FROM    Employees
ORDER BY                LastName
LIMIT 5 OFFSET 10;
```
