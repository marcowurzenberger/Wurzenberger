USE versandhaus;
GO
--------------------------------------------------------------
-- Alle aktuellen Artikel auflisten (keine gelöschten Artikel)
---------------------------------------------------------------
CREATE VIEW AktuelleArtikelAnzeigen
AS
SELECT	a.bez,
		a.preis,
		ad.beschreibung,
		ad.verpackungseinheit,
		a.erstellDatum
	FROM artikel AS a
		JOIN artikelDetail AS ad
			ON ad.id = a.artikelDetail_id
		LEFT JOIN artikelGeloescht AS ag
			ON ag.artikel_id = a.id
	WHERE NOT a.id = ag.artikel_id;
GO
---------------------------------------------------------------
-- Alle Kunden mit Telefonnummern anzeigen
---------------------------------------------------------------
CREATE VIEW KundenAnzeigen
AS
SELECT	k.vorname,
		k.nachname,
		k.email,
		t.laenderVorwahl,
		t.vorwahl,
		t.nummer
FROM kunde AS k
	JOIN telefonKunde AS tk
		ON tk.kunde_id = k.id
	JOIN telefon AS t
		ON t.id = tk.telefon_id;
GO
---------------------------------------------------------------
--Alle Bestellungen mit dazugehörigen Kunden und Gesamtsumme
---------------------------------------------------------------
CREATE VIEW BestellungenAnzeigen
AS
SELECT	k.vorname,
		k.nachname,
		a.bez,
		a.preis,
		b.anzahl,
		a.preis * b.anzahl AS Gesamtsumme
FROM bestellung AS b
	JOIN kundeBestellung AS kb
		ON kb.bestellung_id = b.id
	JOIN kunde AS k
		ON k.id = kb.kunde_id
	JOIN artikelBestellung AS ab
		ON ab.bestellung_id = b.id
	JOIN artikel AS a
		ON a.id = ab.artikel_id;
GO
---------------------------------------------------------------
-- Alle Adressen anzeigen, die sich in 
-- einem vorgegebenen Land befinden
---------------------------------------------------------------
CREATE FUNCTION AdresseNachLandAnzeigen(@land NVARCHAR(50))
	RETURNS @retTable TABLE (strasse NVARCHAR(50), stiege NVARCHAR(10), stock NVARCHAR(10), nr NVARCHAR(10))
AS
BEGIN
			INSERT INTO @retTable(strasse, stiege, stock, nr)
			SELECT	a.strasse, a.stiege, a.stock, a.nr
			FROM adresse AS a
				JOIN land AS l
					ON a.land_id = l.id
			WHERE l.bez = @land;
	RETURN;
END
GO

---------------------------------------------------------------
-- Einen neuen Artikel anlegen
---------------------------------------------------------------
CREATE PROCEDURE NeuenArtikelAnlegen
		@bezeichnung NVARCHAR(50),
		@preis DECIMAL(6,2),
		@verpackungseinheit NVARCHAR(5),
		@beschreibung NVARCHAR(4000)
AS
BEGIN
	DECLARE @error INT = 0;
	DECLARE @artikelDetail_id INT = 0;

	WHILE(@error = 0)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION t_1;
			IF(RTRIM(LTRIM(@bezeichnung)) = '') 
			BEGIN
				SET @error = -1;
				BREAK;
			END
			ELSE IF(RTRIM(LTRIM(@preis)) = '')
			BEGIN
				SET @error = -2;
				BREAK;
			END
			ELSE IF(RTRIM(LTRIM(@verpackungseinheit)) = '')
			BEGIN
				SET @error = -3;
				BREAK;
			END
			ELSE IF(RTRIM(LTRIM(@beschreibung)) = '')
			BEGIN
				SET @error = -4;
				BREAK;
			END

			INSERT INTO artikelDetail(beschreibung, verpackungseinheit)
			VALUES(@beschreibung, @verpackungseinheit);

			SET @artikelDetail_id = SCOPE_IDENTITY();

			INSERT INTO artikel(bez, preis, artikelDetail_id)
			VALUES(@bezeichnung, @preis, @artikelDetail_id);

			SET @error = 1;
			COMMIT TRANSACTION t_1;
		END TRY

		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t keine Bezeichnung angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t keinen Preis angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Verpackungseinheit angegeben!';
			--ELSE IF(@error = -4) PRINT 'Fehlercode ' + @error + '\t keine Beschreibung angegeben!';
			ROLLBACK TRANSACTION t_1;
		END CATCH

	END
	RETURN;
