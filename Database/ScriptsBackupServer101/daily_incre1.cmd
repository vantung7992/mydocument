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
	crosscheck backup;
	delete noprompt archivelog until time 'SYSDATE-3';
	delete expired archivelog all;
    	backup as compressed backupset incremental level 1 database format 'F:\backup\bk_new\&1\tcdn_dblv1_%Y%M%D_%u.bak' PLUS ARCHIVELOG FORMAT 'F:\backup\bk_new\&1\tcdn_archlv1_%Y%M%D_%u.bak';	
    	backup current controlfile format 'F:\backup\bk_new\&1\tcdn_ctllv1_%Y%M%D_%u.bak';
    	backup spfile format 'F:\backup\bk_new\&1\tcdn_spfilelv1_%Y%M%D_%u.bak';
	#CROSSCHECK BACKUP;
	#CROSSCHECK ARCHIVELOG ALL;
}