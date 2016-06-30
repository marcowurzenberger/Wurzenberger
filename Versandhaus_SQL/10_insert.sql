USE versandhaus;
GO

PRINT '';
PRINT 'Dummy Inserts';
PRINT '';

PRINT '';
PRINT 'Land anlegen';
PRINT '';
INSERT INTO land(bez) VALUES('Oesterreich');
INSERT INTO land(bez) VALUES('Frankreich');
INSERT INTO land(bez) VALUES('Deutschland');
INSERT INTO land(bez) VALUES('Italien');
INSERT INTO land(bez) VALUES('Schweiz');
GO

PRINT '';
PRINT 'Adresse anlegen';
PRINT '';
INSERT INTO adresse(land_id, ort, plz, strasse, stiege, stock, nr) VALUES(1, 'Wien', '1110', 'Simmeringer Hauptstrasse', '', '', '47-49');
INSERT INTO adresse(land_id, ort, plz, strasse, stiege, stock, nr) VALUES(2, 'Paris', '22222', 'Rue du Seine', '2', '1', '4');
INSERT INTO adresse(land_id, ort, plz, strasse, stiege, stock, nr) VALUES(3, 'Berlin', '31252', 'Riemer Strasse', '3', '', '15');
INSERT INTO adresse(land_id, ort, plz, strasse, stiege, stock, nr) VALUES(4, 'Rom', '42542', 'Via Accia', '', '', '14');
INSERT INTO adresse(land_id, ort, plz, strasse, stiege, stock, nr) VALUES(5, 'Bern', '15525', 'Hauptplatz', '', '', '5');
GO

PRINT '';
PRINT 'Kunde anlegen';
PRINT '';
INSERT INTO kunde(vorname, nachname, email) VALUES('Marc', 'Muster', 'marcmuster@itfox.at');
INSERT INTO kunde(vorname, nachname, email) VALUES('Sarah', 'Schuh', 'sarahschuh@itfox.at');
INSERT INTO kunde(vorname, nachname, email) VALUES('Michael', 'Klein', 'mklein@live.at');
INSERT INTO kunde(vorname, nachname, email) VALUES('Bernd', 'Brot', 'toastbrot@itfox.at');
GO

PRINT '';
PRINT 'Telefon anlegen';
PRINT '';
INSERT INTO telefon(vorwahl, nummer, laenderVorwahl) VALUES('676', '123456', '0043');
INSERT INTO telefon(vorwahl, nummer, laenderVorwahl) VALUES('7142', '251452', '+49');
INSERT INTO telefon(vorwahl, nummer, laenderVorwahl) VALUES('8425', '33114', '0032');
INSERT INTO telefon(vorwahl, nummer, laenderVorwahl) VALUES('4689', '89542', '0065');
INSERT INTO telefon(vorwahl, nummer, laenderVorwahl) VALUES('362', '694752', '0023');
GO

PRINT '';
PRINT 'Bestellung anlegen';
PRINT '';
INSERT INTO bestellung(anzahl) VALUES(1);
INSERT INTO bestellung(anzahl) VALUES(2);
INSERT INTO bestellung(anzahl) VALUES(3);
INSERT INTO bestellung(anzahl) VALUES(4);
INSERT INTO bestellung(anzahl) VALUES(5);
INSERT INTO bestellung(anzahl) VALUES(6);
INSERT INTO bestellung(anzahl) VALUES(7);
INSERT INTO bestellung(anzahl) VALUES(8);
INSERT INTO bestellung(anzahl) VALUES(9);
INSERT INTO bestellung(anzahl) VALUES(10);
GO

PRINT '';
PRINT 'ArtikelDetail anlegen';
PRINT '';
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('Der beste Grill aller Zeiten','Stk');
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('schmeckt süss','Pkg');
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('Teure Bonbons','Pkg');
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('Gutes vom Bauern','Stk');
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('Dosenbier vom Feinsten','Pal');
GO

PRINT '';
PRINT 'Artikel anlegen';
PRINT '';
INSERT INTO artikel(bez, preis, artikelDetail_id) VALUES('Weber Grill', 199.90, 1);
INSERT INTO artikel(bez, preis, artikelDetail_id) VALUES('Wiener Zucker', 2.50, 2);
INSERT INTO artikel(bez, preis, artikelDetail_id) VALUES('Meinl Zuckerl', 50.00, 3);
INSERT INTO artikel(bez, preis, artikelDetail_id) VALUES('Eier', 0.33, 4);
INSERT INTO artikel(bez, preis, artikelDetail_id) VALUES('Huelsinger', 20.00, 5);

GO

PRINT '';
PRINT 'AdresseKunde anlegen - Zwischentabelle';
PRINT '';
INSERT INTO adresseKunde(kunde_id, adresse_id) VALUES(1, 1);
INSERT INTO adresseKunde(kunde_id, adresse_id) VALUES(2, 1);
INSERT INTO adresseKunde(kunde_id, adresse_id) VALUES(3, 3);
INSERT INTO adresseKunde(kunde_id, adresse_id) VALUES(4, 4);
GO

PRINT '';
PRINT 'ArtikelBestellung anlegen - Zwischentabelle';
PRINT '';
INSERT INTO artikelBestellung(artikel_id, bestellung_id) VALUES(1, 1);
INSERT INTO artikelBestellung(artikel_id, bestellung_id) VALUES(2, 5);
INSERT INTO artikelBestellung(artikel_id, bestellung_id) VALUES(3, 2);
INSERT INTO artikelBestellung(artikel_id, bestellung_id) VALUES(4, 10);
INSERT INTO artikelBestellung(artikel_id, bestellung_id) VALUES(5, 3);
INSERT INTO artikelBestellung(artikel_id, bestellung_id) VALUES(2, 2);
INSERT INTO artikelBestellung(artikel_id, bestellung_id) VALUES(3, 6);
GO

PRINT '';
PRINT 'KundeBestellung anlegen - Zwischentabelle';
PRINT '';
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(1, 1);
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(2, 2);
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(3, 3);
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(4, 4);
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(2, 10);
GO

PRINT '';
PRINT 'TelefonKunde anlegen - Zwischentabelle';
PRINT '';
INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(1, 1);
INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(2, 1);
INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(3, 3);
INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(4, 4);
GO