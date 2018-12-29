libname hw10_1 "C:\Users\kurt chuang\Desktop\SAS\lesson10";
data hw10_1;
set hw10_1.statpack107fhw10_1;
run;
libname hw10_2 "C:\Users\kurt chuang\Desktop\SAS\lesson10";
data hw10_2;
set hw10_2.statpack107fhw10_2;
run;
libname hw10_3 "C:\Users\kurt chuang\Desktop\SAS\lesson10";
data hw10_3;
set hw10_3.statpack107fhw10_3;
run;
proc sort 
data=HW10_1
out=HW10_1s;
by id;
run;
proc sort 
data=HW10_3
out=HW10_3s;
by id;
run;
data HW10_2a;
set hw10_2;
eyestate=substr(PARAMCD,1,2);
eyearea=substr(PARAMCD,3,4);
if ATPTN= .  then delete;
drop PARAMCD;
run;
proc print data=hw10_2a;run;

data HW10_2b;
set HW10_2a;
if AVISITN=1  then output HW10_2b;
run;
data HW10_2c;
set HW10_2b;
bench=AVAL;
run;
proc sort 
data=HW10_2c
out=HW10_2s;
by id ATPTN eyestate eyearea ;
run;
proc sort 
data=HW10_2a
out=HW10_2d;
by id ATPTN eyestate eyearea ;
run;
data mgb;
merge HW10_2s HW10_2d;
by id ATPTN eyestate eyearea ;
data mgb_1 mgb_2;
set mgb;
diff=bench-AVAL;
if ATPTN=1 then output mgb_1;
if ATPTN=2 then output mgb_2;
run;
proc sgplot data=mgb_1;  /*µe¹Ï*/
dot AVISITN/response=diff stat=mean 
	limits=both limitstat=stderr numstd=2;
run;
data HW10_3a;
set HW10_3;
if ATPTN=2 then output HW10_3a;
run;
proc sgplot data=HW10_3a;
 HBOX AVAL / CATEGORY=ATPTN;
 run;
proc sort 
data=HW10_2a
out=HW10_2e;
by id;
run;
data mg23;
merge HW10_2e HW10_3s( rename=(AVAL=comAVAL));
by id  ;
data mg123;
merge HW10_1s mg23;
by id  ;
data mg123a;
set mg123;
if comAVAL<=2 then comfor=0;
if comAVAL>2 then comfor=1;
run;
data mg123b;
set mg123a;
if eyestate='FF' &  ATPTN='0' then output mg123b;
run;
proc sgplot data=mg123b;
vbar comfor/stat=percent group=eyearea
	groupdisplay=cluster datalabel
	datalabelattrs=(size=10);
run;
data mg123c;
set mg123a;
if eyestate='FF' & ATPTN='1' & eyearea='CONJ' then output mg123c;
run;
proc print data= mg123c ; run;
proc sgplot
data=mg123c;
reg x=id
y=AVAL;
run;
data mg123cM mg123cF;
set mg123c;
if sex='M' then output mg123cM;
if sex='F' then output mg123cF;
run;
proc sgplot
data=mg123cM;
reg x=id
y=AVAL;
run;
proc sgplot
data=mg123cF;
reg x=id
y=AVAL;
run;
data mg123g;
set mg123a;
if AVISITN=5 then output mg123g;
run;
data mg123new mg123pla;
set mg123g;
if treatment=1 then output mg123new;
if treatment=2 then output mg123pla;
run;
proc sgplot
data=mg123new;
reg x=AGE
y=AVAL/clm;
run;
proc sgplot
data=mg123pla;
reg x=AGE
y=AVAL/clm;
run;
