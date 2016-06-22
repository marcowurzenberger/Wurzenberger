ALTER TABLE artikel ADD CONSTRAINT pk_artikel PRIMARY KEY (id);
ALTER TABLE bestellung ADD CONSTRAINT pk_bestellung PRIMARY KEY (id);
ALTER TABLE kunde ADD CONSTRAINT pk_kunde PRIMARY KEY (id);
ALTER TABLE adresse ADD CONSTRAINT pk_adresse PRIMARY KEY (id);
ALTER TABLE land ADD CONSTRAINT pk_land PRIMARY KEY (id);
ALTER TABLE telefon ADD CONSTRAINT pk_telefon PRIMARY KEY (id);
ALTER TABLE vorwahl ADD CONSTRAINT pk_vorwahl PRIMARY KEY (id);
ALTER TABLE laenderVorwahl ADD CONSTRAINT pk_laenderVorwahl PRIMARY KEY (id);
ALTER TABLE artikelDetail ADD CONSTRAINT pk_artikelDetail PRIMARY KEY (id);
ALTER TABLE artikelBestellung ADD CONSTRAINT pk_artikelBestellung PRIMARY KEY (id);
ALTER TABLE kundeBestellung ADD CONSTRAINT pk_kundeBestellung PRIMARY KEY (id);
ALTER TABLE plz ADD CONSTRAINT pk_plz PRIMARY KEY (id);
ALTER TABLE ort ADD CONSTRAINT pk_ort PRIMARY KEY (id);
ALTER TABLE telefonKunde ADD CONSTRAINT pk_telefonKunde PRIMARY KEY (id);
ALTER TABLE adresseKunde ADD CONSTRAINT pk_adresseKunde PRIMARY KEY (id);
GO