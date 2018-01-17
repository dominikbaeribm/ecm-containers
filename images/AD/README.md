# Docker container implementing AD for ECM containers dev and test environments

This docker container was copied from Ralph Sippl and the custom.sh was adapted.

This repository is unmaintained. Check if one of the forks are up to date.

Run these commands to build, start and stop the container
```
# build ecm-ad
docker build . -t ecm-ad
# run ecm-ad image with passwords set to Password01
docker run --privileged -p 389:389 -p 389:389/udp -p 3268:3268 -e "SAMBA_DOMAIN=SAMDOM"  -e "SAMBA_REALM=SAMDOM.EXAMPLE.COM" -e "ROOT_PASSWORD=Password01" -e "SAMBA_ADMIN_PASSWORD=Password01" -e "LDAP_ALLOW_INSECURE=true" --name dc1 --dns 127.0.0.1 -d ecm-ad

# samba volume could be mounted if needed.
docker run --privileged -v ${PWD}/samba:/var/lib/samba ....

# stop and remove ecm-ad image
docker stop dc1 && docker rm dc1
# remove local ecm-ad 
sudo rm -rf samba
```
You can of course change the domain and realm to your liking.

You get the IP-address of the running machine by issuing `docker inspect dc1 | grep IPAddress` and the root user's
password as well as other passwords by running `docker logs dc1 2>&1 | head -3`. You should then be able to log in with SSH.

One fast check to see that Kerberos talks with Samba:
```
docker exec -it dc1 bash
root@1779834e202b:~# kinit administrator@SAMDOM.EXAMPLE.COM
Password for administrator@SAMDOM.EXAMPLE.COM:
Warning: Your password will expire in 41 days on Thu Jul 10 19:36:55 2014
root@1779834e202b:~# klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: administrator@SAMDOM.EXAMPLE.COM

Valid starting     Expires            Service principal
05/29/14 19:45:53  05/30/14 05:45:53  krbtgt/SAMDOM.EXAMPLE.COM@SAMDOM.EXAMPLE.COM
        renew until 05/30/14 19:45:43

```

LDAP search within the container:
```
ldapsearch -b "DC=samdom,DC=example,DC=com" "(&(objectClass=user)(name=administrator))"
```

LDAP search outside the container: search user administrator with bind user ldap_user:
```
ldapsearch -h 192.168.1.215 -p 389 -b "DC=samdom,DC=example,DC=com" "(&(objectClass=user)(name=administrator))" -D "CN=ldap_user,CN=Users,DC=samdom,DC=example,DC=com" -W
```

Edit [custom.sh](custom.sh) to add custom logic executed at the and of supervisord. 

## Allow Insecure LDAP Authentication

Simple auth via LDAP fails if you have an unencrypted connection ("BindSimple: Transport encryption required").

For debugging purposes, you can avoid this error by setting the LDAP_ALLOW_INSECURE environment variable to true.

DO NOT USE LDAP_ALLOW_INSECURE IN PRODUCTION!



## LDAP explorers

I used [JXplorer](http://jxplorer.org/) to explore the LDAP-schema. To log in you need to input something like this:
![JXplorer example](http://i.imgur.com/LniIp22.png)


## Resources
I followed the guide on Samba's wiki pages https://wiki.samba.org/index.php/Samba_AD_DC_HOWTO

Port usage: https://wiki.samba.org/index.php/Samba_port_usage

## Port forwarding command
If you want the DC to be reachable through the host's IP you need starting the container with --priviledged 
```
For further explanations please go to the original project from ralph sippl
See https://hub.docker.com/r/rsippl/samba-ad-dc/

