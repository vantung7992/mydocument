set ORACLE_SID=drtcdn
set ORACLE_HOME=E:\app\Administrator\product\11.2.0\dbhome_1
rman target / cmdfile F:\scripts\del_arch_stb.cmd log F:\log\del_log_drtcdn_%date:~4,2%_%date:~7,2%_%date:~10%.log
