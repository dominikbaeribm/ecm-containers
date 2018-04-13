#!/usr/bin/env bash

function print-help()
{
        echo "Argument error, command usage: "
        echo " -n database name - ICN"
        echo " -s schema name - icn"
        echo " -t tablespace name - ICN_TS"
        echo " -u db2 user - icn"
        echo " -a navigator admin id - p8admin"
        exit 1
}

if [ $# -lt 5 ]; then
    print-help
fi

while getopts ":n:s:t:u:a:" opt
do
        case $opt in
                n ) DB_NAME=$OPTARG
                    echo "ICN database name: $DB_NAME";;
                s ) SCHEMA_NAME=$OPTARG
                    echo "ICN database schema name: $SCHEMA_NAME";;
                t ) TS_NAME=$OPTARG
                    echo "ICN database table space name: $TS_NAME";;
                u ) DB2_USER=$OPTARG
                    echo "ICN database user name: $DB2_USER";;
                a ) ICN_ADMIN_ID=$OPTARG
                    echo "ICN admin ID: $ICN_ADMIN_ID";;
                ? ) print-help
                    exit 1;;
        esac
done

ICNDBDIR=/home/db2inst1/db2inst1/NODE0000/${DB_NAME}

mkdir -p ${ICNDBDIR}
cp DB2_CREATE_SCRIPT.sql create_icn.sql
cp DB2_ONE_SCRIPT_ICNDB ddl_icn.sql
sed -i -e "s/@ICNDBDIR@/$DB_NAME/g" create_icn.sql
sed -i -e "s/@ICNDBDIR@/$ICNDBDIR/g" create_icn.sql
sed -i -e "s/@ECMClient_DBUSER@/$DB2_USER/g" ddl_icn.sql
sed -i -e "s/@ECMClient_SCHEMA@/$SCHEMA_NAME/g" ddl_icn.sql
sed -i -e "s/@ECMClient_TBLSPACE@/$TS_NAME/g" ddl_icn.sql
sed -i -e "s/@ECMClient_ADMINID@/$ICN_ADMIN_ID/g" ddl_icn.sql
