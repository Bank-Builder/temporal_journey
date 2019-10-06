INSERT INTO _bank.bank 
		  (name, universal_branch_code, updated_by) 
   VALUES 
		  ('UNIBANK', 'N/A', 'D1 migration');
		  
		  
UPDATE _bank.bank SET universal_branch_code = '632005' where name = 'ABSA';
UPDATE _bank.bank SET universal_branch_code = '470010' where name = 'CAPITEC BANK';