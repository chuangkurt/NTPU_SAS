libname ex8a "C:\Users\kurt chuang\Desktop\SAS\lesson8";
data hw8a;
set ex8a.statpack107fhw8a;
run;
libname ex8b "C:\Users\kurt chuang\Desktop\SAS\lesson8";
data hw8b;
set ex8b.statpack107fhw8b;
run;
libname ex8c "C:\Users\kurt chuang\Desktop\SAS\lesson8";
data hw8c;
set ex8c.statpack107fhw8c;
run;
libname ex8d "C:\Users\kurt chuang\Desktop\SAS\lesson8";
data hw8d;
set ex8d.statpack107fhw8d;
run;
data hw8ba;
set hw8b;
F3a=input(F3,yymmdd10.);
if F3a=. then delete;
run;
proc sort data=hw8ba;
by F1 F3a;
data hw8firstba;
set hw8ba;
by F1;
if first.F1 then output;
run;
data hw8lastba;
set hw8ba;
by F1;
if last.F1 then output;
rename F3a=F3b;
run;
data hw8bamg;
merge hw8firstba hw8lastba;
by F1;
through=round((F3b-F3a)/365.25,0.1);
drop F3 nf8 nf9 nf10 F3a F3b;
run;
proc print data=hw8bamg;
run;
proc means data=hw8ba n sum mean max min;
var nf8 nf9 nf10;
class F1;
output out=hw8bb  n=count MEAN=nf8_mean nf9_mean nf10_mean ;
run;
data hw8bmg;
merge hw8bamg hw8bb;
by F1;
run;
proc print data=hw8bmg;
run;

data hw8da;
set hw8d(rename=(F1=sicknum));
sicknum=input(sicknum,10.);
run;
data hw8aa;
set hw8a(rename=(F2=sicknum));
run;
proc sort 
data=hw8da
out=hw8sd;
by sicknum;
run;
proc sort 
data=hw8aa
out=hw8sa;
by sicknum;
run;

data mgad;
merge hw8sa hw8sd(in=in1);
by sicknum;
array sv{4} sv1 sv2 sv3 sv5;
array nsv{4} nsv1 nsv2 nsv3 nsv5;
do i=1 to 4;
	if sv{i}>0 then nsv{i}=1;
	else nsv{i}=0;
end;
hospital=in1;
drop  sv1 sv2 sv3 sv5 i ;
label hospital='琌皘'
nsv1='琌砃登猂'
nsv2='琌蔼﹀溃︸登癐很'
nsv3='琌材縸Э痜'
nsv5='琌み纽癐很';
run;
data hw8bmga;
set hw8bmg;
where count^=0;
run;
proc sort 
data=hw8bmg
out=hw8sbmg;
by F1;
run;
proc sort 
data=hw8c
out=hw8sc;
by F1;
run;
data mgbc;
merge hw8sbmg hw8sc;
by F1;
proc sort 
data= mgad
out= mgsad;
by F1;
run;
proc sort 
data=mgbc
out=mgsbc;
by F1;
run;
data mgabcd;
merge mgsad mgsbc;
by F1;
run;
data final;
set mgabcd;
proc print data=mgabcd;
run;
PROC TABULATE data=mgabcd;
CLASS F16 F18 hospital;
var nf8_mean ;
table F16,F18*hospital*nf8_mean*( mean='キА计'  stddev='夹非畉' );
run;
PROC TABULATE data=mgabcd;
CLASS F16 F18 hospital;
var nf9_mean ;
table F16,F18*hospital*nf9_mean*( mean='キА计'  stddev='夹非畉' );
run;
PROC TABULATE data=mgabcd;
CLASS F16 F18 hospital;
var nf10_mean ;
table F16,F18*hospital*nf10_mean*( mean='キА计'  stddev='夹非畉' );
run;
PROC TABULATE data=mgabcd;
CLASS F16 F18 hospital;
var through ;
table F16,F18*hospital*through*( mean='キА计'  stddev='夹非畉' );
run;
