create or replace procedure PBH_BA_DL_DSACH
    (b_ma_dvi varchar2,b_nsd varchar2,b_pas varchar2,b_ngayd number,b_ngayc number,
    b_dvi varchar2,b_phong varchar2,b_ma_nh varchar2,b_ma_dl varchar2,cs1 out pht_type.cs_type,cs2 out pht_type.cs_type,
    b_kieu varchar2:='C',b_loai varchar2:='CT')
AS
    b_loi varchar2(100); b_loai_dl varchar2(1);
Begin
-- So khai thac
  b_loi:=FBH_BA_NSD_KTRA(b_ma_dvi,b_nsd,b_pas);
  if b_loi is not null then raise PROGRAM_ERROR; end if;
  PBC_LAY_DVI(b_ma_dvi,b_dvi,b_nsd,b_pas,b_loi);
  if b_loi is not null then raise PROGRAM_ERROR; end if;
  b_loi:='loi:PBH_BA_DL_DSACH: ';
  
-- Lay danh sach dai ly (thieu dai ly thuoc to chuc ngoai he thong)
  delete temp_2_u;
  insert into temp_2_u(c1,c2,c3,c4,c5,c13,c7,d1) select distinct ma_dvi,ma_ct,ma,phong,nhang,ten,dchi,ngay_c from bh_dl_ma_kh,temp_bc_dvi
      where ma_dvi= dvi and ma_ct is not null and nhang like 'AGRI%'
      and (hd_dly is not null or gcn_hd is not null)
      and (b_phong is null or phong=b_phong)
      and pt_thue <> 'D';
  
  if b_ma_dl is null and b_ma_nh is null then
      -- Dai ly ca nhan 
      insert into temp_2_u(c1,c2,c3,c4,c5,c13,c7,d1) select distinct ma_dvi,'LE',ma,phong,nhang,ten,dchi,ngay_c from bh_dl_ma_kh,temp_bc_dvi
          where ma_dvi = dvi and ma_ct is null and ma not like ma_dvi||'%'
          and (hd_dly is not null or gcn_hd is not null)
          and (b_phong is null or phong=b_phong) and pt_thue <> 'D';
      -- To chuc ngoai he thong (to chuc co dai ly ca nhan) 
      insert into temp_2_u(c1,c2,c3,c4,c5,c13,c7,d1) select distinct a.ma_dvi,a.ma_ct,a.ma,a.phong,a.nhang,a.ten,a.dchi,a.ngay_c from bh_dl_ma_kh a,temp_bc_dvi
          where  a.ma_dvi = dvi 
          and (a.hd_dly is not null or a.gcn_hd is not null)
          and (b_phong is null or a.phong=b_phong)
          and a.ma_ct in
          (select ma from bh_dl_ma_kh b 
            where pt_thue='D' 
            and ( nhang is null or nhang not like 'AGRI%') 
            and loai <> '0301' and ma_ct is null
            and exists(select c.ma from bh_dl_ma_kh c where c.ma_ct=b.ma)); 
  end if;
  
  if b_ma_dl is not null then
      delete temp_2_u where b_ma_dl not in (c2,c3);
  end if;
  
  if b_ma_nh is not null then
      delete temp_2_u where c5 not like b_ma_nh||'%';
  end if;
  
-- xoa dl da thanh ly, dl rac
  delete from temp_2_u where c1='080' and c2 in ('08003','08001','08007','08009','08011');
  delete from temp_2_u where c1='002' and c2 in ('00229','00233','00213');
  delete from temp_2_u where c1='001' and c2 in ('00145','00106','00213');
  delete from temp_2_u where c1='006' and c2 in ('00606');
  
  delete from temp_2_u where c3='0041' and c1='080';
  delete from temp_2_u where c3='00801' and c1='080';
  
  delete from temp_2_u where c3='00403' and c1='009';
  delete from temp_2_u where c3='01001' and c1='009';
  delete from temp_2_u where c3='01003' and c1='009';
  delete from temp_2_u where c3='01004' and c1='009';
