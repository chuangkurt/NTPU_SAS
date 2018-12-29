proc format;
VALUE yesnoF
0='⊿Τ' 1='Τ' ;
VALUE VAR9F
1='IT' 2='璸' 3='м砃' 4='祘' ;
VALUE VAR10F
1='蔼羱戈' 2='い单羱戈'  3='羱戈'  ;
VALUE QQF
11='い计'  12='い计'  13='い计'  14='い计' 
21='い计'  22='い计'  23='い计'  24='い计' ;
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
VAR1='骸種祘' VAR2='程Ω蝶挪' VAR3='–る磅︽璸礶计' VAR4='–るキА()' 
VAR5='戈()' VAR6='種' VAR7='5ずど' VAR8='瞒戮' VAR9='场' VAR10='羱单';
proc print data=HW5 LABEL;
run;
data HW5;
set HW5;
averwork=VAR3/VAR4;
label
averwork='–ンキА惠';
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
 if VAR1<=0.43 then GP1='材竤';
if 0.43< VAR1<=0.64 then GP1='材竤';
if 0.64< VAR1<=0.81 then GP1='材竤';
else GP1='材竤';
label
GP1='骸種竤舱';
run;
proc print data=HW5b LABEL;
run;
proc means data=HW5  median;
var VAR2;
run;

data HW5c;
set HW5;
	if VAR9=1 & VAR2<= 0.73 then QQ='い计';
	else if VAR9=2 & VAR2<= 0.73 then QQ='い计';
	else if VAR9=3 & VAR2<= 0.73 then QQ='い计';
	else if VAR9=4 & VAR2<= 0.73 then QQ='い计';
	else if VAR9=1 & VAR2> 0.73 then QQ='い计';
	else if VAR9=2 & VAR2> 0.73 then QQ='い计';
	else if VAR9=3 & VAR2> 0.73 then QQ='い计';
	else if VAR9=4 & VAR2> 0.73 then QQ='い计'; 
label
QQ='蝶挪絛瞅';
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
table VAR9,QQ*averwork*(n='计' mean='キА计'  stddev='夹非畉' MEDIAN='い计')
all*averwork*(n='计' mean='キА计'  stddev='夹非畉' MEDIAN='い计');
run;
