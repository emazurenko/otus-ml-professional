WITH t AS (
      SELECT ROW_NUMBER() OVER (PARTITION BY c.currency ORDER BY c.dtime) rn,
             c.currency,
             c.dtime,
             CAST(c.open AS REAL) open,
             CAST(c.high AS REAL) high,
             CAST(c.low AS REAL) low,
             CAST(c.close AS REAL) close,
             CAST(c.ma5 AS REAL) ma5,
             CAST(c.ma15 AS REAL) ma15,
             CAST(c.ma10 AS REAL) ma10
        FROM candle_h12 c
)

SELECT t1.currency,
       t1.dtime t1_dtime,
       t1.open t1_open,
       t1.high t1_high,
       t1.low t1_low,
       t1.close t1_close,
       t1.ma5 t1_ma5,
       t1.ma10 t1_ma10,
       t1.ma15 t1_ma15,
       t2.dtime t2_dtime,
       t2.open t2_open,
       t2.high t2_high,
       t2.low t2_low,
       t2.close t2_close,
       t2.ma5 t2_ma5,
       t2.ma10 t2_ma10,
       t2.ma15 t2_ma15,
       t3.dtime t3_dtime,
       t3.open t3_open,
       t3.high t3_high,
       t3.low t3_low,
       t3.close t3_close,
       t3.ma5 t3_ma5,
       t3.ma10 t3_ma10,
       t3.ma15 t3_ma15,
       t4.dtime t4_dtime,
       t4.open t4_open,
       t4.high t4_high,
       t4.low t4_low,
       t4.close t4_close,
       t4.ma5 t4_ma5,
       t4.ma10 t4_ma10,
       t4.ma15 t4_ma15,
       t5.dtime t5_dtime,
       t5.open t5_open,
       t5.high t5_high,
       t5.low t5_low,
       t5.close t5_close,
       t5.ma5 t5_ma5,
       t5.ma10 t5_ma10,
       t5.ma15 t5_ma15,
       t6.dtime t6_dtime,
       t6.open t6_open,
       t6.high t6_high,
       t6.low t6_low,
       t6.close t6_close,
       t6.ma5 t6_ma5,
       t6.ma10 t6_ma10,
       t6.ma15 t6_ma15
      --  t7.dtime t7_dtime,
      --  t7.open t7_open,
      --  t7.high t7_high,
      --  t7.low t7_low,
      --  t7.close t7_close,
      --  t7.ma5 t7_ma5,
      --  t7.ma10 t7_ma10,
      --  t7.ma15 t7_ma15
      --  COALESCE((SELECT label FROM class WHERE currency = t6.currency and dtime = t6.dtime), 0) class
  FROM t as t1
       INNER JOIN t as t2
       ON t2.rn = t1.rn + 1
          AND t2.currency = t1.currency
       INNER JOIN t as t3
       ON t3.rn = t2.rn + 1
          AND t3.currency = t2.currency
       INNER JOIN t as t4
       ON t4.rn = t3.rn + 1
          AND t4.currency = t3.currency
       INNER JOIN t as t5
       ON t5.rn = t4.rn + 1
          AND t5.currency = t4.currency
       INNER JOIN t as t6
       ON t6.rn = t5.rn + 1
          AND t6.currency = t5.currency
      --  INNER JOIN t as t7
      --  ON t7.rn = t6.rn + 1
      --     AND t7.currency = t6.currency
  WHERE t1.currency = 'AUD'
        AND t1.rn < 1000