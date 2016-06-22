ALTER TABLE artikel ADD CONSTRAINT fk_artikel_artikelDetail
FOREIGN KEY( artikelDetail_id )
REFERENCES artikelDetail(id);

ALTER TABLE adresse ADD CONSTRAINT fk_adresse_land
FOREIGN KEY( land_id )
REFERENCES land(id);

ALTER TABLE land ADD CONSTRAINT fk_land_plz
FOREIGN KEY( plz_id )
REFERENCES plz(id);

ALTER TABLE plz ADD CONSTRAINT fk_plz_ort
FOREIGN KEY( ort_id )
REFERENCES ort(id);

ALTER TABLE telefon ADD CONSTRAINT fk_telefon_vorwahl
FOREIGN KEY( vorwahl_id )
REFERENCES vorwahl(id);

ALTER TABLE telefon ADD CONSTRAINT fk_telefon_laenderVorwahl
FOREIGN KEY( laenderVorwahl_id )
REFERENCES laenderVorwahl(id);

ALTER TABLE artikelBestellung ADD CONSTRAINT fk_artikelBestellung_artikel
FOREIGN KEY( artikel_id )
REFERENCES artikel(id);

ALTER TABLE artikelBestellung ADD CONSTRAINT fk_artikelBestellung_bestellung
FOREIGN KEY( bestellung_id )
REFERENCES bestellung(id);

ALTER TABLE kundeBestellung ADD CONSTRAINT fk_kundeBestellung_kunde
FOREIGN KEY( kunde_id )
REFERENCES kunde(id);

ALTER TABLE kundeBestellung ADD CONSTRAINT fk_kundeBestellung_bestellung
FOREIGN KEY( bestellung_id )
REFERENCES bestellung(id);

ALTER TABLE telefonKunde ADD CONSTRAINT fk_telefonKunde_telefon
FOREIGN KEY( telefon_id )
REFERENCES telefon(id);

ALTER TABLE telefonKunde ADD CONSTRAINT fk_telefonKunde_kunde
FOREIGN KEY( kunde_id )
REFERENCES kunde(id);

ALTER TABLE adresseKunde ADD CONSTRAINT fk_adresseKunde_adresse
FOREIGN KEY( adresse_id )
REFERENCES adresse(id);

ALTER TABLE adresseKunde ADD CONSTRAINT fk_adresseKunde_kunde
FOREIGN KEY( kunde_id )
REFERENCES kunde(id);

GO