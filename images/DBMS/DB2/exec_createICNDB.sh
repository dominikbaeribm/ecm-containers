#!/usr/bin/env bash

db2 CONNECT RESET
db2 -tvf DB2_CREATE_SCRIPT.sql
db2 connect to $DB_NAME
db2 -tvf DB2_ONE_SCRIPT_ICNDB.sql
