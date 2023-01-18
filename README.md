## Połączenie z bazą

docker exec -ti postgres2 psql -U postgres
docker exec -it postgres bash
psql -U postgres

https://stackoverflow.com/questions/769683/postgresql-show-tables-in-postgresql


## Notatki

### Polecenia

\l - lista baz danych
\du - listowanie grup i użytkowników
\dt - listowanie tabel
\dn - lista schematów
\dp - lista uprawnien do tabel
"psql -t" - wyświetla wyniki zamiast pretty printu 
"psql ... -L log.log" - zapisywanie query do pliku 

### Zapytania

```postgresql
CREATE TABLE osoby(lp serial primary key, imie varchar(30), nazwisko varchar(30));
INSERT INTO osoby (imie, nazwisko) VALUES ('Konrad', 'Albrecht'), ('Piotruś', 'Pan');
UPDATE osoby SET nazwisko='Pani' WHERE lp=2;
CREATE TABLE osoby_kopia AS (SELECT * FROM osoby);
SELECT imie, nazwisko FROM osoby WHERE lp BETWEEN 1 AND 3 ORDER BY nazwisko DESC;
DELETE FROM osoby WHERE lp IN (1,2);
DELETE FROM osoby WHERE lp BETWEEN 1 AND 3;
DELETE FROM osoby;
ALTER TABLE osoby ADD COLUMN nr_tel varchar(9);
ALTER TABLE osoby DROP COLUMN nr_tel, DROP COLUMN imie;
```

```postgresql
SELECT usename from pg_user;
CREATE USER konrad WITH PASSWORD 'konrad' CREATEDB;
CREATE GROUP gr1 WITH USER postgres, konrad;
ALTER GROUP gr1 DROP USER konrad;
ALTER ROLE konrad WITH NOCREATEDB;
CREATE DATABASE baza1 WITH OWNER=konrad;
```

### Kopia zapasowa

```shell
pg_dump -U baza1 > baza1_bck.sql
pg_restore -U postgres -d baza1 -f baza1.sql

pg_dump -U postgres -Fc baza1 > baza1.dump
pg_restore -U postgres -d baza1 baza1.dump
```

### Sprawdzenia ifowe

```shell
czy_rowne="Czy rowne"
echo $czy_rowne
if [ $czy_rowne == "Czy rowne" ]; then
  echo "Tak";
else 
  echo "Nie";
fi
```

### Klon bazy

```postgresql
CREATE DATABASE baza1_klon TEMPLATE postgres;
CREATE DATABASE baza1_klon TEMPLATE postgres IS_TEMPLATE TRUE;
```

### Schematy

```postgresql
CREATE SCHEMA schema1 AUTHORIZATION albrecht;
SET search_path TO "$user",public,user1; -- Żeby działało \dt dla innego schematu niz public
```

### Role

```postgresql
CREATE ROLE rola1 WITH LOGIN CREATEDB;
GRANT rola1 TO albrecht;
GRANT SELECT ON osoby TO rola1;
GRANT SELECT(imie) ON osoby TO rola1;
GRANT rola1 TO albrecht;
GRANT CONNECT ON DATABASE baza1 TO rola1;
GRANT USAGE, CREATE ON SCHEMA schema1 TO rola1;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA schema1 TO rola1;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA schema1 TO rola1;
SELECT grantee, table_schema, table_name, privilege_type FROM information_schema.table_privileges WHERE table_schema='schema1';
```

```shell
n=3
for i in $(seq $n)
do
    read -p "podaj element tablicy" element
    tab=(${tab[@]} $element)
done

for i in ${tab[*]}
do
  echo $i
done 

echo ${tab[@]}
```

```shell
cat lorem-ipsum.txt | tr "a" "+" # zamiana a na *
cat lorem-ipsum.txt | tr -d "a" # wykasowanie a z inputu
wc lorem-ipsum.txt # ilosc linii, ilosc slow, rozmiar w B, nazwa pliku
```