# Docker container implementing DB2 for ECM containers dev and test environments


First pull the official db2 express docker container 
```
docker pull docker pull ibmcom/db2express-c
```
Then run the container script in ecm-containers/images/DBMS/DB2/run_dockercontainer_db2.sh  
this will create a persistent volume and instantiate a docker container of the ibmcom/db2express-c image.
