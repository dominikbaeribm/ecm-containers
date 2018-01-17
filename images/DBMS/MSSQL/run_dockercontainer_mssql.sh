sudo docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Password01' \
   --name 'sql1' -p 1402:1433 \
   -v sql1data:/var/opt/mssql \
   -d microsoft/mssql-server-linux:2017-latest