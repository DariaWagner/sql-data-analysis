# SQL Data Analysis – Relational Production Model

Dieses Repository zeigt SQL-nahe Datenanalysen auf Basis eines
normalisierten Produktionsdatensatzes.

Der Fokus liegt auf:

- sauberem relationalem Datenmodell
- fachlich korrekten Beziehungen
- nachvollziehbaren KPI-Abfragen
- strukturierten, lesbaren SQL-Queries

Die Ergebnisse dieser Analysen werden im Streamlit-Portfolio
tabellarisch dargestellt.

---

## Projektziel

Ziel dieses Projekts ist es, einen umfangreichen Produktionsdatensatz
aus einer CSV-Datei logisch in mehrere relationale Tabellen zu zerlegen
und darauf aufbauend typische Business- und KPI-Fragen mit SQL zu beantworten.

Der Schwerpunkt liegt auf:

- Normalisierung
- klaren Primär- und Fremdschlüsseln
- reproduzierbaren Abfragen
- analytischem Denken

---

## Datenbasis

Der ursprüngliche Datensatz liegt als CSV-Datei vor und enthält unter anderem:

- Datum
- Unternehmen
- Produkt und Modifikation
- Produktionslinie
- Schicht
- Produktionsmenge
- Ausschuss
- Stillstandszeiten
- Energieverbrauch
- Materialkosten
- Status- und Fehlerinformationen

Dieser CSV-Datensatz wird logisch in relationale Tabellen überführt.

---

## Relationales Datenmodell (logisch)

Der CSV-Datensatz wird in folgende logische Tabellen aufgeteilt:

### Dimensionstabellen

**dim_datum**

- datum_id (PK)
- datum
- jahr
- monat

**dim_unternehmen**

- unternehmen_id (PK)
- unternehmen

**dim_produkt**

- produkt_id (PK)
- produkt
- modifikation

**dim_produktionslinie**

- linien_id (PK)
- produktionslinie

**dim_schicht**

- schicht_id (PK)
- schicht

**dim_status**

- status_id (PK)
- status
- fehlercode

### Faktentabelle

**fact_produktion**

- produktion_id (PK)
- datum_id (FK)
- unternehmen_id (FK)
- produkt_id (FK)
- linien_id (FK)
- schicht_id (FK)
- status_id (FK)
- stueckzahl
- ausschuss
- betriebsstunden
- stillstandszeit_min
- energieverbrauch_kwh
- materialkosten
- max_temperatur
- durchschnittstemperatur
- softwareversion
- firmwareversion
- mitarbeiter_produktion

Alle Beziehungen sind eindeutig über Fremdschlüssel definiert.

---

## SQL-Queries

Die SQL-Abfragen sind in einzelne Dateien aufgeteilt und logisch strukturiert.

### Schema & Struktur

- `00_schema.sql`  
  Definition der Tabellen, Primär- und Fremdschlüssel

### Datenaufbereitung

- `01_load_and_normalize.sql`  
  Logische Zerlegung der CSV-Daten in relationale Tabellen

### Analyseabfragen

- `02_analysis_queries.sql`  
  KPI-Berechnungen und Business-Fragen, z. B.:
  - Gesamtproduktion
  - Ausschussquote
  - Stillstandsanteil
  - Energieverbrauch pro Stück
  - Vergleiche nach Linie, Schicht und Zeitraum

---

## Tabellarische Ergebnisse

Die Ergebnisse der SQL-Abfragen werden bewusst **nicht grafisch**
aufbereitet.

Der Fokus liegt auf:

- klaren Tabellen
- sauberen Aggregationen
- reproduzierbaren Resultsets

Diese Tabellen werden im Streamlit-Portfolio direkt angezeigt.

---

## SQL-Kenntnisse im Projekt

- SELECT, WHERE, ORDER BY
- GROUP BY, HAVING
- Aggregationen (SUM, COUNT, AVG)
- CASE Statements
- JOINs (INNER JOIN, LEFT JOIN)
- KPI-Berechnung und Ergebnisaggregation

---

## Data Disclaimer

Die verwendeten Daten sind synthetisch (KI-generiert) und simulieren
reale industrielle Produktions- und Prozessdaten.

Es werden keine echten oder sensiblen Unternehmensdaten verwendet.

---

## Verknüpfung zum Portfolio

Dieses Repository bildet die SQL-Analysegrundlage
für das Streamlit-Portfolio:

https://daria-portfolio.streamlit.app
