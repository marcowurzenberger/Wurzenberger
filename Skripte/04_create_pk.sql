
ALTER TABLE Adresse
ADD
CONSTRAINT PK_Adresse
PRIMARY KEY (id);
GO

ALTER TABLE Land
ADD
CONSTRAINT PK_Land
PRIMARY KEY (id);
GO

ALTER TABLE Mitarbeiter
ADD
CONSTRAINT PK_Mitarbeiter
PRIMARY KEY (id);
GO

ALTER TABLE Benutzer
ADD
CONSTRAINT PK_Benutzer
PRIMARY KEY(id);
GO

ALTER TABLE Kunde
ADD
CONSTRAINT PK_Kunde
PRIMARY KEY(id);
GO

ALTER TABLE Buchung
ADD
CONSTRAINT PK_Buchung
PRIMARY KEY (reisedetail_id);
GO

ALTER TABLE Reisedetail
ADD
CONSTRAINT PK_Reisedetail
PRIMARY KEY (id);
GO

ALTER TABLE Reise
ADD
CONSTRAINT PK_Reise
PRIMARY KEY (id);
GO

ALTER TABLE Bewertung
ADD
CONSTRAINT PK_Bewertung
PRIMARY KEY (id);
GO

ALTER TABLE Bild_Reise
ADD
CONSTRAINT PK_Bild_Reise
PRIMARY KEY(id);
GO

ALTER TABLE Bild
ADD
CONSTRAINT PK_Bild
PRIMARY KEY(id);
GO

ALTER TABLE Bild_Unterkunft
ADD
CONSTRAINT PK_Bild_Unterkunft
PRIMARY KEY (id);
GO

ALTER TABLE Unterkunft
ADD
CONSTRAINT PK_Unterkunft
PRIMARY KEY(id);
GO


ALTER TABLE Verpflegung
ADD
CONSTRAINT PK_Verpflegung
PRIMARY KEY(id);
GO