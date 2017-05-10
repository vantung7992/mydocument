create or replace PACKAGE BODY PBH_DL_TD_2017 AS

procedure SL(b_ngayd number,b_ngayc number)
AS
    b_loi varchar2(100);
Begin
--Quy - Lay so lieu doanh thu theo chuong trinh thi dua dai ly
PBC_LAY_DVI('080','','080','a',b_loi);
if b_loi is not null then return; end if;

b_loi:='loi:Loi lay so lieu doanh thu BC_BH_DL_TD_DT_M:loi';

delete temp_2;

-- DOANH THU
--Lay doanh thu thuc thu theo doi tuong
insert into temp_2(c1,c2,n1,n2,n3,c3,c4,c7,c5,n5)
    select d.ma_dvi,d.ma_dvi_g,d.so_id,d.so_id_dt,d.ngay_tt,d.lh_nv,d.ma_dl,dl.ma_ct,d.nv,sum(d.phi_qd)
    from bc_bh_hd_dttt d,temp_bc_dvi t,bh_dl_ma_kh dl
    where d.ma_dvi=t.dvi and dl.ma_dvi=d.ma_dvi and dl.ma=d.ma_dl
    and dl.loai='0301'
    and d.lh_nv not in ('050101','050201')
    and d.ngay_tt between b_ngayd and b_ngayc
    group by d.ma_dvi,d.ma_dvi_g,d.so_id,d.so_id_dt,d.ngay_tt,d.lh_nv,d.ma_dl,dl.ma_ct,d.nv;
--Lay doanh thu ban hang
insert into temp_2(c1,c2,n1,n2,n3,c3,c4,c7,c5,n15)
    select d.ma_dvi,d.ma_dvi_g,d.so_id,d.so_id_dt,d.ngay_tt,d.lh_nv,d.ma_dl,dl.ma_ct,d.nv,sum(d.phi_qd)
    from bc_bh_hd_dtbh d,temp_bc_dvi t,bh_dl_ma_kh dl
    where d.ma_dvi=t.dvi and dl.ma_dvi=d.ma_dvi and dl.ma=d.ma_dl
    and dl.loai='0301'
    and d.lh_nv not in ('050101','050201')
    and d.ngay_tt between b_ngayd and b_ngayc
    group by d.ma_dvi,d.ma_dvi_g,d.so_id,d.so_id_dt,d.ngay_tt,d.lh_nv,d.ma_dl,dl.ma_ct,d.nv;

--An chia doanh thu (Dong BH noi bo)
update temp_2 set c1=c2 where not exists(select * from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);

--Lay ma dai ly theo hop dong goc
update temp_2 set c4=(select ma_kt from bh_hd_goc where ma_dvi=c2 and so_id=n1)
    where exists(select ma_kt from bh_hd_goc where ma_dvi=c2 and so_id=n1);

--Lay nhom xe
update temp_2 set c6=(select min(nhom_xe) from bh_xegcn where ma_dvi=c2 and so_id=n1 and so_id_dt=n2) where c5='XE';
update temp_2 set c6=(select min(nhom_xe) from bh_xelgcn where ma_dvi=c2 and so_id=n1) where c5='XEL';
--Lay ma doi tuong bao hiem tai san ky thuat
update temp_2 set c6=(select min(ma_dt) from bh_phhgcn_dk where ma_dvi=c2 and so_id=n1 and so_id_dt=n2 and lh_nv=c3) where c5='PHH';
--Lay tuoi tau
update temp_2 set c6=(select 2016-nam_sx from bh_taugcn where ma_dvi=c2 and so_id=n1 and so_id_dt=n2) where c5='TAU';
--Lay loai dong goi hang
update temp_2 set c6=(select min(ma_dt) from bh_hhgcn where ma_dvi=c2 and so_id=n1) where c5='HANG';
update temp_2 set c16=(select min(g_tri) from bh_hd_goc_dt where ma_dvi=c2 and so_id=n1 and ma_tke='PACKING') where c5='HANG';

--Tach nhom
--Nhom 1: BATD; xe may; chay no bat buoc; xe o to nhom 01
update temp_2 set n4=1 where c3 like '011001%' --Bao an tin dung
    or c3 like '020106' -- Bao hiem tien
    or (c3 like '0702%' and to_number(c6)<=10) -- tau song den 10 tuoi
    or c3 like '020205%' -- may moc thiet bi chu thau
    or c3 like '050202%' or c3 like '050203%' or c3 like '050204%' --Tu nguyen xe may
    or (c3 like '0501%' and c3 not like '050101%' and c6 like '01%') -- Tu nguyen o to nhom 1
    or (c3='020201' and c6 not in ('CAR06','CAR07','CAR09','CAR11')) -- Xay dung
    or (c3='020202' and c6 not in ('EAR02.18')) -- Lap dat
    or ((c3 like '0601%' or c3='020107' or c3='020101') and c6 like 'FIRE01%') -- Chay no va Moi RR TS nhom CAT1
    ;

--Nhom 2:
update temp_2 set n4=2 where (c3='020206' -- thiet bi dien tu
    or (c3 like '0702%' and to_number(c6)>10)) -- tau song tren 10 tuoi
    and n4 is null;

--Nhom 4:
update temp_2 set n4=4 where (c3='020201' -- xay dung
    or c3='020202') -- lap dat
    and n4 is null;

