--Nguoi viet: TAIPA
--Nguoichay:TUNGNV - MAY CHU CHINH THUC - 9h 10/5/2017- Khong loi



-- buoc 1 lay so_du cong no cac tai khoan 13121,13131,33121,33131

-- drop table temp_doi_ma_cn;
-- drop table temp_so_du;
-- delete kt_abic.ket_qua;
create table temp_doi_ma_cn as   select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 from kt_abic.ket_qua order by n3;
DECLARE
TYPE Cursor_Type_12 IS REF CURSOR;
cs1 Cursor_Type_12;
BEGIN
---- tai khoan 33121
kt_abic.BCN_SO_DU_CTTH('080','080','z',20161231,'33121','','','','','');
insert into temp_doi_ma_cn select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 from kt_abic.ket_qua order by n3;

---- tai khoan 33131 

kt_abic.BCN_SO_DU_CTTH('080','080','z',20161231,'33131','','','','',''); 
insert into temp_doi_ma_cn select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 from kt_abic.ket_qua order by n3;
---- tai khoan 13121 
kt_abic.BCN_SO_DU_CTTH('080','080','z',20161231,'13121','','','','',''); 
insert into temp_doi_ma_cn select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 from kt_abic.ket_qua order by n3;
  
---- tai khoan 13131
  kt_abic.BCN_SO_DU_CTTH('080','080','z',20161231,'13131','','','','','');
insert into temp_doi_ma_cn select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 from kt_abic.ket_qua order by n3;

---- tai khoan 13134
  kt_abic.BCN_SO_DU_CTTH('080','080','z',20161231,'13134','','','','','');
insert into temp_doi_ma_cn select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 from kt_abic.ket_qua order by n3;
---- tai khoan 33124
  kt_abic.BCN_SO_DU_CTTH('080','080','z',20161231,'33124','','','','','');
insert into temp_doi_ma_cn select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 from kt_abic.ket_qua order by n3;

---- tai khoan 33132
  kt_abic.BCN_SO_DU_CTTH('080','080','z',20161231,'33132','','','','','');
insert into temp_doi_ma_cn select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 from kt_abic.ket_qua order by n3;
end;
-- buoc 2: lay so lieu snag bang khac
create table temp_so_du as   select c30,n20,n21,n19,c2,c3,c4,c5,c6,c7,n1,n3,n4,n6,c1 l_ct,0 bt_moi,0 id_moi,'AAAAAAAAAAAAAAA' ma_moi ,ROWNUM BT
from temp_doi_ma_cn where length(c2)<>4 order by n3;

-- buoc 3
update temp_so_du set ma_moi='KVNR' where c2='KVINARE';
update temp_so_du set ma_moi='KXTI' where c2='KGMIC';
update temp_so_du set ma_moi='KGRS' where c2='KGRSVW';
update temp_so_du set ma_moi='KBVI' where c2='KBV';
update temp_so_du set ma_moi='KBMI' where c2='KBM';
update temp_so_du set ma_moi='KPJI' where c2='KPJICO';
update temp_so_du set ma_moi='KBLI' where c2='KBL';
update temp_so_du set ma_moi='KBSH' where c2='KSVIC-000';
update temp_so_du set ma_moi='KFBO' where c2='KFUBON';
update temp_so_du set ma_moi='KPVR' where c2='KPVIRE';

-- buoc 4 tao chung tu phat sinh va thanh toan
---- chung tu phat sinh
------ cn_ch
INSERT INTO KT_ABIC.CN_CH 
VALUES('080',20170421002755,20161232,NULL,'32/12/2016',0,NULL,'TRUNGDD','H','CN',TO_DATE('2017-04-21 14:55:00', 'YYYY-MM-DD HH24:MI:SS'));
------ CN_CT
  insert into  kt_abic.cn_ct
  select c30,20170421002755,bt,20161232,l_ct,trim(ma_moi),c3,c4,c5,c6,c7,n4,n6 from temp_so_du where l_ct='C';
  insert into  kt_abic.cn_ct
  select c30,20170421002755,bt,20161232,l_ct,trim(ma_moi),c3,c4,c5,c6,c7,n1,n3 from temp_so_du where l_ct='N';
------ CN_PS
  insert into  kt_abic.cn_ps
  select c30,20170421002755,bt,'Chuyen ma CN TBH',l_ct,trim(ma_moi),c3,c4,c5,c6,n4,0,n6,0,20161232 from temp_so_du where l_ct='C';
  insert into  kt_abic.cn_ps
  select c30,20170421002755,bt,'Chuyen ma CN TBH',l_ct,trim(ma_moi),c3,c4,c5,c6,n1,0,n3,0,20161232 from temp_so_du where l_ct='N';
