proc format;
VALUE yesnoF
0='�S��' 1='��' ;
VALUE VAR9F
1='IT' 2='�D�p' 3='�޳N' 4='�u�{' ;
VALUE VAR10F
1='���~��' 2='�����~��'  3='�C�~��'  ;
VALUE QQF
11='�p�󤤦��'  12='�p�󤤦��'  13='�p�󤤦��'  14='�p�󤤦��' 
21='�j�󤤦��'  22='�j�󤤦��'  23='�j�󤤦��'  24='�j�󤤦��' ;
run;
PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lesson5\statpack107fhw5.csv"
out=HW5 replace;
getnames=no;
run;
data HW5;
set HW5;
format
		VAR6 VAR7 VAR8 yesnoF.
		VAR9	 VAR9F.
		VAR10 VAR10F. ;
label
VAR1='���N�{��' VAR2='�̪�@����Ų' VAR3='�C�����p�e��' VAR4='�C�륭���u��(�p��)' 
VAR5='�~��(�~)' VAR6='�u�@�N�~' VAR7='5�~���ʤ�' VAR8='��¾' VAR9='����' VAR10='�~������';
proc print data=HW5 LABEL;
run;
data HW5;
set HW5;
averwork=VAR3/VAR4;
label
averwork='�C�󥭧��ݮ�';
run;
proc print data=HW5 LABEL;
run;
data HW5a;
set HW5;
proc means data=HW5 Q1 median Q3;
var VAR1;
run;
data HW5b;
set HW5;
 if VAR1<=0.43 then GP1='�Ĥ@�s';
if 0.43< VAR1<=0.64 then GP1='�ĤG�s';
if 0.64< VAR1<=0.81 then GP1='�ĤT�s';
else GP1='�ĥ|�s';
label
GP1='���N�׸s��';
run;
proc print data=HW5b LABEL;
run;
proc means data=HW5  median;
var VAR2;
run;

data HW5c;
set HW5;
	if VAR9=1 & VAR2<= 0.73 then QQ='�p�󤤦��';
	else if VAR9=2 & VAR2<= 0.73 then QQ='�p�󤤦��';
	else if VAR9=3 & VAR2<= 0.73 then QQ='�p�󤤦��';
	else if VAR9=4 & VAR2<= 0.73 then QQ='�p�󤤦��';
	else if VAR9=1 & VAR2> 0.73 then QQ='�j�󤤦��';
	else if VAR9=2 & VAR2> 0.73 then QQ='�j�󤤦��';
	else if VAR9=3 & VAR2> 0.73 then QQ='�j�󤤦��';
	else if VAR9=4 & VAR2> 0.73 then QQ='�j�󤤦��'; 
label
QQ='��Ų�d��';
run;
proc sort
data=HW5c
out=HW5ca;
by VAR9 VAR2;
proc print data=HW5ca LABEL;
VAR VAR9 VAR2 QQ;
run;
PROC TABULATE data=HW5c;
CLASS VAR9 QQ ;
var averwork;
table VAR9,QQ*averwork*(n='�H��' mean='������'  stddev='�зǮt' MEDIAN='�����')
all*averwork*(n='�H��' mean='������'  stddev='�зǮt' MEDIAN='�����');
run;
