--- We create the fica_status (FICA - Financial Intelligence Centre Act) table
--- and add some dummy data with which to demonstrate the concepts
SET timezone='Africa/Johannesburg';

CREATE SCHEMA _fica;

CREATE TABLE _fica.fica_status ( id SERIAL PRIMARY KEY, name text NOT NULL, 
		status text NOT NULL, changed_by text NOT NULL );

ALTER TABLE _fica.fica_status ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);

