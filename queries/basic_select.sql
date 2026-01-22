SELECT *FROM kunde;

SELECT kunde_id, land
FROM kunde
WHERE land = "Deutschland";

SELECT land, COUNT(*) AS anzahl_kunden
FROM kunde
GROUP BY land
ORDER BY anzahl_kunden DESC;