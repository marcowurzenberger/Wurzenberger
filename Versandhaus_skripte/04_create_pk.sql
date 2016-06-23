USE versandhaus;
GO
ALTER TABLE artikel ADD CONSTRAINT pk_artikel PRIMARY KEY (id);
GO
ALTER TABLE bestellung ADD CONSTRAINT pk_bestellung PRIMARY KEY (id);
GO
ALTER TABLE kunde ADD CONSTRAINT pk_kunde PRIMARY KEY (id);
GO
ALTER TABLE adresse ADD CONSTRAINT pk_adresse PRIMARY KEY (id);
GO
ALTER TABLE land ADD CONSTRAINT pk_land PRIMARY KEY (id);
GO
ALTER TABLE telefon ADD CONSTRAINT pk_telefon PRIMARY KEY (id);
GO
ALTER TABLE artikelDetail ADD CONSTRAINT pk_artikelDetail PRIMARY KEY (id);
GO
ALTER TABLE artikelBestellung ADD CONSTRAINT pk_artikelBestellung PRIMARY KEY (id);
GO
ALTER TABLE kundeBestellung ADD CONSTRAINT pk_kundeBestellung PRIMARY KEY (id);
GO
ALTER TABLE telefonKunde ADD CONSTRAINT pk_telefonKunde PRIMARY KEY (id);
GO
ALTER TABLE adresseKunde ADD CONSTRAINT pk_adresseKunde PRIMARY KEY (id);
GO
ALTER TABLE artikelGeloescht ADD CONSTRAINT pk_artikelGeloescht PRIMARY KEY (id);
GO