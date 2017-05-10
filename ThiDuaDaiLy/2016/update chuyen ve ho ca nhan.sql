--Update chuyen ve ho ca nhan
----update stbh
update kt_abic.bh_dl_td_dt set so=so+42746000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00201';
update kt_abic.bh_dl_td_dt set so=so+7001000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00202';
update kt_abic.bh_dl_td_dt set so=so+14138000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00204';
update kt_abic.bh_dl_td_dt set so=so+18819000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00206';
update kt_abic.bh_dl_td_dt set so=so+500000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00207';
update kt_abic.bh_dl_td_dt set so=so+6380000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00230';
update kt_abic.bh_dl_td_dt set so=so+1110000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00235';
update kt_abic.bh_dl_td_dt set so=so+26334000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00402';
update kt_abic.bh_dl_td_dt set so=so+16880000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00403';
update kt_abic.bh_dl_td_dt set so=so+8482000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00404';
update kt_abic.bh_dl_td_dt set so=so+12531000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='00901';
update kt_abic.bh_dl_td_dt set so=so+183131600000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='08005';
update kt_abic.bh_dl_td_dt set so=so+32833000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='08006';
update kt_abic.bh_dl_td_dt set so=so+44714700000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='08008';
update kt_abic.bh_dl_td_dt set so=so+9994000000 where thang=201612 and ma_ct='TNCN_STBH' and ma_dl='08009';


--update kh
update kt_abic.bh_dl_td_dt set so=so+92 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00201'; 
update kt_abic.bh_dl_td_dt set so=so+14 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00202'; 
update kt_abic.bh_dl_td_dt set so=so+12 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00204'; 
update kt_abic.bh_dl_td_dt set so=so+30 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00206'; 
update kt_abic.bh_dl_td_dt set so=so+1 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00207'; 
update kt_abic.bh_dl_td_dt set so=so+10 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00230'; 
update kt_abic.bh_dl_td_dt set so=so+2 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00235'; 
update kt_abic.bh_dl_td_dt set so=so+51 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00402'; 
update kt_abic.bh_dl_td_dt set so=so+30 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00403'; 
update kt_abic.bh_dl_td_dt set so=so+18 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00404'; 
update kt_abic.bh_dl_td_dt set so=so+14 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='00901'; 
update kt_abic.bh_dl_td_dt set so=so+331 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='08005'; 
update kt_abic.bh_dl_td_dt set so=so+47 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='08006'; 
update kt_abic.bh_dl_td_dt set so=so+96 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='08008'; 
update kt_abic.bh_dl_td_dt set so=so+18 where thang=201612 and ma_ct='TNCN_KH' and ma_dl='08009'; 

--
insert into kt_abic.bh_dl_td_dt values('080','08015',201612,'TNCN_KH',2);
insert into kt_abic.bh_dl_td_dt values('080','08015',201612,'TNCN_STBH',2350000000);

