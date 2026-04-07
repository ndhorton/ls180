WITH agg AS (
        SELECT facid,
               EXTRACT(month FROM starttime) AS month,
               SUM(slots) AS total_slots
          FROM cd.bookings
         WHERE starttime >= '2012-01-01'
           AND starttime < '2013-01-01'
         GROUP BY facid, EXTRACT(month FROM starttime)
         ORDER BY facid
)
SELECT facid, month, slots
  FROM (
        SELECT facid,
               month,
               total_slots AS slots
          FROM agg
        UNION
        SELECT facid,
               NULL,
               SUM(total_slots) OVER (PARTITION BY facid) AS slots
          FROM agg
        UNION
        SELECT NULL,
               NULL,
               SUM(total_slots) AS slots
          FROM agg
  )
 ORDER BY facid, month;
