
CREATE TABLE _reference.title_history (LIKE _reference.title);

CREATE TRIGGER versioning_trigger
BEFORE INSERT OR UPDATE OR DELETE ON _reference.title
FOR EACH ROW EXECUTE PROCEDURE versioning(
  'sys_period', '_reference.title_history', true
);

-- from https://www.postgresql.org/message-id/12884dd6-8b96-361b-4264-72ee778c8a88%40postgrespro.ru
-- using ALWAYS so that updates to data on both ms & canonical are reflected to the _history table
ALTER TABLE _reference.title ENABLE ALWAYS TRIGGER versioning_trigger;