drop table bh_hd_goc_ttuc_lh;
create table bh_hd_goc_ttuc_lh(
  ma_dvi varchar2(20),
	so_id number,
	so_id_lh number,
	t_gian date,
	n_dung nvarchar2(500),
	t_trang  varchar2(1), --1,2,3,4,5
	nsd varchar2(20)
);

--LKE
create or replace procedure pbh_hd_goc_ttuc_lh_lke
  (b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_so_hd varchar2,cs out pht_type.cs_type,b_ngay_ht number)
as
  b_loi varchar2(100); b_so_id number;
begin
b_so_id:=FBH_HD_GOC_SO_ID_DAU(b_ma_dvi,b_so_hd);
open cs for
  select * from bh_hd_goc_ttuc_lh where so_id=b_so_id order by t_gian;
exception when others then raise_application_error(-20105,b_loi);
end;

--NHAP
create or replace procedure pbh_hd_goc_ttuc_lh_nh
  (b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_so_hd varchar2, b_ngay_ht date,b_n_dung nvarchar2, b_t_trang varchar2, cs out pht_type.cs_type)
as 
  b_loi varchar2; b_so_id number; b_so_id_lh number; b_i1 number;
begin
  b_so_id:=FBH_HD_GOC_SO_ID_DAU(b_ma_dvi,b_so_hd);
  select count(so_id_lh) into b_i1 from bh_hd_goc_ttuc;
  if b_i1 > 0 then 
    select max(so_id_lh) +1 into b_so_id_lh from bh_hd_goc_ttuc;
  else
    b_so_id_lh:=1;
  end if;
  insert into pbh_hd_goc_ttuc values(b_ma_dvi,b_so_id,b_so_id_lh,b_ngay_ht,b_n_dung,b_t_trang,b_nsd);
  commit;
  exception when others then raise_application_error(-20105,b_loi);
end;


