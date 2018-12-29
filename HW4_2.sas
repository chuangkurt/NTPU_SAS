proc format;
VALUE  $difficultyF
0='�ܮe��' 1='�e��' 2='���q' 3='���@�I�x��' 4='�ܧx��' 'NA'='�򥢭�';
VALUE $hardF
0='�ܳn' 1='���@�I�n' 2='�A��' 3='���@�I�w' 4='�ܵw' 'NA'='�򥢭�';
VALUE 	$stomachF
'Y'='��' 'N'='�S��' 'NA'='�򥢭�';
VALUE 	 freqF
0='1-2��' 1='�@��§���⦸' 2='�@��§���@��' 3='�@��§������@��' 4='�@�Ӥ뤣��@��' ;
VALUE 	 timeF
0='�q�Ӥ��|' 1='�ܤ�' 2='����' 3='�g�`' 4='�`�`' ;
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
		VAR1='�f�w�s��'
		VAR2='�ʧO'
		VAR3='�~��(�~)'
		VAR4='����(��)'
		VAR5='�x����'
		VAR6='�w��'
		VAR7='���h'
		Q1='�ƫK�W�v'
		Q2='�ƫK�ɥΤO�{��'
		Q3='�ƫK��O�_�����K�N'
		Q4='�ƫK�ɬO�_�����k�h'
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
