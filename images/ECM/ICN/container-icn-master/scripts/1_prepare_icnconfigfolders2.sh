#!/usr/bin/env bash


mkdir -p /home/ecm_ad_db2/icn/configDropins/overrides
mkdir -p /home/ecm_ad_db2/icn/logs
mkdir -p /home/ecm_ad_db2/icn/plugins
mkdir -p /home/ecm_ad_db2/icn/viewerlog 
mkdir -p /home/ecm_ad_db2/icn/viewercache
chown -R 501:500 /home/ecm_ad_db2/icn/viewerlog
chown -R 501:500 /home/ecm_ad_db2/icn/viewercache
chown -R 501:500 /home/ecm_ad_db2/icn/plugins
chown -R 501:500 /home/ecm_ad_db2/icn/logs
chown -R 501:500 /home/ecm_ad_db2/icn/configDropins/overrides

cd /home/ecm_ad_db2/icn


cp /tmp/ecm-containers/images/ECM/ICN/container-icn-master/examples/ICNDS.xml .
cp /tmp/ecm-containers/images/ECM/CPE/container-cpe-master/examples/ldapAD.xml .
cp /tmp/ecm-containers/images/ECM/CPE/container-cpe-master/examples/DB2JCCDriver.xml .
cp /tmp/ecm-containers/images/ECM/CPE/container-cpe-master/examples/db2jcc_license_cu.jar .
cp /tmp/ecm-containers/images/ECM/CPE/container-cpe-master/examples/db2jcc4.jar .