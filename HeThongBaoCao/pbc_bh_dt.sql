--pbc_bh_dt;
drop table pbc_bh_dt;
create table pbc_bh_dt(
  id number,
  id_hd number,
  so_hd varchar2(50),
  ngay_hl number,
  ngay_kt number,
  ngay_cap number,
  taituc varchar2(1),
  kenh_kt varchar2(5),
  ma_kt varchar2(50),
  ten_kt nvarchar2(100),
  nhang_kt varchar2(20),
  tong_dl varchar2(20),
  banca varchar2(1),
  ma_kh varchar2(20),
  ten_kh nvarchar2(200),
  loai_kh varchar2(20),
  ttin_kh nvarchar2(200),
  ma_dvi varchar2(10),
  ma_phong varchar2(20),
  ma_cbo varchar2(20),
  id_dt number,
  ten nvarchar2(500),
  nhom_rr varchar2(20),
  nv varchar2(10),
  lh_nv varchar2(20),
  ngay_ky number,
  ngay_ps number,
  tl_do number,
  tl_ta number,
  loai_dt varchar2(2),
  nt_stbh varchar2(10),
  stbh number,
  stbh_qd number,
  nt_phi varchar2(20),
  phi number,
  phi_qd number,
  thue number,
  thue_qd number,
  constraint pbc_bh_dt primary key(id)
);   

--Dvi
drop table ht_ma_dvi;
CREATE TABLE HT_MA_DVI(
  MA VARCHAR2(10), 
  CAP VARCHAR2(1), 
  TEN NVARCHAR2(250), 
  DCHI VARCHAR2(250), 
  PHONE VARCHAR2(20), 
  FAX VARCHAR2(20), 
  MA_THUE VARCHAR2(30), 
  G_DOC NVARCHAR2(100), 
  KTT NVARCHAR2(100), 
  TEN_SV VARCHAR2(50), 
  TEN_DB VARCHAR2(50), 
  TEN_DBO VARCHAR2(50), 
  IP VARCHAR2(50), 
  MA_TK VARCHAR2(20), 
  NHANG VARCHAR2(10), 
  KVUC VARCHAR2(10), 
  MA_CT VARCHAR2(10), 
  PAS_DI VARCHAR2(10), 
  PAS_DEN VARCHAR2(10), 
  TT_HD VARCHAR2(1), 
  LOAI VARCHAR2(1), 
  VP VARCHAR2(1), 
  NGAY_BD DATE, 
  NGAY_KT DATE, 
  NSD VARCHAR2(10), 
  CONSTRAINT HT_MA_DVI_P PRIMARY KEY (MA)
);

insert into ht_ma_dvi
  select * from kt_abic.ht_ma_dvi@abic_test;

--Dai ly
drop table bh_dl_ma_kh;
CREATE TABLE BH_DL_MA_KH(
  MA_DVI VARCHAR2(10), 
	MA VARCHAR2(10), 
	TEN NVARCHAR2(200), 
	TEN_E NVARCHAR2(200), 
	TEN_T NVARCHAR2(200), 
	DCHI NVARCHAR2(200), 
	NGAY_SINH DATE, 
	TAX VARCHAR2(30), 
	SO_CMT VARCHAR2(30), 
	NHANG VARCHAR2(10), 
	MA_TK VARCHAR2(20), 
	LOAI VARCHAR2(5), 
	KVUC VARCHAR2(10), 
	PHONE VARCHAR2(20), 
	FAX VARCHAR2(20), 
	PT_THUE VARCHAR2(1), 
	THUE_HH NUMBER, 
	HD_DLY VARCHAR2(30), 
	NGAY_HD DATE, 
	GCN_HD VARCHAR2(30), 
	NGAY_GCN DATE, 
	NGAY_D DATE, 
	NGAY_C DATE, 
	GCHU NVARCHAR2(1000), 
	MA_CT VARCHAR2(10), 
	PHONG VARCHAR2(10), 
	PAS VARCHAR2(20), 
	NSD VARCHAR2(10), 
  CONSTRAINT BH_DL_MA_KH_P PRIMARY KEY (MA_DVI, MA)
);

