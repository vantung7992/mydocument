update kt_abic.bh_dl_td_dt set ma_ct=ma_ct||'_100217' where ma_ct='TNCN_NHNo_KH' and thang=201612 and ma_dl='00602';
insert into kt_abic.bh_dl_td_dt values('006','00602',201612,'TNCN_NHNo_KH',17400);

----
select sum(so) from kt_abic.bh_dl_td_dt where thang between 201600 and 201612 and  ma_dl='00602' and ma_ct='TNCN_NHNo_KH' order by thang;
select * from kt_abic.bh_dl_td_dt where ma_ct='TNCN_NHNo_KH_100217' and thang=201612 and ma_dl='00602';
select sum(so) from kt_abic.bh_dl_td_dt where ma_ct='TNCN_NHNo_KH' and thang between 201601 and 201612 and ma_dl='00602';
select sum(so) from kt_abic.bh_dl_td_dt where ma_ct='TNCN_NHNo_KH' and thang between 201601 and 201611 and ma_dl='00602';
