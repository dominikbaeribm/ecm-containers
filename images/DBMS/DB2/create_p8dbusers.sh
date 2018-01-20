#creating database users 

#setting a common password
userpwd=Password01
#gcd
useradd gcd
echo "gcd:$userpwd" | chpasswd
#first objectstore
useradd os1
echo "os1:$userpwd" | chpasswd
#second objectstore
useradd os2
echo "os2:$userpwd" | chpasswd
#desktop database
useradd icn
echo "icn:$userpwd" | chpasswd
#design objectstore
useradd dos
echo "dos:$userpwd" | chpasswd
#stagging objectstore
useradd sos
echo "sos:$userpwd" | chpasswd
#target objectstore
useradd tos
echo "tos:$userpwd" | chpasswd
#casehistory
useradd hist
echo "hist:$userpwd" | chpasswd




