create table LWTS_bbtype AS
select
	a.year_ID,
	a.event_cd,
	a.battedball_cd,
	count(a.event_cd) AS count,
	sum(b.run_expectancy)/count(a.event_cd) AS re_pre,
	sum(c.run_expectancy + a.event_runs_ct)/count(a.event_cd) AS re_post,
	(sum(c.run_expectancy + a.event_runs_ct)/count(a.event_cd))-(sum(b.run_expectancy)/count(a.event_cd)) AS re_total
from
	events_regseason_base_state a
inner join run_expectancy_retro_pbp_new b
on (a.year_ID = b.year_ID AND a.outs_ct = b.outs AND a.start_bases_cd = b.base_state)
inner join run_expectancy_retro_pbp_new c
on (a.year_ID = c.year_ID AND (a.outs_ct+a.event_outs_ct) = c.outs AND a.end_bases_cd = c.base_state)
group by 
	a.year_ID, 
	a.event_cd, 
	a.battedball_cd
