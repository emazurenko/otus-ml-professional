CREATE VIEW candle_h12 AS
SELECT t.*,
       avg(t.close) OVER (PARTITION BY t.currency ORDER BY t.dtime rows between 4 preceding and current row) ma5,
       avg(t.close) OVER (PARTITION BY t.currency ORDER BY t.dtime rows between 9 preceding and current row) ma10
  FROM (
         SELECT DISTINCT 
                t.currency,
                t.interval_dtime dtime,
                first_value(t.open) OVER (PARTITION BY t.currency, t.interval_dtime) open,
                max(t.high) OVER (PARTITION BY t.currency, t.interval_dtime) high, 
                min(t.low) OVER (PARTITION BY t.currency, t.interval_dtime) low,
                last_value(t.close) OVER (PARTITION BY t.currency, t.interval_dtime) close
        FROM (      
                SELECT t.*,
                    CASE 
                        WHEN CAST(strftime('%H', dtime) AS INTEGER) = 0 THEN datetime(dtime, 'start of day')
                        WHEN CAST(strftime('%H', dtime) AS INTEGER) BETWEEN 1 AND 12 THEN datetime(dtime, 'start of day', '+12 hour')
                        WHEN CAST(strftime('%H', dtime) AS INTEGER) BETWEEN 13 AND 23 THEN datetime(dtime, 'start of day', '+1 day')
                    END interval_dtime
                FROM candle t
              ) t
        ORDER BY t.currency, dtime
       ) t;