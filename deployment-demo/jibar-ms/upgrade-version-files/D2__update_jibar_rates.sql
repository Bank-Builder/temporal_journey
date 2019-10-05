-- The JSE (Johannesburg Stock Exchange) data imported for the JIBAR demo has missing rate data, so we will run a query to just take the previous row's 
-- rate and insert it into the current row if the current row's rate data is 0.000. We run it a few time as there is more than one consecutive row with 
-- 0.000 needing replacing. This assumes the first row is never 0.000.

WITH r AS (                                                                           
  SELECT jn.valid_from as new_valid_from, jn.rate as now_rate, jo.rate as new_rate        
  FROM _jibar.jibar jn                                                                           
  LEFT JOIN _jibar.jibar jo ON jo.valid_from + INTERVAL '1 day' = jn.valid_from                  
  WHERE jn.rate = '0.000')                                                                
UPDATE _jibar.jibar SET rate = r.new_rate, updated_by ='system correction'                       
FROM r                                                                                    
WHERE valid_from = r.new_valid_from;