:: del file in bk_old
del F:\backup\bk_old\* /F /Q
for /d %%p in (F:\backup\bk_old\*) Do rd /Q /S "%%p"
:: copy file from bk_new to bk_old
xcopy F:\backup\bk_new F:\backup\bk_old /E
:: del file in bk_new
del F:\backup\bk_new\* /F /Q
for /d %%p in (F:\backup\bk_new\*) Do rd /Q /S "%%p"
:: create new folder 
set today=%date:~-4,4%%date:~-10,2%%date:~7,2%
mkdir F:\backup\bk_new\%today%_full
:: set env
set ORACLE_SID=tcdn
set ORACLE_HOME=E:\app\Administrator\product\11.2.0\dbhome_1
:: run RMAN
rman target=sys/oracle@tcdn log F:\backup\bk_new\%today%_full\backup_full_tcdn_%today%.log cmdfile F:\scripts\full_incre0.cmd using '%today%_full';