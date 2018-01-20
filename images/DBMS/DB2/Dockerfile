FROM ibmcom/db2express-c:latest
ADD create_p8dbusers.sh /tmp
RUN chmod 777 /tmp/create_p8dbusers.sh
RUN /tmp/create_p8dbusers.sh