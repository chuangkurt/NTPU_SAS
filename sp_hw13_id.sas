PROC IMPORT
DATAFILE="C:\Users\User\Desktop\class_SAS\lesson13\statpack107fHW13.csv"
out=hw13 replace;
getnames=yes;
run;
proc format;
value genderF
1='男' 2='女' 3='總樣本';
value depF 
 1 = '人文學院' 2 =' 商學院' 3 = '法學院' 4 = '公共事務學院' 5 =' 社會科學院' 6 =' 電機資訊學院';
value highscoolF 
1 = '普通高中' 2 =' 其他' 3='總樣本';
value localF
 1 = '新北市' 2 = '台北市' 3 = '其他' ;
 value agreeF
 1 = '非常同意' 0 = '其他';
 value  $ varF
 nQ1 = '通識課程簡介'  nQ2 = '通識課程的規劃方式'   nQ3 = '體育教學簡介'   nQ4= '體育教學的規劃方式'  
 nQ5 = '資訊中心簡介服務'  nQ6 = '資訊中心簡介設備'   nQ7 = '圖書館簡介服務'   nQ8= '圖書館簡介設備' ;
data hw13_1;
set hw13;
array Q Q1-Q8;
count=0;
do i= 1 to 8;
	if Q{i}=. then count=count+1;
end;
if count >= 3 then delete;
if highschool_1=1 then highscool=1;
	else highscool=2;
if local=1 then local_1=1;
	if local=2 then local_1=2;
		else local_1=3;
agreescore=sum(of Q1-Q8);
format
gender genderF. dep depF. highscool highscoolF. local_1 localF.;
label 
gender='性別'  
dep='學院' 
highscool='就讀高中'
local_1='戶籍地'
agreescore='整體同意度' ;
drop i count;
run;
data hw13_2;
set hw13_1;
array Q Q1-Q8;
array nQ nQ1-nQ8;
do i= 1 to 8;
	if 0<Q{i}<4 then nQ{i}=0;
	else nQ{i}=1;
end;
drop Q1-Q8;
format nQ1-nQ8 agreeF.;
run;
/*第八題*/
proc freq data=hw13_2;
tables nQ1-nQ8*gender;
tables nQ1-nQ8*gender/chisq;
ods output ChiSq=h13_2_chi CrossTabFreqs=hw13_2_CTF;
run;
data h13_chi2;
set h13_2_chi;
if mod(_n_,7)^=1 then delete;
keep Table Value Prob ;
run;
data hw13_2_freqs1;
set hw13_2_CTF;
array nQ nQ1-nQ8;
do i =1 to 8;
if nQ{i}^=. then QQ= nQ{i};
end;
rvar=scan(table,2);
if _type_='01' then delete;
if _type_='00' then delete;
keep Table QQ  rvar gender  Frequency Percent ;
format QQ agreeF. rvar varF.;
run;
proc sort data=hw13_2_freqs1 nodupkey; by Table QQ rvar gender  Frequency Percent ; run;
proc sort data=h13_chi2 nodupkey;by Table; run;
data hw13_2_fc;
merge hw13_2_freqs1 h13_chi2;
by Table;
if gender=. then gender=3;
run;
proc print data=hw13_2_fc ;run;
proc report data=hw13_2_fc;
column rvar QQ gender,( Frequency Percent)  Prob;
define rvar/group '變數';
define QQ/group '類別';
define gender/across '性別';
define Frequency/group '人數';
define Percent/group '百分比';
define  Prob/analysis 'P 值' format=pvalue5.4;
run;

/*第九題*/
proc freq data=hw13_2;
tables nQ1-nQ8*highscool;
tables nQ1-nQ8*highscool/chisq;
ods output ChiSq=h13_9_chi CrossTabFreqs=hw13_9_CTF;
run;
data h13_9_chii2;
set h13_9_chi;
if mod(_n_,7)^=1 then delete;
keep Table Value Prob ;
run;
data hw13_9_freqs1;
set hw13_9_CTF;
array nQ nQ1-nQ8;
do i =1 to 8;
if nQ{i}^=. then QQ= nQ{i};
end;
rvar=scan(table,2);
if _type_='01' then delete;
if _type_='00' then delete;
keep Table QQ  rvar highscool  Frequency Percent ;
format QQ agreeF. rvar varF.;
run;
proc sort data=hw13_9_freqs1 nodupkey; by Table QQ rvar highscool Frequency Percent ; run;
proc sort data=h13_9_chii2 nodupkey;by Table; run;
data hw13_9_fc;
merge hw13_9_freqs1 h13_9_chii2;
by Table;
if highscool=. then delete;
run;
proc print data= hw13_9_fc ;run;
proc report data=hw13_9_fc;
column rvar QQ highscool,( Frequency Percent)  Prob;
define rvar/group '變數';
define QQ/group '類別';
define highscool/across '性別';
define Frequency/group '人數';
define Percent/group '百分比';
define  Prob/analysis 'P 值' format=pvalue5.4;
run;

/*第十題*/
proc ttest data=hw13_2;
var nQ1-nQ8;
ods output Statistics=hw13_1_stat_b ;
run;

proc ttest data=hw13_2;
class gender;
var nQ1-nQ8;
ods output Statistics=hw13_2_stat_b  Equality=hw13_2_var_b;
run;
proc sort data=hw13_2_stat_b;
by variable;
proc sort data=hw13_2_var_b;
by variable;
data hw13_2_alltest;
merge hw13_2_stat_b hw13_2_var_b; 
by variable;
if Class='Diff (1-2)' then delete;
keep Variable Class N Mean StdDev ProbF;
run;
proc sort data=hw13_2_alltest;
by variable N;
proc sort data=hw13_1_stat_b;
by variable N;
data hw13_10_alltest;
merge hw13_2_alltest hw13_1_stat_b; 
by variable N;
if class=' ' then class='總樣本';
RETAIN ProbF nProbF;
if ProbF^=. then nProbF=ProbF;
keep Variable Class N Mean StdDev nProbF ;
format Variable varF.;
run;
proc print data= hw13_10_alltest;run;
proc report data=hw13_10_alltest;
column Variable Class,( Mean StdDev)  nProbF;
define Variable/group '變數';
define Class/across '性別';
define Mean/group '平均值';
define StdDev/group '標準差';
define  nProbF/group 'P 值' format=pvalue6.3;
run;

/*第十一題*/
proc ttest data=hw13_2;
class highscool;
var nQ1-nQ8;
ods output Statistics=hw13_11_stat_b  Equality=hw13_11_var_b;
run;
proc sort data=hw13_11_stat_b;
by variable;
proc sort data=hw13_11_var_b;
by variable;
data hw13_11_alltest;
merge hw13_11_stat_b hw13_11_var_b; 
by variable;
if Class='Diff (1-2)' then delete;
keep Variable Class N Mean StdDev ProbF;
format Variable varF.;
run;
proc report data=hw13_11_alltest;
column Variable Class,( Mean StdDev)  ProbF;
define Variable/group '變數';
define Class/across '性別';
define Mean/group '平均值';
define StdDev/group '標準差';
define  ProbF/analysis 'P 值' format=pvalue5.4;
run;










