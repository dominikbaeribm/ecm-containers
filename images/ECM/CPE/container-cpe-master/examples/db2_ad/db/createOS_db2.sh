#!/usr/bin/env bash

# RUN this script as the DB2 instance owner

function print-help()
{
        echo "Argument error, command usage: "
        echo " -n database name"
        echo " -u db2 user"
        exit 1
}

if [ $# -lt 2 ]; then
    print-help
fi

while getopts ":n:s:t:u:" opt
do
        case $opt in
                n ) DB_NAME=$OPTARG
                    echo "ObjectStore database name: $DB_NAME";;
                u ) DB2_USER=$OPTARG
                    echo "ObjectStore database user name: $DB2_USER";;
                ? ) print-help
                    exit 1;;
        esac
done

P8DBNAME=${DB_NAME}
P8DBDIR=/home/db2inst1/db2inst1/NODE0000/${P8DBNAME}
DB2USER=${DB2_USER}


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
create bufferpool BPDATA32K size -1 pagesize 32K;
create bufferpool BPINDEX32K size -1 pagesize 32K;
create bufferpool BPLOB32K size -1 pagesize 32K;
create bufferpool BPUSER32K size -1 pagesize 32K;
create bufferpool BPSYS32K size -1 pagesize 32K;
-- Create tablespaces
create large tablespace CEDATA_TS1 
	in nodegroup ibmdefaultgroup
	pagesize 32K 
	managed by database 
	using (file '$P8DBDIR/CEDATA_TS1.c001' 150 M) 
	extentsize 32 
	prefetchsize automatic 
	bufferpool BPDATA32K 
	autoresize yes increasesize  10 percent 
	maxsize  500 M 
	dropped table recovery ON
;
create large tablespace CEINDX_TS1
       in nodegroup ibmdefaultgroup
       pagesize  32K
       managed by database
       using (file '$P8DBDIR/CEINDX_TS1.c001' 150 M)
       extentsize 32
       prefetchsize automatic
       bufferpool BPINDEX32K
       autoresize yes increasesize  10 percent
       maxsize  500 M
       dropped table recovery ON
;
create large tablespace CELOB_TS1
       in nodegroup ibmdefaultgroup
       pagesize  32K
       managed by database
       using (file '$P8DBDIR/CELOB_TS1.c001' 150 M)
       extentsize 32
       prefetchsize automatic
       bufferpool BPLOB32K
       autoresize yes increasesize  10 percent
       maxsize  500 M
       dropped table recovery ON
;
create user temporary  tablespace USERTEMPORARY
       in nodegroup ibmdefaultgroup
       pagesize  32K
       managed by system
       using ('$P8DBDIR/USERTEMPORARY')
       extentsize 32
       prefetchsize automatic
       bufferpool BPUSER32K
       dropped table recovery OFF
;
create system temporary tablespace TEMPSPACE32
	pagesize  32K
	managed by system
	using ('$P8DBDIR/TEMPSPACE32')
	extentsize 16 prefetchsize 32
	bufferpool BPSYS32K
;
End_of_file

#-- Grant USER access to tablespaces
# echo Grant user $DB2USER access to tablespaces

db2 -v grant use of tablespace CEDATA_TS1 to PUBLIC;
db2 -v grant use of tablespace CEINDX_TS1 to PUBLIC;
db2 -v grant use of tablespace CELOB_TS1 to PUBLIC;
db2 -v grant use of tablespace USERTEMPORARY to PUBLIC;
db2 -v GRANT CREATETAB, CONNECT ON DATABASE TO USER $DB2USER;

echo "Created database $P8DBNAME *********************************************************************"

#-- Close connection
db2 CONNECT RESET
db2 activate database $P8DBNAME
db2 terminate