-- xoa het du lieu tiem nang doanh nghiep ABIC 201612
-- them moi du lieu tiem nang doanh nghiep Abic 201612
--delete from kt_abic.bh_dl_td_dt where thang BETWEEN 201601 and 201612 and ma_ct in ('TNDN_KH','TNDN_STBH');
update kt_abic.bh_dl_td_dt set MA_CT = MA_CT || '_2016' where thang BETWEEN 201601 and 201612 and ma_ct in ('TNDN_KH','TNDN_STBH');
----KH
insert into kt_abic.bh_dl_td_dt values('080','08005',201612,'TNDN_KH',421);
insert into kt_abic.bh_dl_td_dt values('080','08003',201612,'TNDN_KH',309);
insert into kt_abic.bh_dl_td_dt values('002','00222',201612,'TNDN_KH',213);
insert into kt_abic.bh_dl_td_dt values('002','00201',201612,'TNDN_KH',204);
insert into kt_abic.bh_dl_td_dt values('080','08006',201612,'TNDN_KH',111);
insert into kt_abic.bh_dl_td_dt values('080','08001',201612,'TNDN_KH',86);
insert into kt_abic.bh_dl_td_dt values('080','08008',201612,'TNDN_KH',71);
insert into kt_abic.bh_dl_td_dt values('080','08004',201612,'TNDN_KH',64);
insert into kt_abic.bh_dl_td_dt values('080','08013',201612,'TNDN_KH',59);
insert into kt_abic.bh_dl_td_dt values('006','00605',201612,'TNDN_KH',53);
insert into kt_abic.bh_dl_td_dt values('080','08010',201612,'TNDN_KH',49);
insert into kt_abic.bh_dl_td_dt values('006','00602',201612,'TNDN_KH',44);
insert into kt_abic.bh_dl_td_dt values('002','00206',201612,'TNDN_KH',40);
insert into kt_abic.bh_dl_td_dt values('002','00231',201612,'TNDN_KH',36);
insert into kt_abic.bh_dl_td_dt values('002','00224',201612,'TNDN_KH',34);
insert into kt_abic.bh_dl_td_dt values('002','00220',201612,'TNDN_KH',31);
insert into kt_abic.bh_dl_td_dt values('080','08009',201612,'TNDN_KH',30);
insert into kt_abic.bh_dl_td_dt values('080','08002',201612,'TNDN_KH',27);
insert into kt_abic.bh_dl_td_dt values('002','00223',201612,'TNDN_KH',27);
insert into kt_abic.bh_dl_td_dt values('002','00230',201612,'TNDN_KH',26);
insert into kt_abic.bh_dl_td_dt values('002','00204',201612,'TNDN_KH',18);
insert into kt_abic.bh_dl_td_dt values('006','00603',201612,'TNDN_KH',18);
insert into kt_abic.bh_dl_td_dt values('002','00227',201612,'TNDN_KH',15);
insert into kt_abic.bh_dl_td_dt values('002','00234',201612,'TNDN_KH',13);
insert into kt_abic.bh_dl_td_dt values('002','00235',201612,'TNDN_KH',13);
insert into kt_abic.bh_dl_td_dt values('002','00209',201612,'TNDN_KH',12);
insert into kt_abic.bh_dl_td_dt values('002','00211',201612,'TNDN_KH',10);
insert into kt_abic.bh_dl_td_dt values('002','00232',201612,'TNDN_KH',8);
insert into kt_abic.bh_dl_td_dt values('002','00205',201612,'TNDN_KH',7);
insert into kt_abic.bh_dl_td_dt values('002','00202',201612,'TNDN_KH',7);
insert into kt_abic.bh_dl_td_dt values('080','08011',201612,'TNDN_KH',7);
insert into kt_abic.bh_dl_td_dt values('002','00208',201612,'TNDN_KH',7);
insert into kt_abic.bh_dl_td_dt values('002','00214',201612,'TNDN_KH',6);
insert into kt_abic.bh_dl_td_dt values('080','08015',201612,'TNDN_KH',6);
insert into kt_abic.bh_dl_td_dt values('080','08007',201612,'TNDN_KH',4);
insert into kt_abic.bh_dl_td_dt values('002','00207',201612,'TNDN_KH',4);
insert into kt_abic.bh_dl_td_dt values('002','00219',201612,'TNDN_KH',4);
insert into kt_abic.bh_dl_td_dt values('002','00236',201612,'TNDN_KH',3);
insert into kt_abic.bh_dl_td_dt values('002','00212',201612,'TNDN_KH',3);
insert into kt_abic.bh_dl_td_dt values('002','00225',201612,'TNDN_KH',3);
insert into kt_abic.bh_dl_td_dt values('002','00218',201612,'TNDN_KH',3);
insert into kt_abic.bh_dl_td_dt values('006','00610',201612,'TNDN_KH',2);
insert into kt_abic.bh_dl_td_dt values('003','00307',201612,'TNDN_KH',100);
insert into kt_abic.bh_dl_td_dt values('009','00901',201612,'TNDN_KH',736);
insert into kt_abic.bh_dl_td_dt values('007','00701',201612,'TNDN_KH',33);
insert into kt_abic.bh_dl_td_dt values('005','00506',201612,'TNDN_KH',7);
insert into kt_abic.bh_dl_td_dt values('003','00302',201612,'TNDN_KH',345);
insert into kt_abic.bh_dl_td_dt values('007','00702',201612,'TNDN_KH',225);
insert into kt_abic.bh_dl_td_dt values('007','00704',201612,'TNDN_KH',65);
insert into kt_abic.bh_dl_td_dt values('003','00306',201612,'TNDN_KH',50);
insert into kt_abic.bh_dl_td_dt values('007','00705',201612,'TNDN_KH',60);
insert into kt_abic.bh_dl_td_dt values('003','00304',201612,'TNDN_KH',82);
insert into kt_abic.bh_dl_td_dt values('003','00303',201612,'TNDN_KH',17);
insert into kt_abic.bh_dl_td_dt values('003','00301',201612,'TNDN_KH',129);
insert into kt_abic.bh_dl_td_dt values('007','00703',201612,'TNDN_KH',119);
insert into kt_abic.bh_dl_td_dt values('003','00305',201612,'TNDN_KH',104);
insert into kt_abic.bh_dl_td_dt values('004','00403',201612,'TNDN_KH',34);
insert into kt_abic.bh_dl_td_dt values('005','00502',201612,'TNDN_KH',33);
insert into kt_abic.bh_dl_td_dt values('004','00402',201612,'TNDN_KH',42);
insert into kt_abic.bh_dl_td_dt values('004','00404',201612,'TNDN_KH',32);
insert into kt_abic.bh_dl_td_dt values('007','00706',201612,'TNDN_KH',3);
insert into kt_abic.bh_dl_td_dt values('008','00802',201612,'TNDN_KH',118);
insert into kt_abic.bh_dl_td_dt values('001','00103',201612,'TNDN_KH',77);
insert into kt_abic.bh_dl_td_dt values('008','00808',201612,'TNDN_KH',75);
insert into kt_abic.bh_dl_td_dt values('001','00130',201612,'TNDN_KH',56);
insert into kt_abic.bh_dl_td_dt values('008','00801',201612,'TNDN_KH',50);
insert into kt_abic.bh_dl_td_dt values('008','00803',201612,'TNDN_KH',45);
insert into kt_abic.bh_dl_td_dt values('001','00122',201612,'TNDN_KH',41);
insert into kt_abic.bh_dl_td_dt values('001','00102',201612,'TNDN_KH',40);
insert into kt_abic.bh_dl_td_dt values('001','00128',201612,'TNDN_KH',37);
insert into kt_abic.bh_dl_td_dt values('008','00804',201612,'TNDN_KH',35);
insert into kt_abic.bh_dl_td_dt values('008','00810',201612,'TNDN_KH',32);
insert into kt_abic.bh_dl_td_dt values('001','00147',201612,'TNDN_KH',32);
insert into kt_abic.bh_dl_td_dt values('001','00135',201612,'TNDN_KH',29);
insert into kt_abic.bh_dl_td_dt values('001','00124',201612,'TNDN_KH',29);
insert into kt_abic.bh_dl_td_dt values('001','00109',201612,'TNDN_KH',28);
insert into kt_abic.bh_dl_td_dt values('001','00134',201612,'TNDN_KH',26);
insert into kt_abic.bh_dl_td_dt values('008','00806',201612,'TNDN_KH',26);
insert into kt_abic.bh_dl_td_dt values('001','00125',201612,'TNDN_KH',24);
insert into kt_abic.bh_dl_td_dt values('001','00143',201612,'TNDN_KH',20);
insert into kt_abic.bh_dl_td_dt values('008','00811',201612,'TNDN_KH',18);
insert into kt_abic.bh_dl_td_dt values('001','00115',201612,'TNDN_KH',17);
insert into kt_abic.bh_dl_td_dt values('008','00809',201612,'TNDN_KH',13);
insert into kt_abic.bh_dl_td_dt values('008','00807',201612,'TNDN_KH',11);
insert into kt_abic.bh_dl_td_dt values('001','00105',201612,'TNDN_KH',10);
insert into kt_abic.bh_dl_td_dt values('001','00137',201612,'TNDN_KH',8);
insert into kt_abic.bh_dl_td_dt values('001','00139',201612,'TNDN_KH',7);
insert into kt_abic.bh_dl_td_dt values('008','00805',201612,'TNDN_KH',6);
insert into kt_abic.bh_dl_td_dt values('001','00133',201612,'TNDN_KH',6);
insert into kt_abic.bh_dl_td_dt values('001','00123',201612,'TNDN_KH',6);
insert into kt_abic.bh_dl_td_dt values('001','00126',201612,'TNDN_KH',5);
insert into kt_abic.bh_dl_td_dt values('001','00107',201612,'TNDN_KH',4);
insert into kt_abic.bh_dl_td_dt values('001','00104',201612,'TNDN_KH',4);
insert into kt_abic.bh_dl_td_dt values('001','00152',201612,'TNDN_KH',3);
insert into kt_abic.bh_dl_td_dt values('001','00111',201612,'TNDN_KH',3);
insert into kt_abic.bh_dl_td_dt values('001','00110',201612,'TNDN_KH',2);
insert into kt_abic.bh_dl_td_dt values('001','00140',201612,'TNDN_KH',2);
insert into kt_abic.bh_dl_td_dt values('001','00146',201612,'TNDN_KH',2);
insert into kt_abic.bh_dl_td_dt values('001','00108',201612,'TNDN_KH',2);
insert into kt_abic.bh_dl_td_dt values('001','00136',201612,'TNDN_KH',1);
insert into kt_abic.bh_dl_td_dt values('001','00116',201612,'TNDN_KH',1);
insert into kt_abic.bh_dl_td_dt values('001','00101',201612,'TNDN_KH',1);
insert into kt_abic.bh_dl_td_dt values('001','00131',201612,'TNDN_KH',1);
insert into kt_abic.bh_dl_td_dt values('001','00129',201612,'TNDN_KH',1);

