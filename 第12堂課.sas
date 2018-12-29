PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpack107fp12.xls"
out=pr12 replace;
getnames=yes;
run;
proc format;
value yesnof
0='���`'
1='���`';
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
density ='�K��'
bodyfat ='���p��ת� (\%)'
age =' �~�֡]���G�~�^'
weight1 ='���q�]���G�S�^ '
height1 ='�����]���G�^�T�^'
neck ='�V��]���G�����^'
chest ='�ݳ�]���G�����^'
abdomen ='�y��]���G�����^ '
hip ='�v��]���G�����^'
thigh ='�L��]���G�����^'
knee ='����]���G�����^ '
ankle =' ���]���G�����^'
biceps ='�G�Y�٩P���]���G�����^'
forearm ='�e�u�P���]���G�����^'
wrist ='�ó�]���G�����^';
run;
proc freq data=pr12a;
tables bmi_gp ab_whr abbdf ab_abd;
run;
ods trace on;
/*Output Delivery System*/
ods trace off;
/*ods�O�i�H�h�l��output�A���X���a��i�H�ݱo��A�W�٪��a��*/
proc freq data=pr12a;
tables bmi_gp ab_whr abbdf ab_abd;
ods output onewayfreqs=ab_freq;
label
bmi_gp='BMI ���`����'
ab_whr='�y�v��� ���`����'
abbdf='��ת� ���`����'
ab_abd='�y�� ���`����';
run;
proc print data=ab_freq; run;
/*vlabel�^���쥻������*/
/*vvalue�^���쥻���ƭ�*/
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
/*�p�Gmod2��1�h���L�O�쥻�����ҡA��L�h���ť�*/
if mod(_n_,2)=1 then fvar_l=fvar_label;
run;
/*�Υt�~�@�ؤ覡�g*/
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
/*�Ustackodds�i�H�����N����|�_��*/
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
/*�έp�B�˩w�B�ܲ���*/
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
/*�b���έp�ɡA�n�D�XprobF�p��0.05�M�ܲ��ƬO�_����*/
data p12_alltest;
merge p12_ttest p12_var;
by Variable;
if (probf<=0.05 & variances='������')
 or  (probf>0.05 & variances='����');
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
'neck' ='�V��]���G�����^'
'chest' ='�ݳ�]���G�����^'
'abdomen' ='�y��]���G�����^ '
'hip' ='�v��]���G�����^'
'thigh' ='�L��]���G�����^'
'knee' ='����]���G�����^ '
'ankle' =' ���]���G�����^'
'biceps' ='�G�Y�٩P���]���G�����^'
'forearm' ='�e�u�P���]���G�����^'
'wrist' ='�ó�]���G�����^';
run;
proc print data=p12_mean_test noobs;
var variable class n mean stddev probt;
format variable $varlabelf.;
run;


proc ttest data=ch6d2;
/*�e�������A����˥�*/
paired lead1*lead4;
run;

proc ttest data=ch6d2;
/*�էO���S���t���A��Ӽ˥���t�˩w*/
class group;
var diff_lead;
run;
