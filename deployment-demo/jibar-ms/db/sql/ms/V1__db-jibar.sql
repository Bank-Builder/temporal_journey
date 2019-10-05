--- We create the JIBAR (Johannesburg Interbank Agreed Rate) table
--- and add some real data from the JSE for the 1 month jibar rate.
SET timezone='Africa/Johannesburg';

CREATE SCHEMA _jibar;

CREATE TABLE _jibar.jibar (id SERIAL PRIMARY KEY, rate TEXT NOT NULL, valid_from TIMESTAMP WITH TIME ZONE, updated_by TEXT NOT NULL);
ALTER TABLE _jibar.jibar ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);
