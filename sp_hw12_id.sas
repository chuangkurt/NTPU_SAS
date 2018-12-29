data hw12_1;
infile "C:\Users\User\Desktop\class_SAS\lesson12\statpack107fhw12_1.TXT" FIRSTOBS=2;
input 
Id  age  outcome ;
run;
PROC IMPORT
DATAFILE="C:\Users\User\Desktop\class_SAS\lesson12\statpack107fhw12_2.csv"
out=hw12_2 replace;
getnames=yes;
run;
PROC IMPORT
DATAFILE="C:\Users\User\Desktop\class_SAS\lesson12\statpack107fhw12_3.csv"
out=hw12_3 replace;
getnames=yes;
run;
proc sort data=hw12_1;
by id;
proc sort data=hw12_2;
by id;
proc sort data=hw12_3;
by id;
data hw12;
merge hw12_1 hw12_2 hw12_3;
by id;
run;
data hw12sel;
set hw12;
if Pregnancies=. then delete;
if age<=24 then ageG=1;
if 24<age<=29 then ageG=2;
if 29<age<=40 then ageG=3;
if 40<age then ageG=4;
if Glucose=0 then Glucose=.;
if BloodPressure=0 then BloodPressure=.;
if SkinThickness=0 then SkinThickness=.;
if Insulin=0 then Insulin=.;
if BMI=0 then BMI=.;
run;
ods trace on;
proc ttest
data=hw12sel;
Class outcome;
var Glucose BloodPressure SkinThickness Insulin BMI DiabetesPedigreeFunction;
ods output Statistics=h12_stat
	 TTests=h12_ttest Equality=h12_var;
run;
ods trace off;
proc print data=h12_stat; run;
proc print data=h12_ttest; run;
proc print data=h12_var; run;
proc sort data=h12_ttest;
by Variable;
proc sort data=h12_var;
by Variable;
data h12_alltest;
merge h12_ttest h12_var;
by Variable;
if (probf<=0.05 & variances='ぃА单')
 or  (probf>0.05 & variances='А单');
run;

proc format;
value yesnof
0='タ盽'
1='钵盽';
value Pref
0='い计'
1='单い计';
run;
data hw12b;
set hw12sel;
if 0<BMI<24 then BMIG=0;
if 24<=BMI then BMIG=1;
if BloodPressure<90 then DBP=0;
if 90<=BloodPressure then DBP=1;
format BMIG  DBP yesnof.;
run;
ods trace on;
proc means data=hw12b  median;
var Pregnancies;
ods output summary=h12_median;
run;
ods trace off;
data hw12c;
set hw12b;
if _N_ = 1 then set h12_median;
if Pregnancies>Pregnancies_Median then Pre=0;
else Pre=1;
format Pre Pref.;
run;
ods trace on;
proc freq data=hw12c;
tables outcome*BMIG/chisq;
tables outcome*DBP/chisq;
tables outcome*Pre/chisq;
ods output ChiSq=h12_chi;
run;
ods trace off;
data h12_chi2;
set h12_chi;
if mod(_n_,7)^=1 then delete;
run;
proc print data=h12_chi2; run;
