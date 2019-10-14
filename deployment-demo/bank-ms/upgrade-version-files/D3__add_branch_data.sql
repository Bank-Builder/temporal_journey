INSERT INTO _bank.branch 
		  (bank_id, name, code, updated_by) 
   VALUES (2, 'ABSA 1', '740000', 'D3 migration'),
  		  (2, 'ABSA 2', '632005', 'D3 migration'),
		  (2, 'ABSA 3', 'wrong-code-321', 'D3 migration');
		  
		  
UPDATE _bank.branch SET code = '321', updated_by = 'D3 migration' where name = 'ABSA 3';