--Nhom 5:
update temp_2 set n4=5 where (
    (c3 like '0501%' and (c6 like '04.1' or c6 like '04.3' or c6 like '04.5')) -- xe oto nhom 4
    or (c3 in ('0301','0302') and (c6 like 'H04%' or c6 like 'H06%')
        and c16 in ('Hµng x¸','Hang xa','HANG XA','ROI','Roi','Hµng rêi','Hang roi'))
    or (c3 like '0701%' and to_number(c6)>15)
    or ((c3 like '0601%' or c3 like '020107' or c3='020101') and (c6 like 'FIRE04%' or c6 like 'FIRE05%'))
    )
    and n4 is null;

--Nhom 3:
update temp_2 set n4=3 where n4 is null;
--///

--Tinh diem theo nhom
update temp_2 set n6=decode(n4,1,2.0,2,1.5,3,1.0,4,0.5,0);
update temp_2 set n7=n5*n6;

-- BOI THUONG DA DUYET
BC_BH_THBT_MD('','','','','','','',b_ngayd,b_ngayc,b_loi,'B');
if b_loi is not null then raise PROGRAM_ERROR; end if;
insert into temp_2(c1,c4,c7,n3,n8)
    select g.ma_dvi,g.ma_kt,d.ma_ct,b.n12,sum(n7) from temp_1 b,bh_hd_goc g,bh_dl_ma_kh d
        where g.ma_dvi=b.c30 and g.so_id=b.n13 and g.ma_dvi=d.ma_dvi and g.ma_kt=d.ma and d.loai='0301'
        group by g.ma_dvi,g.ma_kt,d.ma_ct,b.n12;
-- BOI THUONG CHUA DUYET DAU KY
BC_BH_THBT_MD_CD('','','','','','','',0,20151231,b_loi,'B');
if b_loi is not null then raise PROGRAM_ERROR; end if;
insert into temp_2(c1,c4,c7,n3,n10)
    select g.ma_dvi,g.ma_kt,d.ma_ct,b_ngayc,-sum(n7) from temp_1 b,bh_hd_goc g,bh_dl_ma_kh d
        where g.ma_dvi=b.c30 and g.so_id=b.n13 and g.ma_dvi=d.ma_dvi and g.ma_kt=d.ma and d.loai='0301'
        group by g.ma_dvi,g.ma_kt,d.ma_ct;
-- BOI THUONG CHUA DUYET CUOI KY
BC_BH_THBT_MD_CD('','','','','','','',0,b_ngayc,b_loi,'B');
if b_loi is not null then raise PROGRAM_ERROR; end if;
insert into temp_2(c1,c4,c7,n3,n10)
    select g.ma_dvi,g.ma_kt,d.ma_ct,b_ngayc,sum(n7) from temp_1 b,bh_hd_goc g,bh_dl_ma_kh d
        where g.ma_dvi=b.c30 and g.so_id=b.n13 and g.ma_dvi=d.ma_dvi and g.ma_kt=d.ma and d.loai='0301'
        group by g.ma_dvi,g.ma_kt,d.ma_ct;

-- HOA HONG DA CHI
insert into temp_2(c1,c4,c7,n3,n9)
    select a.ma_dvi,a.ma_kh,d.ma_ct,a.ngay_ht,sum(a.tien_qd)
        from bh_dl_cn_tu a,temp_bc_dvi b,bh_dl_ma_kh d
        where a.ma_dvi=b.dvi and a.ma_dvi=d.ma_dvi and a.ma_kh=d.ma and d.loai='0301'
        and a.loai in ('H','T')
        and a.ngay_ht between b_ngayd and b_ngayc and a.so_id_kt<>0
        group by a.ma_dvi,a.ma_kh,d.ma_ct,a.ngay_ht;

-- TONG HOP
--Cap nhat ma tong dai ly
update temp_2 set c7=FBH_DL_TDL(c1,c4); --FHT_MA_NSD_DC_MA_CT(c1,'D',c4,n3);
update temp_2 set c4=c7 where c7 is not null;

delete bh_dl_td_sl where thang between round(b_ngayd/100) and round(b_ngayc/100);

insert into bh_dl_td_sl
    select c1,c4,round(n3/100,0),sum(decode(n4,1,n5,0)),sum(decode(n4,2,n5,0)),
        sum(decode(n4,3,n5,0)),sum(decode(n4,4,n5,0)),sum(decode(n4,5,n5,0)),sum(n15),sum(n5),sum(n7),sum(n8),sum(n9),sum(n10)
    from temp_2 group by c1,c4,round(n3/100,0);

commit;


