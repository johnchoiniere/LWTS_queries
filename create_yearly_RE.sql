create table run_expectancy_retro_pbp AS 
select
	yearID,
	outs_ct AS outs,
	start_bases_cd AS base_state,
	count(*) AS count,
	sum(fate_runs_ct) + sum(event_runs_ct) AS inn_runs,
	(sum(fate_runs_ct) + sum(event_runs_ct))/count(*) AS run_expectancy
from
	events_regseason
where
	yearID>1973
	AND ((inn_ct < 9) OR (inn_ct = 9 AND bat_team_id = away_team_id))
group by 
	yearID,outs,base_state
order by yearID asc, outs asc, base_state
