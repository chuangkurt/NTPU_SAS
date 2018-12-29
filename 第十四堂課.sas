%let dirq=d:\dropbox\school\statpack\107fall\;
libname hw10 "='dirq\graduate\project";
proc import datafile="C:\Users\NTPU\Downloads\statpack107fp12.xls"
	out=practice12;
getnames=yes;
run;
proc format;
value yesnof
0='���`'
1='���`';
run;
data practice12a;
set practice12;
weight=weight1*0.453;
height=height1*2.54/100;
bmi=weight/height**2;
if bmi<24 then bmi_gp=0;
else bmi_gp=1;
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
proc print data=p12_mean; run;
ods trace on;
proc ttest data=practice12a;
class ab_whr;
var neck--wrist;
ods output Statistics=p12_stat_w
	 TTests=p12_ttest_w Equality=p12_var_w;
run;
proc sort data=p12_ttest_w;
by Variable;
proc sort data=p12_var_w;
by Variable;
data p12_alltest_w;
merge p12_ttest_w p12_var_w;
by Variable;
if (probf<=0.05 & variances='������')
 or  (probf>0.05 & variances='����');
run;
data p12_stata_w;
set p12_stat_w;
if ^index(class,'Diff');
keep variable class n mean stddev;
run;
proc sort data=p12_stata_w;
by variable;
data p12_mean_test_w;
merge p12_stata_w p12_alltest_w;
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
proc print data=p12_mean_test_w noobs;
var variable class n mean stddev probt;
format variable $varlabelf.;
run;
proc ttest data=practice12a;
class abbdf;
var neck--wrist;
ods output Statistics=p12_stat_b
	 TTests=p12_ttest_b Equality=p12_var_b;
run;
proc ttest data=practice12a;
class ab_abd;
var neck--wrist;
ods output Statistics=p12_stat_a
	 TTests=p12_ttest_a Equality=p12_var_a;
run;

/*�d���˩w*/

proc freq data=practice12a;
tables bmi_gp*ab_whr/chisq;
ods output CrossTabFreqs=tw_freqs
	 ChiSq=chisq;
label
bmi_gp='BMI ���`����'
ab_whr='�y�v��� ���`����'
abbdf='��ת� ���`����'
ab_abd='�y�� ���`����';
run;
proc print data=tw_freqs; run;
/*ods trace off;*/
/*_TYPE_11��ӳ���*/
/*_TYPE_10�u�ݤ@��*/
/*_TYPE_01�u�ݤ@��*/
/*_TYPE_00������*/

data tw_freqs1;
set tw_freqs;
rvar=scan(table,2);
cvar=scan(table,3);
/*�Τ��e���L�����ҨӳB�z*/
rvar_label=vlabelx(rvar);
rvar_value=vvalue(rvar);
cvar_label=vlabelx(cvar);
cvar_value=vvalue(cvar);
if _type_ in('11');
keep rvar cvar cvar_label cvar_valuefrequency rowpercent;
run;
proc print data=tw_freqs1; run;

data chisq1;
set chisq;
/*if _n_=1;*/
if statistic='�d��';
rvar=scan(table,2);
cvar=scan(table,3);
keep rvar cvar table prob;
run;
proc print data=chisq1;run;

data tw_freqs_test;
merge tw_freqs1 chisq;
by rvar cvar;
run;
proc print data=tw_freqs_test ;run;


/*��h�ܼ�*/
proc freq data=practice12a;
tables (bmi_gp ab_whr ab_abd)*abbdf /chisq;
ods output CrossTabFreqs=tw_freqs
	 ChiSq=chisq;
label
bmi_gp='BMI ���`����'
ab_whr='�y�v��� ���`����'
abbdf='��ת� ���`����'
ab_abd='�y�� ���`����';
run;
proc print data=tw_freqs; run;
/*ods trace off;*/
/*_TYPE_11��ӳ���*/
/*_TYPE_10�u�ݤ@��*/
/*_TYPE_01�u�ݤ@��*/
/*_TYPE_00������*/

data tw_freqs1;
set tw_freqs;
rvar=scan(table,2);
cvar=scan(table,3);
/*�Τ��e���L�����ҨӳB�z*/
rvar_label=vlabelx(rvar);
rvar_value=vvalue(rvar);
cvar_label=vlabelx(cvar);
cvar_value=vvalue(cvar);
if _type_ in('11');
keep rvar cvar cvar_label cvar_valuefrequency rowpercent;
run;
proc print data=tw_freqs1; run;

data chisq1;
set chisq;
/*if _n_=1;*/
if statistic='�d��';
rvar=scan(table,2);
cvar=scan(table,3);
keep rvar cvar table prob;
run;
proc print data=chisq1;run;

proc sort data=tw_freqs1;
by rvar cvar;
run;
proc sort data=chisq1;
by rvar cvar;
run;

data tw_freqs_test;
merge tw_freqs1 chisq1;  
by cvar rvar;
if first.cvar then do; cvarlabel=cvar_label; end;
if first.rvar then do; 
	rvarlabel=rvar_label; 
	cprob=prob;
end;
run;
option missing=' ';
proc print data=tw_freqs_test; 
var cvarlabel cvar_value rvarlabel 
	rvar_value frequency rowpercent cprob;
format rowpercent f6.2 cprob pvalue6.3;
run; 
ods trace on;
proc reg data=practice12a;
model density=age bmi neck--wrist;
ods output  FitStatistics=fit
					ParameterEstimates=est;
run;
ods trace off;

proc print data=fit;run;
/*cvalue2=�r��  nvalue2=�ƭ�*/
data fit1;
set fit;
if label2='R ����';
keep nvalue2 cvalue2 label2;
rename label2=label nvalue2=stderr;
run;
data est_fit;
set est fit1;
run;

proc print data=est_fit; run;
