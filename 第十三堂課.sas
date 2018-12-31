proc import 
	datafile="C:\Users\NTPU\Downloads\statpack107fp14.xlsx"
	out=p14 replace;
run;
proc freq data=p14;
tables gender	race_ethnicity	
parental_level_of_education	
lunch	test_preparation_course;
RUN;
data p14a;
set p14;
if parental_level_of_education
	in ('some high school' 'high school')
	then level_educ=1;
else if parental_level_of_education
	in ('some college' "associate's degree") 
	then level_educ=2;
else level_educ=3;
label
gender='�ʧO'
race_ethnicity='�ر�'
parental_level_of_education='�Ш|�{��'
lunch='���\�ѵ����'
test_preparation_course='�ҫe�ǳƽҵ{'
math_score='�ƾǦ��Z'
reading_score='�\Ū���Z'
writing_score='�g�@���Z';
run;
proc ttest data=p14;
class test_preparation_course;
var math_score reading_score writing_score;
ods output Statistics=p14_stat_b
	 TTests=p14_ttest_b Equality=p14_var_b;
run;
proc sort data=p14_ttest_b;
by variable;
proc sort data=p14_var_b;
by variable;
data p14_alltest;
merge p14_ttest_b p14_var_b; 
by variable;
if (probf<0.05 & variances='������')
	or (probf>=0.05 & variances='����');
run;
proc print data=p14_stat_b; run;
data p14_stat_b1;
set p14_stat_b;
if ^index(class,'Diff');
run;
proc format;
value $varlabelf
'math_score'='�ƾǦ��Z'
'reading_score'='�\Ū���Z'
'writing_score'='�g�@���Z';
run;
proc sort data=p14_stat_b1;
by variable;
data p14_stat_test;
merge p14_stat_b1  p14_alltest;
by variable;
if first.variable then do;
	varlabel=put(variable,$varlabelf.);
	varname=variable;
	prob=probt;
end;
run;
proc print data=p14_stat_test 
	LABEL noobs; 
var  varlabel class mean stddev prob;
format mean stddev 6.3 prob pvalue6.3;
label
varlabel='�ܼ�'
class='���O' 
mean='������'
stddev='�зǮt'
prob='p';
run;
ods select where=(_path_='Ttest.math_score.TTests');
ods select where=(_name_ in ('TTests' 'Equality'));
/*ods trace on;*/
ods html close;
ods html;
ods pdf file="d:\test_ttest.pdf";
proc ttest data=p14a;
class gender;
var math_score;
run;
ods pdf close;
/*ods trace off;*/
proc report data=p14a;
column gender math_score;
define gender/group '�ʧO';
define math_score/analysis '�ƾ�' mean;
run;
proc report data=p14a;
column gender math_score math_score=std_math ;
define gender/group '�ʧO';
define math_score/analysis '�ƾǥ�����' mean;
define std_math/analysis '�ƾǼзǮt' stddev;
run;
/*column�w�q���W��������*/
/*define �]�w�ܼƧe�{�覡*/
proc report data=p14a;
/*�b���W���h�@��C*/
/*�A���̪��ܬ۴N�O�P�@�s*/
column gender ('�ƾ�' math_score=n_math math_score 
	math_score=std_math)
	('�\Ū' reading_score=n_math reading_score 
	reading_score=std_math);
define gender/group '�ʧO';
define n_math/analysis 'N' n;
define math_score/analysis '������' mean format=6.2;
define std_math/analysis '�зǮt' stddev format=6.2;
define n_reading/analysis 'N' n;
define reading_score/analysis '������' mean  format=6.2;
define std_reading/analysis '�зǮt' stddev  format=6.2;
run;

proc format;
value $varlabelf
'math_score'='�ƾǦ��Z'
'reading_score'='�\Ū���Z'
'writing_score'='�g�@���Z';
run;
proc report data=p14_stat_test;
/*�A�����across�u�v�T�̭�����ܼƤ��t��L��*/
column variable class, (mean stddev) prob;
define variable/group '�ܼ�' format=$varlabelf.
	order=internal;
define class/across '�ҫe�Ĩ�Z';
define mean/analysis '������' format=6.2;
define stddev/analysis '�зǮt' format=6.2;
define prob/analysis 'P��' format=pvalue6.3;
run;
data p14_stat_testa;
set p14_stat_test;
order_var=ceil(_n_/2);
run;
proc report data=p14_stat_test;
column order_var variable class, (mean stddev) prob;
define order_var/noprint order=internal;
define variable/group '�ܼ�' format=$varlabelf.
	order=internal;
define class/across '�ҫe�Ĩ�Z';
define mean/analysis '������' format=6.2;
define stddev/analysis '�зǮt' format=6.2;
define prob/analysis 'P��' format=pvalue6.3;
run;
data p14_freqa;
set p14_freq;
xvar=scan(table,2);
xvar_label=vlabelx(xvar);
xvar_value=vvaluex(xvar);
run;
proc report data=p14_freqa;
column xvar_label xvar_value frequency percent;
define xvar_label/group '�ܼ�' order=data;
define xvar_value/group '���O';
define frequency/analysis '�H��' format=5.;
define percent/analysis '�ʤ���' format=5.2;
run;
/*�����C���proc format + style=[color=colf.] */
proc format;
value colf
0-<0.05='red'
0.05-0.1='blue';
run;
/*format=6.2���6��Ƥp���I��ĤG��*/
proc report data=p14_stat_test;
column order_var variable class, (mean stddev) prob;
define order_var/noprint order=internal;
define variable/group '�ܼ�' format=$varlabelf.
	order=internal;
define class/across '�ҫe�Ĩ�Z';
define mean/analysis '������' format=6.2;
define stddev/analysis '�зǮt' format=6.2;
define prob/analysis 'P��' format=pvalue6.3
	style=[color=colf.];
run;
