--- create the canonical database as a replica of the various microservices
--- logical replication does not replicalte DDL (Data Definition Language) commands,
--- but it does replicate DML (Data Manipulation Language) commands
---
--- for the fica microservice
CREATE TABLE fica_status (id SERIAL PRIMARY KEY, name text NOT NULL, status text NOT NULL, changed_by text NOT NULL);
ALTER TABLE fica_status ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);

--- for the jibar microservice
CREATE TABLE jibar (id SERIAL PRIMARY KEY, rate text NOT NULL, valid_from TIMESTAMP WITH TIME ZONE NOT NULL, updated_by text NOT NULL);
ALTER TABLE jibar ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);

--- temporal history tables for both
CREATE TABLE fica_status_history (LIKE fica_status);
CREATE TABLE jibar_history (LIKE jibar);

--- we have already add the versioning function so
--- we can add the triggers

CREATE TRIGGER versioning_trigger
BEFORE UPDATE OR DELETE ON fica_status 
FOR EACH ROW EXECUTE PROCEDURE versioning('sys_period', 'fica_status_history', true);


CREATE TRIGGER versioning_trigger
BEFORE UPDATE OR DELETE ON jibar 
FOR EACH ROW EXECUTE PROCEDURE versioning('sys_period', 'jibar_history', true);

ALTER TABLE fica_status ENABLE ALWAYS TRIGGER versioning_trigger;
ALTER TABLE jibar ENABLE ALWAYS TRIGGER versioning_trigger;

