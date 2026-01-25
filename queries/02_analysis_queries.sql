/* =====================================================
   KPI 1: Gesamtproduktion & Ausschussquote
   ===================================================== */

SELECT
    SUM(f.stueckzahl)                     AS gesamt_stueckzahl,
    SUM(f.ausschuss)                      AS gesamt_ausschuss,
    ROUND(
        SUM(f.ausschuss) * 100.0
        / NULLIF(SUM(f.stueckzahl), 0),
        2
    ) AS ausschussquote_prozent
FROM fact_produktion f;


/* =====================================================
   KPI 2: Produktion nach Produktionslinie
   ===================================================== */

SELECT
    l.produktionslinie,
    SUM(f.stueckzahl) AS gesamt_stueckzahl,
    SUM(f.ausschuss)  AS gesamt_ausschuss,
    ROUND(
        SUM(f.ausschuss) * 100.0
        / NULLIF(SUM(f.stueckzahl), 0),
        2
    ) AS ausschussquote_prozent
FROM fact_produktion f
JOIN dim_produktionslinie l
    ON f.linie_id = l.linie_id
GROUP BY l.produktionslinie
ORDER BY ausschussquote_prozent DESC;


/* =====================================================
   KPI 3: Produktion nach Schicht
   ===================================================== */

SELECT
    s.schicht_name,
    SUM(f.stueckzahl) AS gesamt_stueckzahl,
    SUM(f.ausschuss)  AS gesamt_ausschuss,
    ROUND(
        SUM(f.ausschuss) * 100.0
        / NULLIF(SUM(f.stueckzahl), 0),
        2
    ) AS ausschussquote_prozent
FROM fact_produktion f
JOIN dim_schicht s
    ON f.schicht_id = s.schicht_id
GROUP BY s.schicht_name
ORDER BY ausschussquote_prozent DESC;


/* =====================================================
   KPI 4: Energieverbrauch pro Stück
   ===================================================== */

SELECT
    l.produktionslinie,
    ROUND(
        SUM(f.energieverbrauch_kwh)
        / NULLIF(SUM(f.stueckzahl), 0),
        2
    ) AS energie_kwh_pro_stueck
FROM fact_produktion f
JOIN dim_produktionslinie l
    ON f.linie_id = l.linie_id
GROUP BY l.produktionslinie
ORDER BY energie_kwh_pro_stueck DESC;


/* =====================================================
   KPI 5: Stillstandszeiten nach Linie
   ===================================================== */

SELECT
    l.produktionslinie,
    SUM(f.stillstandszeit_min) AS stillstand_minuten
FROM fact_produktion f
JOIN dim_produktionslinie l
    ON f.linie_id = l.linie_id
GROUP BY l.produktionslinie
ORDER BY stillstand_minuten DESC;


/* =====================================================
   KPI 6: Produktion im Zeitverlauf (Monat)
   ===================================================== */

SELECT
    d.jahr,
    d.monat,
    SUM(f.stueckzahl) AS gesamt_stueckzahl
FROM fact_produktion f
JOIN dim_datum d
    ON f.datum_id = d.datum_id
GROUP BY d.jahr, d.monat
ORDER BY d.jahr, d.monat;
