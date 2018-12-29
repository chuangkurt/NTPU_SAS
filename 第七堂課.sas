 libname pr6 "C:\Users\NTPU\Downloads\";
proc print data=pr6.statpack107fprac6;
run;
data pr6a;
set pr6.statpack107fprac6;
birth_m=scan(bod,1,'/'); birth_d=scan(bod,2,'/'); birth_y=scan(bod,3,'/');
end_m=scan(adm_date,1,'/'); end_d=scan(adm_date,2,'/'); end_y=scan(adm_date,3,'/');
run;
proc print data=pr6a;
run;
data pr6b;
set pr6.statpack107fprac6;
array allday day0-day7;
array nallday nday0-nday7;
array dia $ d0-d7;
do i=1 to 8;
	if allday{i}='y' then nallday{i}=1;
	else if allday{i}='n' then nallday{i}=0;
	dia{i}=scan(diarrhea,i,',');
end;
total_d=sum(of nday0-nday7);
total_dia=sum(of d0-d7);
run;
proc print data=pr6b;
run;


/******************************************** 120.126.135.53*************************************************** */
%let dirclass=D:\Dropbox\School\statpack\107fall;
libname ch4 "&dirclass\graduate\practice";
data p6;
set ch4.statpack107fprac6;
array allday day0-day7;
array nallday nday0-nday7;
array dia d0-d7;
do i=1 to 8;
	if allday{i}='y' then nallday{i}=1;
	else if allday{i}='n' then nallday{i}=0;
	dia{i}=input(scan(diarrhea,i,','),2.);
end;
if bod^='.' then bod1=input(bod,mmddyy10.);
adm_date1=input(adm_date,mmddyy10.);
total_ad=sum(of nday0-nday7);
total_dia=sum(of d0-d7);
run;
data p6a;
set p6;
countdia=count(diarrhea,',');
array dia d0-d7;
do i=1 to (countdia+1);
	dia{i}=input(scan(diarrhea,i,','),2.);
end;
if age=109 then age=.;
run;
proc print data=p6a;
var diarrhea countdia;
run;

proc means data=p6a median;
var age;
output out=p6a_age median=ma;
run;
data p6b;
set p6a;
if 0<age<2 then age2=0;
else if age>=2 then age2=1;
run;
data p6c;
set p6a_age p6a;
agema+lag1(ma);
if 0<age<agema then age2=0;
else if age>=agema then age2=1;
run;
/**/
data p6d;
set p6a;
if _n_=1 then set p6a_age;
if 0<age<agema then age2=0;
else if age>=agema then age2=1;
run;
proc print;run;
data animal;
input common $ animal $;
cards;
A Ant
B Bird
C Cat
D Dog
E Eagle
F Frog
run;
data plant;
input common $ plant$;
cards;
A Apple
B Banana
C Coconut
D Dewberry
E Eggplant
G Fig
run;
data mset;
merge animal plant;
run;
proc print; run;
data mset;
/*in���b�̭��N�O1�A�S�����ܴN�O0*/
merge animal (in=inobs1) plant (in=inobs2);
/*��W�����{���t�b�p�G�S���[by�A���i��X�֫�|���ȿ�*/
by common;
firstflag=inobs1;
secondflag=inobs2;
if inobs1 & inobs2;
run;
proc print; run;


/****************************hw6*******************************/
proc print data=hw6;
by id;
data hw6a;
set hw6;
by id;
/*�O�d�ܼƪ��ƪ���U�@���[��ȡA totamt(0)��� totamt�_�l�Ȭ�0*/
retain totamt count (0);
/*�ݨ�Ĥ@����ƫ� totamt�N�[�WAPPL_AMT*/
/*�ݨ�Ĥ@����ƫ� count�N�[�W1*/
if first.id then do;
	totamt=APPL_AMT;
	count=1;
end;
else do;
	totamt=totamt+APPL_AMT;
	count=count+1;
end;
run;
proc print data=hw6a (obs=15);
run;
/*�p�G�O�k�ʹN��X��male�A�p�G�O�k�ʹN��X�Dfemale*/
data hw6_male hw6_female;
set hw6a;
if id_sex='M' then output hw6_male;
else output hw6_female;
run;

/*�i�H��X���O��ƦC�p��*/

data mi;
do drug=0 to 1;
/*�W�q�O-1*/
	do status=2 to 0 by -1;
/*	@@�O����Ū��*/
		input count @@;
		output;
	end;
end;
cards;
18 171 10845 
5 99 10933
run;
proc print data=mi;
run;

data ch4d8;
infile "&dirclass\graduate\chapter4\statpackch4d8.txt"

/*�Ĥ@���O�q��32���[��ȶ}�l*/
	firstobs=32;
input id group $ lead0 lead1 lead4 lead6;
run;
data ch4d8a;
set ch4d8;
array lead lead0 lead1 lead4 lead6;
count=0;
do time=0, 1, 4, 6;
	count=count+1;
/*�}�C�����Ф��O1234...*/
	y=lead{count};
/*	�z�L�o�˥i�H��V�ܦ��a�V*/
	output;
end;
run;
