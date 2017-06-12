select * from all_objects where object_type ='DIRECTORY';
select * from all_directories; 

--PS C:\Users\Administrator> D:\app\Administrator\product\11.2.0\dbhome_1\BIN\
impdp kt_abic/080 directory=TCDN_BK_DIR DUMPFILE=TCDN_KT_ABIC.dmp logfile=TCDN_KT_ABIC.log schemas=KT_ABIC

/*
CONTENT=METADATA_ONLY
exclude=index
expdp help=yes
impdp help=yes

http://www.orafaq.com/wiki/Datapump
http://ss64.com/ora/impdp.html
