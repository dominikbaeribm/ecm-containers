cd /temp
sudo git clone https://github.com/dominikbaeribm/ecm-containers.git

#Docker installation
cd /tmp
#sudo curl -lJO https://raw.githubusercontent.com/dominikbaeribm/ecm-containers/master/dockerinstallation/install_docker.sh
sudo chmod +x install_docker.sh
sudo ./install_docker.sh

#Get docker images
sudo chmod +x download_dockerimages.sh
sudo ./download_dockerimages.sh

#Get utilities
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt install ldap-utils
udo apt-get update && sudo apt-get install telnet

#Building of the AD image
cd /tmp/ecm-containers/images/AD/ecm-ad
sudo chmod +x create_dockerfile_ecm-ad.sh
sudo ./create_dockerfile_ecm-ad.sh

#Building DB2 image
cd /tmp/ecm-containers/images/DBMS/DB2
sudo chmod +x build_ecmdbcontainer.sh
sudo ./build_ecmdbcontainer.sh 

#Starting the database
cd /tmp/ecm-containers/images/ECM/CPE/container-cpe-master/scripts
sudo ./2_run_dockercontainer_ecm-db2.sh
sudo docker exec -it ecmdb bash
su db2inst1
cd /tmp
./createGCD_db2.sh -nGCD -ugcd -tCEDATA
./createOS_db2.sh  -nOS1 -uos1
exit
exit

#Starting AD
cd /tmp/ecm-containers/images/ECM/CPE/container-cpe-master/scripts
sudo ./1_run_dockercontainer_ecm-ad.sh

#Testing connectivity externally DB2 and AD
docker inspect ecmdb
docker inspect ecmad 
#searching in both commands for the IP-Adress
telnet IP_ecmdb 50000
#Ctrl+c
telent IP_ecmad 389
#Ctrl+c

#Preparing Configuration Directory
cd /tmp/ecm-containers/images/ECM/CPE/container-cpe-master/scripts
sudo ./0_prepare_cpeconfigfolders.sh -s /tmp/ecm-containers/images/ECM/CPE/container-cpe-master/examples -t /home/ecm_ad_db2/dev_unica

#Starting CPE
sudo ./3_run_dockercontainer_ecm-cpe1.sh -s dev -a unica






