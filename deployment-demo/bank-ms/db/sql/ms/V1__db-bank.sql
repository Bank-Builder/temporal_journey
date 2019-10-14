SET timezone='Africa/Johannesburg';

CREATE SCHEMA _bank;

CREATE TABLE _bank.bank ( id SERIAL PRIMARY KEY, name text NOT NULL, 
		universal_branch_code text NOT NULL, 
		updated_by TEXT NOT NULL);

ALTER TABLE _bank.bank ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);

