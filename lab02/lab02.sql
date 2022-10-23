-- zad05

CREATE TABLE nazwiska
(
	"Lp" integer PRIMARY KEY,
	"Nazwisko" "char" NOT NULL
);

CREATE TABLE kwoty
(
	"Lp" integer PRIMARY KEY,
	"Brutto" float UNIQUE,
	"Nazwisko" "char" NOT NULL
);

CREATE TABLE miasto
(
	"Lp" integer PRIMARY KEY,
	"Miasto" "char",
	"Nazwisko" "char" NOT NULL
);

--zad06

CREATE TABLE nazwiska
(
	"Lp" integer PRIMARY K
	"Nazwisko" "char" NOT NULL
);

CREATE TABLE kwoty
(
	"Lp" integer PRIMARY KEY,
	"Brutto" float UNIQUE,
	CONSTRAINT fk_nazwisko_id FOREIGN KEY ("Lp") REFERENCES lab01.nazwiska ("Lp")
)

CREATE TABLE miasto
(
	"Lp" integer PRIMARY KEY,
	"Miasto" "char",
	CONSTRAINT fk_nazwisko_id FOREIGN KEY ("Lp") REFERENCES lab01.nazwiska ("Lp")
)
