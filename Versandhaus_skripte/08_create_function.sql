USE versandhaus;
GO

CREATE FUNCTION AdresseNachLandAnzeigen(@land NVARCHAR(50))
	RETURNS @retTable TABLE (strasse NVARCHAR(50), stiege NVARCHAR(10), stock NVARCHAR(10), nr NVARCHAR(10))
AS
BEGIN
	DECLARE @error INT = 0

	IF(LTRIM(RTRIM(@land)) = '')
	BEGIN
		SET @error = -1;
	END
	
	ELSE
	BEGIN
		INSERT INTO @retTable(strasse, stiege, stock, nr)
		SELECT	a.strasse, a.stiege, a.stock, a.nr
		FROM adresse AS a
			JOIN land AS l
				ON a.land_id = l.id
		WHERE l.bez = @land

		SET @error = 1;
	END
	RETURN;
END
GO

CREATE FUNCTION ArtikelAnzeigenAktuell()
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
		JOIN artikelGeloescht AS ag
			ON ag.artikel_id = a.id
	WHERE a.istGeloescht = 0
	ORDER BY a.erstellDatum DESC;

	SELECT @rowCount = COUNT(*) FROM @retTable;

	IF(@rowCount = 0) SET @error = -1;
	SET @error = 1;
	RETURN;
END
GO