----STBH
insert into kt_abic.bh_dl_td_dt values('080','08005',201612,'TNDN_STBH',1477436249682);
insert into kt_abic.bh_dl_td_dt values('080','08003',201612,'TNDN_STBH',1455732279912);
insert into kt_abic.bh_dl_td_dt values('002','00222',201612,'TNDN_STBH',993806440453);
insert into kt_abic.bh_dl_td_dt values('002','00201',201612,'TNDN_STBH',552740764924);
insert into kt_abic.bh_dl_td_dt values('080','08006',201612,'TNDN_STBH',1711125116189);
insert into kt_abic.bh_dl_td_dt values('080','08001',201612,'TNDN_STBH',308224412797);
insert into kt_abic.bh_dl_td_dt values('080','08008',201612,'TNDN_STBH',1652779926571);
insert into kt_abic.bh_dl_td_dt values('080','08004',201612,'TNDN_STBH',68817320000);
insert into kt_abic.bh_dl_td_dt values('080','08013',201612,'TNDN_STBH',2439697126615);
insert into kt_abic.bh_dl_td_dt values('006','00605',201612,'TNDN_STBH',64471005763);
insert into kt_abic.bh_dl_td_dt values('080','08010',201612,'TNDN_STBH',32746000000);
insert into kt_abic.bh_dl_td_dt values('006','00602',201612,'TNDN_STBH',37397056716);
insert into kt_abic.bh_dl_td_dt values('002','00206',201612,'TNDN_STBH',31407200000);
insert into kt_abic.bh_dl_td_dt values('002','00231',201612,'TNDN_STBH',306142835000);
insert into kt_abic.bh_dl_td_dt values('002','00224',201612,'TNDN_STBH',513912065950);
insert into kt_abic.bh_dl_td_dt values('002','00220',201612,'TNDN_STBH',63926618914);
insert into kt_abic.bh_dl_td_dt values('080','08009',201612,'TNDN_STBH',123894615619);
insert into kt_abic.bh_dl_td_dt values('080','08002',201612,'TNDN_STBH',57849000000);
insert into kt_abic.bh_dl_td_dt values('002','00223',201612,'TNDN_STBH',44165964000);
insert into kt_abic.bh_dl_td_dt values('002','00230',201612,'TNDN_STBH',152902574698);
insert into kt_abic.bh_dl_td_dt values('002','00204',201612,'TNDN_STBH',24366000000);
insert into kt_abic.bh_dl_td_dt values('006','00603',201612,'TNDN_STBH',9840950000);
insert into kt_abic.bh_dl_td_dt values('002','00227',201612,'TNDN_STBH',37550000000);
insert into kt_abic.bh_dl_td_dt values('002','00234',201612,'TNDN_STBH',541687384575);
insert into kt_abic.bh_dl_td_dt values('002','00235',201612,'TNDN_STBH',21540879359);
insert into kt_abic.bh_dl_td_dt values('002','00209',201612,'TNDN_STBH',232275688331);
insert into kt_abic.bh_dl_td_dt values('002','00211',201612,'TNDN_STBH',10566000000);
insert into kt_abic.bh_dl_td_dt values('002','00232',201612,'TNDN_STBH',7457228711);
insert into kt_abic.bh_dl_td_dt values('002','00205',201612,'TNDN_STBH',112859512454);
insert into kt_abic.bh_dl_td_dt values('002','00202',201612,'TNDN_STBH',7943584485);
insert into kt_abic.bh_dl_td_dt values('080','08011',201612,'TNDN_STBH',4270000000);
insert into kt_abic.bh_dl_td_dt values('002','00208',201612,'TNDN_STBH',4000000000);
insert into kt_abic.bh_dl_td_dt values('002','00214',201612,'TNDN_STBH',14710000000);
insert into kt_abic.bh_dl_td_dt values('080','08015',201612,'TNDN_STBH',6551715000);
insert into kt_abic.bh_dl_td_dt values('080','08007',201612,'TNDN_STBH',108772196095);
insert into kt_abic.bh_dl_td_dt values('002','00207',201612,'TNDN_STBH',4200000000);
insert into kt_abic.bh_dl_td_dt values('002','00219',201612,'TNDN_STBH',2600000000);
insert into kt_abic.bh_dl_td_dt values('002','00236',201612,'TNDN_STBH',45952148928);
insert into kt_abic.bh_dl_td_dt values('002','00212',201612,'TNDN_STBH',29531319817);
insert into kt_abic.bh_dl_td_dt values('002','00225',201612,'TNDN_STBH',2665000000);
insert into kt_abic.bh_dl_td_dt values('002','00218',201612,'TNDN_STBH',1740000000);
insert into kt_abic.bh_dl_td_dt values('006','00610',201612,'TNDN_STBH',1599000000);
insert into kt_abic.bh_dl_td_dt values('003','00307',201612,'TNDN_STBH',2030330148630);
insert into kt_abic.bh_dl_td_dt values('009','00901',201612,'TNDN_STBH',1210619752145);
insert into kt_abic.bh_dl_td_dt values('007','00701',201612,'TNDN_STBH',1172643189934);
insert into kt_abic.bh_dl_td_dt values('005','00506',201612,'TNDN_STBH',922764051288);
insert into kt_abic.bh_dl_td_dt values('003','00302',201612,'TNDN_STBH',870871817615);
insert into kt_abic.bh_dl_td_dt values('007','00702',201612,'TNDN_STBH',654942331234);
insert into kt_abic.bh_dl_td_dt values('007','00704',201612,'TNDN_STBH',567437277149);
insert into kt_abic.bh_dl_td_dt values('003','00306',201612,'TNDN_STBH',335213437032);
insert into kt_abic.bh_dl_td_dt values('007','00705',201612,'TNDN_STBH',174649985000);
insert into kt_abic.bh_dl_td_dt values('003','00304',201612,'TNDN_STBH',174646773948);
insert into kt_abic.bh_dl_td_dt values('003','00303',201612,'TNDN_STBH',153349417254);
insert into kt_abic.bh_dl_td_dt values('003','00301',201612,'TNDN_STBH',115552141525);
insert into kt_abic.bh_dl_td_dt values('007','00703',201612,'TNDN_STBH',105124000974);
insert into kt_abic.bh_dl_td_dt values('003','00305',201612,'TNDN_STBH',83126930000);
insert into kt_abic.bh_dl_td_dt values('004','00403',201612,'TNDN_STBH',70232280516);
insert into kt_abic.bh_dl_td_dt values('005','00502',201612,'TNDN_STBH',32368275816);
insert into kt_abic.bh_dl_td_dt values('004','00402',201612,'TNDN_STBH',32048943321);
insert into kt_abic.bh_dl_td_dt values('004','00404',201612,'TNDN_STBH',19745000000);
insert into kt_abic.bh_dl_td_dt values('007','00706',201612,'TNDN_STBH',2280000000);
insert into kt_abic.bh_dl_td_dt values('008','00802',201612,'TNDN_STBH',1139357099473);
insert into kt_abic.bh_dl_td_dt values('001','00103',201612,'TNDN_STBH',270546528000);
insert into kt_abic.bh_dl_td_dt values('008','00808',201612,'TNDN_STBH',168990267881);
insert into kt_abic.bh_dl_td_dt values('001','00130',201612,'TNDN_STBH',383427973673);
insert into kt_abic.bh_dl_td_dt values('008','00801',201612,'TNDN_STBH',79007138000);
insert into kt_abic.bh_dl_td_dt values('008','00803',201612,'TNDN_STBH',231698000000);
insert into kt_abic.bh_dl_td_dt values('001','00122',201612,'TNDN_STBH',253274425895);
insert into kt_abic.bh_dl_td_dt values('001','00102',201612,'TNDN_STBH',191997077074);
insert into kt_abic.bh_dl_td_dt values('001','00128',201612,'TNDN_STBH',77061530240);
insert into kt_abic.bh_dl_td_dt values('008','00804',201612,'TNDN_STBH',247755077184);
insert into kt_abic.bh_dl_td_dt values('008','00810',201612,'TNDN_STBH',323463922873);
insert into kt_abic.bh_dl_td_dt values('001','00147',201612,'TNDN_STBH',57573497383);
insert into kt_abic.bh_dl_td_dt values('001','00135',201612,'TNDN_STBH',94339124385);
insert into kt_abic.bh_dl_td_dt values('001','00124',201612,'TNDN_STBH',53820343000);
insert into kt_abic.bh_dl_td_dt values('001','00109',201612,'TNDN_STBH',102906238908);
insert into kt_abic.bh_dl_td_dt values('001','00134',201612,'TNDN_STBH',1688536270082);
insert into kt_abic.bh_dl_td_dt values('008','00806',201612,'TNDN_STBH',22381625559);
insert into kt_abic.bh_dl_td_dt values('001','00125',201612,'TNDN_STBH',99293727727);
insert into kt_abic.bh_dl_td_dt values('001','00143',201612,'TNDN_STBH',309372090955);
insert into kt_abic.bh_dl_td_dt values('008','00811',201612,'TNDN_STBH',79480722528);
insert into kt_abic.bh_dl_td_dt values('001','00115',201612,'TNDN_STBH',54196072500);
insert into kt_abic.bh_dl_td_dt values('008','00809',201612,'TNDN_STBH',9937679000);
insert into kt_abic.bh_dl_td_dt values('008','00807',201612,'TNDN_STBH',12786577968);
insert into kt_abic.bh_dl_td_dt values('001','00105',201612,'TNDN_STBH',6704554000);
insert into kt_abic.bh_dl_td_dt values('001','00137',201612,'TNDN_STBH',14953748058);
insert into kt_abic.bh_dl_td_dt values('001','00139',201612,'TNDN_STBH',43894825265);
insert into kt_abic.bh_dl_td_dt values('008','00805',201612,'TNDN_STBH',191442072010);
insert into kt_abic.bh_dl_td_dt values('001','00133',201612,'TNDN_STBH',72416244326);
insert into kt_abic.bh_dl_td_dt values('001','00123',201612,'TNDN_STBH',10183805500);
insert into kt_abic.bh_dl_td_dt values('001','00126',201612,'TNDN_STBH',26942000000);
insert into kt_abic.bh_dl_td_dt values('001','00107',201612,'TNDN_STBH',12000000000);
insert into kt_abic.bh_dl_td_dt values('001','00104',201612,'TNDN_STBH',6468000000);
insert into kt_abic.bh_dl_td_dt values('001','00152',201612,'TNDN_STBH',1134600000000);
insert into kt_abic.bh_dl_td_dt values('001','00111',201612,'TNDN_STBH',378848087922);
insert into kt_abic.bh_dl_td_dt values('001','00110',201612,'TNDN_STBH',17305000000);
insert into kt_abic.bh_dl_td_dt values('001','00140',201612,'TNDN_STBH',9980000000);
insert into kt_abic.bh_dl_td_dt values('001','00146',201612,'TNDN_STBH',1260000000);
insert into kt_abic.bh_dl_td_dt values('001','00108',201612,'TNDN_STBH',935000000);
insert into kt_abic.bh_dl_td_dt values('001','00136',201612,'TNDN_STBH',70000000000);
insert into kt_abic.bh_dl_td_dt values('001','00116',201612,'TNDN_STBH',1500000000);
insert into kt_abic.bh_dl_td_dt values('001','00101',201612,'TNDN_STBH',1470000000);
insert into kt_abic.bh_dl_td_dt values('001','00131',201612,'TNDN_STBH',1000000000);
insert into kt_abic.bh_dl_td_dt values('001','00129',201612,'TNDN_STBH',693000000);
--//
select * from kt_abic.kt_abic.bh_dl_td_dt where thang=201612 and ma_ct in ('TNDN_KH','TNDN_STBH');