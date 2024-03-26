--Snowflake Code:
---------------------------
use role ACCOUNTADMIN;

drop database if exists s3_to_snowflake;

create database if not exists s3_to_snowflake;

--Specify the active/current database for the session.
use s3_to_snowflake;


--Storage Integration Creation
create or replace stage s3_to_snowflake.PUBLIC.Snow_stage url="s3://{}/" 
credentials=(aws_key_id='{}'
aws_secret_key='{}');



list @s3_to_snowflake.PUBLIC.Snow_stage;

--File Format Creation
create or replace file format my_json_format
type = json;

--Table Creation
create or replace external table s3_to_snowflake.PUBLIC.customers_actions with location = @s3_to_snowflake.PUBLIC.Snow_stage file_format ='my_json_format';

select * from s3_to_snowflake.PUBLIC.customers_actions;

ALTER EXTERNAL TABLE s3_to_snowflake.PUBLIC.customers_actions REFRESH;

show external tables;


select * from s3_to_snowflake.PUBLIC.customers_actions;

--Query the table
select trim(parse_json(VALUE):email,'"') as Email,trim(parse_json(VALUE):event,'"') as Event_type,
trim(parse_json(VALUE):ip,'"') as IP,trim(parse_json(VALUE):reason,'"') as reason
from  s3_to_snowflake.PUBLIC.customers_actions;