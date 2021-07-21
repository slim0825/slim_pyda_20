select 
a.title title_a,
a.language_id language_id_a,
b.name name_b,
b.language_id language_id_b
from 
film a
left join language b on a.language_id=b.language_id;


select 
a.title,
a.language_id,
b.name,
b.language_id
from 
film a
left join language b on a.language_id=b.language_id;

select 
a.title,
b.name,
from 
film a
left join language b on a.title=b.name;