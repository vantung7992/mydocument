--Table h?p ??ng h?y: h?p ??ng ch?m d?t tr??c h?n
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
 
--B?ng h?p ??ng h?t h?t h?n: gi?m phí khi h?t h?n h?p ??ng
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