-- them thong tin 
  update temp_2_u set (d2,c8,c9,d3,c10,d4,c11,d5)=(select ngay_sinh,so_cmt,gcn_hd,ngay_gcn,hd_dly,ngay_hd,substr(gchu,1,250),ngay_c
      from bh_dl_ma_kh where ma_dvi=c1 and ma=c3);

-- 1a:dl tuyen moi,-1a:Thoi viec,1b:Tai tuc,-1b:Het han HD    
    update temp_2_u a set c14='1a' where exists (select ma_dl,ma_dvi from bh_dl_ls where ngay between b_ngayd and b_ngayc and a.c1= ma_dvi and a.c3=ma_dl and loai='KM');
    update temp_2_u a set c14='1b' where exists (select * from bh_dl_ls where ngay between b_ngayd and b_ngayc and a.c1=ma_dvi and a.c3=ma_dl and loai = 'TT');
    update temp_2_u a set c15='-1a' where exists (select * from bh_dl_ls where ngay between b_ngayd and b_ngayc and a.c1=ma_dvi and a.c3=ma_dl and loai = 'TV');
    update temp_2_u a set c15='-1b' where exists (select * from bh_dl_ls where ngay between b_ngayd and b_ngayc and a.c1=ma_dvi and a.c3=ma_dl and loai = 'HH');

  if b_kieu='C' then -- Tinh tong
    update temp_2_u set c30='C',n30=2,n29=1;

  -- Dai ly ca nhan
    if b_ma_dl is null and b_ma_nh is null then
        insert into temp_2_u(c30,n30,n29,c29,c1,c2,c13,n6,n11,n12,c16)
            select 'T',1,2,c1,c1,' ',ten,count(*),sum(n11),sum(n12),'T' from temp_2_u, ht_ma_dvi
                where c2='LE' and c30='C' and c1=ma group by c1,ten;
        update temp_2_u set n30=1,c2=' ' where c2='LE';
    end if;

    -- Chi nhanh cho dai ly to chuc
    insert into temp_2_u(c30,n30,n29,c29,c1,c2,c13,n6,n11,n12,c16)
            select 'T',2,5,c1,c1,' ',ten,count(*),sum(n11),sum(n12),'T' from temp_2_u,ht_ma_dvi
            where n30=2 and c30='C' and c1=ma group by c1,ten;

    -- Tong dai ly
    delete temp_1_u;
    insert into temp_1_u(c1,c2,c5,c13,n6,n11,n12,d5,c8,c10,d4)
        select c1,c2,' ',lpad(' ',4)||c2||' - '||ten||' - '||dchi,count(*),sum(n11),sum(n12),ngay_c,so_cmt,hd_dly,ngay_hd 
          from temp_2_u,bh_dl_ma_kh
          where ma_dvi=c1 and ma=c2 and c30='C' group by c1,c2,ten,dchi,ngay_c,so_cmt,hd_dly,ngay_hd;
            
    insert into temp_2_u(c30,n30,c29,n29,c1,c2,c5,c13,n6,d2,c8,c9,n9,c10,n10,c11,d5,d4)
        select 'T',2,'B'||rownum,4,a.* from (select c1,c2,c5,c13,n6,d2,c8,c9,n9,c10,n10,c11,d5,d4 from temp_1_u where c2<>'LE' order by c2) a;

    -- Tieu de
    insert into temp_2_u(c30,n30,c29,n29,c13,c16,c1) values('T',1,'A',6,'§¹i lý c¸ nh©n','T','000');
    insert into temp_2_u(c30,n30,c29,n29,c13,c16,c1) values('T',2,'B',6,'§¹i lý tæ chøc','T','000');

    -- Tong hop
    delete temp_1_u;
    insert into temp_1_u(c1,n1)
      select '1.1',count(*) from temp_2_u
      where n30=1 and n29=1 and d5 >= PKH_SO_CDT(b_ngayd);
    insert into temp_1_u(c1,n1)
      select '1.2',count(*) from temp_2_u
      where n30=2 and n29=4 and d5 >= PKH_SO_CDT(b_ngayd);
    insert into temp_1_u(c1,n1)
      select '1.3',count(*) from temp_2_u
      where n30=2 and n29=1 and d5 >= PKH_SO_CDT(b_ngayd);
    insert into temp_1_u(c1,n1)
      select '2.1.1',count(*) from temp_2_u a, bh_dl_ls b 
      where a.c3 = b.ma_dl and a.c1=b.ma_dvi and b.loai='KM' and a.n30=1 and n29=1
      and b.ngay between b_ngayd and b_ngayc;
    insert into temp_1_u(c1,n1)
      select '2.1.2',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='KM' and a.n30=2 and a.n29=4
       and b.ngay between b_ngayd and b_ngayc;
    insert into temp_1_u(c1,n1)
      select '2.1.3',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='KM' and a.n30=2 and a.n29=1
      and b.ngay between b_ngayd and b_ngayc;  
    insert into temp_1_u(c1,n1)
      select '2.2.1',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='TT' and a.n30=1 and a.n29=1
      and b.ngay between b_ngayd and b_ngayc;
    insert into temp_1_u(c1,n1)
      select '2.2.2',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='TT' and a.n30=2 and a.n29=4
      and b.ngay between b_ngayd and b_ngayc;
    insert into temp_1_u(c1,n1)
      select '2.2.3',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='TT' and a.n30=2 and a.n29=1
      and b.ngay between b_ngayd and b_ngayc;  
    insert into temp_1_u(c1,n1)
      select '3.1.1',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='TV' and a.n30=1 and a.n29=1
      and b.ngay between b_ngayd and b_ngayc;
    insert into temp_1_u(c1,n1)
      select '3.1.2',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='TV' and a.n30=2 and a.n29=4
      and b.ngay between b_ngayd and b_ngayc;
    insert into temp_1_u(c1,n1)
      select '3.1.3',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='TV' and a.n30=2 and a.n29=1
      and b.ngay between b_ngayd and b_ngayc;  
    insert into temp_1_u(c1,n1)
      select '3.2.1',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='HH' and a.n30=1 and a.n29=1
      and b.ngay between b_ngayd and b_ngayc;
    insert into temp_1_u(c1,n1)
      select '3.2.2',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='HH' and a.n30=2 and a.n29=4
      and b.ngay between b_ngayd and b_ngayc;
    insert into temp_1_u(c1,n1)
      select '3.2.3',count(*) from temp_2_u a, bh_dl_ls b
      where a.c3=b.ma_dl and a.c1=b.ma_dvi and b.loai='HH' and a.n30=2 and a.n29=1
      and b.ngay between b_ngayd and b_ngayc;
      
    open cs1 for select c30 tc,c29 tt,c1 ma_dvi,c3 ma_dl,FKH_TCVN_UNI(trim(c13)) ten,c4 phong,
        c7 dchi,PKH_NG_CNG(d2) ngay_sinh,c8 so_cmt,c9 cc_so,PKH_NG_CNG(d3) cc_ngay,c10 hd_so,PKH_NG_CNG(d4) hd_ngay,
        PKH_NG_CNG(d1) ngay_kt,c14 tang,c15 giam,FKH_TCVN_UNI(c11) gchu,c17,n30,c2,c5,n29,c30,c3 from temp_2_u
        order by n30,c1,c16,c2,c5,n29 desc,c30,c3;    
    open cs2 for
      select c1,n1 from temp_1_u;
else
    open cs1 for select c1 ma_dvi,c3 ma_dl,FKH_TCVN_UNI(c13) ten,c4 phong,
        c7 dchi,PKH_NG_CNG(d2) ngay_sinh,c8 so_cmt,c9 cc_so,PKH_NG_CNG(d3) cc_ngay,c10 hd_so,PKH_NG_CNG(d4) hd_ngay,
        PKH_NG_CNG(d1) ngay_kt,c14 tang,c15 giam,FKH_TCVN_UNI(c11) gchu from temp_2_u
        order by c2,c5,c30,c3;
end if;
commit;
exception when others then rollback;
    b_loi:=substr(b_loi||SQLERRM||':loi',1,100);
    raise_application_error(-20105,b_loi);
end;