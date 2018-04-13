#!/usr/bin/env bash


sudo docker run -d --name icn1 \
  -p 4082:9080 -p 4445:9443 \
--hostname=icn1 \
--link=ecmdb \
--link=ecmad \
--link=dev_ecmch_cpe1 \
-e ICNSCHEMA=icn \
-v /home/ecm_ad_db2/icn/plugins:/opt/ibm/plugins \
-v /home/ecm_ad_db2/icn/viewerlog:/opt/ibm/viewerconfig/logs \
-v /home/ecm_ad_db2/icn/viewercache:/opt/ibm/viewerconfig/cache \
-v /home/ecm_ad_db2/icn/logs:/opt/ibm/wlp/usr/servers/defaultServer/logs \
-v /home/ecm_ad_db2/icn/configDropins/overrides:/opt/ibm/wlp/usr/servers/defaultServer/configDropins/overrides \
ibmcorp/content_navigator:latest
