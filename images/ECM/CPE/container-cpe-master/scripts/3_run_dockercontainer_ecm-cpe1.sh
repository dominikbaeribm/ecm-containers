#!/usr/bin/env bash
function print-help()
{
        echo "Argument error, command usage: "
    	echo " -s stage {dev|test|preprod|prod|edu}"
    	echo " -a application {name of the application"
        exit 1
}

if [ $# -lt 2 ]; then
    print-help
fi

while getopts ":s:a:" opt
do
        case $opt in
                s ) Stage=$OPTARG
                    echo "Stage: $Stage";;
            	a ) Application=$OPTARG
                    echo "Application name: $Application";;
                ? ) print-help
                    exit 1;;
        esac
done

Label=${Stage}_${Application}
echo $Label

sudo docker run -d --name ${Label}_cpe1 \
  -p 4081:9080 -p 4443:9443 \
--hostname=${Label}_cpe1 \
--link=ecmdb \
--link=ecmad \
-v /home/ecm_ad_db2/${Label}/asa:/opt/ibm/asa \
-v /tmp/data/textext:/opt/ibm/textext \
-v /home/ecm_ad_db2/${Label}_cpe1/icmrules:/opt/ibm/icmrules \
-v /home/ecm_ad_db2/${Label}_cpe1/logs:/opt/ibm/wlp/usr/servers/defaultServer/logs \
-v /home/ecm_ad_db2/${Label}_cpe1/FileNet:/opt/ibm/wlp/usr/servers/defaultServer/FileNet \
-v /home/ecm_ad_db2/${Label}_cpe1/configDropins/overrides:/opt/ibm/wlp/usr/servers/defaultServer/configDropins/overrides \
-v /home/ecm_ad_db2/${Label}_cpe1/bootstrap:/opt/ibm/wlp/usr/servers/defaultServer/lib/bootstrap \
ibmcorp/filenet_content_platform_engine:latest

