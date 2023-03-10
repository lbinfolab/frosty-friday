create storage integration week37_integration
type = external_stage
storage_provider = 's3'
storage_aws_role_arn = 'arn:aws:iam::184545621756:role/week37'
enabled = true
storage_allowed_locations = ('s3://frostyfridaychallenges/challenge_37/');

show integrations;

create or replace stage week37_stage
url = 's3://frostyfridaychallenges/challenge_37/'
storage_INTEGRATION =  week37_integration
DIRECTORY = ( enable = TRUE  refresh_on_create = true);


SELECT * FROM DIRECTORY( @week37_stage );

SELECT 
relative_path, 
size, 
build_scoped_file_url(@week37_stage, relative_path) as scoped_url, --scoped access internal users
build_stage_file_url(@week37_stage, relative_path) as staged_url, -- permanent access to stage
GET_PRESIGNED_URL(@week37_stage, relative_path) as presigned_url -- external users access

FROM DIRECTORY( @week37_stage );
