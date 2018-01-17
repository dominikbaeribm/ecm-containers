use $(DBName)
go
EXEC sp_addlogin $(DBUser), $(DBPassword), $(DBName), us_english
go
create user $(DBUser) for login $(DBUser)
go
EXEC sp_addrolemember  db_owner,  $(DBUser)
go
use master
go
EXEC sp_grantdbaccess  $(DBUser), $(DBUser)
go
EXEC sp_addrolemember SqlJDBCXAUser, $(DBUser)
go
ALTER USER $(DBUser) WITH DEFAULT_SCHEMA = dbo;
go
