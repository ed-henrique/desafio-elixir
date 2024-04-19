-- DDL

CREATE TABLE IF NOT EXISTS ACCOUNT (
    ID INTEGER PRIMARY KEY, -- Alias for ROWID in SQLite
    AGENCY_NUMBER TEXT NOT NULL CHECK(LENGTH(NOME) = 6), -- Formatted as 0000-x
    ACCOUNT_NUMBER TEXT NOT NULL, 
    CREATED_AT TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UPDATED_AT TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DELETED_AT TEXT DEFAULT NULL -- Used for soft delete operations
);

CREATE INDEX IF NOT EXISTS IDX_ACCOUNT ON ACCOUNT(ID);

-- The HISTORY tables use a versioning system, making it possible to recursively
-- restore a previous state of a row. It also stores the changes using a bitmap,
-- which takes less space than copying the row, storing only the diffs between
-- the previous and the current version.
--
-- By default, I am using -1 as the version for deleted records.

CREATE TABLE IF NOT EXISTS ACCOUNT_HISTORY (
    _ROWID INTEGER,
    ID INTEGER,
    AGENCY_NUMBER TEXT,
    ACCOUNT_NUMBER TEXT,
    CREATED_AT TEXT,
    UPDATED_AT TEXT,
    DELETED_AT TEXT,
    _VERSION INTEGER,
    _BITMASK INTEGER,
    _CREATED_AT TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY(ID) REFERENCES ACCOUNT(ID)
);

CREATE INDEX IF NOT EXISTS IDX_ACCOUNT_HISTORY ON ACCOUNT_HISTORY(_ROWID);
