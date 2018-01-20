VOLUME_NAME='ecm-db2-data-home'
# Checking if docker container with $CONTAINER_NAME name exists.
COUNT=$(docker volume ls | grep "$VOLUME_NAME" | wc -l)
if (($COUNT > 0)); then
    echo 'volume '$VOLUME_NAME 'exists'
else
        echo 'create volume '$VOLUME_NAME
        sudo docker volume create $VOLUME_NAME
fi

CONTAINER_NAME='ecmdb'
# Checking if docker container with $CONTAINER_NAME name exists.
COUNT=$(docker ps -a | grep "$CONTAINER_NAME" | wc -l)
if (($COUNT > 0)); then
    echo 'container '$CONTAINER_NAME 'exists'
else
        echo 'starting container '$CONTAINER_NAME        
        sudo docker run \
        	--name ecmdb -d -p 50000:50000 -e DB2INST1_PASSWORD=Password01 \
			-e LICENSE=accept   \
			-v  ecm-db2-data-home:/home  \
			ecmdb2express \
			db2start
fi