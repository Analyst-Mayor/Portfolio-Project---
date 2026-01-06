---ALL JOINED

WITH Flights AS (
    SELECT  
        FL_DATE,
        ORIGIN,
        DESTINATION,
        OP_CARRIER,
        OP_CARRIER_FL_NUM,
        DEP_DELAY,
        ARR_DELAY,
        AIR_TIME,
        DISTANCE,
        OCCUPANCY_RATE
    FROM dbo.Flights1
),

Airports AS (
    SELECT 
        NAME AS AIRPORT_NAME,
        MUNICIPALITY,
        IATA_CODE
    FROM dbo.Airport_Codes1
),

Tickets AS (
    SELECT
        REPORTING_CARRIER,
        YEAR AS TICKET_YEAR,
        SUM(CAST(PASSENGERS AS INT)) AS PASSENGERS,
        AVG(CAST(ITIN_FARE AS INT)) AS ITIN_FARE
    FROM dbo.TICKETS1
    GROUP BY REPORTING_CARRIER, YEAR
)

SELECT TOP 500000
    f.FL_DATE,
    f.OP_CARRIER,
    f.OP_CARRIER_FL_NUM,
    f.ORIGIN,
    ao.AIRPORT_NAME AS ORIGIN_AIRPORT_NAME,
    ao.MUNICIPALITY AS ORIGIN_CITY,
    f.DESTINATION,
    ad.AIRPORT_NAME AS DEST_AIRPORT_NAME,
    ad.MUNICIPALITY AS DEST_CITY,
    f.DEP_DELAY,
    f.ARR_DELAY,
    f.AIR_TIME,
    f.DISTANCE,
    f.OCCUPANCY_RATE,
    t.PASSENGERS,
    t.ITIN_FARE
--INTO dbo.ALLJOINED  

FROM Flights f
	LEFT JOIN Airports ao
    ON f.ORIGIN = ao.IATA_CODE
	JOIN Airports ad
    ON f.DESTINATION = ad.IATA_CODE
	JOIN Tickets t
    ON f.OP_CARRIER = t.REPORTING_CARRIER
    AND YEAR(f.FL_DATE) = t.TICKET_YEAR;

