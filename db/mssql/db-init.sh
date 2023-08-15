#wait for the SQL Server to come up
sleep 30s

echo "running bootstrap tables.."
#run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Query063@ -d master -i db-init.sql