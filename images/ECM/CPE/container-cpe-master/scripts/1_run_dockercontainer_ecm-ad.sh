sudo docker run --privileged -p 389:389 -p 389:389/udp -p 3268:3268 \
-e "SAMBA_DOMAIN=SAMDOM"  -e "SAMBA_REALM=SAMDOM.EXAMPLE.COM" -e "ROOT_PASSWORD=Password01" -e "SAMBA_ADMIN_PASSWORD=Password01" -e "LDAP_ALLOW_INSECURE=true" \
--name ecmad --dns 127.0.0.1 -d ecm-ad 

