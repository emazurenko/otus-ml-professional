CREATE TABLE class (
    currency CHAR(3),
    dtime TIMESTAMP,
    label INTEGER,

    PRIMARY KEY (currency, dtime)
);