-- TIEM NANG DOANH NGHIEP
delete bh_dl_td_dt where thang between round(b_ngayd/100) and round(b_ngayc/100) and ma_ct in ('TNDN_KH','TNDN_STBH');
delete temp_1;
insert into temp_1(c1,c2,n1,n2,n3)
select a.ma_dvi,FHT_MA_NSD_DC_MA_CT(a.ma_dvi,'D',a.ma_kt,a.ngay_ht) ma_dl,round(ngay_ht/100,0) thang,count(distinct a.so_id) so_kh,
    sum(decode(b.nt_tien,'VND',b.tien,FTT_VND_QD(b.ma_dvi,a.ngay_ht,b.nt_tien,b.tien))) tien
    from bh_hd_goc a,bh_hd_goc_dk b,bh_hd_ma_kh k,bh_dl_ma_kh d
    where a.ma_dvi=b.ma_dvi and a.so_id=b.so_id and a.kieu_hd='G' and a.ttrang='D'
    and a.ngay_ht between b_ngayd and b_ngayc
    and b.lh_nv not in ('050101','050102','050105','050201','050202','050203','070101','070201','011001') and b.lh_nv not like '08%'
    and a.ma_dvi=b.ma_dvi and a.ma_kh=k.ma and k.loai not in ('11','13')
    and a.kieu_kt='D' and a.ma_dvi=d.ma_dvi and a.ma_kt=d.ma and d.nhang like 'AGRI%'
    group by a.ma_dvi,FHT_MA_NSD_DC_MA_CT(a.ma_dvi,'D',a.ma_kt,a.ngay_ht),round(ngay_ht/100,0);

update temp_1 set c7=FHT_MA_NSD_DC_MA_CT(c1,'D',c1,n3);

insert into bh_dl_td_dt select c1 ma_dvi,c2 ma_dl,n1 thang,'TNDN_KH' ma_ct,n2 so from temp_1 where n2 is not null;
insert into bh_dl_td_dt select c1 ma_dvi,c2 ma_dl,n1 thang,'TNDN_STBH' ma_ct,n3 so from temp_1 where n3 is not null;

commit;

-- TIEM NANG HO SAN XUAT VA CA NHAN
delete bh_dl_td_dt where thang between round(b_ngayd/100) and round(b_ngayc/100) and ma_ct in ('TNCN_KH','TNCN_STBH');
delete temp_1;
insert into temp_1(c1,c2,n1,n2,n3)
select a.ma_dvi,decode(nvl(d.ma_ct,' '),' ',d.ma,d.ma_ct) ma_dl,round(ngay_ht/100,0) thang,count(distinct a.so_id) so_kh,
    sum(decode(b.nt_tien,'VND',b.tien,FTT_VND_QD(b.ma_dvi,a.ngay_ht,b.nt_tien,b.tien))) tien
    from bh_hd_goc a,bh_hd_goc_dk b,bh_hd_ma_kh k,bh_dl_ma_kh d
    where a.ma_dvi=b.ma_dvi and a.so_id=b.so_id and a.kieu_hd='G' and a.ttrang='D'
    and a.ngay_ht between b_ngayd and b_ngayc
    and b.lh_nv not in ('050101','050102','050105','050201','050202','050203','070101','070201','011001') and b.lh_nv not like '08%'
    and a.ma_dvi=b.ma_dvi and a.ma_kh=k.ma and k.loai in ('11','13')
    and a.kieu_kt='D' and a.ma_dvi=d.ma_dvi and a.ma_kt=d.ma and d.nhang like 'AGRI%'
    group by a.ma_dvi,decode(nvl(d.ma_ct,' '),' ',d.ma,d.ma_ct),round(ngay_ht/100,0);
insert into temp_1(c1,c2,n1,n2,n3)
select a.ma_dvi,d.ma_ct ma_dl,round(ngay_cap/100,0) thang,count(distinct a.so_id) so_kh,sum(tien) tien
    from bh_nggcn_ba a,bh_dl_ma_kh d
    where a.ma_dvi=d.ma_dvi and a.ma_dl=d.ma and d.ma_ct is not null
    and a.ngay_cap between b_ngayd and b_ngayc
    group by a.ma_dvi,d.ma_ct,round(ngay_cap/100,0);
insert into bh_dl_td_dt select c1 ma_dvi,c2 ma_dl,n1 thang,'TNCN_KH' ma_ct,sum(n2) so from temp_1 where n2 is not null
    group by c1,c2,n1;
insert into bh_dl_td_dt select c1 ma_dvi,c2 ma_dl,n1 thang,'TNCN_STBH' ma_ct,sum(n3) so from temp_1 where n3 is not null
    group by c1,c2,n1;

commit;
exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
End;

procedure DT(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_dvi varchar2,b_ma_dl varchar2,
    b_ngayd number,b_ngayc number,cs1 out pht_type.cs_type)
AS
    b_loi varchar2(100); b_dt_m number;
Begin
--Quy - Bao cao doanh thu theo chuong trinh thi dua dai ly
if b_ngayd not between 20160101 and 20161231 or b_ngayc not between 20160101 and 20161231 then
    b_loi:='loi:Ngay bao cao khong hop le:loi'; raise_application_error(-20105,b_loi);
end if;
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','','');
if b_loi is not null then raise program_error; end if;

PBC_LAY_DVI('080','','080','a',b_loi);
if b_loi is not null then return; end if;

delete temp_2;
insert into temp_2(c4,n8,n9,n10,n11,n12,n5,n7)
    select ma_dl,sum(nhom_1),sum(nhom_2),sum(nhom_3),sum(nhom_4),sum(nhom_5),sum(dt_tt),sum(dt_qd) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0)
        group by ma_dl;

update temp_2 set c1=(select min(ma_dvi) from bh_dl_td_sl where thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_dl=c4);
update temp_2 set (c6,c7)=(select ma_kv,kvuc from bh_dl_td_kvuc where ma_dvi=c1 and ma_dl=c4);

update temp_2 set n7=0 where n7 is null;
update temp_2 a set n17=(select max(n7) from temp_2 b where a.c6=b.c6);
update temp_2 set n13=round(n7/n17*250,2) where n17>0;
update temp_2 set n13=0 where n17=0;

