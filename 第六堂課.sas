proc format;
VALUE agreeynF
1='完全不同意'
2='很不同意'
3='普通'
4='很同意'
5='完全同意';
VALUE locationF
1='住家裡'
2='住學校宿舍'
3='校外租屋'
4='住親戚家';
VALUE  worktimeF
1='0小時'
2='1-5小時'
3='6-10小時'
4='11-15小時'
5='16小時以上';
VALUE  tvtimeF
1='0小時'
2='1-7小時'
3='8-14小時'
4='15-21小時'
5='22小時以上';
run;
PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpack107fp5.xlsx"
out= practice5 replace;
getnames=yes;
run;
data practice5;
set practice5;
format
		Q1 Q2 Q3 Q4 Q5 Q6  Q7 Q8 Q9 Q10 Q11 Q12 Q13 Q14 Q15  agreeynF.
		Q61 locationF.
		Q62 worktimeF.
		Q63 tvtimeF.
	;
	run;
	data practice5a;
	set practice5;
	mean_anx=mean(of Q1 Q2 Q3 Q4 Q5 Q6  Q7 Q8 Q9 Q10 Q11 Q12 Q13 Q14 Q15);
	/*_col0=14  第14欄*/
			/*_col0要去work看*/
	if _col0=14 then Q5=	mean_anx;
	else if _col0=39 then do;
	Q11=	mean_anx;
	Q14=	mean_anx;
	end;
	else if _col0=41then Q3=	mean_anx;
	/*也可以寫成
array allQ Q1-Q15;
array mallQ mQ1-mQ15;
	do i=1 to 15;
	if missing(allQ{i}) then mallQ{i}=mean_anx;
	else mallQ{i}=allQ{i};
	end;      
	*/
run;
data practice5b;
	set practice5a;
	array allQ Q1-Q15;
	array nallQ nQ1-nQ15;
	do i=1 to 15;
		nallQ{i}=6-allQ{i};
		end;
		ameasure=sum(of nQ1-nQ15);
		/*dept 的長度需要設定*/
		format dept $10;
		if _coll in('統計系' '企管系' '運管系' '會計系')
		then dept='商學院';
		else dept=('其他非商學院');
class=(_col2 ^=1);
work=(Q62 in (2 3 4 5));
run;
proc print data=practice5b;
var _col1 dept;
run;
data practice5c;
set practice5;
mean_anx=mean(of q1-q15);
array allques q1-q15;
array mallques mq1-mq15;
do i=1 to 15;
	if missing(allques{i}) then 
		mallques{i}=mean_anx;
	else mallques{i}=allques{i};
end;
run;
proc print data=practice5c LABEL;
run;






libname ch4"C:\Users\NTPU\Downloads\statpackch4";
proc print data=ch4.statpackch4d4;
run;

data ch4d4;
set ch4.statpackch4d4;
predbp=scan(preopbs,1,'/');
presbp=scan(preopbs,2,'/');
/*上下兩種都一樣，但是上面是字串，下面沒有宣告的話是數值*/
array post postdbp postsbp;
do i=1to 2;
	post{i}=scan(postopbs,i,'/');
end;
run;
proc print data=ch4d4;
var preopbs predbp presbp;
run;
data ch4d4a;
set ch4d4;
/*篩選出要的幾個位元*/
dm=substr(dmtype,1,2);
/*將YR刪去*/
temp=compress(dmtype,'YR');
/*將temp空格山去*/
temp1=compress(temp);
/*計算長度*/
leng_dm=length(temp1);
/*擷取所需要的*/
dm_yr=substr(temp1,3,leng_dm-2);
run;
proc print data=ch4d4a (obs=10);
var dmtype dm temp temp1 leng_dm dm_yr;
run;

data ch4d4b;
set ch4d4a;
flag_i=index(infect,'P');
if flag_i>0 then do;
/*只要是M、O、 空格，都會壓掉*/
	temp2=compress(infect,'MO ');
	inf_yr=substr(temp2,2,1);
	end;
run;
proc print data=ch4d4b (obs=10);
var infect flag_i temp2 inf_yr;
run;
data ch4d4c;
set ch4d4b;
/*將字串改為數值*/
npredbp=input(predbp,3.);
array old predbp presbp postdbp postsbp;
array new npredbp npresbp npostdbp npostsbp;
do i=1to 4;
new{i}=input(old{i},3.);
end;
run;
proc print data= ch4d4c;
var predbp presbp postdbp postsbp npredbp npresbp npostdbp npostsbp;
run;
/******************************************以下老師***************************************/
libname ch4 "&dirstat\graduate\chapter4";
proc print data=ch4.statpackch4d4;
run;
data ch4d4;
set ch4.statpackch4d4;
predbp=scan(preopbs,1,'/');
presbp=scan(preopbs,2,'/');
array post $ postdbp postsbp;
do i=1 to 2;
	post{i}=scan(postopbs,i,'/');
end;
run;
proc print data=ch4d4;
var preopbs predbp presbp postopbs
	postdbp postsbp;
run;
data ch4d4a;
set ch4d4;
dm=substr(dmtype,1,2);
temp=compress(dmtype,'YR');
temp1=compress(temp);
leng_dm=length(temp1);
dm_yr=substr(temp1,3,leng_dm-2);
run;
proc print data=ch4d4a (obs=10);
var dmtype dm temp temp1 leng_dm dm_yr;
run;
data ch4d4b;
set ch4d4a;
flag_i=index(infect,'P');
if flag_i>0 then do;
	temp2=compress(infect,'MO ');
	inf_yr=substr(temp2,2,1);
end;
run;
proc print data=ch4d4b;
var infect flag_i temp2 inf_yr;
run;
data ch4d4c;
set ch4d4b;
/*npredbp=input(predbp,3.);*/
array old predbp presbp postdbp postsbp;
array new npredbp npresbp 
	npostdbp npostsbp;
do i=1 to 4;
	new{i}=input(old{i},3.);
end;
prebp=(npredbp+npresbp+npostdbp)/3;
prebp1=round(prebp);
prebp2=ceil(prebp);
prebp3=floor(prebp);
prebp4=int(prebp);
run;
proc print data=ch4d4c;
var prebp prebp1-prebp4;
run;
/*****************************************************/
data ch4d6;
infile "C:\Users\NTPU\Downloads\statpackch4\statpackch4d6.txt";
input id $ 7-12
        hird $ 13-21
		salary 22-29
		dept $ 30-35
		jobcode $ 37-39
		sex $ 40;
	hiredata=input(hird,data9.);
	new_sal=put(salary,5.);
	todayd=mdy(10,22,2018);
run;
proc print data=ch4d6;
format hiredata mmddyy10.;
run;
