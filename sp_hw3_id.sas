proc format;
VALUE SEXF
1='�k'
2='�k';
VALUE  SLICEF
1='��'
2='�S��';
VALUE PretreatmentF
0='�S��'
1='����'
3='�����[����';
VALUE CURRENTSTATE
1='�S���_�o'
2='�_�o'
5='���`'
6='����';
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
		F1='�s��'
		F2='�ʧO'
		F3='�~��(��)'
		F4='�o�f�Ѽ�(��)'
		F5='����'
		F6='��N�e�v���覡'
		F7='���O'
		F8='��N���'
		F9='��N����'
		F11='�ثe���A'
		fu_day='�l�ܤѼ�(��)'
	;
run;
proc print data=sp_hw3 LABEL;
run;

PROC SORT DATA=sp_hw3 OUT=sp_hw3a ;
BY F2 F7;
proc print data=sp_hw3a LABEL noobs N='�`���=';
by F2 F7;
pageby F2 ;
var F1 F3 F4 F8 F9;
run;
PROC TABULATE data=sp_hw3a;
CLASS F2 F5 ;
var fu_day;
table F2,F5*fu_day*(n='�H��' mean='������' median='�����' std='�зǮt');
run;
PROC TABULATE data=sp_hw3a;
CLASS F2 F5 ;
var F4;
table F2,F5*F4*(n='�H��' mean='������' median='�����' std='�зǮt');
run;
