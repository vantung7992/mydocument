create or replace PROCEDURE BC_BH_DHTT
    (b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_ngayd number,b_ngayc number,b_dvi varchar2,
    b_phong varchar2,b_ma_nh varchar2,b_ma_dl varchar2,b_ma_bh varchar2, cs_kq out pht_type.cs_type)
AS
    b_loi varchar2(100);b_ngay number;
begin
  PBC_LAY_DVI(b_ma_dvi,b_dvi,b_nsd,b_pas,b_loi);
  if b_loi is not null then raise PROGRAM_ERROR; end if;

  delete temp_1_u;
--BA
  if b_ma_bh is not null and b_ma_bh in ('*','BA') then
    insert into temp_1_u(c1,c2,c4,c6,c7,c8,n1,n2,n3)
      select ma_dvi,ma_dl,phong,ten,dchi,'CMT:'||so_cmt||';NS:'||nam_sinh||';HÐTD:'||hd_vay||';GCN:'||gcn,tien,ttoan_qd,ngay_kt 
        from bh_nggcn_ba
        where ma_dvi='005' and ngay_kt between 20170101 and 20190131;
  end if;
--2B
  if b_ma_bh is not null and b_ma_bh in ('*','2B') then
    insert into temp_1_u(c1,c2,c4,c6,c7,c8,n1,n2,n3)
      select ma_dvi,ma_kt,phong,chu_xe,dchi,'GCN:'||gcn||';BKS:'||bien_xe,ttoan,ttoan_qd,ngay_cap
        from bh_xe_ps a, temp_bc_dvi
        where a.ma_dvi=dvi and ngay_cap + 10000 between b_ngayd and b_ngayc
        and (b_phong is null or phong=b_phong);
  end if;
--cap nhat nhang,tdl
  update temp_1_u set (c3,c5)= (select nhang,ma_ct from bh_dl_ma_kh where ma_dvi=c1 and ma=c2 and (b_ma_nh is null or nhang=b_ma_nh));
  delete from temp_1_u where c3 is null and c5 is null;
--CT
  if b_ma_bh is not null and b_ma_bh in ('*','BT') then
    insert into temp_1_u(c1,c2,c3,c4,c5,c6,c7,c8,n1,n3)
      select ma_dvi,ma_dl,ma_nhang,phong,ma_tdl,ten,dchi,'Cmt: '||so_cmt||'; So the: '||so_the||'; Gcn: '||gcn,ttoan_qd,ngay_kt 
        from bh_ba_ct_gcn a, temp_bc_dvi
        where a.ma_dvi=dvi and a.ngay_kt between b_ngayd and b_ngayc
        and (b_phong is null or phong=b_phong)
        and (b_ma_nh is null or ma_nhang like b_ma_nh||'%')
        and (b_ma_dl is null or ma_dl=b_ma_dl);
  end if;
  
  update temp_1_u set c30='C',n30=1,n29=1;
  
--Dai ly vien
  insert into temp_1_u(c30,n30,n29,c1,c2,c6,c3,c4,c5,n1,n2)
    select 'T',1,2,c1,c2,c2||' - '||ten,c3,c4,c5,sum(n1),sum(n2) from temp_1_u,bh_dl_ma_kh
      where ma_dvi=c1 and ma=c2 and c30='C' group by c1,c2,ten,c3,c4,c5;
--Ngan hang
  insert into temp_1_u(c30,n30,n29,c1,c3,c6,c5,n1,n2)
    select 'T',1,3,c1,c3,c3||' - '||ten,c5,sum(n1),sum(n2) from temp_1_u,kh_ma_nhang
      where ma_dvi=c1 and ma=c3 and c30='C' group by c1,c3,ten,c5;            
--Tong dai ly
  if b_ma_dl is null then
    insert into temp_1_u(c30,n30,n29,c1,c5,c6,n1,n2)
      select 'T',1,4,c1,c5,c5||' - '||ten,sum(n1),sum(n2) from temp_1_u,bh_dl_ma_kh
        where ma_dvi=c1 and ma=c5 and c30='C' group by c1,c5,ten;
  end if;
--Chi nhanh
  if b_dvi is null and b_phong is null and b_ma_dl is null then
    insert into temp_1_u(c30,n30,n29,c1,c6,n1,n2)
      select 'T',1,5,c1,c1||' - '||ten,sum(n1),sum(n2)from temp_1_u,ht_ma_dvi
        where ma=c1 and c30='C' group by c1,ten;
  end if;
    
  open cs_kq for select c30 tc,c1 ma_dvi,c5 tdl,c3 nhang,c2 ma_dl,n29 tt,FKH_TCVN_UNI(c6) ten,c7 dchi,c8 dtbh,
    n1 phi,n2 stbh,PKH_SO_CDT(n3) ngay_kt from temp_1_u
    order by c1,c5,c3,c2,n29;
  commit;            
  exception when others then rollback;
  if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
end;