update temp_2 set c11=(select ten from ht_ma_dvi where ma=c1);
update temp_2 set c14=(select ten from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);
update temp_2 set c5=(select ma_nhno from bh_dl_nhno where ma_dl=c4 and nam=2016);

open cs1 for select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n5 dt_tt,n7 dt_qd,n8 dt_1,n9 dt_2,n10 dt_3,n11 dt_4,n12 dt_5,n13 diem_dt from temp_2 order by c6,n13 desc,n7 desc;

commit;
exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
End;

procedure BT(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_dvi varchar2,b_ma_dl varchar2,
    b_ngayd number,b_ngayc number,cs1 out pht_type.cs_type)
AS
    b_loi varchar2(100); b_tl_max number; b_tl_min number; b_dt number;
Begin
--Quy - Bao cao theo chuong trinh thi dua dai ly - Hieu qua
if b_ngayd not between 20160101 and 20161231 or b_ngayc not between 20160101 and 20161231 then
    b_loi:='loi:Ngay bao cao khong hop le:loi'; raise_application_error(-20105,b_loi);
end if;
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','','');
if b_loi is not null then raise program_error; end if;

PBC_LAY_DVI('080','','080','a',b_loi);
if b_loi is not null then return; end if;

delete temp_2;
insert into temp_2(c4,n5,n6)
    select ma_dl,nvl(sum(dt_bh),0),nvl(sum(bt_dd),0) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0)
        group by ma_dl;

update temp_2 set c1=(select min(ma_dvi) from bh_dl_td_sl where thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_dl=c4);
update temp_2 set n7=(select nvl(bt_cd,0) from bh_dl_td_sl where ma_dvi=c1 and ma_dl=c4 and thang=round(b_ngayc/100,0));

update temp_2 set n6=nvl(n6,0)+nvl(n7,0);

--Chia loai dai ly theo doanh thu
b_dt:=1000000000*(PKH_SO_CDT(b_ngayc)-PKH_SO_CDT(round(b_ngayd,-4)+101))/365;
update temp_2 set n11=1 where b_dt<=n5;
update temp_2 set n11=2 where b_dt>n5;

--Lay ty le boi thuong
update temp_2 set n9=decode(n5,0,1,round(n6/n5,4));

--Tinh diem hieu qua
update temp_2 set n10=round(100-n9*100,2) where n9<1;
update temp_2 set n10=100 where n10>100;
update temp_2 set n10=0 where n9>=1;

update temp_2 set c5=(select ma_nhno from bh_dl_nhno where ma_dl=c4 and nam=2016);
update temp_2 set (c6,c7)=(select ma_kv,kvuc from bh_dl_td_kvuc where ma_dvi=c1 and ma_dl=c4);
update temp_2 set c11=(select ten from ht_ma_dvi where ma=c1);
update temp_2 set c14=(select ten from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);

open cs1 for select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n5 dt_tt,n6 st_bt,n9 tl_bt,n10 diem_hq,n11 dat from temp_2 order by c6,n11,n10 desc,n5 desc,c14;

commit;
exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
End;

procedure TT(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_dvi varchar2,b_ma_dl varchar2,
    b_ngayd number,b_ngayc number,cs1 out pht_type.cs_type)
AS
    b_loi varchar2(100); b_tl_m number; b_dt number;
Begin
--Quy - Bao cao chuong trinh thi dua dai ly - tang truong
if b_ngayd not between 20160101 and 20161231 or b_ngayc not between 20160101 and 20161231 then
    b_loi:='loi:Ngay bao cao khong hop le:loi'; raise_application_error(-20105,b_loi);
end if;
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','','');
if b_loi is not null then raise program_error; end if;

PBC_LAY_DVI('080','','080','a',b_loi);
if b_loi is not null then return; end if;

delete temp_1;
insert into temp_1(c4,n5)
    select ma_dl,sum(dt_tt) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between round((b_ngayd-10000)/100,0) and round((b_ngayc-10000)/100,0)
        group by ma_dl;
update temp_1 set c4='00903' where c4='00606';
update temp_1 set c4='00904' where c4='00213';
update temp_1 set c4='08013' where c4='00229';

insert into temp_1(c4,n6)
    select ma_dl,sum(dt_tt) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0)
        group by ma_dl;

delete temp_2;
insert into temp_2(c4,n5,n6) select c4,nvl(sum(n5),0),nvl(sum(n6),0) from temp_1 group by c4;

update temp_2 set c1=(select min(ma_dvi) from bh_dl_td_sl where thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_dl=c4);
update temp_2 set (c6,c7)=(select ma_kv,kvuc from bh_dl_td_kvuc where ma_dvi=c1 and ma_dl=c4);

-- Ty le tang truong
b_dt:=1000000000*((PKH_SO_CDT(b_ngayc)-PKH_SO_CDT(round(b_ngayd,-4)+101))/365);
update temp_2 set n7=decode(n5,0,0,round(n6/n5*100,2)) where n5>=b_dt;
update temp_2 set n7=decode(b_dt,0,0,round(n6/b_dt*100,2)) where n5<b_dt;
update temp_2 set n7=n7-100;

-- Gia tri tang truong
update temp_2 set n8=n6-n5;

