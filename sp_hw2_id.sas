
proc format;
value $CITYF
'A'='�_��'
'B'='�W��'
'C'='�n��'
'D'='�n��'
'E'='������'
'F'='�G�{'
'G'='�ӭ�'
'H'='���{';
value SMOKEF
0='�S��'
1='��';
value LUNG_CANCERF
0='�S��'
1='��';
run;
proc import 
datafile="C:\Users\kurt chuang\Desktop\SAS\lesson2\statpack107fhw2_3.csv"
out=HW2_3
dbms=CSV REPLACE; 
getnames=no;
run;
data HW2_3;
	set HW2_3;
format
		VAR1 $CITYF.
		VAR2 SMOKEF.
		VAR3 LUNG_CANCERF.
	;
label
		VAR1='����'
		VAR2='�l�ұ��p'
		VAR3='�������p'
		VAR4='�H��'
	;
run;
proc print data=HW2_3 label;
run;
