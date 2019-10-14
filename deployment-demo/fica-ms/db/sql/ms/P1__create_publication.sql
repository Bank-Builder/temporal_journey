-- CREATE PUBLICATION fica_db FOR ALL TABLES;
-- https://stackoverflow.com/questions/55666099/how-to-add-new-schema-table-to-postgresql-publication-for-all-tables-without-d

CREATE PUBLICATION fica_db;
ALTER PUBLICATION fica_db ADD TABLE  _fica.fica_status;