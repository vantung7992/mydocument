--Table hop dong huy: hop dong cham dut truoc han
drop table bh_hd_goc_huy;
Create table bh_hd_goc_huy(
   ma_dvi varchar2(10),
   so_id number,
   ngay_ht number,
   ngay_kt number,
   phi_hoan number,
   phi_tra number,
   hoan_thue varchar2(1),
   kieu_vat varchar2(1),
   mau_vat varchar2(20),
   seri_vat varchar2(20),
   so_vat number,
   pthuc varchar2(1),
   nsd varchar2(20),
   tgian date
 );
 
--Bang hop dong het han: giam phi khi het han hop dong
drop table bh_hd_goc_giam;
create table bh_hd_goc_giam(
   ma_dvi varchar2(10),
   so_id number,
   ngay_ht number,
   phi_giam number,
   kieu_vat varchar2(1),
   mau_vat varchar2(20),
   seri_vat varchar2(20),
   so_vat number,
   pthuc varchar2(1),
   nsd varchar2(20),
   tgian date
 );
 select * from bh_hd_goc_giam;
 
 --Nhap
create or replace procedure pbh_hd_goc_huy_nh(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,
  b_ngay_ht number,b_so_hd number,
  b_ngay_kt number, b_hphi number, b_ttra number,
  b_hthue varchar2,b_kvat varchar2,b_mau varchar2,b_seri varchar2,b_so_don varchar2,
  cs out pht_type.cs_type)
as
  b_loi varchar2(100);b_so_id number;b_tgian varchar2(50);b_i1 number;
begin
  b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','HUY','N');
  if b_loi is not null then raise PROGRAM_ERROR; end if;
  b_so_id:=FBH_HD_GOC_SO_ID_DAU(b_ma_dvi,b_so_hd);
  if b_so_id=0 then b_loi:='loi:Hop dong goc dang xu ly:loi'; raise PROGRAM_ERROR; end if;
  b_tgian:=TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS');

  select count(*) into b_i1 from bh_hd_goc_huy where ma_dvi=b_ma_dvi and so_id=b_so_id;
  if b_i1<>0 then
    b_loi:='loi:Da huy:loi';
    if b_loi is not null then raise PROGRAM_ERROR; end if;
  end if;
  
  insert into bh_hd_goc_huy values(b_ma_dvi,b_so_id,b_ngay_ht,b_ngay_kt,b_hphi,b_ttra,b_hthue,b_kvat,b_mau,b_seri,b_so_don,'',b_nsd,sysdate);
  commit;
  exception when others then raise_application_error(-20105,b_loi);
end;

--liet ke
create or replace procedure PBH_HD_HUY_LKE
	(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,cs1 out pht_type.cs_type,b_ngay_ht number,b_klk varchar2)
AS
	b_loi varchar2(100); b_phong varchar2(10);
begin
-- Dan - Liet ke
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','HUY','NX');
if b_loi is not null then raise PROGRAM_ERROR; end if;
if b_klk='N' then
	open cs1 for select ma_dvi,so_id,FBH_HD_GOC_SO_HD(b_ma_dvi,so_id) so_hd from bh_hd_goc_huy
		where ma_dvi=b_ma_dvi and ngay_ht=b_ngay_ht and nsd=b_nsd order by so_hd;
else	open cs1 for select ma_dvi,so_id,FBH_HD_GOC_SO_HD(b_ma_dvi,so_id) so_hd from bh_hd_goc_huy
		where ma_dvi=b_ma_dvi and ngay_ht=b_ngay_ht order by so_hd;
end if;
exception when others then raise_application_error(-20105,b_loi);
end;
 
create or replace procedure pbh_hd_goc_ttin(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_so_hd varchar2,cs1 out pht_type.cs_type)
as
  b_loi varchar2(100);b_so_id number;
begin
delete temp_1;
--thong tin chung
insert into temp_1(c1,c2,c3,c4,c5,d1,d2)
  select ma_dvi,so_hd,FBH_HD_GOC_SO_ID_DAU(ma_dvi,so_hd) so_id,ma_kh,ma_kt,ngay_hl,ngay_kt from bh_hd_goc where ma_dvi = b_ma_dvi and so_hd=b_so_hd;
  
--tong phi
update temp_1 set n1=(select phi from bh_hd_goc_dk where ma_dvi=c1 and so_id=c3);

--da thu
update temp_1 set n2=(select tien from bh_hd_goc_tthd where ma_dvi=c1 and so_id=c3 and pt='N');

open cs1 for
  select c1 ma_dvi,c2 so_hd,c3 id_hd,c4 ma_kh,c5 ma_dl,pkh_ng_cso(d1) ngay_hl,pkh_ng_cso(d2) ngay_kt,n1 tong_phi,n1 da_thu 
  from temp_1;
end;

--Chi tiet theo so_hd
create or replace procedure pbh_hd_goc_huy_ct(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_so_hd varchar2,cs1 out pht_type.cs_type)
as
  b_loi varchar2(100);b_so_id number;
begin
  b_so_id:=FBH_HD_GOC_SO_ID_DAU(b_ma_dvi,b_so_hd);
  open cs1 for
    select * from bh_hd_goc_huy where ma_dvi=b_ma_dvi and so_id=b_so_id;
end;