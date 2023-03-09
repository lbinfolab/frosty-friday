create or replace table week25 (json variant);

CREATE  OR REPLACE  FILE FORMAT json_file_format
	 TYPE = JSON;

copy into week25 from 's3://frostyfridaychallenges/challenge_25/ber_7d_oct_clim.json'
file_format=json_file_format;

select json:weather from WEEK25;
select json:sources from week25;


select  *
from week25 , lateral flatten (json);

select *
from WEEK25
  , lateral flatten (json:weather) as wtr
  , lateral flatten (value);

select *  from (select json:weather from WEEK25);

SELECT  
value['timestamp'] as datetime, 
value['icon'] as icon,
value['precipitation'] as prcp,
value['temperature'] as temp,
value['relative_humidity'] as humidity,
value['wind_speed'] as windspeed
FROM WEEK25,
LATERAl FLATTEN( input => json:weather) ;

create view parsedjson as (SELECT  
value['timestamp'] as datetime, 
value['icon'] as icon,
value['precipitation'] as prcp,
value['temperature'] as temp,
value['relative_humidity'] as humidity,
value['wind_speed'] as windspeed
FROM WEEK25,
LATERAl FLATTEN( input => json:weather));



SELECT 
  date(DATE_TRUNC('day', TO_TIMESTAMP_NTZ(datetime))) AS date,
  sum(prcp) as precipitation,
  avg(temp) as temp,
  avg(humidity) as humidity,
  avg(windspeed) as windspeed,
  listagg(DISTINCT icon,' ') as icon
FROM 
  parsedjson
GROUP BY 
  1
ORDER BY 
  1 ASC;


create or replace table week25 as 
SELECT 
  date(DATE_TRUNC('day', TO_TIMESTAMP_NTZ(datetime))) AS date,
  sum(prcp) as precipitation,
  avg(temp) as temp,
  avg(humidity) as humidity,
  avg(windspeed) as windspeed,
  listagg(DISTINCT icon,' ') as icon
FROM 
  parsedjson
GROUP BY 
  1
ORDER BY 
  1 ASC;

select * from week25 limit 10;
