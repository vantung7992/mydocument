RUN
{
	allocate channel ch1 device type disk;
	allocate channel ch2 device type disk;
	allocate channel ch3 device type disk;
	allocate channel ch4 device type disk;
	allocate channel ch5 device type disk;
	allocate channel ch6 device type disk;
	allocate channel ch7 device type disk;
	allocate channel ch8 device type disk;
    	sql 'alter system archive log current';
	delete noprompt archivelog until time 'SYSDATE-3';
	delete expired archivelog all;
   	backup AS COMPRESSED BACKUPSET incremental level 0 DATABASE format 'F:\backup\bk_new\&1\tcdn_dblv0_%Y%M%D_%u.bak';
	backup as compressed backupset incremental level 0 archivelog all format 'F:\backup\bk_new\&1\tcdn_archlv0_%Y%M%D_%u.bak'; 
    	backup current controlfile format 'F:\backup\bk_new\&1\tcdn_ctllv0_%Y%M%D_%u.bak';
   	backup spfile format 'F:\backup\bk_new\&1\tcdn_spfilelv0_%Y%M%D_%u.bak';
	report obsolete;
	delete noprompt obsolete;
	delete noprompt expired backupset;
	#CROSSCHECK BACKUP;
	#CROSSCHECK ARCHIVELOG ALL;
	release channel ch1;
	release channel ch2;
	release channel ch3;
	release channel ch4;
	release channel ch5;
	release channel ch6;
	release channel ch7;
	release channel ch8;
}