END
GO
---------------------------------------------------------------
-- Eine neue Adresse anlegen
---------------------------------------------------------------
CREATE PROCEDURE NeueAdresseAnlegen
		@land NVARCHAR(50),
		@ort NVARCHAR(50),
		@plz NVARCHAR(10),
		@strasse NVARCHAR(50),
		@stiege NVARCHAR(10),
		@stock NVARCHAR(10),
		@nummer NVARCHAR(10)
AS
BEGIN
	DECLARE @error INT = 0;
	DECLARE @foundLand NVARCHAR(50) = '';
	DECLARE @landId INT = 0;

WHILE( @error = 0 )
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION t_2;
		IF(RTRIM(LTRIM(@land)) = '')
		BEGIN
			SET @error = -1;
			BREAK;
		END
		ELSE IF(RTRIM(LTRIM(@ort)) = '')
		BEGIN
			SET @error = -2;
			BREAK;
		END
		ELSE IF(RTRIM(LTRIM(@plz)) = '')
		BEGIN
			SET @error = -3;
			BREAK;
		END
		ELSE IF(RTRIM(LTRIM(@strasse)) = '')
		BEGIN
			SET @error = -4;
			BREAK;
		END
		ELSE IF(RTRIM(LTRIM(@nummer)) = '')
		BEGIN
			SET @error = -5;
			BREAK;
		END

		SELECT TOP 1 @foundLand = land.bez
		FROM land
		WHERE land.bez = @land;

		IF (@foundLand = '')
		BEGIN
			INSERT INTO land(bez) VALUES(@land);

			SET @landId = SCOPE_IDENTITY();

			INSERT INTO adresse(land_id, ort, plz, strasse, stiege, stock, nr)
			VALUES(@landId, @ort, @plz, @strasse, @stiege, @stock, @nummer);
		END
		ELSE
		BEGIN
			SELECT TOP 1 @landId = land.bez FROM land WHERE @land = land.bez;

			INSERT INTO adresse(land_id, ort, plz, strasse, stiege, stock, nr)
			VALUES(@landId, @ort, @plz, @strasse, @stiege, @stock, @nummer);
		END

		SET @error = 1;
		COMMIT TRANSACTION t_2;
	END TRY
	BEGIN CATCH
		--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t kein Land angegeben!';
		--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t kein Ort angegeben!';
		--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t kein PLZ angegeben!';
		--ELSE IF(@error = -4) PRINT 'Fehlercode ' + @error + '\t keine Strasse angegeben!';
		--ELSE IF(@error = -5) PRINT 'Fehlercode ' + @error + '\t keine Nummer angegeben!';
		ROLLBACK TRANSACTION t_2;
	END CATCH
END
RETURN; 
END
GO
---------------------------------------------------------------
-- Einen neuen Kunden anlegen
---------------------------------------------------------------
CREATE PROCEDURE NeuenKundenAnlegen
		@vorname NVARCHAR(50),
		@nachname NVARCHAR(50),
		@email NVARCHAR(50)
AS
BEGIN
	DECLARE @error INT = 0;

	WHILE(@error = 0)
	BEGIN

		BEGIN TRY
		BEGIN TRANSACTION t_3;
			IF(LTRIM(RTRIM(@vorname)) = '')
			BEGIN
				SET @error = -1;
				BREAK;
			END
			ELSE IF(LTRIM(RTRIM(@nachname)) = '')
			BEGIN
				SET @error = -2;
				BREAK;
			END
			ELSE IF(LTRIM(RTRIM(@email)) = '')
			BEGIN
				SET @error = -3;
				BREAK;
			END

			INSERT INTO kunde(vorname, nachname, email) VALUES(@vorname, @nachname, @email);
			SET @error = 1;
			COMMIT TRANSACTION t_3;
		END TRY
		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t kein Vorname angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t kein Nachname angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Email angegeben!';
			ROLLBACK TRANSACTION t_3;
		END CATCH
	END
