-- CREATE PUBLICATION jibar_db FOR ALL TABLES;

CREATE PUBLICATION jibar_db;
ALTER PUBLICATION jibar_db ADD TABLE  _jibar.jibar;
ALTER PUBLICATION jibar_db ADD TABLE  _jibar.jibar_history;