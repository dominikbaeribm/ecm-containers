docker run -d --name cmis -p 4087:9080 -p 9449:9443 -e CE_URL=http://192.168.1.215:4081/wsi/FNCEWS40MTOM \
-e CMIS_VERSION=1.0 \
--hostname=cmis \
--link=dev_ecmch_cpe1 \
--link=ecmad \
-v /home/ecm_ad_db2/cmis/logs:/opt/ibm/wlp/usr/servers/defaultServer/logs \
-v /home/ecm_ad_db2/cmis/configDropins/overrides:/opt/ibm/wlp/usr/servers/defaultServer/configDropins/overrides \
ibmcorp/content_management_interoperability_services:latest

#go and navigate to  http://192.168.1.215:4087/fncmis_wlp
