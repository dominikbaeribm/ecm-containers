#!/usr/bin/env bash

# RUN this script as the DB2 instance owner

function print-help()
{
        echo "Argument error, command usage: "
        echo " -n database name"
        echo " -s schema name"
        echo " -t tablespace name"
        echo " -u db2 user"
        exit 1
}

if [ $# -lt 3 ]; then
    print-help
fi

while getopts ":n:s:t:u:" opt
do
        case $opt in
                n ) DB_NAME=$OPTARG
                    echo "GCD database name: $DB_NAME";;
                t ) TS_NAME=$OPTARG
                    echo "GCD database table space name: $TS_NAME";;
                u ) DB2_USER=$OPTARG
                    echo "GCD database user name: $DB2_USER";;
                ? ) print-help
                    exit 1;;
        esac
done

P8DBNAME=${DB_NAME}
P8DBDIR=/home/db2inst1/db2inst1/NODE0000/${P8DBNAME}
DB2USER=${DB2_USER}
TBLSPC=${TS_NAME}_TS

mkdir -p ${P8DBDIR}

#-- Close any outstanding connection
db2 CONNECT RESET

echo "Creating database $P8DBNAME ****************************************************************"
db2 +p -t -v<<End_of_file
CREATE DATABASE $P8DBNAME
ON $P8DBDIR
USING CODESET UTF-8 TERRITORY en_US
COLLATE USING UCA500R1_S1
;

-- Increase the application heap size
UPDATE DATABASE CONFIGURATION FOR ${P8DBNAME} USING APPLHEAPSZ 2560;
UPDATE DATABASE CONFIGURATION FOR ${P8DBNAME} USING STMTHEAP 8192;
update DATABASE  CONFIGURATION FOR ${P8DBNAME} USING cur_commit ON;

End_of_file

sleep 5

db2 +p -t -v<<End_of_file
-- Connect
CONNECT TO $P8DBNAME;
-- Drop unnecessary default tablespaces
-- Try not dropping
DROP TABLESPACE USERSPACE1;
-- REVOKE USE OF TABLESPACE USERSPACE1 FROM PUBLIC;
-- Create default buffer pool size
CREATE Bufferpool BPGCD32K IMMEDIATE  SIZE -1 PAGESIZE 32 K;
create large tablespace $TBLSPC in nodegroup ibmdefaultgroup 
	pagesize 32K managed by database 
	using (file '$P8DBDIR/GCDDATA_TS1.c001' 150 M) extentsize 32 
	prefetchsize automatic bufferpool BPGCD32K autoresize yes 
	increasesize  10 percent maxsize  500 M dropped table recovery ON;
End_of_file

#-- Grant USER access to tablespaces
echo Grant user $DB2USER access to tablespace

db2 -v GRANT CREATETAB,CONNECT ON DATABASE  TO user $DB2USER;
db2 -v GRANT USE OF TABLESPACE $TBLSPC TO user $DB2USER;
--db2 GRANT USE OF TABLESPACE TEMPSPACE1 TO user $DB2USER;
echo "Created database $P8DBNAME *********************************************************************

#-- Close connection
db2 CONNECT RESET
db2 activate database $P8DBNAME
db2 terminate