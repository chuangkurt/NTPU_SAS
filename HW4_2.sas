proc format;
VALUE  $difficultyF
0='很容易' 1='容易' 2='普通' 3='有一點困難' 4='很困難' 'NA'='遺失值';
VALUE $hardF
0='很軟' 1='有一點軟' 2='適中' 3='有一點硬' 4='很硬' 'NA'='遺失值';
VALUE 	$stomachF
'Y'='有' 'N'='沒有' 'NA'='遺失值';
VALUE 	 freqF
0='1-2天' 1='一個禮拜兩次' 2='一個禮拜一次' 3='一個禮拜不到一次' 4='一個月不到一次' ;
VALUE 	 timeF
0='從來不會' 1='很少' 2='偶爾' 3='經常' 4='常常' ;
run;
PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lesson4\statpack107fhw4_2.csv"
out=HW4_2 replace  ;
getnames=yes;
run;
data HW4_2;
	set HW4_2;
	format
		VAR5 $difficultyF.
		VAR6 $hardF.
		VAR7 $stomachF.
		Q1 freqF.
		Q2 Q3 Q4 timeF.
	;
label
		VAR1='病患編號'
		VAR2='性別'
		VAR3='年齡(年)'
		VAR4='次數(月)'
		VAR5='困難度'
		VAR6='硬度'
		VAR7='腹痛'
		Q1='排便頻率'
		Q2='排便時用力程度'
		Q3='排便後是否仍有便意'
		Q4='排便時是否腹部疼痛'
;
proc print data=HW4_2 LABEL;
run;
PROC freq data=HW4_2;
table VAR2*Q1/nocum;
table VAR2*Q2/nocum;
table VAR2*Q3/nocum;
table VAR2*Q4/nocum;
;
run;
