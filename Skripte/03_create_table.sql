USE reisebuero;
GO

CREATE TABLE Benutzer (
	id INT IDENTITY NOT NULL,
	email NVARCHAR(50) NOT NULL,
	passwort VARBINARY(1000) NOT NULL,
	vorname NVARCHAR(50) NOT NULL,
	nachname NVARCHAR(50) NOT NULL,
	geschlecht BIT NOT NULL,
	adresse_id INT NOT NULL,
	telefon NVARCHAR(25) NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Mitarbeiter (
	id INT IDENTITY NOT NULL,
	benutzer_id INT NOT NULL,
	svnr INT NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Adresse (
	id INT IDENTITY NOT NULL,
	land_id INT NOT NULL,
	adresse NVARCHAR(255) NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Kunde (
	id INT IDENTITY NOT NULL,
	benutzer_id INT NOT NULL,
	geburtsdatum DATETIME NOT NULL,
	titel NVARCHAR(25),
	land_id INT NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Buchung (
	reisedetail_id INT NOT NULL,
	kunde_id INT NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Bewertung (
	id INT IDENTITY NOT NULL,
	bewertung INT NOT NULL,
	buchung_id INT NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Reise (
	id INT IDENTITY NOT NULL,
	titel NVARCHAR(50) NOT NULL,
	beschreibung NVARCHAR(MAX) NOT NULL,
	unterkunft_id INT NOT NULL,
	preis_erwachsener DECIMAL(6,2) NOT NULL,
	preis_kind DECIMAL(6,2) NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Verpflegung (
	id INT IDENTITY NOT NULL,
	bezeichnung NVARCHAR(50) NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Unterkunft (
	id INT IDENTITY NOT NULL,
	bezeichnung NVARCHAR(50) NOT NULL,
	beschreibung NVARCHAR(MAX) NOT NULL,
	kategorie INT NOT NULL,
	verpflegung_id INT NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Reisedetail (
	id INT IDENTITY NOT NULL,
	reise_id INT NOT NULL,
	startdatum DATETIME NOT NULL,
	enddatum DATETIME NOT NULL,
	anmeldefrist DATETIME NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Land (
	id INT IDENTITY NOT NULL,
	bezeichnung NVARCHAR(50),
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Bild (
	id INT IDENTITY NOT NULL,
	bild VARBINARY(MAX) NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Bild_Unterkunft (
	id INT IDENTITY NOT NULL,
	bild_id INT NOT NULL,
	unterkunft_id INT NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);

CREATE TABLE Bild_Reise (
	id INT IDENTITY NOT NULL,
	bild_id INT NOT NULL,
	reise_id INT NOT NULL,
	erstelldatum DATETIME DEFAULT GETDATE()
);
GO