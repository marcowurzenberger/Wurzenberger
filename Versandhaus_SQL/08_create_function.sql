USE versandhaus;
GO

CREATE FUNCTION AdresseNachLandAnzeigen(@land NVARCHAR(50))
	RETURNS @retTable TABLE (strasse NVARCHAR(50), stiege NVARCHAR(10), stock NVARCHAR(10), nr NVARCHAR(10))
AS
BEGIN
	DECLARE @error INT = 0
	
	WHILE(@error = 0)
	BEGIN
		BEGIN TRY
			
			IF(LTRIM(RTRIM(@land)) = '') SET @error = -1;

			INSERT INTO @retTable(strasse, stiege, stock, nr)
			SELECT	a.strasse, a.stiege, a.stock, a.nr
			FROM adresse AS a
				JOIN land AS l
					ON a.land_id = l.id
			WHERE l.bez = @land

			SET @error = 1;
			
		END TRY
		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + ' Kein Land angegeben!';
			--ELSE PRINT 'Unerwarteter Fehler aufgetreten!';
		END CATCH
	END
	RETURN;
END
GO

CREATE FUNCTION AktuelleArtikelAnzeigen()
	RETURNS @retTable TABLE (bezeichnung NVARCHAR(50), preis DECIMAL(6,2), beschreibung NVARCHAR(MAX), verpackungseinheit NVARCHAR(5))
AS
BEGIN
	DECLARE @rowCount INT = 0;
	DECLARE @error INT = 0;

	INSERT INTO @retTable (bezeichnung, preis, beschreibung, verpackungseinheit)
	SELECT	a.bez,
			a.preis,
			ad.beschreibung,
			ad.verpackungseinheit
	FROM artikel AS a
		JOIN artikelDetail AS ad
			ON ad.id = a.artikelDetail_id
	WHERE a.artikelGeloescht = 0
	ORDER BY a.erstellDatum DESC;

	SELECT @rowCount = COUNT(*) FROM @retTable;

	IF(@rowCount = 0) SET @error = -1;
	SET @error = 1;
	RETURN;
END
GO

CREATE PROCEDURE NeuenArtikelAnlegen
		@bezeichnung NVARCHAR(50),
		@preis DECIMAL(6,2),
		@verpackungseinheit NVARCHAR(5),
		@beschreibung NVARCHAR(MAX)
AS
BEGIN
	DECLARE @error INT = 0;
	DECLARE @artikelDetail_id INT = 0;

	WHILE(@error = 0)
	BEGIN
		BEGIN TRY
		
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
		END TRY

		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t keine Bezeichnung angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t keinen Preis angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Verpackungseinheit angegeben!';
			--ELSE IF(@error = -4) PRINT 'Fehlercode ' + @error + '\t keine Beschreibung angegeben!';
		END CATCH

	END
	RETURN;
END
GO

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
	END TRY
	BEGIN CATCH
		--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t kein Land angegeben!';
		--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t kein Ort angegeben!';
		--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t kein PLZ angegeben!';
		--ELSE IF(@error = -4) PRINT 'Fehlercode ' + @error + '\t keine Strasse angegeben!';
		--ELSE IF(@error = -5) PRINT 'Fehlercode ' + @error + '\t keine Nummer angegeben!';
	END CATCH
END
RETURN; 
END
GO

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
		END TRY
		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t kein Vorname angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t kein Nachname angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Email angegeben!';
		END CATCH
	END
RETURN;
END
GO

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
		END TRY

		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t kein Artikel angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t keine Kundennummer angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Anzahl angegeben!';
		END CATCH

	END
	RETURN;
END
GO

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
		END TRY

		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t keine Vorwahl angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t keine Laendervorwahl angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Nummer angegeben!';
			--ELSE IF(@error = -4) PRINT 'Fehlercode ' + @error + '\t keine Kundennummer angegeben!';
		END CATCH
	END
	RETURN;
END
GO

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
		END TRY
		BEGIN CATCH
			--IF(@error = -1) PRINT 'Fehlercode ' + @error + '\t kein Vorname angegeben!';
			--ELSE IF(@error = -2) PRINT 'Fehlercode ' + @error + '\t kein Nachname angegeben!';
			--ELSE IF(@error = -3) PRINT 'Fehlercode ' + @error + '\t keine Email angegeben!';
		END CATCH

	RETURN;
END
GO