
CREATE TABLE _bank.branches (
	id SERIAL PRIMARY KEY,
	bank_id smallint,
	name text NOT NULL,
	code text NOT NULL,
	updated_by TEXT NOT NULL
);

ALTER TABLE _bank.branches ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);

ALTER TABLE _bank.branches ADD CONSTRAINT "fk_bank.id" FOREIGN KEY (id)
REFERENCES _bank.bank (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;

