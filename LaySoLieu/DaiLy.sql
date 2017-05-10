--Dai ly
--08/04/2017:Lay danh sach dl vien thuoc agri - Ngan
select ma_dvi,ten,dchi,tax,so_cmt,nhang,loai,pt_thue from kt_abic.bh_dl_ma_kh 
  where nhang like 'AGRI%' and ma_ct is not null and pt_thue <> 'K'
  order by ma_dvi;