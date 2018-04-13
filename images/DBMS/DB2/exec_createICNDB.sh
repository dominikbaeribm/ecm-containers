#!/usr/bin/env bash

db2 CONNECT RESET
db2 -tvf create_icn.sql
db2 connect to $DB_NAME
db2 -tvf ddl_icn.sql
