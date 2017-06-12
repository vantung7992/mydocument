g:
cd \Bk
rem @echo off

set ORACLE_SID=%1%
set ORA_USER=%2%
set ORA_PASS=%3%
set ORA_OWN=%4%

rem -- Keep 2 versions of the export log file --
IF EXIST %ORACLE_SID%_%ORA_OWN%_3.log DEL %ORACLE_SID%_%ORA_OWN%_3.log 
IF EXIST %ORACLE_SID%_%ORA_OWN%_2.log REN %ORACLE_SID%_%ORA_OWN%_2.log %ORACLE_SID%_%ORA_OWN%_3.log 
IF EXIST %ORACLE_SID%_%ORA_OWN%_1.log REN %ORACLE_SID%_%ORA_OWN%_1.log %ORACLE_SID%_%ORA_OWN%_2.log 
IF EXIST %ORACLE_SID%_%ORA_OWN%.log REN %ORACLE_SID%_%ORA_OWN%.log %ORACLE_SID%_%ORA_OWN%_1.log 

rem -- Keep 2 versions of the export dump file --
IF EXIST %ORACLE_SID%_%ORA_OWN%_3.dmp DEL %ORACLE_SID%_%ORA_OWN%_3.dmp
IF EXIST %ORACLE_SID%_%ORA_OWN%_2.dmp REN %ORACLE_SID%_%ORA_OWN%_2.dmp %ORACLE_SID%_%ORA_OWN%_3.dmp 
IF EXIST %ORACLE_SID%_%ORA_OWN%_1.dmp REN %ORACLE_SID%_%ORA_OWN%_1.dmp %ORACLE_SID%_%ORA_OWN%_2.dmp 
IF EXIST %ORACLE_SID%_%ORA_OWN%.dmp REN %ORACLE_SID%_%ORA_OWN%.dmp %ORACLE_SID%_%ORA_OWN%_1.dmp 

rem -- Do the export --
rem exp %ORA_USER%/%ORA_PASS%@%ORACLE_SID% file=%ORACLE_SID%_%ORA_OWN%.dmp log=%ORACLE_SID%_%ORA_OWN%.log owner=%ORA_OWN%
expdp %ORA_USER%/%ORA_PASS%@%ORACLE_SID% directory=TCDN_BK_DIR dumpfile=%ORACLE_SID%_%ORA_OWN%.dmp logfile=%ORACLE_SID%_%ORA_OWN%.log schemas=%ORA_OWN%
