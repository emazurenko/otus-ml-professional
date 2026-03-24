WITH t AS (
      SELECT ROW_NUMBER() OVER (PARTITION BY c.currency ORDER BY c.dtime) rn,
             c.*
        FROM candle_h12 c
)

SELECT t1.currency,
       t1.dtime t1_dtime,
       t1.open t1_open,
       t1.high t1_high,
       t1.low t1_low,
       t1.close t1_close,
       t1.ma5 t1_ma5,
       t1.ma10 t1_m10,
       t2.dtime t2_dtime,
       t2.open t2_open,
       t2.high t2_high,
       t2.low t2_low,
       t2.close t2_close,
       t2.ma5 t2_ma5,
       t2.ma10 t2_m10,
       t3.dtime t3_dtime,
       t3.open t3_open,
       t3.high t3_high,
       t3.low t3_low,
       t3.close t3_close,
       t3.ma5 t3_ma5,
       t3.ma10 t3_m10,
       t4.dtime t4_dtime,
       t4.open t4_open,
       t4.high t4_high,
       t4.low t4_low,
       t4.close t4_close,
       t4.ma5 t4_ma5,
       t4.ma10 t4_m10,
       t5.dtime t5_dtime,
       t5.open t5_open,
       t5.high t5_high,
       t5.low t5_low,
       t5.close t5_close,
       t5.ma5 t5_ma5,
       t5.ma10 t5_m10,
       t6.dtime t_dtime,
       t6.open t_open,
       t6.high t_high,
       t6.low t_low,
       t6.close t_close

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