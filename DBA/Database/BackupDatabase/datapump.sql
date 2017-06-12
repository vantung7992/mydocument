DECLARE
  l_dp_handle       NUMBER;
  l_status          varchar2(200);
BEGIN
  l_dp_handle := DBMS_DATAPUMP.open(
    operation   => 'IMPORT', -- 'IMPORT, EXPORT',
    job_mode    => 'SCHEMA', --FULL, SCHEMA, TABLE, TABLESPACE
    remote_link => NULL,
    job_name    => 'DATAPUMP_0001',
    version     => 'LATEST');

  DBMS_DATAPUMP.add_file(
    handle    => l_dp_handle,
    filename  => 'TCDN_KT_ABIC.dmp',
    directory => 'TCDN_BK_DIR');

  DBMS_DATAPUMP.add_file(
    handle    => l_dp_handle,
    filename  => 'TCDN_KT_ABIC_imp_3.log',
    directory => 'TCDN_BK_DIR',
    filetype  => DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE);

  DBMS_DATAPUMP.metadata_filter(
    handle => l_dp_handle,
    name   => 'SCHEMA_EXPR',
    value  => '= ''KT_ABIC''');

/*
  DBMS_DATAPUMP.METADATA_REMAP(
    handle => l_dp_handle,
    name   => 'REMAP_SCHEMA',
    old_value	=> 'KT_ABIC',
	value  => 'KT_TEST');
*/

  DBMS_DATAPUMP.metadata_filter(
    handle => l_dp_handle,
    name   => 'NAME_EXPR',
    value  => 'NOT LIKE ''%_LOG%''',
--    value  => 'IN (select table_name from my_table_names where table_name like ''CUST%'')',
	object_type => 'TABLE');
	
  DBMS_DATAPUMP.metadata_filter(
    handle => l_dp_handle,
    name   => 'NAME_EXPR',
    value  => 'NOT LIKE ''%KT_%''',
--    value  => 'IN (select table_name from my_table_names where table_name like ''CUST%'')',
	object_type => 'TABLE');

/*
  DBMS_DATAPUMP.metadata_filter(
    handle => l_dp_handle,
    name   => 'EXCLUDE_PATH_EXPR',
    value  => '=''INDEX''');
*/

  DBMS_DATAPUMP.metadata_filter(
    handle => l_dp_handle,
    name   => 'NAME_EXPR',
    value  => 'NOT LIKE ''BC_%''',
	object_type => 'INDEX');	

/*
  DBMS_DATAPUMP.metadata_filter(
    handle => l_dp_handle,
    name   => 'EXCLUDE_PATH_EXPR',
    value  => 'IN (''STATISTICS'')');
*/
	
  DBMS_DATAPUMP.SET_PARAMETER(
    handle => l_dp_handle,
    name   => 'TABLE_EXISTS_ACTION',
    value  => 'TRUNCATE'); --TRUNCATE, REPLACE, APPEND, and SKIP.

  DBMS_DATAPUMP.start_job(l_dp_handle);
  DBMS_DATAPUMP.wait_for_job(
  	handle => l_dp_handle,
	job_state => l_status );
  
  dbms_output.put_line( l_status );
 
  DBMS_DATAPUMP.detach(l_dp_handle);
END;
/

DECLARE
   h1 NUMBER;
BEGIN
   h1 := DBMS_DATAPUMP.ATTACH('DATAPUMP_0001','KT_ABIC');
   DBMS_DATAPUMP.STOP_JOB (h1,1,0);
   DBMS_DATAPUMP.detach(h1);
END;
/

select * from dba_datapump_jobs;

--
/*
http://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_datpmp.htm
