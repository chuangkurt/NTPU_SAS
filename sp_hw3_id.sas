proc format;
VALUE SEXF
1='男'
2='女';
VALUE  SLICEF
1='有'
2='沒有';
VALUE PretreatmentF
0='沒有'
1='化療'
3='化療加放療';
VALUE CURRENTSTATE
1='沒有復發'
2='復發'
5='死亡'
6='不詳';
run;
PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lesson3\statpack107fhw3.csv"
out=sp_hw3 replace;
getnames=yes;
run;
data sp_hw3;
	set sp_hw3;
format
		F2 SEXF.
		F5 SLICEF.
		F6 PretreatmentF.
		F11 CURRENTSTATE.
	;
label
		F1='編號'
		F2='性別'
		F3='年齡(歲)'
		F4='發病天數(月)'
		F5='切片'
		F6='手術前治療方式'
		F7='期別'
		F8='手術日期'
		F9='手術類型'
		F11='目前狀態'
		fu_day='追蹤天數(天)'
	;
run;
proc print data=sp_hw3 LABEL;
run;

PROC SORT DATA=sp_hw3 OUT=sp_hw3a ;
BY F2 F7;
proc print data=sp_hw3a LABEL noobs N='總比數=';
by F2 F7;
pageby F2 ;
var F1 F3 F4 F8 F9;
run;
PROC TABULATE data=sp_hw3a;
CLASS F2 F5 ;
var fu_day;
table F2,F5*fu_day*(n='人數' mean='平均數' median='中位數' std='標準差');
run;
PROC TABULATE data=sp_hw3a;
CLASS F2 F5 ;
var F4;
table F2,F5*F4*(n='人數' mean='平均數' median='中位數' std='標準差');
run;
