--- We create the JIBAR (Johannesburg Interbank Agreed Rate) table
--- and add some real data from the JSE for the 1 month jibar rate.
SET timezone='Africa/Johannesburg';
CREATE TABLE jibar (id SERIAL PRIMARY KEY, rate TEXT NOT NULL, valid_from TIMESTAMP WITH TIME ZONE, updated_by TEXT NOT NULL);
ALTER TABLE jibar ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);

--- We don't insert the history table in the microservice because we will
--- be using logical replication and the history will be triggered in the
--- subscribing canonical database
INSERT INTO jibar (valid_from, rate, updated_by) 
VALUES (to_timestamp('01/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('02/02/2019', 'dd/mm/yyyy'), '0.000', 'JSE-data-feed'),
       (to_timestamp('03/02/2019', 'dd/mm/yyyy'), '0.000', 'JSE-data-feed'),
       (to_timestamp('04/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('05/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('06/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('07/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('08/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('09/02/2019', 'dd/mm/yyyy'), '0.000', 'JSE-data-feed'),
       (to_timestamp('10/02/2019', 'dd/mm/yyyy'), '0.000', 'JSE-data-feed'),
       (to_timestamp('11/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('12/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('13/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('14/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('15/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('16/02/2019', 'dd/mm/yyyy'), '0.000', 'JSE-data-feed'),
       (to_timestamp('17/02/2019', 'dd/mm/yyyy'), '0.000', 'JSE-data-feed'),
       (to_timestamp('18/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('19/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('20/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('21/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('22/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('23/02/2019', 'dd/mm/yyyy'), '0.000', 'JSE-data-feed'),
       (to_timestamp('24/02/2019', 'dd/mm/yyyy'), '0.000', 'JSE-data-feed'),
       (to_timestamp('25/02/2019', 'dd/mm/yyyy'), '6.967', 'JSE-data-feed'),
       (to_timestamp('26/02/2019', 'dd/mm/yyyy'), '6.975', 'JSE-data-feed'),
       (to_timestamp('27/02/2019', 'dd/mm/yyyy'), '6.975', 'JSE-data-feed'),
       (to_timestamp('28/02/2019', 'dd/mm/yyyy'), '6.975', 'JSE-data-feed');


