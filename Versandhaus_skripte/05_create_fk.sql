USE versandhaus;
GO

ALTER TABLE artikel ADD CONSTRAINT fk_artikel_artikelDetail
FOREIGN KEY( artikelDetail_id )
REFERENCES artikelDetail(id);
GO

ALTER TABLE adresse ADD CONSTRAINT fk_adresse_land
FOREIGN KEY( land_id )
REFERENCES land(id);
GO

ALTER TABLE artikelBestellung ADD CONSTRAINT fk_artikelBestellung_artikel
FOREIGN KEY( artikel_id )
REFERENCES artikel(id);
GO

ALTER TABLE artikelBestellung ADD CONSTRAINT fk_artikelBestellung_bestellung
FOREIGN KEY( bestellung_id )
REFERENCES bestellung(id);
GO

ALTER TABLE kundeBestellung ADD CONSTRAINT fk_kundeBestellung_kunde
FOREIGN KEY( kunde_id )
REFERENCES kunde(id);
GO

ALTER TABLE kundeBestellung ADD CONSTRAINT fk_kundeBestellung_bestellung
FOREIGN KEY( bestellung_id )
REFERENCES bestellung(id);
GO

ALTER TABLE telefonKunde ADD CONSTRAINT fk_telefonKunde_telefon
FOREIGN KEY( telefon_id )
REFERENCES telefon(id);
GO

ALTER TABLE telefonKunde ADD CONSTRAINT fk_telefonKunde_kunde
FOREIGN KEY( kunde_id )
REFERENCES kunde(id);
GO

ALTER TABLE adresseKunde ADD CONSTRAINT fk_adresseKunde_adresse
FOREIGN KEY( adresse_id )
REFERENCES adresse(id);
GO

ALTER TABLE adresseKunde ADD CONSTRAINT fk_adresseKunde_kunde
FOREIGN KEY( kunde_id )
REFERENCES kunde(id);
GO