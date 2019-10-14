
CREATE TABLE _fica.fica_status_history (LIKE _fica.fica_status);

CREATE TRIGGER versioning_trigger
BEFORE INSERT OR UPDATE OR DELETE ON _fica.fica_status
FOR EACH ROW EXECUTE PROCEDURE versioning(
  'sys_period', '_fica.fica_status_history', true
);

-- from https://www.postgresql.org/message-id/12884dd6-8b96-361b-4264-72ee778c8a88%40postgrespro.ru
-- using ALWAYS so that updates to data on both ms & canonical are reflected to the _history table
ALTER TABLE _fica.fica_status ENABLE ALWAYS TRIGGER versioning_trigger;