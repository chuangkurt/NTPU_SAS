proc format;
VALUE VARF
0='沒有'
1='有';
VALUE $dmF
'0'='沒有'
'1'='有';
VALUE  sexF
0='男性'
1='女性';
run;
PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpack107fp3.xlsx"
out=pr3 replace;
getnames=yes;
mixed=yes;
run;
data pr3;
	set pr3;
	/*將dbp變數改成數值格式*/
/*ndbp=input(dbp,8.);*/
format
		dm $dmF.
		HRstatus HDLstatus VARF.
		sex sexF.
	;
label
		id='編號'
		dm='糖尿病'
		hs-crp='高敏感性C-反應蛋白'
		sex='性別'
		birthday='出生'
		wrist='腕圍'
		status='疾病狀態'
		sbp='收縮壓'
		dbp='舒張壓'
		HRstatus='心跳'
		HDLstatus='高酯密度蛋白'
		sugar='血糖'
		HRV1='心率變異性1'
		HRV2='心率變異性2'
	;
run;
proc print data=pr3 LABEL;
run;

PROC TABULATE data=pr3;
CLASS sex dm ;
var dbp;
table sex,dm*dbp*(n='人數' mean='平均數'  stddev='標準差')
all*dbp*(n='人數' mean='平均數'  stddev='標準差')
;
run;
PROC TABULATE data=pr3;
CLASS sex dm status;
var dbp;
table sex*(dm all) all,status*dbp*(n='人數' mean='平均數'  stddev='標準差')
;
run;

proc freq data=pr3;
tables dm status HRstatus HDLstatus;
run;
/*對列排序*/
proc freq data=pr3  order=formatted;
tables dm status HRstatus HDLstatus;
run;
/*對人數多寡排序*/
proc freq data=pr3  order=freq;
tables dm status HRstatus HDLstatus;
run;

/*對人數多寡排序只給百分比*/
proc freq data=pr3  order=freq;
tables dm status HRstatus HDLstatus/nocum;
run;
/*類別型態*/
proc freq data=pr3 ;
tables (sex dm)*status;
run;
/*將上面類別型態的表，再存成data*/
proc freq data=pr3 ;
tables (sex dm)*status/out=out_frq outpct;
run;
proc print data=out_frq;
run;
/*means可以算出很簡單的平均值，標準差，最大最小直*/
/*maxdec 小數點後最多兩位*/
/*nway就是在type中最高層的篩選，只列出最高的type*/
proc means data=pr3 nway
maxdec=2	q1 median q3 noprint;
class sex status;
var hs_crp dbp;
output out=out_mean
	mean(hs_crp)=mhs_crp
	median=mdhs_crp mddbp;
run;
proc print data=out_mean;run;
