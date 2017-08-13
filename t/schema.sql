DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    login_id        TEXT,
    password        TEXT,
    authority       INTEGER,
    deleted         INTEGER,
    create_ts       TEXT,
    modify_ts       TEXT
);
