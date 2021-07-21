create table lang_nation1 (
PRIMARY KEY (language_id, nationality_id),
	language_id int2 references table1(language_id),
	nationality_id int2 references table2(nationality_id)
	)
	
create table nation_country1 (
PRIMARY KEY (nationality_id, countries_id),
	nationality_id int2 references table2(nationality_id),
	countries_id int2 references table3(countries_id)
	)
