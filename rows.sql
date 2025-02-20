-- 获取每个表的行数
SELECT 
    TABLE_NAME, 
    TABLE_ROWS
FROM 
    INFORMATION_SCHEMA.TABLES
WHERE 
    TABLE_SCHEMA = 'your_database_name';
