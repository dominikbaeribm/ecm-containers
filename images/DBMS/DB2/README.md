# Docker container implementing DB2 for ECM containers dev and test environments


First pull the official db2 express docker container 
```
docker pull docker pull ibmcom/db2express-c
```
Then change to ecm-containers/images/DBMS/DB2
run     
```
./build_ecmdbcontainer.sh  
```
then run the container script 
```
/run_dockercontainer_db2.sh  
```  
this will create a persistent volume and instantiate a docker container of the customized 
ibmcom/db2express-c image (ecmdb2express)  
Next step to create the various databases. (coming soon)  

