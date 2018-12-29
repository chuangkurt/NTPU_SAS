proc format;
VALUE VARF
0='�S��'
1='��';
VALUE $dmF
'0'='�S��'
'1'='��';
VALUE  sexF
0='�k��'
1='�k��';
run;
PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpack107fp3.xlsx"
out=pr3 replace;
getnames=yes;
mixed=yes;
run;
data pr3;
	set pr3;
	/*�Ndbp�ܼƧ令�ƭȮ榡*/
/*ndbp=input(dbp,8.);*/
format
		dm $dmF.
		HRstatus HDLstatus VARF.
		sex sexF.
	;
label
		id='�s��'
		dm='�}���f'
		hs-crp='���ӷP��C-�����J��'
		sex='�ʧO'
		birthday='�X��'
		wrist='�ó�'
		status='�e�f���A'
		sbp='���Y��'
		dbp='�αi��'
		HRstatus='�߸�'
		HDLstatus='��ୱK�׳J��'
		sugar='��}'
		HRV1='�߲v�ܲ���1'
		HRV2='�߲v�ܲ���2'
	;
run;
proc print data=pr3 LABEL;
run;

PROC TABULATE data=pr3;
CLASS sex dm ;
var dbp;
table sex,dm*dbp*(n='�H��' mean='������'  stddev='�зǮt')
all*dbp*(n='�H��' mean='������'  stddev='�зǮt')
;
run;
PROC TABULATE data=pr3;
CLASS sex dm status;
var dbp;
table sex*(dm all) all,status*dbp*(n='�H��' mean='������'  stddev='�зǮt')
;
run;

proc freq data=pr3;
tables dm status HRstatus HDLstatus;
run;
/*��C�Ƨ�*/
proc freq data=pr3  order=formatted;
tables dm status HRstatus HDLstatus;
run;
/*��H�Ʀh��Ƨ�*/
proc freq data=pr3  order=freq;
tables dm status HRstatus HDLstatus;
run;

/*��H�Ʀh��Ƨǥu���ʤ���*/
proc freq data=pr3  order=freq;
tables dm status HRstatus HDLstatus/nocum;
run;
/*���O���A*/
proc freq data=pr3 ;
tables (sex dm)*status;
run;
/*�N�W�����O���A����A�A�s��data*/
proc freq data=pr3 ;
tables (sex dm)*status/out=out_frq outpct;
run;
proc print data=out_frq;
run;
/*means�i�H��X��²�檺�����ȡA�зǮt�A�̤j�̤p��*/
/*maxdec �p���I��̦h���*/
/*nway�N�O�btype���̰��h���z��A�u�C�X�̰���type*/
proc means data=pr3 nway
maxdec=2	q1 median q3 noprint;
class sex status;
var hs_crp dbp;
output out=out_mean
	mean(hs_crp)=mhs_crp
	median=mdhs_crp mddbp;
run;
proc print data=out_mean;run;
