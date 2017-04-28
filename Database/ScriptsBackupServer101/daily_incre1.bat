:: create new folder
set today=%date:~-4,4%%date:~-10,2%%date:~7,2%
mkdir F:\backup\bk_new\%today%
:: set env
set ORACLE_SID=tcdn
set ORACLE_HOME=E:\app\Administrator\product\11.2.0\dbhome_1
:: run RMAN
rman target=sys/oracle@tcdn log F:\backup\bk_new\%today%\backup_incre1_tcdn_%date:~4,2%_%date:~7,2%_%date:~10%.log cmdfile F:\scripts\daily_incre1.cmd using '%today%'
