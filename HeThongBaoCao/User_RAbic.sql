create user tungnv identified by Tungnv88;
grant create session to tungnv;
create user kt_abic identified by 123456;
GRANT create session TO smithj;
GRANT create table TO smithj;
GRANT create view TO smithj;
GRANT create any trigger TO smithj;
GRANT create any procedure TO smithj;
GRANT create sequence TO smithj;
GRANT create synonym TO smithj;

--
create user r_abic identified by 123456;
grant create session to r_abic;
grant create table to r_abic;
grant create view to r_abic;
grant create any trigger to r_abic;
grant create any procedure to r_abic;
grant create sequence to r_abic;
grant create synonym to r_abic;
grant create database link to r_abic;

Create public database link abic_s1
  connect to tungnv identified by Tungnv88
  using
  '(DESCRIPTION=
    (ADDRESS=
     (PROTOCOL=TCP)
     (HOST=10.10.10.1)
     (PORT=1521))
    (CONNECT_DATA=
     (SID=tcdn)))';

SELECT TABLESPACE_NAME "TABLESPACE",
   INITIAL_EXTENT "INITIAL_EXT",
   NEXT_EXTENT "NEXT_EXT",
   MIN_EXTENTS "MIN_EXT",
   MAX_EXTENTS "MAX_EXT",
   PCT_INCREASE
   FROM DBA_TABLESPACES;


DROP PUBLIC DATABASE LINK abic_s1; 
select * from r_abic.pbc_bh_dt;

insert into not_found?.PBC_BH_DT
select * from kt_abic.ht_ma_nsd@abic_s1;


grant insert, update, delete on r_abic.pbc_bh_dt to r_abic;

-- create table space
CREATE BIGFILE TABLESPACE tbs_perm_01
  DATAFILE 'tbs_perm_01'
    SIZE 10M
    AUTOEXTEND ON;
    
-- create user r_abic
drop user r_abic;

ALTER USER r_abic quota 100M on USERS;