insert into bh_dl_ma_kh
  select * from kt_abic.bh_dl_ma_kh@abic_test;

--nhang
drop table kh_ma_nhang;
CREATE TABLE KH_MA_NHANG (	
  MA_DVI VARCHAR2(10), 
	MA VARCHAR2(10), 
	TEN VARCHAR2(100), 
	DCHI VARCHAR2(100), 
	NSD VARCHAR2(10), 
	NHOM VARCHAR2(100), 
  CONSTRAINT KH_MA_NHANG_P PRIMARY KEY (MA_DVI, MA)
);
insert into kh_ma_nhang
  select * from kt_abic.kh_ma_nhang@abic_test;

--loai KH
drop table kh_ma_loai_dn;
CREATE TABLE KH_MA_LOAI_DN (	
  MA_DVI VARCHAR2(10), 
	MA VARCHAR2(10), 
	TEN VARCHAR2(50), 
	MA_CT VARCHAR2(10), 
	NSD VARCHAR2(10), 
  CONSTRAINT KH_MA_LOAI_DN_P PRIMARY KEY (MA_DVI, MA)
);
insert into kh_ma_loai_dn
  select * from kt_abic.kh_ma_loai_dn@abic_test;

-- phong
drop table ht_ma_phong;
CREATE TABLE HT_MA_PHONG (
  MA_DVI VARCHAR2(10), 
	MA VARCHAR2(10), 
	TEN VARCHAR2(50), 
	MA_CT VARCHAR2(10), 
	NSD VARCHAR2(10), 
  CONSTRAINT HT_MA_PHONG_P PRIMARY KEY (MA_DVI, MA)
);
insert into ht_ma_phong
  select * from kt_abic.ht_ma_phong@abic_test;

--lhnv
drop table bh_ma_lhnv;
CREATE TABLE BH_MA_LHNV (	
  MA_DVI VARCHAR2(10), 
	MA VARCHAR2(10), 
	TEN VARCHAR2(100), 
	TC VARCHAR2(1), 
	UU VARCHAR2(1), 
	MA_CD VARCHAR2(10), 
	MA_TAI VARCHAR2(10), 
	MA_CT VARCHAR2(10), 
	NSD VARCHAR2(10), 
  CONSTRAINT BH_MA_LHNV_P PRIMARY KEY (MA_DVI, MA)
);
insert into bh_ma_lhnv
  select * from kt_abic.bh_ma_lhnv@abic_test;

--cbo
drop table ht_ma_cbo;
CREATE TABLE HT_MA_CB (	
  MA_DVI VARCHAR2(10), 
	MA VARCHAR2(10), 
	TEN NVARCHAR2(30), 
	PHONG VARCHAR2(10), 
	CV NVARCHAR2(50), 
	SO_CMT VARCHAR2(30), 
	PHONE VARCHAR2(20), 
	EMAIL VARCHAR2(50), 
	NSD VARCHAR2(10), 
  CONSTRAINT HT_MA_CB_P PRIMARY KEY (MA_DVI, MA)
);
insert into ht_ma_cb
  select * from kt_abic.ht_ma_cb@abic_test;

-- nsd
drop table ht_ma_nsd;
CREATE TABLE HT_MA_NSD (	
  MA_DVI VARCHAR2(10), 
	MA VARCHAR2(10), 
	TEN NVARCHAR2(30), 
	PAS VARCHAR2(10), 
	PHONG VARCHAR2(10), 
	NSD VARCHAR2(10), 
	KHOA VARCHAR2(1), 
	TGIAN DATE, 
	NLOI NUMBER, 
  CONSTRAINT HT_MA_NSD_P PRIMARY KEY (MA_DVI, MA)
);
insert into ht_ma_nsd
  select * from kt_abic.ht_ma_nsd@abic_test;