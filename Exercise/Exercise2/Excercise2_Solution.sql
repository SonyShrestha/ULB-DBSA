-- Question 3.1
select most_common_vals from pg_stats
where schemaname='public'
and tablename='film'
and attname='rating';

select (most_common_vals::text::varchar[])[1] from pg_stats
where schemaname='public'
and tablename='film'
and attname='rating';


-- Question 3.2
select null_frac*100 from pg_stats
where schemaname='public'
and tablename='rental'
and attname='return_date' 


-- Question 3.3
select * from pg_stats
where schemaname='public'
and tablename='film'
and attname='length'