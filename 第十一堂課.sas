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


/********************上課用******************/
%let dirq=D:\Dropbox\School\statpack\107fall\;
proc format;
value trtf
0='安慰劑'
1='Zylkene';
value resultf
0='無效'
1='有效';
run;
data p10;
infile "&dirq\graduate\practice\statpack107fp10.txt";
/*畫直條圖用*/
input id weight age gender
	environment origin treatment result
	es1-es5;
format result resultf. treatment trtf.;
run;
proc freq data=p10;
tables treatment*result;
run;
/*要畫出列百分比，數值型變數須加discrete*/
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

/*SGSCATTER可以化多個變數*/
/*MATRIX可以看出各變數之間的相關性*/
/*DIAGONAL可以在MATRIX圖形中劃出NORMAL圖形*/
proc sgscatter data=p10a;
matrix es1-es5/group=treatment
	diagonal=(histogram normal);
run;

/*PLOT可以看出與基準時間線性關聯的強弱，後面REG可以畫出信賴區帶*/
proc sgscatter data=p10a;
plot (es2-es5)*es1/reg=(clm) group=treatment;
run;
/*LOESS，DEGREE=2表示為二次多項式*/
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

/*NOVARNAME上面變數沒有名稱*/

/*SGPANEL可以作趨勢比較*/






