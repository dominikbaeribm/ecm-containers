# IBM Case Manager Container Overview
The IBM® Case Manager container is a Docker image that enables you to quickly deploy IBM Case Manager without needing to do a traditional software install. The IBM Case Manager container image is based on IBM Case Manager 5.3.2, IBM Content Navigator 3.0.3 and the Liberty 17.0.0.3 release.

For more details about IBM Case Manager, see the [IBM Knowledge Center](https://www.ibm.com/support/knowledgecenter/SSCTJ4_5.3.2/com.ibm.casemgmttoc.doc/casemanager_5.3.2.htm)

# Limitations
Currently the following features are not available for this image:

- Limitations defined for ICN container
- IBM FileNet eForms integration
- IBM Forms integration
- IBM Content Manager integration
- IBM Business Process Manager integration
- Box integration
- Version control system integration
- Policy-based forms

Additional limitations:

- Extensions packages must be registered by using the IBM Case Manager configuration tool.
- External data service integration must be registered using the IBM Case Manager configuration tool.
- When you create a new second target object store, you must configure Business Rules by using the IBM Case Manager configuration tool. 
- CMIS and PE REST are no longer included in the IBM Case Manager application. CMIS is in a separate Docker container, while PE REST is hosted in the Content Platform Engine application. For more information, see [CMIS document](https://github.com/ibm-ecm/container-cmis) and [PE REST Service](https://www.ibm.com/support/knowledgecenter/en/SSGLW6_5.5.0/com.ibm.p8.pe.dev.doc/rest/rest_configure.htm).

# Known Issues
The following issues have been observed:

- Benign JAXRS exceptions being logged to the Liberty log
- Benign Tag Library exception being logged to the Liberty log during initial startup

# Requirements and prerequisites
Before you deploy and run the IBM Case Manager container image, confirm the following prerequisites:

- A Docker runtime environment (a Linux host or virtual machine with Docker installed)
- IBM FileNet P8 Content Platform Engine (CPE) container, deployed and configured
- Supported LDAP provider (Microsoft Active Directory or IBM Security Directory Server)
- Supported database provider (currently only IBM Db2 v10.5 or higher)

# Preparing for container installation

## 1. Prepare Content Platform Engine for IBM Case Manager.
- Create a DESIGN Object Store and a TARGET Object Store. For details, see [Creating IBM Case Manager object stores on Content Platform Engine](https://www.ibm.com/support/knowledgecenter/SSCTJ4_5.3.2/com.ibm.casemgmt.installing.doc/acmin048b.htm)
- Create a Workflow System, Connection Point, and Isolated Region in the TARGET Object Store. For details, see [Configuring a workflow system for IBM Case Manager](https://www.ibm.com/support/knowledgecenter/SSCTJ4_5.3.2/com.ibm.casemgmt.installing.doc/acmin049.htm)

## 2. Prepare the IBM Content Navigator configuration files.
This image based is based on IBM Content Navigator. To make IBM Case Manager work, you must first prepare the configuration files for the IBM Content Navigatory container image. See [Preparing for container installation](https://github.com/ibm-ecm/container-icn#preparing-for-container-installation) in the IBM Content Navigator container readme and confirm that all the listed steps are completed.

## 3. Create volumes for the container.
Create a folder on shared or local storage to hold the deployment specific configuration files as well as data that will live outside the container. In addition to the volumes that are created for IBM Content Navigator in the previous step, the IBM Case Manager container requires one extra volume.
<table>
<tr><td>Container folder </td><td>Host directory example</td><td>Description</td></tr>
<tr><td>/opt/ibm/icm/shared</td><td>/home/data/shared</td><td>IBM Case Manager network shared directory </td></tr>
</table>

## 4. Create the configuration details.

Create the following files with data that is specific to your environment:

- XML configuration file for DESIGN Object Store
- XML configuration file for each TARGET Object Store
- XML configuration file for any Case History stores or Case Analyzer stores

The XA datasource must set ```enableSharingForDirectLookups=true```, while the non-XA datasource must set ```enableSharingForDirectLookups=false```. Examples of these configuration files can be found in [samples folder](https://github.com/ibm-ecm/container-icm/tree/master/examples).

Copy the following XML configuration files to the configDropins/overrides directory in your Content Platform Engine container image:

- Design object store data source xml file
- Target object store data source xml file or files
- Case History store and/or Case Analyzer store data source xml files

## 5. Enable logging for Case Manager.
To enable logging of Case Manager messages, copy the sample [log4j.properties](https://github.com/ibm-ecm/container-icm/blob/master/examples/log4j.properties) file from the [samples folder](https://github.com/ibm-ecm/container-icm/tree/master/examples) to the configDropins/overrides volume map directory in your IBM Case Manager container image.  You may customize the file to change how Case Manager messages are logged.  If you wish to enable additional logging for other components, such as the Content Platform Engine client, you may combine this file with CPE client log4j.properties files.

## 6. Change the permissions for mounted directories.

Change the owner permission on the host mount directories to make sure that the owner permission is set properly. For simplicity, you can change the owner for the parent folder, for example:
```chown -R 501:500 /home/data/```

# Quickstart
## 1. Pull the IBM Case Manager Docker image.
Use the following commands with your own credentials:

- ```docker login -u [Docker ID] -p [Password]```
- ```docker pull ecmcontainers/ecm_earlyadopters_icm:earlyadopters-gm5.5```

## 2. Run the container in the Docker environment.
Reminder: A Linux host or virtual machine with Docker engine installed is required to run this image. You can use the information [here](https://docs.docker.com/engine/installation/) for Docker installation.

You can use the following sample command to run the IBM Case Manager container without monitoring: 

```docker run -d --name icm -p 9080:9080 -p 9443:9443  -v /home/data/plugins:/opt/ibm/plugins -v /home/data/viewerlog:/opt/ibm/viewerconfig/logs -v /home/data/viewercache:/opt/ibm/viewerconfig/cache -v /home/data/logs:/opt/ibm/wlp/usr/servers/defaultServer/logs -v /home/data/configDropins/overrides:/opt/ibm/wlp/usr/servers/defaultServer/configDropins/overrides -v /home/data/shared:/opt/ibm/icm/shared -e CPE_URL=http://CE_HOST:CE_PORT/wsi/FNCEWS40MTOM/  ecmcontainers/ecm_earlyadopters_icm:earlyadopters-gm5.5 ```

Compared with the IBM Content Navigator Docker image, two changes are required:

1. IBM Case Manager shared volumn map: -v /root/icmdata/shared:/opt/ibm/icm/shared
2. CPE_URL: the CPE WSI link

## 3. Configure Case Manager.
Before continuing to use IBM Case Manager, make sure you have done the following:

  - Configured a Content Platform Engine domain
  - Created DESIGN and TARGET object stores
  - Configured a Workflow System, PE region, and Isolated Region on the TOS
  - Set up the IBM Content Navigator configuration database
  
### 3.1 Run the IBM Case Manager Container configuration plug-in.
You can use the IBM Case Manager Container configuration plug-in to set up IBM Case Manager:

- Register the plug-in ```/opt/ibm/icm/config/ICMContainerConfigPlugin.jar```. To learn more, see [Registering and configuring plug-ins](https://www.ibm.com/support/knowledgecenter/SSEUEX_3.0.3/com.ibm.installingeuc.doc/eucco012.htm) in the IBM Content Navigator documentation.
- Create a new Repository connecting to your Design Object Store. To learn more, see [Connecting and configuring IBM FileNet Content Manager repositories](https://www.ibm.com/support/knowledgecenter/SSEUEX_3.0.3/com.ibm.installingeuc.doc/eucco015.htm) in the IBM Content Navigator documentation.
- Create a new desktop with the following values. To learn more, see [Definning desktops](https://www.ibm.com/support/knowledgecenter/SSEUEX_3.0.3/com.ibm.installingeuc.doc/eucco006.htm) in the IBM Content Navigator documentation. 
    - Name: IBM Case Manager Container configuration
    - ID: icmconfig
    - Description: Default desktop for Case Manager Container configuration
    - Repository: (Add the repository that you created in the previous step)
    - Layout: Uncheck the default selection and check IBM Case Manager Container configuration feature only.
- Log in to the new desktop (icmconfig) with the following link http://your-host-ip:9080/navigator/?desktop=icmconfig, and follow the instructions in the interface to complete the configuration.

After the configuration is complete, you can browse to http://your-host-ip:9443/navigator/?desktop=icm and http://your-host-ip:9080/CaseBuilder to start the IBM Case Manager tools.


# Usage
## 1. Set environment variables.  
Since IBM Case Manager image is based on IBM Content Navigator, all Navigator environment variables are inherited. You can see which variables are relevant for IBM Content Navigator in the Navigator container [here](https://github.com/ibm-ecm/container-icn#set-environment-variables). The following variables are specific to IBM Case Manager:
<table style="width:100%">
  <tr>
    <th>Name</th>
    <th>Description</th> 
    <th>Required</th>
    <th>Default Value</th>
  </tr>
    <tr>
    <td>CPE_URL</td>
    <td>CPE WSI URL, like http://CE_HOST:CE_PORT/wsi/FNCEWS40MTOM/</td> 
    <td>Yes</td>
    <td>N/A</td>
  </tr>
  <tr>
    <td>CMIS_URL</td>
    <td>CMIS URL, like http://CMIS_HOST:CMIS_PORT/fncmis/resources</td> 
    <td>No</td>
    <td>N/A</td>
  </tr>
    <tr>
    <td>production</td>
    <td>Whether it is a production environment, set "true" if it is, any other value will be taken as a development environment wanted.</td> 
    <td>No</td>
    <td>false</td>
  </tr>
  </table>

For monitoring environment variables, see [ECM Monitoring Github](https://github.com/ibm-ecm/container-monitoring#environment-variables)

## 2. Run IBM Case Manager container with monitoring.

Connect to the Bluemix metrics service by using IBM Cloud Monitoring metrics writer for space or organization scope, and connect to the Bluemix logging service using Bluemix multi-tenant lumberjack writer:

- ```docker run -d --name icn -p 9080:9080 -p 9443:9443 --hostname=icm1 -e MON_METRICS_WRITER_OPTION=2 -e MON_METRICS_SERVICE_ENDPOINT=metrics.ng.bluemix.net:9095 -e MON_BMX_GROUP=com.ibm.ecm.monitor. -e MON_BMX_METRICS_SCOPE_ID={space or organization guid} -e MON_BMX_API_KEY={IAM API key} -e MON_LOG_SHIPPER_OPTION=2 -e MON_BMX_SPACE_ID={tenant id} -e MON_LOG_SERVICE_ENDPOINT=logs.opvis.bluemix.net:9091 -e MON_BMX_LOGS_LOGGING_TOKEN={log logging token} -v /home/data/viewerlog:/opt/ibm/viewerconfig/logs -v /home/data/viewercache:/opt/ibm/viewerconfig/cache -v /home/data/plugins:/opt/ibm/plugins -v /home/data/logs:/opt/ibm/wlp/usr/servers/defaultServer/logs -v /home/data/configDropins/overrides:/opt/ibm/wlp/usr/servers/defaultServer/configDropins/overrides -v /home/data/shared:/opt/ibm/icm/shared -e CPE_URL=http://CE_HOST:CE_PORT/wsi/FNCEWS40MTOM/ docker pull ecmcontainers/ecm_earlyadopters_icm:earlyadopters-gm5.5```

## 3. Run the IBM Case Manager container on Kubernetes.
Following the [guide](https://github.com/ibm-ecm/container-icn#run-the-ibm-content-navigator-container-on-kubernetes) on Navigator to do it. Just remember to create ICM specific folder under /cfgstore:

```/cfgstore/icm/shared```

Then follow the guide in [Configure Case Manager](https://github.com/ibm-ecm/container-icm#3-configure-case-manager) section to configure Case Manager.
## 4. Optional ICM configuration.

### 4.1 Use Stand-alone Process Designer.
By default, Case Builder is configured to not launch the Process Designer applet.  To launch Process Designer, you can use the stand-alone Process Designer for CPE 5.5.0.  For more information, see [here](http://www-01.ibm.com/support/docview.wss?uid=swg27049480).  You do not need to install the Content Platform Engine Server component, just the Tools component.

After installing the stand-alone Process Designer application, IBM Case Manager requires an additional step:

- Copy the [ICMSolutionEdit.jar](https://github.com/ibm-ecm/container-icm/blob/master/examples/ICMSolutionEdit.jar) from the [samples folder](https://github.com/ibm-ecm/container-icm/tree/master/examples) to the lib folder in your Content Platform Engine installation directory in which you installed the standalone Process Designer. This file enables standalone Process Designer to support editing by multiple users.

### 4.2 Use the Case Synchronizer tool.
To set up the Case Synchronizer tool:

- Download [caseSynchronizer.jar](https://github.com/ibm-ecm/container-icm/blob/master/examples/caseSynchronizer.jar), either [caseSynchronizer.bat](https://github.com/ibm-ecm/container-icm/blob/master/examples/caseSynchronizer.bat) or [caseSynchronizer.sh](https://github.com/ibm-ecm/container-icm/blob/master/examples/caseSynchronizer.sh), [Jace.jar](https://github.com/ibm-ecm/container-icm/blob/master/examples/Jace.jar), and [log4j-1.2.13.jar](https://github.com/ibm-ecm/container-icm/blob/master/examples/log4j-1.2.13.jar) from the [samples folder](https://github.com/ibm-ecm/container-icm/tree/master/examples).
- Designate a folder as the starting folder (such as /opt/IBM/CaseManagement).  In that starting folder, create a lib directory and copy the above jar files to that directory.
- Update caseSynchronizer.bat or caseSynchronizer.sh:
    - Set STARTING_FOLDER to the designated folder that contains the lib directory with the downloaded jar files.
    - Edit CLASSPATH as appropriate (such as changing `configure/lib/Jace.jar` to `configure/Jace.jar` and changing `configure/lib/log4j-1.2.13.jar` to `lib/log4j-1.2.13.jar`)
    - Set JAVA_HOME location to the bin directory of the system's JRE.

For full information, see [Synchronizing cases with solution data](https://www.ibm.com/support/knowledgecenter/en/SSCTJ4_5.3.2/com.ibm.casemgmt.design.doc/acmdr005.htm).
 
### 4.3 Use the Precondition Checker tool.
 
To set up the Precondition Checker tool:

- Download [preconditionChecker.jar](https://github.com/ibm-ecm/container-icm/blob/master/examples/preconditionChecker.jar), either [preconditionChecker.bat](https://github.com/ibm-ecm/container-icm/blob/master/examples/preconditionChecker.bat) or [preconditionChecker.sh](https://github.com/ibm-ecm/container-icm/blob/master/examples/preconditionChecker.sh), [Jace.jar](https://github.com/ibm-ecm/container-icm/blob/master/examples/Jace.jar), and [log4j-1.2.13.jar](https://github.com/ibm-ecm/container-icm/blob/master/examples/log4j-1.2.13.jar) from the [samples folder](https://github.com/ibm-ecm/container-icm/tree/master/examples).
- Designate a folder as the starting folder (such as /opt/IBM/CaseManagement).  In that starting folder, create a lib directory and copy the above jar files to that directory.
- Update preconditionChecker.bat or preconditionChecker.sh:
    - Set STARTING_FOLDER to the designated folder that contains the lib directory with the downloaded jar files.
    - Edit CLASSPATH as appropriate (such as changing `configure/lib/Jace.jar` to `configure/Jace.jar` and changing `configure/lib/log4j-1.2.13.jar` to `lib/log4j-1.2.13.jar`)
    - Set JAVA_HOME location to the bin directory of the system's JRE.

For full information, see [Validating preconditions](https://www.ibm.com/support/knowledgecenter/en/SSCTJ4_5.3.2/com.ibm.casemgmt.design.doc/acmdr002.htm).

### 4.4 Configure required to support business rules.
On the CPE Docker container, there neesd to be an additional volume map for the IBM Case Manager rules repository directory:
		  
Container folder | Host directory example | Description
------------ | ------------- | ------------
/opt/ibm/icmrules | /home/data/icmrules | Rules repository |

### 4.5 Deploy EAR files associated with a Widgets Package or Extensions Package.
When registering a widgets packages or extensions package, the ICM tools will not deploy the EAR file on the WebSphere Liberty server.  You will need to manually deploy the EAR file on the WebSphere Liberty server:

- Extract the EAR file from the widgets package or extensions package
- Copy the EAR file to the configDropins/overrides volume map directory in your IBM Case Manager container image.
- Create a configuration xml file for the application.  It is recommended that a separate application configuration xml file be used just for the application, rather than editing the server.xml.  This application configuration xml file is also copied into the configDropins/overrides volume as the EAR file. See the WebSphere Liberty Knowledge Center topic on [Deploying applicaitons in Liberty]( https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/twlp_dep.html).

### 4.6 Other configurations.
As stated above under the Limitations section, there are some configurations that will require using the ICM configuration tool:

- Registering custom extensions packages
- Configuring business rules for multiple new target object stores.  Note: Configuring one target object for business rules or upgrading one or more target object stores that were previously configured for business rules does not require the ICM configuration tool and can be handled using the IBM Case Manager Container configuration plug-in.
- Registering an external data service.

To use the ICM configuration tool to perform these actions, do the following:

- Install IBM Case Manager on a system or use an existing IBM Case Manager installation. It doesn't matter where you install IBM Case Manager, as the IBM Case Manager configuration tool can configure CPE and IBM Content Navigator remotely.
- Launch Case Manager configuration tool and create a new configuration tool profile.
  - For the application server properties page:
     - Set Application server installation directory to: C:\ or /
     - Set Application server profile directory to: C:\ or /
     - Note: Do not click the Test Connection option as this will return an error
    
  - For the Content Navigator server properties page:
     - Set Content Navigator server name to the Navigator container host name
     - Set the Content Navigator port number (such as 9080)
     - Set the Content Navigator administrator user name and password
     - Use default values for all other parameters
     
  - For the Content Platform Engine server properties page:
     - Set the CPE server host name and port number (such as 9080)
     - Set the CPE EJB URL to the same value as the WSI URL (i.e., http instead of iiop)
     - Set the CPE domain administrator user name and password
     - Select the Design Object Store with the dropdown
     - You may leave the network shared directory as is. If you are using an existing installation, you might consider creating a new directory and using it for the network shared directory, as the tasks below will copy certain files to this directory.
     - Note: Do not click the Test Connection option as this will return an error
     
  - Select the tasks that are needed out of the following:
     - Configure Business Rules
     - Register the External Data Service
     - Deploy and Register Extensions Package

- If desired, make additional copies of these tasks.  For example, you may wish to make copies of Configure Business Rules for each Project Area/Target Environment, copies of Register the External Data Service for each solution with an external data service, and copies of Deploy and Register Extensions Package for each extensions package.
- Run the desired tasks:
  - Configure Business Rules
     - Select Project Area or target environment from the dropdown
     - Specify /opt/ibm/icmrules for Rules repository directory
     - Leave default value for "Rules persistent locale" (English (en)), or specify the desired rules persistence locale
     - Fill in a user with Full Control permissions on the target object store for Rule operations user name and password.

  - Register the External Data Service
     - Select the desired solution from the dropdown
     - (Production environment only) Select the target environment from the dropdown
     - Fill in the External Data Service URL

  - Deploy and Register Extensions Package
     - Fill in the path to the extensions package
     - Type anything for the application server node and application server name.  The value does not matter, as long as the fields are not blank.
     - Note: This task will fail, but will register the widgets package with the IBM Case Manager server.

- If you are registering an extensions package, follow the additional steps:
  - Copy the extensionsPackage folder from the network shared directory specified in the profile properties to the shared volume map directory in your IBM Case Manager container image.
  - If the extensions package contains an EAR file, follow the instructions under the section **3.5 Deploy EAR files associated with a Widgets Package or Extensions Package.**
  - Log into the admin desktop with the following link: http://your-host-ip:9080/navigator/?desktop=admin
  - Navigate to **Plug-ins** and then click **New Plug-in**.
  - Update the JAR file location to: /opt/ibm/icm/config/*plugin.jar*, where *plugin.jar* is the name of the plug-in jar for your extensions package.

# Support
Support can be obtained at [IBM® DeveloperWorks Answers](https://developer.ibm.com/answers/)
<br>
Use the ECM-CONTAINERS tag and assistance will be provided.<br>
*Note: Limited support available during Early Adopter Program*
