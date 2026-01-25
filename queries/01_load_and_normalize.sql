/* ===============================
   1. Dimension: Datum
   =============================== */

INSERT INTO dim_datum (datum_id, datum, jahr, monat, tag)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY Datum) AS datum_id,
    Datum,
    EXTRACT(YEAR FROM Datum) AS jahr,
    EXTRACT(MONTH FROM Datum) AS monat,
    EXTRACT(DAY FROM Datum) AS tag
FROM raw_produktionsdaten;


/* ===============================
   2. Dimension: Unternehmen
   =============================== */

INSERT INTO dim_unternehmen (unternehmen_id, unternehmen_name)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY Unternehmen) AS unternehmen_id,
    Unternehmen
FROM raw_produktionsdaten;


/* ===============================
   3. Dimension: Produkt
   =============================== */

INSERT INTO dim_produkt (produkt_id, produkt_name, modifikation)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY Produkt, Modifikation) AS produkt_id,
    Produkt,
    Modifikation
FROM raw_produktionsdaten;


/* ===============================
   4. Dimension: Produktionslinie
   =============================== */

INSERT INTO dim_produktionslinie (linie_id, produktionslinie)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY Produktionslinie) AS linie_id,
    Produktionslinie
FROM raw_produktionsdaten;


/* ===============================
   5. Dimension: Schicht
   =============================== */

INSERT INTO dim_schicht (schicht_id, schicht_name)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY Schicht) AS schicht_id,
    Schicht
FROM raw_produktionsdaten;


/* ===============================
   6. Dimension: Software
   =============================== */

INSERT INTO dim_software (software_id, softwareversion, firmwareversion)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY Softwareversion, Firmwareversion) AS software_id,
    Softwareversion,
    Firmwareversion
FROM raw_produktionsdaten;


/* ===============================
   7. Faktentabelle: Produktion
   =============================== */

INSERT INTO fact_produktion (
    produktion_id,
    datum_id,
    unternehmen_id,
    produkt_id,
    linie_id,
    schicht_id,
    software_id,
    auftragsnummer,
    status,
    fehlercode,
    stueckzahl,
    ausschuss,
    betriebsstunden,
    stillstandszeit_min,
    materialkosten,
    energieverbrauch_kwh,
    mitarbeiter_produktion,
    maxtemperatur,
    durchschnittstemperatur,
    endofline_test
)
SELECT
    ROW_NUMBER() OVER () AS produktion_id,

    d.datum_id,
    u.unternehmen_id,
    p.produkt_id,
    l.linie_id,
    s.schicht_id,
    sw.software_id,

    r.Auftragsnummer,
    r.Status,
    r.Fehlercode,
    r.Stueckzahl,
    r.Ausschuss,
    r.Betriebsstunden,
    r.Stillstandszeit_Min,
    r.Materialkosten,
    r.Energieverbrauch_kWh,
    r.Mitarbeiter_Produktion,
    r.MaxTemperatur,
    r.Durchschnittstemperatur,
    r.EndOfLine_Test

FROM raw_produktionsdaten r
JOIN dim_datum d
    ON r.Datum = d.datum
JOIN dim_unternehmen u
    ON r.Unternehmen = u.unternehmen_name
JOIN dim_produkt p
    ON r.Produkt = p.produkt_name
   AND r.Modifikation = p.modifikation
JOIN dim_produktionslinie l
    ON r.Produktionslinie = l.produktionslinie
JOIN dim_schicht s
    ON r.Schicht = s.schicht_name
JOIN dim_software sw
    ON r.Softwareversion = sw.softwareversion
   AND r.Firmwareversion = sw.firmwareversion;
