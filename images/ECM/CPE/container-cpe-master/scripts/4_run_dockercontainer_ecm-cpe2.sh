docker run -d --name cpe2 \
  -p 4082:9080 -p 4442:9443 \
--hostname=cpe2 \
--link=ecmdb \
--link=ecmad \
-v /home/ecm_ad_db2/cpe_data/asa:/opt/ibm/asa \
-v /tmp/data/textext:/opt/ibm/textext \
-v /home/ecm_ad_db2/cpe_data/icmrules:/opt/ibm/icmrules \
-v /home/ecm_ad_db2/cpe_data/logs:/opt/ibm/wlp/usr/servers/defaultServer/logs \
-v /home/ecm_ad_db2/cpe_data/FileNet:/opt/ibm/wlp/usr/servers/defaultServer/FileNet \
-v /home/ecm_ad_db2/cpe_data/configDropins/overrides:/opt/ibm/wlp/usr/servers/defaultServer/configDropins/overrides \
-v /home/ecm_ad_db2/cpe_data/bootstrap:/opt/ibm/wlp/usr/servers/defaultServer/lib/bootstrap \
ibmcorp/ecm_earlyadopters_cpe:earlyadopters-gm5.5

