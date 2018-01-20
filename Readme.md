# ecm-containers
Auxiliary Repository for deploying ECM docker containers 


Here you should find everything to create a complete working IBM Case Manager, IBM Content Manager infrastructure
running directly from docker containers.
There are 5 areas of interest:

1) LDAP: an image containing an AD with preconfigured users and groups  [AD](https://github.com/dominikbaeribm/ecm-containers/blob/master/images/AD/README.md "ECM-AD")  
2) DBMS: an image containing all databases with preconfigured users, logins, tablespaces etc.  
3) CPE:	 all auxiliary scripts to produce the configuration artefacts for the official IBM Content Platform image  
4) ICND: all auxiliary scripts to produce the configuration artefacts for the official IBM Navigator image  
5) P8Toolkit: an additional docker image for running infrastructure related and deployment related activities against the CPE and ICN images  


CSS, CMIS and ICM later   
Status:  
Status: LDAP 1) completed  
Status: DBMS 2) MSSQL:  
					failed with mssql due to MSDTC not available on unix. trying DB2 and oracle 
		   		DB2 in a container currently only with the db2inst1 user, but with persistent datalayer available.  
		   		https://github.com/dominikbaeribm/ecm-containers/tree/master/images/DBMS/DB2 
		   		p8users implemented.
		   		Database creation scripts to be provided soon.

Goal:
It should be possible to clone this repository into an Ubuntu host or Ubuntu on vmware   
and to be running ICN within 1h.  


Variables: 
	Name of the application/project (insuranceX,bankingY, ...)  
	Stage of the environment (dev/test/integration/preprod/production/education)  
	The shellscripts will only start 1 docker container (1 instance of each docker image) initially - later kubernetes support will be added.  
	
Users:  
	*p8admin	GCDAdmin and ICNAdmin  
	cpeop_user	CPE operations User  	
	*os1_user	Objectstore1 User  
	dos_user	Design Objectstore User  
	sos_user	Stagging Objectstore User  
	tos_user	TargetObjectstore User  
	*icn_user	ICN desktop User   
	icm_user	ICM desktop User  
	ldap_user	Binduser  
Groups  
	*p8admins	GCDAdmins  
	cpeop_users	CPE operations User Group	 
	*os1_users	Objectstore1 User Group  
	dos_users	Design Objectstore User Group  
	sos_users	Stagging Objectstore User Group  
	tos_users	TargetObjectstore User Group  
	icn_users	ICN desktop User Group  
	icm_users	ICM desktop User Group  
  
Memberships:  
	1:1  
	 
Built-in users: Administrator	  		
	
	
