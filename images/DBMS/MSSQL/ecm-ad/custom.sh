#!/bin/bash

#
# Custom script
#


# add groups
samba-tool group add P8ADMINS



# add users
samba-tool user add p8admin Password01
samba-tool user add ldap_user Password01



# add users to groups
samba-tool group addmembers P8ADMINS p8admin