RETURN;
END
GO
---------------------------------------------------------------
-- Eine neue Bestellung anhand von Artikelname, Kundennummer
-- und Anzahl anlegen
---------------------------------------------------------------
CREATE PROCEDURE NeueBestellungAnlegen
		@artikel NVARCHAR(50),
		@kundenNr INT,
		@anzahl INT
AS
BEGIN
	DECLARE @error INT = 0;
	DECLARE @bestellungId INT = 0;
	DECLARE @artikelId INT = 0;

	WHILE(@error = 0)
	BEGIN
		BEGIN TRY
		BEGIN TRANSACTION t_4;

		IF(LTRIM(RTRIM(@artikel)) = '')
		BEGIN
			SET @error = -1;
			BREAK;
		END
		ELSE IF(LTRIM(RTRIM(@kundenNr)) = 0)
		BEGIN
			SET @error = -2;
			BREAK;
		END
		ELSE IF(LTRIM(RTRIM(@anzahl)) = 0)
		BEGIN
			SET @error = -3;
			BREAK;
		END

		INSERT INTO bestellung(anzahl) VALUES(@anzahl);
		SET @bestellungId = SCOPE_IDENTITY();

		INSERT INTO kundeBestellung(kunde_id, bestellung_id) VALUES(@kundenNr, @bestellungId);

		SELECT TOP 1 @artikelId = id
		FROM artikel
		WHERE bez = @artikel;

		INSERT INTO artikelBestellung(artikel_id, bestellung_id) VALUES(@artikelId, @bestellungId);
		
		SET @error = 1;
		COMMIT TRANSACTION t_4;
		END TRY

		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t kein Artikel angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t keine Kundennummer angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Anzahl angegeben!';
			ROLLBACK TRANSACTION t_4;
		END CATCH

	END
	RETURN;
END
GO
---------------------------------------------------------------
-- Eine neue Telefonnummer für einen bestimmten Kunden anlegen
---------------------------------------------------------------
CREATE PROCEDURE NeueTelNummerFuerKundeAnlegen
		@vorwahl NVARCHAR(10),
		@laenderVorwahl NVARCHAR(10),
		@nummer NVARCHAR(20),
		@kundenNr INT
AS
BEGIN
	DECLARE @error INT = 0;
	DECLARE @telId INT = 0;

	WHILE(@error = 0)
	BEGIN
		BEGIN TRY
		BEGIN TRANSACTION t_5;

		IF(LTRIM(RTRIM(@vorwahl)) = '')
		BEGIN
			SET @error = -1;
			BREAK;
		END
		ELSE IF(LTRIM(RTRIM(@laenderVorwahl)) = '')
		BEGIN
			SET @error = -2;
			BREAK;
		END
		ELSE IF(LTRIM(RTRIM(@nummer)) = '')
		BEGIN
			SET @error = -3;
			BREAK;
		END
		ELSE IF(LTRIM(RTRIM(@kundenNr)) = '')
		BEGIN
			SET @error = -4;
			BREAK;
		END

		INSERT INTO telefon(vorwahl, laenderVorwahl, nummer) VALUES(@vorwahl, @laenderVorwahl, @nummer);
		SET @telId = SCOPE_IDENTITY();

		INSERT INTO telefonKunde(kunde_id, telefon_id) VALUES(@kundenNr, @telId);

		SET @error = 1;
		COMMIT TRANSACTION t_5;
		END TRY

		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t keine Vorwahl angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t keine Laendervorwahl angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Nummer angegeben!';
			--ELSE IF(@error = -4) PRINT 'Fehlercode ' + @error + '\t keine Kundennummer angegeben!';
			ROLLBACK TRANSACTION t_5;
		END CATCH
	END
	RETURN;
