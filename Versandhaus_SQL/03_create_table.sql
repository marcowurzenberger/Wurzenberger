USE versandhaus;
GO

CREATE TABLE artikel(
	id INT IDENTITY NOT NULL,
	bez NVARCHAR(50) NOT NULL,
	preis DECIMAL(6,2) NOT NULL,
	erstellDatum DATETIME NOT NULL DEFAULT GETDATE(),
	artikelDetail_id INT NOT NULL
);
GO
CREATE TABLE bestellung(
	id INT IDENTITY NOT NULL,
	anzahl INT NOT NULL
);
GO
CREATE TABLE kunde(
	id INT IDENTITY NOT NULL,
	vorname NVARCHAR(50) NOT NULL,
	nachname NVARCHAR(50) NOT NULL,
	email NVARCHAR(50)
);
GO
CREATE TABLE adresse(
	id INT IDENTITY NOT NULL,
	land_id INT NOT NULL,
	ort NVARCHAR(50) NOT NULL,
	plz NVARCHAR(10) NOT NULL,
	strasse NVARCHAR(50) NOT NULL,
	stiege NVARCHAR(10),
	stock NVARCHAR(10),
	nr NVARCHAR(10) NOT NULL
);
GO
CREATE TABLE land(
	id INT IDENTITY NOT NULL,
	bez NVARCHAR(50) NOT NULL,
);
GO
CREATE TABLE telefon(
	id INT IDENTITY NOT NULL,
	vorwahl NVARCHAR(10) NOT NULL,
	laenderVorwahl NVARCHAR(10) NOT NULL,
	nummer NVARCHAR(20) NOT NULL
);
GO
CREATE TABLE artikelDetail(
	id INT IDENTITY NOT NULL,
	verpackungseinheit NVARCHAR(5) NOT NULL,
	beschreibung NVARCHAR(4000) NOT NULL
);
GO
CREATE TABLE artikelBestellung(
	id INT IDENTITY NOT NULL,
	artikel_id INT NOT NULL,
	bestellung_id INT NOT NULL
);
GO
CREATE TABLE kundeBestellung(
	id INT IDENTITY NOT NULL,
	kunde_id INT NOT NULL,
	bestellung_id INT NOT NULL
);
GO
CREATE TABLE telefonKunde(
	id INT IDENTITY NOT NULL,
	kunde_id INT NOT NULL,
	telefon_id INT NOT NULL
);
GO
CREATE TABLE adresseKunde(
	id INT IDENTITY NOT NULL,
	kunde_id INT NOT NULL,
	adresse_id INT NOT NULL
);
GO
CREATE TABLE artikelGeloescht(
	artikel_id INT NOT NULL,
	erstellDatum DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE bestellungStorniert(
	bestellung_id INT NOT NULL,
	erstellDatum DATETIME DEFAULT GETDATE()
);