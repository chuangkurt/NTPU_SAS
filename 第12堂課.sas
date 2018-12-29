PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpack107fp12.xls"
out=pr12 replace;
getnames=yes;
run;
proc format;
value yesnof
0='正常'
1='異常';
run;
data pr12a;
set pr12;
weight=weight1*0.453;
height=height1*2.54/100;
BMI=weight/height**2;
if BMI<24 then BMI_GP=0;
	else BMI_GP=1;
whr=abdomen/hip;
if whr<=0.9 then ab_whr=0;
else ab_whr=1;
if 10<=bodyfat<=20 then abbdf=0;
else abbdf=1;
if abdomen<102 then ab_abd=0;
else ab_abd=1;
format bmi_gp ab_whr abbdf ab_abd yesnof.;
label
density ='密度'
bodyfat ='估計體脂肪 (\%)'
age =' 年齡（單位：年）'
weight1 ='重量（單位：磅） '
height1 ='身高（單位：英吋）'
neck ='頸圍（單位：公分）'
chest ='胸圍（單位：公分）'
abdomen ='腰圍（單位：公分） '
hip ='臀圍（單位：公分）'
thigh ='腿圍（單位：公分）'
knee ='膝圍（單位：公分） '
ankle =' 踝圍（單位：公分）'
biceps ='二頭肌周長（單位：公分）'
forearm ='前臂周長（單位：公分）'
wrist ='腕圍（單位：公分）';
run;
proc freq data=pr12a;
tables bmi_gp ab_whr abbdf ab_abd;
run;
ods trace on;
/*Output Delivery System*/
ods trace off;
/*ods是可以去追蹤output，到輸出的地方可以看得到，名稱的地方*/
proc freq data=pr12a;
tables bmi_gp ab_whr abbdf ab_abd;
ods output onewayfreqs=ab_freq;
label
bmi_gp='BMI 異常指標'
ab_whr='腰臀圍比 異常指標'
abbdf='體脂肪 異常指標'
ab_abd='腰圍 異常指標';
run;
proc print data=ab_freq; run;
/*vlabel擷取原本的標籤*/
/*vvalue擷取原本的數值*/
data ab_freq1;
set ab_freq;
fvar=scan(table,2);
fvar_label=vlabelx(fvar);
fvar_value=vvaluex(fvar);
run;
proc print data=ab_freq1; run;
proc print data=ab_freq1;
var fvar_label fvar_value frequency 
	percent;
run;
data ab_freq2;
set ab_freq1;
format fvar_l $20.;
/*如果mod2為1則讓他是原本的標籤，其他則為空白*/
if mod(_n_,2)=1 then fvar_l=fvar_label;
run;
/*用另外一種方式寫*/
data ab_freq3;
set ab_freq1;
by notsorted fvar_label;
format fvar_l $20.;
if first.fvar_label then fvar_l=fvar_label;
run;
proc print data=ab_freq2;
var fvar_l fvar_value frequency 
	percent;
run;
/*下stackodds可以直接將資料疊起來*/
proc means data=pr12a 
	stackods mean median stddev qrange;
var neck--wrist;
ods output summary=p12_mean;
run;
/*ods trace off;*/
ods trace on;
proc print data=p12_mean; run;
ods trace off;

data ab_freq3;
set ab_freq1;
by notsorted fvar_label;
format fvar_l $20.;
if first.fvar_label then fvar_l=fvar_label;
run;
proc print data=ab_freq3;
var fvar_l fvar_value frequency 
	percent;
run;
/*統計、檢定、變異數*/
proc ttest data=pr12a;
class bmi_gp;
var neck--wrist;
ods output Statistics=p12_stat
	 TTests=p12_ttest Equality=p12_var;
run;
ods trace off;
proc print data=p12_ttest; run;
proc print data=p12_var; run;
proc sort data=p12_ttest;
by Variable;
proc sort data=p12_var;
by Variable;
/*在做統計時，要挑出probF小於0.05和變異數是否均等*/
data p12_alltest;
merge p12_ttest p12_var;
by Variable;
if (probf<=0.05 & variances='不均等')
 or  (probf>0.05 & variances='均等');
run;
data p12_stata;
set p12_stat;
if ^index(class,'Diff');
keep variable class n mean stddev;
run;
proc sort data=p12_stata;
by variable;
data p12_mean_test;
merge p12_stata p12_alltest;
by variable;
run;
proc format;
value $varlabelf
'neck' ='頸圍（單位：公分）'
'chest' ='胸圍（單位：公分）'
'abdomen' ='腰圍（單位：公分） '
'hip' ='臀圍（單位：公分）'
'thigh' ='腿圍（單位：公分）'
'knee' ='膝圍（單位：公分） '
'ankle' =' 踝圍（單位：公分）'
'biceps' ='二頭肌周長（單位：公分）'
'forearm' ='前臂周長（單位：公分）'
'wrist' ='腕圍（單位：公分）';
run;
proc print data=p12_mean_test noobs;
var variable class n mean stddev probt;
format variable $varlabelf.;
run;


proc ttest data=ch6d2;
/*前測比後測，成對樣本*/
paired lead1*lead4;
run;

proc ttest data=ch6d2;
/*組別有沒有差異，兩個樣本的t檢定*/
class group;
var diff_lead;
run;
