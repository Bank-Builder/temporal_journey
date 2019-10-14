SET timezone='Africa/Johannesburg';

CREATE SCHEMA _reference;

CREATE TABLE _reference.title ( id SERIAL PRIMARY KEY, 
		description text NOT NULL, 
		updated_by TEXT NOT NULL);

ALTER TABLE _reference.title ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);


