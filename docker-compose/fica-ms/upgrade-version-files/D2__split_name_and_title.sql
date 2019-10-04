UPDATE 
	_fica.fica_status
SET 
	title = substring(name from 0 for position(' ' in name)),
	name = substring(name from position(' ' in name)+1 for char_length(name)-position(' ' in name)), 
	changed_by = 'data fix D2__split_name_and_title.sql'

	;
