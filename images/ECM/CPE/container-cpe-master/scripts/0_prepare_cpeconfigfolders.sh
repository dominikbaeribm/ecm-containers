#!/usr/bin/env bash

function print-help()
{
        echo "Argument error, command usage: "
    	echo " -s path for example files - default ../examples"
    	echo " -t cpe_config_directore - default /home/ecm_ad_db2/cpe_data"
        exit 1
}

if [ $# -lt 2 ]; then
    print-help
fi

while getopts ":s:t:" opt
do
        case $opt in
                s ) ExamplesDir=$OPTARG
                    echo "Examples Path: $ExamplesDir";;
            	t ) CPEConfig=$OPTARG
                echo "CPE configuration path: $CPEConfig";;
                ? ) print-help
                    exit 1;;
        esac
done


# Prepare home/ecm_ad_db2/cpe_data
echo "creating configuration directory in : " $CPEConfig
sudo mkdir -p $CPEConfig/configDropins/overrides 
sudo mkdir -p $CPEConfig/asa 
sudo mkdir -p $CPEConfig/textext 
sudo mkdir -p $CPEConfig/logs 
sudo mkdir -p $CPEConfig/FileNet 
sudo mkdir -p $CPEConfig/icmrules 
sudo mkdir -p $CPEConfig/bootstrap
sudo mkdir -p $CPEConfig/tmp
cp $ExamplesDir/BootstrapConfig.jar $CPEConfig/tmp/BootstrapConfig.jar
cp $ExamplesDir/BootstrapConfigProps.jar $CPEConfig/tmp/BootstrapConfigProps.jar
cd $CPEConfig/tmp
sudo java -Dfile.encoding=utf-8 -jar BootstrapConfig.jar -s FNGCDDS -x FNGCDDSXA -u p8admin -p Password01 -e BootstrapConfigProps.jar -b 256 -c AES -k -o true
sudo jar xvf BootstrapConfigProps.jar APP-INF/lib/props.jar
cp APP-INF/lib/props.jar $CPEConfig/bootstrap/
#copy db2_ad specific files
cp $ExamplesDir/db2_ad/{ldapAD.xml,DB2JCCDriver.xml,FNGCDDS.xml,OS1DS.xml} $CPEConfig/configDropins/overrides/
cp $ExamplesDir/{db2jcc4.jar,db2jcc_license_cu.jar} $CPEConfig/configDropins/overrides/
sudo chown -R 501:500 $CPEConfig/