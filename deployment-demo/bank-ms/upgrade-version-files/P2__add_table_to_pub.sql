-- CREATE PUBLICATION bank_db FOR ALL TABLES;
-- https://stackoverflow.com/questions/55666099/how-to-add-new-schema-table-to-postgresql-publication-for-all-tables-without-d


ALTER PUBLICATION bank_db ADD TABLE  _bank.branches;

-- ALTER SUBSCRIPTION bank_db REFRESH PUBLICATION;