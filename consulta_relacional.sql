select m.id,title,rating,awards,genre_id,g.name
from movies as m
inner join genres as g
on m.genre_id = g.id
where m.genre_id >= 5
having m.title like "A%"
order by m.id;
