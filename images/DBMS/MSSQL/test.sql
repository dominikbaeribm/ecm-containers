use $(DBName)
go
SELECT * from sysdatabases where name like '$(DBName)'
select name, filename from sysdatabases where name like '$(DBName)' and filename like '$(DataPath)'
go