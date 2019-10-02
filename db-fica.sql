--- We create the fica_status (FICA - Financial Intelligence Centre Act) table
--- and add some dummy data with which to demonstrate the concepts
SET timezone='Africa/Johannesburg';
CREATE TABLE fica_status ( id SERIAL PRIMARY KEY, name text NOT NULL, status text NOT NULL, changed_by text NOT NULL );

ALTER TABLE fica_status ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);

--- We don't insert the history table in the micro-service because we will
--- be using logical replication and the history will be triggered in the
--- subscribing canonical database

INSERT INTO fica_status (name, status, changed_by) 
   VALUES ('mr big', 'non-compliant', 'vanessa'),
          ('mr cool', 'frozen', 'tracy'),
          ('mr frugal', 'compliant', 'betty');