--Tinh diem tang truong
update temp_2 a set n17=(select max(n7) from temp_2 b where a.c6=b.c6);
update temp_2 set n10=round(n7/n17*70,2);
update temp_2 set n10=0 where n7<0;
update temp_2 a set n18=(select max(n8) from temp_2 b where a.c6=b.c6);
update temp_2 set n11=round(n8/n18*30,2);
update temp_2 set n11=0 where n8<0;
update temp_2 set n12=nvl(n10,0)+nvl(n11,0);

update temp_2 set c11=(select ten from ht_ma_dvi where ma=c1);
update temp_2 set c14=(select ten from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);
update temp_2 set c5=(select ma_nhno from bh_dl_nhno where ma_dl=c4 and nam=2016);

open cs1 for select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n6 dt_tt,n5 dt_tt_nt,n7 tl_tt,n10 diem_tl,n8 dt_ttr,n11 diem_dt_ttr,n12 diem_tt from temp_2 order by c6,n12 desc,n6;

commit;
exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
End;

procedure TTBV(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_dvi varchar2,b_ma_dl varchar2,
    b_ngayd number,b_ngayc number,cs1 out pht_type.cs_type,b_th varchar2:='K')
AS
    b_loi varchar2(100);
    b_ngay1 number; b_ngay2 number; b_tl number;
begin
--Quy - Bao cao chuong trinh thi dua dai ly - tang truong
if b_ngayd not between 20160101 and 20161231 or b_ngayc not between 20160101 and 20161231 then
    b_loi:='loi:Ngay bao cao khong hop le:loi'; raise_application_error(-20105,b_loi);
end if;
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','','');
if b_loi is not null then raise program_error; end if;

if b_th='K' then
    PBC_LAY_DVI('080','','080','a',b_loi);
    if b_loi is not null then return; end if;
end if;

delete temp_1;
-- so lieu theo ky
b_ngay1:=201300+to_number(substr(b_ngayd,5,2)); b_ngay2:=201300+to_number(substr(b_ngayc,5,2)); -- 2013
insert into temp_1(c4,n3)
    select ma_dl,sum(dt_tt) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between b_ngay1 and b_ngay2
        group by ma_dl;
b_ngay1:=b_ngay1+200; b_ngay2:=b_ngay2+200; -- 2015
insert into temp_1(c4,n4)
    select ma_dl,sum(dt_tt) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between b_ngay1 and b_ngay2
        group by ma_dl;
-- so lieu ca nam
b_ngay1:=201301; b_ngay2:=201312; -- 2013
insert into temp_1(c4,n5)
    select ma_dl,sum(dt_tt) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between b_ngay1 and b_ngay2
        group by ma_dl;
-- tru di TNDS-BB
insert into temp_1(c4,n5)
    select ma_dl,-sum(so) from bh_dl_td_dt,temp_bc_dvi
        where ma_dvi=dvi and thang between b_ngay1 and b_ngay2 and ma_ct='DTTT_TNDS-BB'
        group by ma_dl;

b_ngay1:=b_ngay1+100; b_ngay2:=b_ngay2+100; -- 2014
insert into temp_1(c4,n6)
    select ma_dl,sum(dt_tt) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between b_ngay1 and b_ngay2
        group by ma_dl;
-- tru di TNDS-BB
insert into temp_1(c4,n6)
    select ma_dl,-sum(so) from bh_dl_td_dt,temp_bc_dvi
        where ma_dvi=dvi and thang between b_ngay1 and b_ngay2 and ma_ct='DTTT_TNDS-BB'
        group by ma_dl;

b_ngay1:=b_ngay1+100; b_ngay2:=b_ngay2+100; -- 2015
insert into temp_1(c4,n7)
    select ma_dl,sum(dt_tt) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between b_ngay1 and b_ngay2
        group by ma_dl;
-- so lieu 2016
insert into temp_1(c4,n8)
    select ma_dl,sum(dt_tt) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0)
        group by ma_dl;

-- Ty le tang truong
b_tl:=1.e9/(PKH_SO_CDT(20161231)-PKH_SO_CDT(20160101))*(PKH_SO_CDT(b_ngayc)-PKH_SO_CDT(b_ngayd));
delete temp_2;
insert into temp_2(c4,n3,n4,n5,n6,n7,n8) select c4,sum(n3),sum(n4),sum(n5),sum(n6),sum(n7),sum(n8) from temp_1 group by c4;
update temp_2 set n3=nvl(n3,0),n4=nvl(n4,0),n5=nvl(n5,0),n6=nvl(n6,0),n7=nvl(n7,0),n8=nvl(n8,0),n15=0,n16=0,n17=0,n18=0;

delete temp_2 where n8<b_tl;

update temp_2 set n15=(n6-n5)/n5*100 where n5<>0;
update temp_2 set n16=(n7-n6)/n6*100 where n6<>0;
update temp_2 set n17=(n8-n4)/n4*100 where n4<>0;
update temp_2 set n18=(n8-n3)/n3*100/3 where n3>b_tl;
update temp_2 set n18=(n8-b_tl)/b_tl*100/3 where n3<=b_tl;

update temp_2 set c1=(select min(ma_dvi) from bh_dl_td_sl where thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_dl=c4);
update temp_2 set (c6,c7)=(select ma_kv,kvuc from bh_dl_td_kvuc where ma_dvi=c1 and ma_dl=c4);
update temp_2 set (c5)=(select ma_nhno from bh_dl_nhno where ma_dl=c4 and nam=2016);
update temp_2 set c11=(select ten from ht_ma_dvi where ma=c1);
update temp_2 set c14=(select ten from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);

