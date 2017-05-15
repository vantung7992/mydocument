--DBA--

--CREATE USER
	CREATE USER NewDBA IDENTIFIED BY passwd;
	
	grant create session to r_abic;
	grant create table to r_abic;
	grant create view to r_abic;
	grant create any trigger to r_abic;
	grant create any procedure to r_abic;
	grant create sequence to r_abic;
	grant create synonym to r_abic;
	grant create database link to r_abic;
	ALTER USER r_abic quota 100M on USERS;
	alter user <user_name> quota unlimited on <tablespace_name>;

--CHANGE PASS
	ALTER USER tungnv IDENTIFIED BY Tungnv;

--GRANT 
	GRANT DBA TO NewDBA WITH ADMIN OPTION;

--Ngày --> số
	kt_abic.pkh_ng_cso(ngay_hl)
--Số --> ngày
	PKH_SO_CDT

--Select user
	create user tungnv identified by Tungnv88;
	grant create session to tungnv;

--DB link 
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
		 
	DROP PUBLIC DATABASE LINK abic_s1; 
--TNS PING
https://docs.oracle.com/cd/E11882_01/network.112/e41945/connect.htm#NETAG357

--Lay so lieu
----Lay danh sach dl vien thuoc agri
	select ma_dvi,ten,dchi,tax,so_cmt,nhang,loai,pt_thue from kt_abic.bh_dl_ma_kh 
	  where nhang like 'AGRI%' and ma_ct is not null and pt_thue <> 'K'
	  order by ma_dvi;
