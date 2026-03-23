SELECT t.currency,
       t.gr combination
  FROM (
        SELECT 
               c.currency,
               string_agg(c.dtime||'|'||c.open||'|'||c.high||'|'||c.low||'|'||c.close||'|'||c.ma5||'|'||c.ma10, '^') OVER (PARTITION BY c.currency ORDER BY c.dtime rows between 5 preceding and current row) gr,
               COUNT(1) OVER (PARTITION BY c.currency ORDER BY c.dtime rows between 5 preceding and current row) combination_length,
               first_value(CAST(strftime('%w', dtime) AS INTEGER)) OVER (PARTITION BY c.currency ORDER BY c.dtime rows between 5 preceding and current row) first_week_day,
               last_value(CAST(strftime('%w', dtime) AS INTEGER)) OVER (PARTITION BY c.currency ORDER BY c.dtime rows between 5 preceding and current row) last_week_day
        FROM candle_h12 c
       ) t
  WHERE 1 = 1
        --AND t.first_week_day < t.last_week_day --исключение перехода через выходные
        AND t.combination_length = 6