--Tinh diem tang truong ben vung
update temp_2 a set n19=(select max(n18) from temp_2 b where a.c6=b.c6 and n15>=20 and n16>=20 and n17>=20 and n8>=5000000000);
update temp_2 set n20=round(n18/n19*50,2);
update temp_2 set n20=0 where n15 <20 or n16 <20 or n17<20 or n8<5000000000 or n20<0;

open cs1 for select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n3 dt_13_ky,n4 dt_15_ky,n5 dt_13,n6 dt_14,n7 dt_15,n8 dt_16,n15 tt_14,n16 tt_15,n17 tt_16,n3 dt_tt13,n8 dt_tt16,n18 tt_bq,n20 diem_tt
    from temp_2 order by c6,n20 desc;

exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
end;

procedure HH(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_dvi varchar2,b_ma_dl varchar2,
    b_ngayd number,b_ngayc number,cs1 out pht_type.cs_type)
AS
    b_loi varchar2(100); b_tl_m number; b_dt number;
Begin
--Quy - Bao cao chuong trinh thi dua dai ly - vuot ke hoach
if b_ngayd not between 20160101 and 20161231 or b_ngayc not between 20160101 and 20161231 then
    b_loi:='loi:Ngay bao cao khong hop le:loi'; raise_application_error(-20105,b_loi);
end if;
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','','');
if b_loi is not null then raise program_error; end if;

PBC_LAY_DVI('080','','080','a',b_loi);
if b_loi is not null then return; end if;

delete temp_2;
insert into temp_2(c4,n5,n6)
    select ma_dl,sum(dt_tt),sum(hh_dd) from bh_dl_td_sl,temp_bc_dvi
        where ma_dvi=dvi and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0)
        group by ma_dl;

update temp_2 set c1=(select min(ma_dvi) from bh_dl_td_sl where thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_dl=c4);
update temp_2 set (c6,c7)=(select ma_kv,kvuc from bh_dl_td_kvuc where ma_dvi=c1 and ma_dl=c4);
/*
update temp_2 set n16=(select sum(ttoan_qd) from bh_cp where ma_dvi=c1 and FBH_DL_TDL(ma_dvi,ma_dly)=c4 and l_ct in ('HTKT_T')
    and ngay_ht between b_ngayd and b_ngayc and so_id_kt<>0);
*/
update temp_2 set n6=n6+nvl(n16,0);

update temp_2 set (c5,n7)=(select ma_nhno,kh from bh_dl_nhno where ma_dl=c4 and nam=2016);
update temp_2 set n5=nvl(n5,0),n6=nvl(n6,0),n7=nvl(n7,0);

-- Ty le thuc hien
update temp_2 set n8=round(decode(n7,0,0,n6/n7*100),2);

-- Ty le vuot ke hoach
b_dt:=(PKH_SO_CDT(b_ngayc)-PKH_SO_CDT(round(b_ngayd,-4)+101))/(PKH_SO_CDT(20161231)-PKH_SO_CDT(20160101));
update temp_2 set n9=round(decode(n7,0,0,n6/n7/b_dt*100),2)-100;

--Tinh diem vuot ke hoach
update temp_2 a set n19=(select max(n9) from temp_2 b where a.c6=b.c6);
update temp_2 set n10=round(n9/n19*30,2);
update temp_2 set n10=0 where n10<0;

update temp_2 set c11=(select ten from ht_ma_dvi where ma=c1);
update temp_2 set c14=(select ten from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);

open cs1 for select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n5 dt_tt,n6 hh_ps,n7 hh_kh,n8 tl_hh,n9 tl_hh_vuot,n10 diem_vuot from temp_2 order by c6,n10 desc,n8 desc;

commit;
exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
End;

procedure TNDN(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_dvi varchar2,b_ma_dl varchar2,
    b_ngayd number,b_ngayc number,cs1 out pht_type.cs_type)
AS
    b_loi varchar2(100);
Begin
if b_ngayd not between 20160101 and 20161231 or b_ngayc not between 20160101 and 20161231 then
    b_loi:='loi:Ngay bao cao khong hop le:loi'; raise_application_error(-20105,b_loi);
end if;
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','','');
if b_loi is not null then raise program_error; end if;

PBC_LAY_DVI('080','','080','a',b_loi);
if b_loi is not null then return; end if;

delete temp_2;
insert into temp_2(c4,n5,n15)
    select ma_dl,sum(decode(ma_ct,'TNDN_KH',so,0)),sum(decode(ma_ct,'TNDN_STBH',so,0)) from bh_dl_td_dt,temp_bc_dvi
        where ma_dvi=dvi and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0)
        group by ma_dl;

update temp_2 set c1=(select min(ma_dvi) from bh_dl_td_dt where thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_dl=c4);
update temp_2 set (c6,c7)=(select ma_kv,kvuc from bh_dl_td_kvuc where ma_dvi=c1 and ma_dl=c4);
update temp_2 set (c5)=(select ma_nhno from bh_dl_nhno where ma_dl=c4 and nam=2016);

update temp_2 set n6=(select sum(so) from bh_dl_td_dt where ma_dvi=c1 and ma_dl=c4
    and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_ct='TNDN_NHNo_KH');
