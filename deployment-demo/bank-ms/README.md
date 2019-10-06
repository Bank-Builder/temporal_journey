


-- curl -X GET localhost:8183/banks/
-- curl -X PUT localhost:8183/banks/2 -H "Content-type:application/json" -d "{\"name\":\"CAPITEC BANK\",\"universalBranchCode\":\"wrong-again-470010\",\"updatedBy\":\"rest api call 1\"}" | jq '.'

-- curl -X GET localhost:8183/branches/
-- curl -X PUT localhost:8183/branches/2 -H "Content-type:application/json" -d "{\"bankId\":\"2\",\"name\":\"ABSA 3\",\"code\":\"wrong-again-321\",\"updatedBy\":\"rest api call 1\"}" | jq '.'
-- curl -X PUT localhost:8183/branches/2 -H "Content-type:application/json" -d "{\"bankId\":\"2\",\"name\":\"ABSA 3\",\"code\":\"321\",\"updatedBy\":\"rest api call 2\"}" | jq '.'