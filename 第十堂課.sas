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
proc sgplot data=p9;  /*畫圖*/
dot group/response=cd4_1 stat=mean 
	limits=both limitstat=stderr numstd=2;
run;
proc sgplot data=p9;
dot group/response=cd4_5 stat=mean 
/*limits 設定區間， limitstat 區間對應統計量*/
	limits=both limitstat=clm;
run;
proc print data=p9a;
run;

libname ch5 "C:\Users\NTPU\Downloads";
proc print data=ch5.statpackch5d1 (obs=10);
run;
proc format;
value educf
1='不識字'
2='小學'
3='國中'
4='高中'
5='大學';
value sexf
1='女'
2='男';
value sevf
1='輕'
2='重';
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
/*MARKERATTRS 標記的設定*/
	markerattrs=(size=10)
	limitattrs=(thickness=2 pattern=2);
run;
proc sgplot data=ch5d1;
vbar educ;
run;
proc sgplot data=ch5d1;
/*hbar是垂直的圖*/
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