update temp_2 set n16=(select sum(so) from bh_dl_td_dt where ma_dvi=c1 and ma_dl=c4
    and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_ct='TNDN_NHNo_VAY');

update temp_2 set n7=round(n5/n6*100,2) where n6<>0;
update temp_2 set n17=round(n15/n16*100,2) where n16<>0;

delete temp_2 where exists(select sum(dt_tt) from bh_dl_td_sl where ma_dl=c4 and thang between 201601 and 201612
    having sum(dt_tt)<1000000000);
-- Tinh diem
update temp_2 a set n8=(select max(n7) from temp_2 b where a.c6=b.c6);
update temp_2 set n9=round(n7/n8*37.5,2);
update temp_2 a set n18=(select max(n17) from temp_2 b where a.c6=b.c6);
update temp_2 set n19=round(n17/n18*37.5,2);

update temp_2 set n5=nvl(n5,0),n6=nvl(n6,0),n7=nvl(n7,0),n8=nvl(n8,0),n9=nvl(n9,0),
    n15=nvl(n15,0),n16=nvl(n16,0),n17=nvl(n17,0),n18=nvl(n18,0),n19=nvl(n19,0);
update temp_2 set n10=n9+n19;
update temp_2 set c11=(select ten from ht_ma_dvi where ma=c1);
update temp_2 set c14=(select ten from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);

commit;

open cs1 for select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n5 hd_dn,n6 hdtd_dn,n7 tl_dn,n9 diem_dn,n15 stbh_dn,n16 st_vay_dn,n17 tl_dt_dn,n19 diem_dt_dn,n10 diem_tt from temp_2
    order by c6,n10 desc,n8 desc;

exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
end;

procedure TNCN(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_dvi varchar2,b_ma_dl varchar2,
    b_ngayd number,b_ngayc number,cs1 out pht_type.cs_type)
AS
    b_loi varchar2(100);
Begin
if b_ngayd not between 20160101 and 20161231 or b_ngayc not between 20160101 and 20161231 then
    b_loi:='loi:Ngay bao cao khong hop le:loi'; raise_application_error(-20105,b_loi);
end if;
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','','');
if b_loi is not null then raise program_error; end if;

PBC_LAY_DVI('080','','080','a',b_loi);
if b_loi is not null then return; end if;

delete temp_2;
insert into temp_2(c4,n5,n15)
    select ma_dl,sum(decode(ma_ct,'TNCN_KH',so,0)),sum(decode(ma_ct,'TNCN_STBH',so,0)) from bh_dl_td_dt,temp_bc_dvi
        where ma_dvi=dvi and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0)
        group by ma_dl;

update temp_2 set c1=(select min(ma_dvi) from bh_dl_td_dt where thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_dl=c4);
update temp_2 set (c6,c7)=(select ma_kv,kvuc from bh_dl_td_kvuc where ma_dvi=c1 and ma_dl=c4);
update temp_2 set (c5)=(select ma_nhno from bh_dl_nhno where ma_dl=c4 and nam=2016);

update temp_2 set n6=(select sum(so) from bh_dl_td_dt where ma_dvi=c1 and ma_dl=c4
    and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_ct='TNCN_NHNo_KH');
update temp_2 set n16=(select sum(so) from bh_dl_td_dt where ma_dvi=c1 and ma_dl=c4
    and thang between round(b_ngayd/100,0) and round(b_ngayc/100,0) and ma_ct='TNCN_NHNo_VAY');

update temp_2 set n7=round(n5/n6*100,2) where n6<>0;
update temp_2 set n17=round(n15/n16*100,2) where n16<>0;

delete temp_2 where exists(select sum(dt_tt) from bh_dl_td_sl where ma_dl=c4 and thang between 201601 and 201612
    having sum(dt_tt)<1000000000);
-- Tinh diem
update temp_2 a set n8=(select max(n7) from temp_2 b where a.c6=b.c6);
update temp_2 set n9=round(n7/n8*37.5,2) where n8<>0;
update temp_2 a set n18=(select max(n17) from temp_2 b where a.c6=b.c6);
update temp_2 set n19=round(n17/n18*37.5,2) where n18<>0;

update temp_2 set n5=nvl(n5,0),n6=nvl(n6,0),n7=nvl(n7,0),n8=nvl(n8,0),n9=nvl(n9,0),
    n15=nvl(n15,0),n16=nvl(n16,0),n17=nvl(n17,0),n18=nvl(n18,0),n19=nvl(n19,0);
update temp_2 set n10=n9+n19;

update temp_2 set c11=(select ten from ht_ma_dvi where ma=c1);
update temp_2 set c14=(select ten from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);

commit;

open cs1 for select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n5 hd_cn,n6 hdtd_cn,n7 tl_cn,n9 diem_cn,n15 stbh_cn,n16 st_vay_cn,n17 tl_dt_cn,n19 diem_dt_cn,n10 diem_tt from temp_2
    order by c6,n10 desc;

exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
end;

procedure TH(b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_dvi varchar2,b_ma_dl varchar2,
    b_ngayd number,b_ngayc number,cs1 out pht_type.cs_type)
AS
    b_loi varchar2(100); b_tl_m number; b_dt number; b_dt_m number; cs2 pht_type.cs_type;
