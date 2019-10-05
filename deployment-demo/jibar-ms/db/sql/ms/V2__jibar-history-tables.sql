

CREATE TABLE _jibar.jibar_history (LIKE _jibar.jibar);

CREATE TRIGGER versioning_trigger
BEFORE INSERT OR UPDATE OR DELETE ON _jibar.jibar
FOR EACH ROW EXECUTE PROCEDURE versioning(
  'sys_period', '_jibar.jibar_history', true
);

-- from https://www.postgresql.org/message-id/12884dd6-8b96-361b-4264-72ee778c8a88%40postgrespro.ru
ALTER TABLE _jibar.jibar ENABLE ALWAYS TRIGGER versioning_trigger;