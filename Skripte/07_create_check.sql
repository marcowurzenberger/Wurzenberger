ALTER TABLE Unterkunft
ADD
CONSTRAINT ck_kategorie
CHECK ( kategorie >= 0 AND kategorie <= 5 );