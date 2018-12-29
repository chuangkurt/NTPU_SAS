libname pr8a "C:\Users\NTPU\Downloads";
proc print data=pr8a.statpack107fp7_1;
run;
libname pr8b "C:\Users\NTPU\Downloads";
proc print data=pr8b.statpack107fp7_2;
run;
libname pr8c "C:\Users\NTPU\Downloads";
proc print data=pr8c.statpack107fp7_3;
run;
proc sort 
data=pr8a.statpack107fp7_1
out=pr8a1;
by id;
run;
proc sort 
data=pr8b.statpack107fp7_2
out=pr8b1;
by id;
run;
proc sort 
data=pr8c.statpack107fp7_3
out=pr8c1;
by id;
run;
data mgbc;
merge pr8b1 pr8c1;
by id;
run;
data practice9a practice9b;
merge pr8a1(in=in1) mgbc(in=in2);
by id;
if in1 & in2 then output practice9a;
else output practice9b;
run;
proc print data=practice9a;
run;
data pr8state;
set pr8a1;
if substr(state,1,1)='A' then gstate='第一類';
if substr(state,1,1)='C' then gstate='第一類';
if substr(state,1,1)='D' then gstate='第一類';
if substr(state,1,1)='F' then gstate='第一類';
if substr(state,1,1)='G' then gstate='第一類';
if substr(state,1,1)='H' then gstate='第一類';
if substr(state,1,1)='I' then gstate='第一類';
else  gstate='第二類';
run;
/*fletter=substr(state,1,1);*/
/*if fletter in ('A' 'C' 'D' 'F' 'G' 'H' 'I') then gstate=1;*/
/*else gstate=0;*/
proc print data=pr8state;
run;
proc means data=practice9a;
var x7;
output out=x7_IQR q1=x7_q1
	median=x7_q2 q3=x7_q3;
run;



**********************************************120.126.135.53*********************************************************************

%let dirclass=D:\Dropbox\School\statpack\107fall;
libname ch4b "C:\Users\NTPU\Downloads";
data p7a;
set ch4b.statpack107fp7_1;
run;
data p7b;
set ch4b.statpack107fp7_2;
run;
data p7c;
set ch4b.statpack107fp7_3;
run;
data p7bc;
set p7b p7c;
run;
proc sort data=p7bc;
by id;
proc sort data=p7a;
by id;
data practice9a practice9b;
merge p7a (in=in1) p7bc (in=in2);
by id;
if in1=1 & in2=1 then output practice9a;
else output practice9b;
run;
proc means data=practice9a;
var x7;
output out=x7_IQR min=x7_min q1=x7_q1
	median=x7_q2 q3=x7_q3 max=x7_max;
run;
proc print data=x7_IQR; run;
data practice9a;
set practice9a;
if _n_=1 then set x7_IQR (drop=_type_ _freq_);
/*array iqr  x7_q1 x7_q2 x7_q3 ;*/
/*do i=1 to 3;*/
/*	if i=1 then do; if x7<iqr{i} then group=i; end;*/
/*	else if iqr{i-1}<x7<iqr{i} then group=i;*/
/*end;*/
array iqr x7_min x7_q1 x7_q2 x7_q3 x7_max;
do i=1 to 4;
	if iqr{i}<=x7<iqr{i+1} then group=i;
end;
fletter=substr(state,1,1);
if fletter in ('A' 'C' 'D' 'F' 'G' 'H' 'I') then gstate=1;
else gstate=0;
if fletter='A' or fletter='C' or fletter='D' 
	or fletter='F' or fletter='G' or  fletter='H' 
	or fletter='I' then gstate=1;
else gstate=0;
array x13range x13_1 x13_2 (3500 8000);
if x13<3500 then income=1;
else if x13<8000 then income=2;
else  income=3;
drop x7_min x7_q1 x7_q2 x7_q3 x7_max i;
run;
proc print data=practice9a;
/*var x7 x7_q1 x7_q2 x7_q3 group;*/
run;
/*隨機生成一組常態data*/
data normal;
do id=1 to 100;
	y=normal(123);
	output;
end;
run;
proc print data=normal (obs=10); run;
proc univariate data=normal normal;
var y;
histogram y/normal;
run;

data practice9a_state1;
set practice9a (where=(gstate=1));
run;
data practice9a_state1;
set practice9a (rename=(group=gx7));
if gstate=1;
/*rename group=gx7;*/
run;
proc print data=practice9a 
	(keep=id x1-x10 gstate where=(gstate=1));
run;
proc print data=practice9a;
where (gstate=1);
run;
data normal;
do id=1 to 100;
	y=normal(123);
	z=60+10*normal(1000);
    output;
end;
run;
proc print data=normal (obs=10); run;
proc univariate data=normal normal;
var y;
histogram y/normal;
run;
/*uniform分配*/
data randomsample;
do id=1 to 100;
	temp=uniform(1);
	if temp<=0.5 then group='A';
	else group='B';
	output;
end;
run;
proc freq data=randomsample; tables group; run;
proc sort data=randomsample;
by temp;
run;
data randomsample1;
set randomsample;
if _n_<=50 then newgroup='A';
else newgroup='B';
run;
proc print; run;
