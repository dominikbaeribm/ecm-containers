
docker run -it -v /mnt/hgfs/data:/p8toolkit/config  —link=dev_ecmch_cpe1 -e application=mefas p8toolkit bash

/p8toolkit/config -> ./Env/Stage/Application (contains Excel for generation of master properties)
e.g. /Env/VMWARE/MEFAS

-link points to the CPE

-e application=mefas


#Generating master.properties file:
java -jar P8Toolkit52.jar master -app MEFAS -env /p8toolkit/config/Env -stage VMWARE

#Running a deployment job
java -Dconfigdir=/p8toolkit/config/Env/VMWARE -jar P8Toolkit52.jar model -header -path /p8toolkit/config/Env/VMWARE/MEFAS/test -res 1 -tar 1

Remark: -header doesn't work yet

Other calls which are not yet added to the jar command line options:
#retrieving a value for a key
java -cp ./P8Toolkit52.jar -Dconfigdir=/p8toolkit/config/Env/VMWARE 
com.ibm.ecm.dptk.deployment.process.utility.ConfigLocatorCmdLine cpeconfigure.1.P8User
#retrieving an encrypted value for a key
java -cp ./P8Toolkit52.jar -Dconfigdir=/p8toolkit/config/Env/VMWARE com.ibm.ecm.dptk.deployment.process.utility.ConfigLocatorCmdLine cpeconfigure.1.P8Password 1
#get Information about the current Deployment Toolkit
java -cp ./P8Toolkit52.jar  com.ibm.ecm.dptk.deployment.process.utility.getInfo
#generating a bunch of GUIDs
java -cp ./P8Toolkit52.jar -Dconfigdir=/p8toolkit/config/Env/VMWARE com.ibm.ecm.dptk.deployment.process.infrastructure.UUIDGenerator
#generating an encrypted value
java -cp ./P8Toolkit52.jar -Dconfigdir=/p8toolkit/config/Env/VMWARE com.ibm.ecm.dptk.deployment.process.utility.PasswordEncoder Password01