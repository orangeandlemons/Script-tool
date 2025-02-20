SELECT CONCAT('CHECKSUM TABLE ', table_name, ';') 
FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'your_database_name';


mysql -u username -p your_database_name < /path/to/your/checksum_queries.sql >> /path/to/output.txt
