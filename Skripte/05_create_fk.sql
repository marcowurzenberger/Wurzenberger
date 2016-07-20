ALTER TABLE Reisedetail
ADD
CONSTRAINT FK_Reisedetail_Reise
FOREIGN KEY (reise_id)
REFERENCES Reise(id);
GO

ALTER TABLE Buchung
ADD
CONSTRAINT FK_Buchung_Kunde
FOREIGN KEY (kunde_id)
REFERENCES Kunde(id);
GO

ALTER TABLE Adresse
ADD
CONSTRAINT FK_Adresse_Land
FOREIGN KEY (land_id)
REFERENCES Land(id);
GO

ALTER TABLE Mitarbeiter
ADD
CONSTRAINT FK_Mitarbeiter_Benutzer
FOREIGN KEY (benutzer_id)
REFERENCES Benutzer(id);
GO

ALTER TABLE Kunde
ADD
CONSTRAINT FK_Kunde_Land
FOREIGN KEY (land_id)
REFERENCES Land(id);
GO

ALTER TABLE Reise
ADD 
CONSTRAINT FK_Reise_Unterkunft
FOREIGN KEY (unterkunft_id)
REFERENCES Unterkunft(id);
GO

ALTER TABLE Buchung
ADD
CONSTRAINT FK_Buchung_Reisedetail
FOREIGN KEY (reisedetail_id)
REFERENCES Reisedetail(id);
GO

ALTER TABLE Benutzer
ADD
CONSTRAINT FK_Benutzer_Adresse
FOREIGN KEY (adresse_id)
REFERENCES Adresse(id);
GO

ALTER TABLE Kunde
ADD
CONSTRAINT FK_Kunde_Benutzer
FOREIGN KEY (benutzer_id)
REFERENCES Benutzer(id);
GO

ALTER TABLE Bild_Reise
ADD
CONSTRAINT FK_Bild_Reise_Reise
FOREIGN KEY (reise_id)
REFERENCES Reise(id);
GO

ALTER TABLE Bewertung
ADD
CONSTRAINT FK_Bewertung_Buchung
FOREIGN KEY (buchung_id)
REFERENCES Buchung(reisedetail_id);
GO

ALTER TABLE Bild_Reise
ADD
CONSTRAINT FK_Bild_Reise_Bild
FOREIGN KEY (bild_id)
REFERENCES Bild(id);
GO

ALTER TABLE Bild_Unterkunft
ADD
CONSTRAINT FK_Bild_Unterkunft_Bild
FOREIGN KEY (bild_id)
REFERENCES Bild(id);
GO

ALTER TABLE Unterkunft
ADD
CONSTRAINT FK_Unterkunft_Verpflegung
FOREIGN KEY (verpflegung_id)
REFERENCES Verpflegung(id);
GO

ALTER TABLE Bild_Unterkunft
ADD
CONSTRAINT FK_Bild_Unterkunft_Unterkunft
FOREIGN KEY (unterkunft_id)
REFERENCES Unterkunft(id);
GO


