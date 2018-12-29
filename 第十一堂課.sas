data PR10;
infile "C:\Users\NTPU\Downloads\statpack107fp10.TXT" missover;
input 
 ID 7-8
Weight 12-16 
Age 23-24 
Gender 32 
 Environment 40
Origin 48 
Treatment 56 
Result 64 
 ES1 71-72
ES2 79-80 
 ES3 87-88
 ES4 95-96
ES5 103-104 ;
RUN;
proc sgplot data=PR10;
 HBOX Treatment / CATEGORY=Result;
 run;


/********************�W�ҥ�******************/
%let dirq=D:\Dropbox\School\statpack\107fall\;
proc format;
value trtf
0='�w����'
1='Zylkene';
value resultf
0='�L��'
1='����';
run;
data p10;
infile "&dirq\graduate\practice\statpack107fp10.txt";
/*�e�����ϥ�*/
input id weight age gender
	environment origin treatment result
	es1-es5;
format result resultf. treatment trtf.;
run;
proc freq data=p10;
tables treatment*result;
run;
/*�n�e�X�C�ʤ���A�ƭȫ��ܼƶ��[discrete*/
proc gchart data=p10;
vbar result/discrete group=treatment g100;
run;
proc sgplot data=p10;
vbar result/group=treatment stat=percent
	groupdisplay=cluster;
run;
proc sgplot data=p10;
vbar result/group=treatment stat=mean
	response=weight groupdisplay=cluster;
run;
proc sgplot data=p10;
vline result/group=treatment stat=mean
	response=weight limitstat=clm;
run;
proc sgplot data=p10;
vbox weight/group=treatment;
run;
data p10a;
set p10;
newgroup=1+result+2*treatment;
run;
proc sgplot data=p10a;
vbox weight/category=newgroup;
run;
proc sgplot data=p10a;
scatter x=es1 y=es5/datalabel=id;
run;

/*SGSCATTER�i�H�Ʀh���ܼ�*/
/*MATRIX�i�H�ݥX�U�ܼƤ�����������*/
/*DIAGONAL�i�H�bMATRIX�ϧΤ����XNORMAL�ϧ�*/
proc sgscatter data=p10a;
matrix es1-es5/group=treatment
	diagonal=(histogram normal);
run;

/*PLOT�i�H�ݥX�P��Ǯɶ��u�����p���j�z�A�᭱REG�i�H�e�X�H��ϱa*/
proc sgscatter data=p10a;
plot (es2-es5)*es1/reg=(clm) group=treatment;
run;
/*LOESS�ADEGREE=2��ܬ��G���h����*/
proc sgscatter data=p10a;
plot (es2-es5)*es1/loess=(degree=2);
run;
proc sgscatter data=p10a;
compare x=(weight age es1) y=(es2-es5);
run;
data p10b;
set p10;
array es es1-es5;
do time=1 to 5;
	y=es{time}; output;
end;
keep id y time treatment;
run;

/*NOVARNAME�W���ܼƨS���W��*/

/*SGPANEL�i�H�@�Ͷդ��*/