---- chung tu thanh toan
------ cn_ch  
INSERT INTO KT_ABIC.CN_CH 
VALUES('080',20170421002756,20161232,NULL,'32/12/2016',0,NULL,'TRUNGDD','H','CN',TO_DATE('2017-04-21 14:55:00', 'YYYY-MM-DD HH24:MI:SS'));
------ CN_CT
  insert into  kt_abic.cn_ct
  select c30,20170421002756,bt,20161232,'N',c2,c3,c4,c5,c6,c7,n4,n6 from temp_so_du where l_ct='C';
  insert into  kt_abic.cn_ct
  select c30,20170421002756,bt,20161232,'C',c2,c3,c4,c5,c6,c7,n1,n3 from temp_so_du where l_ct='N';
------ CN_TT
  insert into  kt_abic.cn_tt
  select c30,20170421002756,bt,1,'N',n20,n21,n4,n6,0,0,20161232 from temp_so_du where l_ct='C';
  insert into  kt_abic.cn_tt
  select c30,20170421002756,bt,1,'C',n20,n21,n1,n3,0,0,20161232 from temp_so_du where l_ct='N';
  
-- buoc 5 update s? li?u
---- sua chung tu neu gia tri la null
update kt_abic.cn_ps set tra=0,tra_qd=0 where ma_dvi ='080' and so_id = 20170421002755;
---- cac chung tu cong no theo mã cu duoc thanh toan het
update  kt_abic.cn_ps set tra=tien,tra_qd=tien_qd where   ma_dvi ='080' and (so_id,bt) in (select so_id_ps,bt_ps from kt_abic.cn_tt where so_id = 20170421002756);
---- chung tu thanh toan nam 2017 cho cac chung tu cu duoc doi thanh chung tu moi
update kt_abic.cn_tt set (so_id_ps,bt_ps) = ( select max(id_moi),max(bt_moi) from temp_so_du where so_id_ps = n20 
and bt_ps =n21)
 where ngay_ht >= 20170101 and (so_id_ps,bt_ps) in (select n20,n21 from temp_so_du);
---- Chung tu ma moi duoc tong hop thanh toan
update kt_abic.cn_ps set (tra,tra_qd)= (select sum(tra),sum(tra_qd)
 from kt_abic.cn_tt where ma_dvi ='080' and so_id_ps = so_id and bt_ps=bt)
 where so_id = 20170421002755 ;
update kt_abic.cn_ps set tra=0 where so_id = 20170421002755 and tra is null;
update kt_abic.cn_ps set tra_qd=0 where so_id = 20170421002755 and tra_qd is null;

--buoc6  update ma_cn_moi cho cac chung tu phat sinh nam 2017
update kt_abic.cn_ct set ma_cn='KVNR' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KVINARE';
update kt_abic.cn_ct set ma_cn='KXTI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KGMIC';
update kt_abic.cn_ct set ma_cn='KGRS' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KGRSVW';
update kt_abic.cn_ct set ma_cn='KBVI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KBV';
update kt_abic.cn_ct set ma_cn='KBMI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KBM';
update kt_abic.cn_ct set ma_cn='KPJI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KPJICO';
update kt_abic.cn_ct set ma_cn='KBLI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KBL';
update kt_abic.cn_ct set ma_cn='KBSH' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KSVIC-000';
update kt_abic.cn_ct set ma_cn='KFBO' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KFUBON';
update kt_abic.cn_ct set ma_cn='KPVR' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KPVIRE';

update kt_abic.cn_ps set ma_cn='KVNR' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KVINARE';
update kt_abic.cn_ps set ma_cn='KXTI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KGMIC';
update kt_abic.cn_ps set ma_cn='KGRS' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KGRSVW';
update kt_abic.cn_ps set ma_cn='KBVI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KBV';
update kt_abic.cn_ps set ma_cn='KBMI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KBM';
update kt_abic.cn_ps set ma_cn='KPJI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KPJICO';
update kt_abic.cn_ps set ma_cn='KBLI' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KBL';
update kt_abic.cn_ps set ma_cn='KBSH' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KSVIC-000';
update kt_abic.cn_ps set ma_cn='KFBO' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KFUBON';
update kt_abic.cn_ps set ma_cn='KPVR' where ma_dvi ='080' and ngay_ht>=20170101 and   ma_cn='KPVIRE';




