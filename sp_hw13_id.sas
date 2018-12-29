PROC IMPORT
DATAFILE="C:\Users\User\Desktop\class_SAS\lesson13\statpack107fHW13.csv"
out=hw13 replace;
getnames=yes;
run;
proc format;
value genderF
1='�k' 2='�k' 3='�`�˥�';
value depF 
 1 = '�H��ǰ|' 2 =' �Ӿǰ|' 3 = '�k�ǰ|' 4 = '���@�ưȾǰ|' 5 =' ���|��ǰ|' 6 =' �q����T�ǰ|';
value highscoolF 
1 = '���q����' 2 =' ��L' 3='�`�˥�';
value localF
 1 = '�s�_��' 2 = '�x�_��' 3 = '��L' ;
 value agreeF
 1 = '�D�`�P�N' 0 = '��L';
 value  $ varF
 nQ1 = '�q�ѽҵ{²��'  nQ2 = '�q�ѽҵ{���W���覡'   nQ3 = '��|�о�²��'   nQ4= '��|�оǪ��W���覡'  
 nQ5 = '��T����²���A��'  nQ6 = '��T����²���]��'   nQ7 = '�Ϯ��]²���A��'   nQ8= '�Ϯ��]²���]��' ;
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
gender='�ʧO'  
dep='�ǰ|' 
highscool='�NŪ����'
local_1='���y�a'
agreescore='����P�N��' ;
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
/*�ĤK�D*/
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
define rvar/group '�ܼ�';
define QQ/group '���O';
define gender/across '�ʧO';
define Frequency/group '�H��';
define Percent/group '�ʤ���';
define  Prob/analysis 'P ��' format=pvalue5.4;
run;

/*�ĤE�D*/
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
define rvar/group '�ܼ�';
define QQ/group '���O';
define highscool/across '�ʧO';
define Frequency/group '�H��';
define Percent/group '�ʤ���';
define  Prob/analysis 'P ��' format=pvalue5.4;
run;

/*�ĤQ�D*/
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
if class=' ' then class='�`�˥�';
RETAIN ProbF nProbF;
if ProbF^=. then nProbF=ProbF;
keep Variable Class N Mean StdDev nProbF ;
format Variable varF.;
run;
proc print data= hw13_10_alltest;run;
proc report data=hw13_10_alltest;
column Variable Class,( Mean StdDev)  nProbF;
define Variable/group '�ܼ�';
define Class/across '�ʧO';
define Mean/group '������';
define StdDev/group '�зǮt';
define  nProbF/group 'P ��' format=pvalue6.3;
run;

/*�ĤQ�@�D*/
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
define Variable/group '�ܼ�';
define Class/across '�ʧO';
define Mean/group '������';
define StdDev/group '�зǮt';
define  ProbF/analysis 'P ��' format=pvalue5.4;
run;










