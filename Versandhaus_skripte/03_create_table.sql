USE versandhaus;
GO

CREATE TABLE artikel(
	id INT IDENTITY NOT NULL,
	bez VARCHAR(50) NOT NULL,
	preis DECIMAL(6,2) NOT NULL,
	istGeloescht BIT NOT NULL,
	artikelDetail_id INT NOT NULL
);

CREATE TABLE bestellung(
	id INT IDENTITY NOT NULL,
	anzahl INT NOT NULL
);

CREATE TABLE kunde(
	id INT IDENTITY NOT NULL,
	vorname VARCHAR(50) NOT NULL,
	nachname VARCHAR(50) NOT NULL,
	email VARCHAR(50)
);

CREATE TABLE adresse(
	id INT IDENTITY NOT NULL,
	land_id INT NOT NULL,
	strasse VARCHAR(50) NOT NULL,
	stiege VARCHAR(10),
	stock VARCHAR(10),
	nr VARCHAR(10) NOT NULL
);

CREATE TABLE land(
	id INT IDENTITY NOT NULL,
	bez VARCHAR(50) NOT NULL,
	plz_id INT NOT NULL
);

CREATE TABLE plz(
	id INT IDENTITY NOT NULL,
	bez VARCHAR(10) NOT NULL,
	ort_id INT NOT NULL
);

CREATE TABLE ort(
	id INT IDENTITY NOT NULL,
	bez VARCHAR(50) NOT NULL
);

CREATE TABLE telefon(
	id INT IDENTITY NOT NULL,
	vorwahl_id INT NOT NULL,
	laenderVorwahl_id INT NOT NULL,
	nummer VARCHAR(20) NOT NULL
);

CREATE TABLE vorwahl(
	id INT IDENTITY NOT NULL,
	nummer VARCHAR(10) NOT NULL
);

CREATE TABLE laenderVorwahl(
	id INT IDENTITY NOT NULL,
	nummer VARCHAR(10) NOT NULL
);

CREATE TABLE artikelDetail(
	id INT IDENTITY NOT NULL,
	verpackungseinheit VARCHAR(5) NOT NULL,
	beschreibung VARCHAR(MAX) NOT NULL
);

CREATE TABLE artikelBestellung(
	id INT IDENTITY NOT NULL,
	artikel_id INT NOT NULL,
	bestellung_id INT NOT NULL
);

CREATE TABLE kundeBestellung(
	id INT IDENTITY NOT NULL,
	kunde_id INT NOT NULL,
	bestellung_id INT NOT NULL
);

CREATE TABLE telefonKunde(
	id INT IDENTITY NOT NULL,
	kunde_id INT NOT NULL,
	telefon_id INT NOT NULL
);

CREATE TABLE adresseKunde(
	id INT IDENTITY NOT NULL,
	kunde_id INT NOT NULL,
	adresse_id INT NOT NULL
);

GO