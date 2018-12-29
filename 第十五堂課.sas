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
gender='性別'
race_ethnicity='種族'
parental_level_of_education='教育程度'
lunch='中餐供給方案'
test_preparation_course='考前準備課程'
math_score='數學成績'
reading_score='閱讀成績'
writing_score='寫作成績';
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
if (probf<0.05 & variances='不均等')
	or (probf>=0.05 & variances='均等');
run;
proc print data=p14_stat_b; run;
data p14_stat_b1;
set p14_stat_b;
if ^index(class,'Diff');
run;
proc format;
value $varlabelf
'math_score'='數學成績'
'reading_score'='閱讀成績'
'writing_score'='寫作成績';
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
varlabel='變數'
class='類別' 
mean='平均數'
stddev='標準差'
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
define gender/group '性別';
define math_score/analysis '數學' mean;
run;
proc report data=p14a;
column gender math_score math_score=std_math ;
define gender/group '性別';
define math_score/analysis '數學平均值' mean;
define std_math/analysis '數學標準差' stddev;
run;
/*column定義表格上面的標籤*/
/*define 設定變數呈現方式*/
proc report data=p14a;
/*在表格上面多一格列*/
/*括號裡的變相就是同一群*/
column gender ('數學' math_score=n_math math_score 
	math_score=std_math)
	('閱讀' reading_score=n_math reading_score 
	reading_score=std_math);
define gender/group '性別';
define n_math/analysis 'N' n;
define math_score/analysis '平均值' mean format=6.2;
define std_math/analysis '標準差' stddev format=6.2;
define n_reading/analysis 'N' n;
define reading_score/analysis '平均值' mean  format=6.2;
define std_reading/analysis '標準差' stddev  format=6.2;
run;

proc format;
value $varlabelf
'math_score'='數學成績'
'reading_score'='閱讀成績'
'writing_score'='寫作成績';
run;
proc report data=p14_stat_test;
/*括號表示across只影響裡面兩個變數不含其他的*/
column variable class, (mean stddev) prob;
define variable/group '變數' format=$varlabelf.
	order=internal;
define class/across '考前衝刺班';
define mean/analysis '平均值' format=6.2;
define stddev/analysis '標準差' format=6.2;
define prob/analysis 'P值' format=pvalue6.3;
run;
data p14_stat_testa;
set p14_stat_test;
order_var=ceil(_n_/2);
run;
proc report data=p14_stat_test;
column order_var variable class, (mean stddev) prob;
define order_var/noprint order=internal;
define variable/group '變數' format=$varlabelf.
	order=internal;
define class/across '考前衝刺班';
define mean/analysis '平均值' format=6.2;
define stddev/analysis '標準差' format=6.2;
define prob/analysis 'P值' format=pvalue6.3;
run;
data p14_freqa;
set p14_freq;
xvar=scan(table,2);
xvar_label=vlabelx(xvar);
xvar_value=vvaluex(xvar);
run;
proc report data=p14_freqa;
column xvar_label xvar_value frequency percent;
define xvar_label/group '變數' order=data;
define xvar_value/group '類別';
define frequency/analysis '人數' format=5.;
define percent/analysis '百分比' format=5.2;
run;
/*改變顏色用proc format + style=[color=colf.] */
proc format;
value colf
0-<0.05='red'
0.05-0.1='blue';
run;
/*format=6.2表示6位數小數點後第二位*/
proc report data=p14_stat_test;
column order_var variable class, (mean stddev) prob;
define order_var/noprint order=internal;
define variable/group '變數' format=$varlabelf.
	order=internal;
define class/across '考前衝刺班';
define mean/analysis '平均值' format=6.2;
define stddev/analysis '標準差' format=6.2;
define prob/analysis 'P值' format=pvalue6.3
	style=[color=colf.];
run;