END
GO
---------------------------------------------------------------
-- Eine neue Adresse mit dazugehörigem Kunden anlegen
---------------------------------------------------------------
CREATE PROCEDURE NeueAdresseMitKundenAnlegen
		@vorname NVARCHAR(50),
		@nachname NVARCHAR(50),
		@email NVARCHAR(50),
		@land NVARCHAR(50),
		@ort NVARCHAR(50),
		@plz NVARCHAR(10),
		@strasse NVARCHAR(50),
		@stiege NVARCHAR(10),
		@stock NVARCHAR(10),
		@nummer NVARCHAR(10)
AS
BEGIN
	DECLARE @error INT = 0;
	DECLARE @foundLand NVARCHAR(50) = '';
	DECLARE @landId INT = 0;

	WHILE(@error = 0)
	BEGIN

		BEGIN TRY
			BEGIN TRANSACTION t_6;

			IF(LTRIM(RTRIM(@vorname)) = '')
			BEGIN
				SET @error = -1;
				BREAK;
			END
			ELSE IF(LTRIM(RTRIM(@nachname)) = '')
			BEGIN
				SET @error = -2;
				BREAK;
			END
			ELSE IF(LTRIM(RTRIM(@email)) = '')
			BEGIN
				SET @error = -3;
				BREAK;
			END
			ELSE IF(RTRIM(LTRIM(@land)) = '')
			BEGIN
				SET @error = -4;
				BREAK;
			END
			ELSE IF(RTRIM(LTRIM(@ort)) = '')
			BEGIN
				SET @error = -5;
				BREAK;
			END
			ELSE IF(RTRIM(LTRIM(@plz)) = '')
			BEGIN
				SET @error = -6;
				BREAK;
			END
			ELSE IF(RTRIM(LTRIM(@strasse)) = '')
			BEGIN
				SET @error = -7;
				BREAK;
			END
			ELSE IF(RTRIM(LTRIM(@nummer)) = '')
			BEGIN
				SET @error = -8;
				BREAK;
			END


			INSERT INTO kunde(vorname, nachname, email) VALUES(@vorname, @nachname, @email);
			SET @error = 1;
			COMMIT TRANSACTION t_6;
		END TRY
		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t kein Vorname angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t kein Nachname angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Email angegeben!';
			ROLLBACK TRANSACTION t_6;
		END CATCH
	END
	RETURN;
END
GO
---------------------------------------------------------------
-- Einen Artikel als geloescht eintragen
---------------------------------------------------------------
CREATE PROCEDURE ArtikelLoeschenId
		@artikelId INT
AS
BEGIN
	DECLARE @error INT = 0;

	WHILE(@error = 0)
	BEGIN
		
		BEGIN TRY
		BEGIN TRANSACTION t_7;
			IF(@artikelId = 0)
			BEGIN
				SET @error = -1;
				BREAK;
			END

			INSERT INTO artikelGeloescht(artikel_id) VALUES(@artikelId);

			SET @error = 1;
			COMMIT TRANSACTION t_7;
		END TRY

		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t keine ArtikelID angegeben!';
			ROLLBACK TRANSACTION t_7;
		END CATCH
	END
RETURN;
END
GO
---------------------------------------------------------------
-- Eine Bestellung als storniert anlegen
---------------------------------------------------------------
CREATE PROCEDURE BestellungStornieren
		@bestellungId INT
AS
BEGIN
	DECLARE @error INT = 0;

	WHILE(@error = 0)
	BEGIN

		BEGIN TRY
			BEGIN TRANSACTION t_8

			IF(@bestellungId = 0)
			BEGIN
				SET @error = -1;
				BREAK;
			END

			INSERT INTO bestellungStorniert(bestellung_id) VALUES(@bestellungId);

			SET @error = 1;
			COMMIT TRANSACTION t_8
		END TRY
		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t keine BestellungsID angegeben!';
			ROLLBACK TRANSACTION t_8
		END CATCH

	END
RETURN;
END
GO
---------------------------------------------------------------
-- Einen Artikel anhand der Bezeichnung loeschen
---------------------------------------------------------------