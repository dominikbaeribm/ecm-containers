# ecm-containers
Auxiliary Repository for deploying ECM docker containers


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
	
	
