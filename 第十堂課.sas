data p9;
infile "C:\Users\NTPU\Downloads\statpack107fp9.dat";
input id cd4_1-cd4_5 group;
run;
data p9a;
set p9;
array cd4 cd4_1-cd4_5;
count=0;
do time=0, 8, 16, 24, 32;
	count=count+1;
	y=cd4{count}; output;
end;
run;
proc print data=p9a (obs=10); run;
data p9a;
set p9;
array cd4 cd4_1-cd4_5;
do count=1 to 5;
	time=0+(count-1)*8;
	y=cd4{count}; output;
end;
run;
proc sgplot data=p9;
dot group;
run;
proc sgplot data=p9;  /*�e��*/
dot group/response=cd4_1 stat=mean 
	limits=both limitstat=stderr numstd=2;
run;
proc sgplot data=p9;
dot group/response=cd4_5 stat=mean 
/*limits �]�w�϶��A limitstat �϶������έp�q*/
	limits=both limitstat=clm;
run;
proc print data=p9a;
run;

libname ch5 "C:\Users\NTPU\Downloads";
proc print data=ch5.statpackch5d1 (obs=10);
run;
proc format;
value educf
1='���Ѧr'
2='�p��'
3='�ꤤ'
4='����'
5='�j��';
value sexf
1='�k'
2='�k';
value sevf
1='��'
2='��';
run;
data ch5d1;
set ch5.statpackch5d1;
format educ educf. sex sexf. a1cgp sevf.;
run;
ods graphics/attrpriority=none;/* Default: color*/
proc sgplot data=ch5d1;
styleattrs datasymbols=(circle circlefilled);
dot educ/response=posta1c stat=mean 
	limits=both limitstat=clm group=sex
/*	markerattrs=(color=cx000000
	size=10 symbol=square)*/;
run;
proc sgplot data=ch5d1;      
styleattrs datasymbols=(circle circlefilled);
dot educ/response=posta1c stat=mean 
	limits=both limitstat=clm group=sex
/*MARKERATTRS �аO���]�w*/
	markerattrs=(size=10)
	limitattrs=(thickness=2 pattern=2);
run;
proc sgplot data=ch5d1;
vbar educ;
run;
proc sgplot data=ch5d1;
/*hbar�O��������*/
hbar educ/stat=percent group=sex
	groupdisplay=cluster datalabel
	datalabelattrs=(size=10);
run;
proc gchart data=ch5d1;
hbar educ/discrete 
	type=percent group=sex g100;
run;
proc sgplot data=ch5d1;
hbar educ/stat=mean group=sex 
	response=posta1c limits=upper
	groupdisplay=cluster datalabel
	datalabelattrs=(size=10);
run; 
