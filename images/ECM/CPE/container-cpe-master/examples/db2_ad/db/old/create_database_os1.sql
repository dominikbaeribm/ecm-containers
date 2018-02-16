drop database os1;
--update dbm cfg using dftdbpath /db2_datavol_db2inst1/;
create database os1 using codeset UTF-8 territory en_US collate using UCA500R1_S1;
connect to os1;
update db cfg using cur_commit ON;
update db cfg using APPLHEAPSZ 2560;
update db cfg using cur_commit ON;
create bufferpool BPDATA32K size 1000 pagesize 32K;
create bufferpool BPINDEX32K size 1000 pagesize 32K;
create bufferpool BPLOB32K size 1000 pagesize 32K;
create bufferpool BPUSER32K size 1000 pagesize 32K;
create bufferpool BPSYS32K size 1000 pagesize 32K;

create large tablespace CEDATA_TS 
	in nodegroup ibmdefaultgroup
	pagesize 32K 
	managed by database 
	using (file '/db2_datavol_db2inst1/db2inst1/NODE0000/OS1/CEDATA_TS1.c001' 150 M) 
	extentsize 32 
	prefetchsize automatic 
	bufferpool BPDATA32K 
	autoresize yes increasesize  10 percent 
	maxsize  500 M 
	dropped table recovery ON
;
create large tablespace CEINDX_TS1
       in nodegroup ibmdefaultgroup
       pagesize  32K
       managed by database
       using (file '/db2_datavol_db2inst1/db2inst1/NODE0000/OS1/CEINDX_TS1.c001' 150 M)
       extentsize 32
       prefetchsize automatic
       bufferpool BPINDEX32K
       autoresize yes increasesize  10 percent
       maxsize  500 M
       dropped table recovery ON
;
create large tablespace CELOB_TS1
       in nodegroup ibmdefaultgroup
       pagesize  32K
       managed by database
       using (file '/db2_datavol_db2inst1/db2inst1/NODE0000/OS1/CELOB_TS1.c001' 150 M)
       extentsize 32
       prefetchsize automatic
       bufferpool BPLOB32K
       autoresize yes increasesize  10 percent
       maxsize  500 M
       dropped table recovery ON
;
create user temporary  tablespace USERTEMPORARY
       in nodegroup ibmdefaultgroup
       pagesize  32K
       managed by system
       using ('/db2_datavol_db2inst1/db2inst1/NODE0000/OS1/USERTEMPORARY')
       extentsize 32
       prefetchsize automatic
       bufferpool BPUSER32K
       dropped table recovery OFF;
create system temporary tablespace TEMPSPACE32
	pagesize  32K
	managed by system
	using ('/db2_datavol_db2inst1/db2inst1/NODE0000/OS1/TEMPSPACE32')
	extentsize 16 prefetchsize 32
	bufferpool BPSYS32K
	;
grant use of tablespace CEDATA_TS to PUBLIC;
grant use of tablespace CEINDX_TS1 to PUBLIC;
grant use of tablespace CELOB_TS1 to PUBLIC;
grant use of tablespace USERTEMPORARY to PUBLIC;
REVOKE USE OF TABLESPACE USERSPACE1 FROM PUBLIC;
GRANT CREATETAB, CONNECT ON DATABASE TO USER os1;
terminate;
