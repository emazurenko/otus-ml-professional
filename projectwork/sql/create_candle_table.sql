CREATE TABLE candle (
    currency CHAR(3),
    dtime TIMESTAMP,
    open REAL,
    high REAL,
    low REAL,
    close REAL,

    PRIMARY KEY (currency, dtime)
);