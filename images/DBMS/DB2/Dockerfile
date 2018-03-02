FROM ibmcom/db2express-c:latest
ADD create_p8dbusers.sh /tmp
ADD createGCD_db2.sh /tmp
ADD createOS_db2.sh /tmp
RUN chmod 777 /tmp/create_p8dbusers.sh
RUN chmod 777 /tmp/createGCD_db2.sh
RUN chmod 777 /tmp/createOS_db2.sh
RUN /tmp/create_p8dbusers.sh