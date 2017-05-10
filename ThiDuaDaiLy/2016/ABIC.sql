declare cs1 kt_abic.pht_type.cs_type;
begin
TH('080','080','z','','',20160101,20161231,cs1);
end;

select c1 ma_dvi,c11 ten_dvi,c4 ma_dl,c14 ten_dl,c5 ma_nh,c6 kvuc,c7 kvuc_ten,
    n1 diem_dt,n2 diem_hq,n3 diem_tt,n5 diem_dn,n6 diem_hsx,n8 diem_thuong,n7 tong_diem from kt_abic.temp_2
	where n7<>0 and c4 in ('00901')
	order by c6,n7 desc,n1 desc;
  
  
  
  select * from kt_abic.bh_dl_ma_kh;