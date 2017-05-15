select directory_name,directory_path from dba_directories;

create or replace directory TCDN_BK_DIR as 'E:\bk';
create directory THUVIEN_BK_DIR as 'g:\db\thuvien';
 
grant read, write on directory THUVIEN_BK_DIR to bk;
grant read, write on directory TCDN_BK_DIR to kt_test;

