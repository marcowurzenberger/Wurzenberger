USE reisebuero;
GO

INSERT INTO Land(bezeichnung) VALUES('Österreich');
INSERT INTO Land(bezeichnung) VALUES('Deutschland');
INSERT INTO Land(bezeichnung) VALUES('Italien');
INSERT INTO Land(bezeichnung) VALUES('Schweiz');
INSERT INTO Land(bezeichnung) VALUES('Frankreich');
INSERT INTO Land(bezeichnung) VALUES('Spanien');
INSERT INTO Land(bezeichnung) VALUES('Portugal');
INSERT INTO Land(bezeichnung) VALUES('Grossbritannien');
INSERT INTO Land(bezeichnung) VALUES('Belgien');
INSERT INTO Land(bezeichnung) VALUES('Schweden');

INSERT INTO Adresse(land_id, adresse)
VALUES(1, '1010 Stephansplatz 1');
INSERT INTO Adresse(land_id, adresse)
VALUES(2, '23456 Domplatz 22');
INSERT INTO Adresse(land_id, adresse)
VALUES(3, '31312 Via Roma 3');
INSERT INTO Adresse(land_id, adresse)
VALUES(4, '1452 Schweizergarten 4');
INSERT INTO Adresse(land_id, adresse)
VALUES(5, '52541 Boulevard du Paris');

INSERT INTO Benutzer(email, passwort, vorname, nachname, geschlecht, adresse_id, telefon)
VALUES('muster@itfox.at', HASHBYTES('SHA2_512', '123user!'), 'Max', 'Muster', 0, 1, 0043676123456);
INSERT INTO Benutzer(email, passwort, vorname, nachname, geschlecht, adresse_id, telefon)
VALUES('marco@itfox.at', HASHBYTES('SHA2_512', '123user!'), 'Marco', 'Wurz', 0, 2, 0049743212121);
INSERT INTO Benutzer(email, passwort, vorname, nachname, geschlecht, adresse_id, telefon)
VALUES('claudia@itfox.at', HASHBYTES('SHA2_512', '123user!'), 'Claudia', 'Stiegl', 1, 3, 003256124565);
INSERT INTO Benutzer(email, passwort, vorname, nachname, geschlecht, adresse_id, telefon)
VALUES('daniel@itfox.at', HASHBYTES('SHA2_512', '123user!'), 'Daniel', 'Zalli', 0, 4, 00396123456);
INSERT INTO Benutzer(email, passwort, vorname, nachname, geschlecht, adresse_id, telefon)
VALUES('stefan@itfox.at', HASHBYTES('SHA2_512', '123user!'), 'Stefan', 'Groig', 0, 5, 0055236458);

INSERT INTO Kunde(benutzer_id, geburtsdatum, titel, land_id)
VALUES(1, '1990/1/1', 'Mag.', 1);
INSERT INTO Kunde(benutzer_id, geburtsdatum, titel, land_id)
VALUES(2, '1989/3/8', '', 1);
INSERT INTO Kunde(benutzer_id, geburtsdatum, titel, land_id)
VALUES(4, '1991/12/12', 'Dr.', 3);

INSERT INTO Mitarbeiter(benutzer_id, svnr) VALUES(3, 1234);
INSERT INTO Mitarbeiter(benutzer_id, svnr) VALUES(5, 1470);

INSERT INTO Verpflegung(bezeichnung) VALUES('Ohne Verpflegung');
INSERT INTO Verpflegung(bezeichnung) VALUES('Frühstück');
INSERT INTO Verpflegung(bezeichnung) VALUES('Halbpension');
INSERT INTO Verpflegung(bezeichnung) VALUES('Vollpension');
INSERT INTO Verpflegung(bezeichnung) VALUES('All Inclusive');

INSERT INTO Unterkunft(bezeichnung, beschreibung, kategorie, verpflegung_id)
VALUES('Hotel Arosa', 'Dieses Hotel bietet außergewöhnlichen Komfort', 4, 4);
INSERT INTO Unterkunft(bezeichnung, beschreibung, kategorie, verpflegung_id)
VALUES('Hotel de Croissant', 'Dieses Hotel schmeckt nach Croissants', 3, 2);
INSERT INTO Unterkunft(bezeichnung, beschreibung, kategorie, verpflegung_id)
VALUES('Pension Pomp', 'Luxus in seiner schönsten Form', 5, 5);
INSERT INTO Unterkunft(bezeichnung, beschreibung, kategorie, verpflegung_id)
VALUES('Almhütte zum Sepp', 'Gute urige Küche und Jausen', 2, 1);
INSERT INTO Unterkunft(bezeichnung, beschreibung, kategorie, verpflegung_id)
VALUES('Hotel Allin', 'Dieses Hotel bietet alles außer Vollpension', 4, 3);

