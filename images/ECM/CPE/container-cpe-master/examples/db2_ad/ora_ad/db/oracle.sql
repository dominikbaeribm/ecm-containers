----------------------------------------------
----------------------------------------------
-- TABLESPACES
----------------------------------------------
----------------------------------------------

----------------------------------------------
-- FNGCD
----------------------------------------------
-- TS_FNGCD_DATA
CREATE TABLESPACE TS_FNGCD_DATA DATAFILE 
  '/etc/entrypoint-initdb.d/TS_FNGCD_DATA01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_FNGCD_TEMP
CREATE TEMPORARY TABLESPACE TS_FNGCD_TEMP TEMPFILE 
  '/etc/entrypoint-initdb.d/TS_FNGCD_TEMP01.dbf' SIZE 1G 
TABLESPACE GROUP ''
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M;

----------------------------------------------
-- SYSTESTOS
----------------------------------------------
-- TS_FNCPESYSTEST_INDEX
CREATE TABLESPACE TS_FNCPESYSTEST_INDEX DATAFILE 
  '/etc/entrypoint-initdb.d/TS_FNCPESYSTEST_INDEX01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_FNCPESYSTEST_DATA
CREATE TABLESPACE TS_FNCPESYSTEST_DATA DATAFILE 
  '/etc/entrypoint-initdb.d/TS_FNCPESYSTEST_DATA01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_FNCPESYSTEST_LOB
CREATE TABLESPACE TS_FNCPESYSTEST_LOB DATAFILE 
  '/etc/entrypoint-initdb.d/TS_FNCPESYSTEST_LOB01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_FNCPEVWTEST_DATA
CREATE TABLESPACE TS_FNCPEVWTEST_DATA DATAFILE 
  '/etc/entrypoint-initdb.d/TS_FNCPEVWTEST_DATA01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_FNCPEVWTEST_INDEX
CREATE TABLESPACE TS_FNCPEVWTEST_INDEX DATAFILE 
  '/etc/entrypoint-initdb.d/TS_FNCPEVWTEST_INDEX01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_FNCPEVWTEST_LOB
CREATE TABLESPACE TS_FNCPEVWTEST_LOB DATAFILE 
  '/etc/entrypoint-initdb.d/TS_FNCPEVWTEST_LOB01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_FNSYSTEST_TEMP
CREATE TEMPORARY TABLESPACE TS_FNSYSTEST_TEMP TEMPFILE 
  '/rgsi070/data/ora/002/RFITFN01/data/dbf/TS_FNSYSTEST_TEMP01.dbf' SIZE 1G 
TABLESPACE GROUP ''
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M;

----------------------------------------------
-- Statging
----------------------------------------------
-- TS_SYST_DATA
CREATE TABLESPACE TS_SYST_DATA DATAFILE 
  '/etc/entrypoint-initdb.d/TS_SYST_DATA01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_SYST_TEMP
CREATE TEMPORARY TABLESPACE TS_SYST_TEMP TEMPFILE 
  '/etc/entrypoint-initdb.d/TS_SYST_TEMP01.dbf' SIZE 1G 
TABLESPACE GROUP ''
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M;

----------------------------------------------
-- ICNCFG
----------------------------------------------
-- TS_ICNCGF_DATA 
CREATE TABLESPACE TS_ICNCGF_DATA DATAFILE 
  '/etc/entrypoint-initdb.d/TS_ICNCGF_DATA01.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE 2G 
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- TS_ICNCFG_TEMP
CREATE TEMPORARY TABLESPACE TS_ICNCFG_TEMP TEMPFILE 
  '/etc/entrypoint-initdb.d/TS_ICNCFG_TEMP01.dbf' SIZE 1G 
TABLESPACE GROUP ''
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100M;

----------------------------------------------
-- SCHEMES
----------------------------------------------

-- M_FNGCD
CREATE USER M_FNGCD
  IDENTIFIED BY Password01
  DEFAULT TABLESPACE TS_FNGCD_DATA
  TEMPORARY TABLESPACE TS_FNGCD_TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  -- 2 Roles for M_FNGCD 
  GRANT CONNECT TO M_FNGCD;
  GRANT RESOURCE TO M_FNGCD;
  ALTER USER M_FNGCD DEFAULT ROLE ALL;
  -- 1 System Privilege for M_FNGCD 
  GRANT UNLIMITED TABLESPACE TO M_FNGCD;
  -- 1 Tablespace Quota for M_FNGCD
  ALTER USER M_FNGCD QUOTA UNLIMITED ON TS_FNGCD_DATA;
    
-- M_SYSTESTOS
CREATE USER M_SYSTESTOS
  IDENTIFIED BY Password01
  DEFAULT TABLESPACE TS_FNCPESYSTEST_DATA
  TEMPORARY TABLESPACE TS_SYST_TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  -- 2 Roles for M_SYSTESTOS 
  GRANT CONNECT TO M_SYSTESTOS;
  GRANT RESOURCE TO M_SYSTESTOS;
  ALTER USER M_SYSTESTOS DEFAULT ROLE ALL;
  -- 1 System Privilege for M_SYSTESTOS 
  GRANT UNLIMITED TABLESPACE TO M_SYSTESTOS;
  -- 5 Tablespace Quota for M_SYSTESTOS
  ALTER USER M_SYSTESTOS QUOTA UNLIMITED ON TS_FNCPESYSTEST_DATA;
  ALTER USER M_SYSTESTOS QUOTA UNLIMITED ON TS_FNCPESYSTEST_INDEX;
  ALTER USER M_SYSTESTOS QUOTA UNLIMITED ON TS_FNCPESYSTEST_LOB;
  ALTER USER M_SYSTESTOS QUOTA UNLIMITED ON TS_FNCPEVWTEST_DATA;
  ALTER USER M_SYSTESTOS QUOTA UNLIMITED ON TS_FNCPEVWTEST_INDEX;
  ALTER USER M_SYSTESTOS QUOTA UNLIMITED ON TS_FNCPEVWTEST_LOB;
  
-- M_SYSST
CREATE USER M_SYSST
  IDENTIFIED BY Password01
  DEFAULT TABLESPACE TS_SYST_DATA
  TEMPORARY TABLESPACE TS_SYST_TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  -- 2 Roles for M_SYSST 
  GRANT CONNECT TO M_SYSST;
  GRANT RESOURCE TO M_SYSST;
  ALTER USER M_SYSST DEFAULT ROLE ALL;
  -- 1 System Privilege for M_SYSST 
  GRANT UNLIMITED TABLESPACE TO M_SYSST;
  -- 5 Tablespace Quota for M_SYSST
  ALTER USER M_SYSST QUOTA UNLIMITED ON TS_SYST_DATA;

-- M_ICNCFG
CREATE USER M_ICNCFG
  IDENTIFIED BY Password01
  DEFAULT TABLESPACE TS_ICNCGF_DATA
  TEMPORARY TABLESPACE TS_ICNCFG_TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  -- 2 Roles for M_ICNCFG 
  GRANT CONNECT TO M_ICNCFG;
  GRANT RESOURCE TO M_ICNCFG;
  ALTER USER M_ICNCFG DEFAULT ROLE ALL;
  -- 1 System Privilege for M_ICNCFG 
  GRANT UNLIMITED TABLESPACE TO M_ICNCFG;
  -- 1 Tablespace Quota for M_ICNCFG
  ALTER USER M_ICNCFG QUOTA UNLIMITED ON TS_ICNCGF_DATA;
  