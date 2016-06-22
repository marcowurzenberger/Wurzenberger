PRINT '';
PRINT 'Dummy Inserts';
PRINT '';

PRINT '';
PRINT 'Ort anlegen';
PRINT '';
INSERT INTO ort(bez) VALUES('Wien');
INSERT INTO ort(bez) VALUES('Paris');
INSERT INTO ort(bez) VALUES('Berlin');
INSERT INTO ort(bez) VALUES('Rom');
INSERT INTO ort(bez) VALUES('Bern');

PRINT '';
PRINT 'PLZ anlegen';
PRINT '';
INSERT INTO plz(bez, ort_id) VALUES('1110', 1);
INSERT INTO plz(bez, ort_id) VALUES('20202', 2);
INSERT INTO plz(bez, ort_id) VALUES('31313', 3);
INSERT INTO plz(bez, ort_id) VALUES('42424', 4);
INSERT INTO plz(bez, ort_id) VALUES('52525', 5);

PRINT '';
PRINT 'Land anlegen';
PRINT '';
INSERT INTO land(bez, plz_id) VALUES('Österreich', 1);
INSERT INTO land(bez, plz_id) VALUES('Frankreich', 2);
INSERT INTO land(bez, plz_id) VALUES('Deutschland', 3);
INSERT INTO land(bez, plz_id) VALUES('Italien', 4);
INSERT INTO land(bez, plz_id) VALUES('Schweiz', 5);

PRINT '';
PRINT 'Adresse anlegen';
PRINT '';
INSERT INTO adresse(land_id, strasse, stiege, stock, nr) VALUES(1, 'Simmeringer Hauptstrasse', NULL, NULL, '47');
INSERT INTO adresse(land_id, strasse, stiege, stock, nr) VALUES(2, 'Boulevard du Paris', '2', NULL, '22');
INSERT INTO adresse(land_id, strasse, stiege, stock, nr) VALUES(3, 'Riemstrasse', '3', '3', '3');
INSERT INTO adresse(land_id, strasse, stiege, stock, nr) VALUES(4, 'Via Accia', NULL, NULL, '444');
INSERT INTO adresse(land_id, strasse, stiege, stock, nr) VALUES(5, 'Schweizer Garten', '5', NULL, '55');

PRINT '';
PRINT 'Kunde anlegen';
PRINT '';
INSERT INTO kunde(vorname, nachname, email) VALUES('Marc', 'Muster', 'marcmuster@itfox.at');
INSERT INTO kunde(vorname, nachname, email) VALUES('Sarah', 'Schuh', 'sarahschuh@itfox.at');
INSERT INTO kunde(vorname, nachname, email) VALUES('Michael', 'Klein', 'mklein@live.at');
INSERT INTO kunde(vorname, nachname, email) VALUES('Bernd', 'Brot', 'toastbrot@itfox.at');

PRINT '';
PRINT 'Vorwahl anlegen';
PRINT '';
INSERT INTO vorwahl(nummer) VALUES('676');
INSERT INTO vorwahl(nummer) VALUES('741');
INSERT INTO vorwahl(nummer) VALUES('410');
INSERT INTO vorwahl(nummer) VALUES('323');

PRINT '';
PRINT 'LaenderVorwahl anlegen';
PRINT '';
INSERT INTO laenderVorwahl(nummer) VALUES('0043');
INSERT INTO laenderVorwahl(nummer) VALUES('0033');
INSERT INTO laenderVorwahl(nummer) VALUES('0049');
INSERT INTO laenderVorwahl(nummer) VALUES('0038');
INSERT INTO laenderVorwahl(nummer) VALUES('0031');

PRINT '';
PRINT 'Telefon anlegen';
PRINT '';
INSERT INTO telefon(nummer, laenderVorwahl_id, vorwahl_id) VALUES('123456', 1, 1);
INSERT INTO telefon(nummer, laenderVorwahl_id, vorwahl_id) VALUES('212121', 3, 2);
INSERT INTO telefon(nummer, laenderVorwahl_id, vorwahl_id) VALUES('369693', 2, 3);
INSERT INTO telefon(nummer, laenderVorwahl_id, vorwahl_id) VALUES('404045', 4, 4);
INSERT INTO telefon(nummer, laenderVorwahl_id, vorwahl_id) VALUES('777771', 1, 2);

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

PRINT '';
PRINT 'ArtikelDetail anlegen';
PRINT '';
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('Der beste Grill aller Zeiten','Stk');
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('schmeckt süss','Pkg');
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('Teure Bonbons','Pkg');
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('Gutes vom Bauern','Stk');
INSERT INTO artikelDetail(beschreibung, verpackungseinheit) VALUES('Dosenbier vom Feinsten','Pal');

PRINT '';
PRINT 'Artikel anlegen';
PRINT '';
INSERT INTO artikel(bez, preis, artikelDetail_id, istGeloescht) VALUES('Weber Grill', 199.90, 1, 0);
INSERT INTO artikel(bez, preis, artikelDetail_id, istGeloescht) VALUES('Wiener Zucker', 2.50, 2, 0);
INSERT INTO artikel(bez, preis, artikelDetail_id, istGeloescht) VALUES('Meinl Zuckerl', 50.00, 3, 0);
INSERT INTO artikel(bez, preis, artikelDetail_id, istGeloescht) VALUES('Eier', 0.33, 4, 0);
INSERT INTO artikel(bez, preis, artikelDetail_id, istGeloescht) VALUES('Hülsinger', 20.00, 5, 0);

PRINT '';
PRINT 'AdresseKunde anlegen - Zwischentabelle';
PRINT '';
INSERT INTO adresseKunde(kunde_id, adresse_id) VALUES(1, 1);
INSERT INTO adresseKunde(kunde_id, adresse_id) VALUES(2, 1);
INSERT INTO adresseKunde(kunde_id, adresse_id) VALUES(3, 3);
INSERT INTO adresseKunde(kunde_id, adresse_id) VALUES(4, 4);

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

PRINT '';
PRINT 'KundeBestellung anlegen - Zwischentabelle';
PRINT '';
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(1, 1);
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(2, 2);
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(3, 3);
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(4, 4);
INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(2, 10);

PRINT '';
PRINT 'TelefonKunde anlegen - Zwischentabelle';
PRINT '';
INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(1, 1);
INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(2, 1);
INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(3, 3);
INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(4, 4);
GO