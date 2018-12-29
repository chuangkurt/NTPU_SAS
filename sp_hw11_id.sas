PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lesson11\statpack107fhw11.csv"
out=HW11 replace;
getnames=yes;
run;
PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lesson11\statpack107fhw11case.csv"
out=HW11case replace;
getnames=yes;
run;
data HW11a;
set HW11;
array x6{4} x6_1-x6_4;
array nx6{4} nx6_1-nx6_4;
array x7{4} x7_1-x7_4;
array nx7{4} nx7_1-nx7_4;
do i=1 to 4;
	if x6{i}='µê'  then nx6{i}=1;
		else  nx6{i}=0;
			if x7{i}='²L'  then nx7{i}=1;
		else  nx7{i}=0;
	end;
run;
data HW111;
set HW11a;
round=1;
keep id gender age x1 x2_1 nx6_1 nx7_1 y1_1 round;
output HW111;
run;
data HW112;
set HW11a;
round=2;
keep id gender age x1 x2_2 nx6_2 nx7_2 y1_2 round;
output HW112;
run;
data HW113;
set HW11a;
round=3;
keep id gender age x1 x2_3 nx6_3 nx7_3 y1_3 round;
output HW113;
run;
data HW114;
set HW11a;
round=4;
keep id gender age x1 x2_4 nx6_4 nx7_4 y1_4 round;
output HW114;
run;
proc sort 
data= HW111
out= HW111s;
by id round;
run;
proc sort 
data= HW112
out= HW112s;
by id round;
run;
proc sort 
data= HW113
out= HW113s;
by id round;
run;
proc sort 
data= HW114
out= HW114s;
by id round;
run;
data mg1234;
merge HW111s( rename=(x2_1=x2 nx6_1=nx6 nx7_1=nx7 y1_1=y1)) HW112s( rename=(x2_2=x2 nx6_2=nx6 nx7_2=nx7 y1_2=y1)) 
	HW113s( rename=(x2_3=x2 nx6_3=nx6 nx7_3=nx7 y1_3=y1)) HW114s( rename=(x2_4=x2 nx6_4=nx6 nx7_4=nx7 y1_4=y1));
type='control';
by id round;
run;
data HW11casea;
set HW11case;
array x6{4} x6_1-x6_4;
array nx6{4} nx6_1-nx6_4;
array x7{4} x7_1-x7_4;
array nx7{4} nx7_1-nx7_4;
do i=1 to 4;
	if x6{i}='µê'  then nx6{i}=1;
		else  nx6{i}=0;
			if x7{i}='²L'  then nx7{i}=1;
		else  nx7{i}=0;
	end;
run;
data HW11case1;
set HW11casea;
round=1;
keep gender age x1 x2_1 nx6_1 nx7_1 y1_1 round;
output HW11case1;
run;
data HW11case2;
set HW11casea;
round=2;
keep gender age x1 x2_2 nx6_2 nx7_2 y1_2 round;
output HW11case2;
run;
data HW11case3;
set HW11casea;
round=3;
keep gender age x1 x2_3 nx6_3 nx7_3 y1_3 round;
output HW11case3;
run;
data HW11case4;
set HW11casea;
round=4;
keep gender age x1 x2_4 nx6_4 nx7_4 y1_4 round;
output HW11case4;
run;
data mgcase1234;
merge HW11case1( rename=(x2_1=x2 nx6_1=nx6 nx7_1=nx7 y1_1=y1)) HW11case2( rename=(x2_2=x2 nx6_2=nx6 nx7_2=nx7 y1_2=y1)) 
	HW11case3( rename=(x2_3=x2 nx6_3=nx6 nx7_3=nx7 y1_3=y1)) HW11case4( rename=(x2_4=x2 nx6_4=nx6 nx7_4=nx7 y1_4=y1));
type='case';
by  round;
run;
data mgcs;
merge mg1234 mgcase1234;
by  type;
run;
proc sgpanel
data=mgcs;
panelby
type/columns=2;
reg x= round
y=nx6/clm;
run;
proc sgpanel
data=mgcs;
panelby
type/columns=2;
reg x= round
y=nx7/clm;
run;
proc sgpanel
data=mgcs;
panelby
type/columns=2;
reg x= round
y=y1/clm;
run;
proc sgscatter
data=mgcs;
compare
x=round
y=x2 / group=type; run;
data HW11b;
set HW11a;
type=0;
keep id   x2_2 x2_3 x2_4 type;
output HW11b; run;
data HW11c;
set HW11case;
type=1;
keep  x2_2 x2_3 x2_4 type;
output HW11c; run;
data mgbc;
merge HW11b HW11c;
by type;
run;
proc g3grid data=mgbc out=mgbcgrid;
grid x2_2*x2_3=x2_4/
axis1=50 to 120 by 10 axis2=50 to 120 by 10;
run;
proc g3d data=mgbcgrid;
plot x2_2*x2_3=x2_4;
run;quit;