Begin
--Quy - Bao cao chuong trinh thi dua dai ly - tong hop
if b_ngayd not between 20160101 and 20161231 or b_ngayc not between 20160101 and 20161231 then
    b_loi:='loi:Ngay bao cao khong hop le:loi'; raise_application_error(-20105,b_loi);
end if;
b_loi:=FHT_MA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas,'BH','','');
if b_loi is not null then raise program_error; end if;

PBC_LAY_DVI('080','','080','a',b_loi);
if b_loi is not null then return; end if;

delete temp_6;

--DOANH THU
PBH_DL_TD_2016.DT(b_ma_dvi,b_nsd,b_pas,b_dvi,b_ma_dl,b_ngayd,b_ngayc,cs2);
insert into temp_6(c1,c6,c4,n1)
    select c1 ma_dvi,c6 ma_kv,c4 ma_dl,n13 diem_dt from temp_2;

-- HIEU QUA
PBH_DL_TD_2016.BT(b_ma_dvi,b_nsd,b_pas,b_dvi,b_ma_dl,b_ngayd,b_ngayc,cs2);
insert into temp_6(c1,c6,c4,n2)
    select c1 ma_dvi,c6 ma_kv,c4 ma_dl,n10 diem_hq from temp_2;

-- TANG TRUONG
PBH_DL_TD_2016.TT(b_ma_dvi,b_nsd,b_pas,b_dvi,b_ma_dl,b_ngayd,b_ngayc,cs2);
insert into temp_6(c1,c6,c4,n3)
    select c1 ma_dvi,c6 ma_kv,c4 ma_dl,n12 diem_tt from temp_2;

-- TANG TRUONG BEN VUNG
PBH_DL_TD_2016.TTBV(b_ma_dvi,b_nsd,b_pas,b_dvi,b_ma_dl,b_ngayd,b_ngayc,cs2,'C');
insert into temp_6(c1,c6,c4,n13)
    select c1 ma_dvi,c6 ma_kv,c4 ma_dl,n20 diem_tt_bv from temp_2;

-- VUOT KE HOACH
PBH_DL_TD_2016.HH(b_ma_dvi,b_nsd,b_pas,b_dvi,b_ma_dl,b_ngayd,b_ngayc,cs2);
insert into temp_6(c1,c6,c4,n4)
    select c1 ma_dvi,c6 ma_kv,c4 ma_dl,n10 diem_vuot from temp_2;

-- TIEM NANG DOANH NGHIEP
PBH_DL_TD_2016.TNDN(b_ma_dvi,b_nsd,b_pas,b_dvi,b_ma_dl,b_ngayd,b_ngayc,cs2);
insert into temp_6(c1,c6,c4,n5)
    select c1 ma_dvi,c6 ma_kv,c4 ma_dl,n10 diem_tt from temp_2;

-- TIEM NANG HO SAN XUAT
PBH_DL_TD_2016.TNCN(b_ma_dvi,b_nsd,b_pas,b_dvi,b_ma_dl,b_ngayd,b_ngayc,cs2);
insert into temp_6(c1,c6,c4,n6)
    select c1 ma_dvi,c6 ma_kv,c4 ma_dl,n10 diem_tt from temp_2;

-- TONG HOP
update temp_6 set n1=nvl(n1,0),n2=nvl(n2,0),n3=nvl(n3,0),n4=nvl(n4,0),n5=nvl(n5,0),n6=nvl(n6,0),n7=nvl(n7,0),n13=nvl(n13,0);
delete temp_2;
insert into temp_2(c1,c6,c4,n1,n2,n3,n13,n4,n5,n6,n7)
    select c1,c6,c4,sum(n1),sum(n2),sum(n3),sum(n13),sum(n4),sum(n5),sum(n6),sum(n1)+sum(n2)+sum(n3)+sum(n5)+sum(n6)+sum(n13)
        from temp_6 group by c1,c6,c4;

-- DIEM THUONG
update temp_2 set n8=0;
update temp_2 set n8='30' where c4='08006';
update temp_2 set n8='30' where c4='00217';
update temp_2 set n8='20' where c4='00201';
update temp_2 set n8='10' where c4='00206';
update temp_2 set n8='10' where c4='08005';
update temp_2 set n8='10' where c4='00210';

update temp_2 set n8='30' where c4='00705';
update temp_2 set n8='20' where c4='00509';

update temp_2 set n8='30' where c4='00134';
update temp_2 set n8='20' where c4='00806';
update temp_2 set n8='10' where c4='00808';
update temp_2 set n8='10' where c4='00116';
update temp_2 set n8='10' where c4='00801';
--//


update temp_2 set c11=(select ten from ht_ma_dvi where ma=c1);
update temp_2 set c14=(select ten from bh_dl_ma_kh where ma_dvi=c1 and ma=c4);
update temp_2 set c5=(select ma_nhno from bh_dl_nhno where ma_dl=c4 and nam=2016);
update temp_2 set n7=n7+n8;

update temp_2 set c7=(select min(kvuc) from bh_dl_td_kvuc where ma_kv=c6);

open cs1 for select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n1 diem_dt,n2 diem_hq,n3 diem_tt,n13 diem_tt_bv,n5 diem_dn,n6 diem_hsx,n8 diem_thuong,n7 tong_diem from temp_2
    where n7<>0
    order by c6,n7 desc,n1 desc;

commit;
exception when others then rollback;
    if b_loi is null then raise; else raise_application_error(-20105,b_loi); end if;
End;
End;