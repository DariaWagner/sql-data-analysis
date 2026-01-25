-- Dimension: Datum
CREATE TABLE dim_datum (
    datum_id INTEGER PRIMARY KEY,
    datum DATE,
    jahr INTEGER,
    monat INTEGER,
    tag INTEGER
);

-- Dimension: Unternehmen
CREATE TABLE dim_unternehmen (
    unternehmen_id INTEGER PRIMARY KEY,
    unternehmen_name TEXT
);

-- Dimension: Produkt
CREATE TABLE dim_produkt (
    produkt_id INTEGER PRIMARY KEY,
    produkt_name TEXT,
    modifikation TEXT
);

-- Dimension: Produktionslinie
CREATE TABLE dim_produktionslinie (
    linie_id INTEGER PRIMARY KEY,
    produktionslinie TEXT
);

-- Dimension: Schicht
CREATE TABLE dim_schicht (
    schicht_id INTEGER PRIMARY KEY,
    schicht_name TEXT
);

-- Dimension: Software
CREATE TABLE dim_software (
    software_id INTEGER PRIMARY KEY,
    softwareversion TEXT,
    firmwareversion TEXT
);

-- Faktentabelle: Produktion
CREATE TABLE fact_produktion (
    produktion_id INTEGER PRIMARY KEY,

    datum_id INTEGER,
    unternehmen_id INTEGER,
    produkt_id INTEGER,
    linie_id INTEGER,
    schicht_id INTEGER,
    software_id INTEGER,

    auftragsnummer TEXT,
    status TEXT,
    fehlercode TEXT,

    stueckzahl INTEGER,
    ausschuss INTEGER,
    betriebsstunden REAL,
    stillstandszeit_min INTEGER,
    materialkosten REAL,
    energieverbrauch_kwh REAL,
    mitarbeiter_produktion INTEGER,

    maxtemperatur REAL,
    durchschnittstemperatur REAL,
    endofline_test TEXT
);