INSERT INTO Reise(titel, beschreibung, unterkunft_id, preis_erwachsener, preis_kind)
VALUES('Wandern in den Bergen', 'Erleben Sie die schöne Bergwelt in Österreich', 4, 65.99, 32.99);
INSERT INTO Reise(titel, beschreibung, unterkunft_id, preis_erwachsener, preis_kind)
VALUES('Wellnes pur', 'Genießen Sie italienische Luft und Wellnes vom Feinsten', 1, 150.00, 75.00);
INSERT INTO Reise(titel, beschreibung, unterkunft_id, preis_erwachsener, preis_kind)
VALUES('Fußball pur', 'Fahren Sie zum EM-Finale nach Paris!', 2, 199.99, 99.99);
INSERT INTO Reise(titel, beschreibung, unterkunft_id, preis_erwachsener, preis_kind)
VALUES('Urlaub der Creme de la Creme', 'Verbleiben Sie in einem unserer 4000 Zimmer', 3, 259.90, 129.90);
INSERT INTO Reise(titel, beschreibung, unterkunft_id, preis_erwachsener, preis_kind)
VALUES('Pokern wie die Pros', 'Fahren Sie zur World Pokers Tour nach Las Vegas!', 5, 1200.00, 600.00);

INSERT INTO Reisedetail(reise_id, startdatum, enddatum, anmeldefrist)
VALUES(1, '2016-31-07', '2016-06-08', '2016-30-06');
INSERT INTO Reisedetail(reise_id, startdatum, enddatum, anmeldefrist)
VALUES(2, '2016-01-12', '2016-06-12', '2016-10-11');
INSERT INTO Reisedetail(reise_id, startdatum, enddatum, anmeldefrist)
VALUES(3, '2016-25-07', '2016-30-07', '2016-15-06');
INSERT INTO Reisedetail(reise_id, startdatum, enddatum, anmeldefrist)
VALUES(4, '2017-07-01', '2017-21-01', '2016-23-12');
INSERT INTO Reisedetail(reise_id, startdatum, enddatum, anmeldefrist)
VALUES(5, '2017-01-03', '2017-15-03', '2017-02-02');

INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\1_hotel_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\2_hotel_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\3_hotel_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\4_hotel_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\5_hotel_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\1_reise_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\2_reise_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\3_reise_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\4_reise_test.jpg', Single_Blob) 
AS import;
GO
INSERT INTO Bild (bild)
SELECT *
FROM Openrowset( 
Bulk 'C:\ITIN20AKT\Datenbank\reisebuero_skripten_datenbank\testimages\5_reise_test.jpg', Single_Blob) 
AS import;
GO

INSERT INTO Buchung(reisedetail_id, kunde_id) VALUES(1, 1);
INSERT INTO Buchung(reisedetail_id, kunde_id) VALUES(2, 2);
INSERT INTO Buchung(reisedetail_id, kunde_id) VALUES(3, 3);
GO

INSERT INTO Bewertung(bewertung, buchung_id) VALUES(5,1);
INSERT INTO Bewertung(bewertung, buchung_id) VALUES(3,2);
INSERT INTO Bewertung(bewertung, buchung_id) VALUES(4,3);

INSERT INTO Bild_Reise(bild_id, reise_id) VALUES(1, 1);
INSERT INTO Bild_Reise(bild_id, reise_id) VALUES(2, 2);
INSERT INTO Bild_Reise(bild_id, reise_id) VALUES(3, 3);
INSERT INTO Bild_Reise(bild_id, reise_id) VALUES(4, 4);
INSERT INTO Bild_Reise(bild_id, reise_id) VALUES(5, 5);
GO

INSERT INTO Bild_Unterkunft(unterkunft_id, bild_id) VALUES(1, 6);
INSERT INTO Bild_Unterkunft(unterkunft_id, bild_id) VALUES(2, 7);
INSERT INTO Bild_Unterkunft(unterkunft_id, bild_id) VALUES(3, 8);
INSERT INTO Bild_Unterkunft(unterkunft_id, bild_id) VALUES(4, 9);
INSERT INTO Bild_Unterkunft(unterkunft_id, bild_id) VALUES(5, 10);