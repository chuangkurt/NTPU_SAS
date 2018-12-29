PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\midterm\statpack107fm1.csv"
out=F1 replace;
getnames=yes;
run;
/*1-(1)*/
proc format;
VALUE deptF
0='磕'
1='猭';
VALUE  $groupF
'L'='凹'
'B'='璉';
VALUE typeF
0='秈'
1='癴秈';
run;
data F1a;
	set F1;
format
	dept deptF.
	group groupF.
	type typeF. ;
label
	Id='絪腹'		dept='╰' 	group='щ耏舱' 		type='щ耏よΑ' 	Nf4='玡代щ耏挡狦1'
	Nf5='玡代щ耏挡狦2'		Nf6='玡代щ耏挡狦3'		Nf7='代щ耏挡狦1'		Nf8='代щ耏挡狦2'		Nf9='代щ耏挡狦3'	;
run;
proc print data=F1a label; run;
data F1b;
	set F1a;
	mean1=mean(of Nf4 Nf5 Nf6 );
	mean2=mean(of Nf7 Nf8 Nf9 );
label
	mean1='玡代'		mean2='代' ;
run;
PROC MEANS DATA=F1b MEDIAN;
VAR mean1 mean2;
RUN;
data F1c;
set F1b;
if mean1<6.377 then Mmean1=0;
else Mmean1=1;
if mean2<7.1 then Mmean2=0;
else Mmean2=1;
label
Mmean1='玡代い计' Mmean2='代い计'; 
run;
proc freq data= F1c;
table Mmean1 Mmean2; 
run;
proc print data=F1c label; run;
/*1-(3)*/
proc sgplot data= F1c;
vbar Mmean1/stat=percent group=group
	groupdisplay=cluster datalabel
	datalabelattrs=(size=10);
run;

proc gchart data=F1c;
vbar Mmean1/discrete 
	type=percent group=group g100;
run;
proc gchart data=F1c;
vbar Mmean2/discrete 
	type=percent group=group g100;
run;

/*1-(4)*/
proc univariate
data=F1b
normal;
var mean2;
histogram
mean2
/normal;
qqplot
mean2;
run;

proc print data=F1b label; run;

/*1-(5)*/
proc boxplot data=F1b;
plot mean1*group/CBOXFILL=pink
cboxes=blue
boxwidth=10;
run;
proc boxplot data=F1b;
plot mean2*group/CBOXFILL=pink
cboxes=blue
boxwidth=10;
run;

Id='絪腹'		dept='╰' 	group='щ耏舱' 		type='щ耏よΑ' 	Nf4='玡代щ耏挡狦1'
	Nf5='玡代щ耏挡狦2'		Nf6='玡代щ耏挡狦3'		Nf7='代щ耏挡狦1'		Nf8='代щ耏挡狦2'		Nf9='代щ耏挡狦3'	;
/*1-(6)*/
proc sgplot
data=F1b;
vline Nf7;  

Run;

proc sgpanel data=F1b;
panelby group/columns=2;
series x=group y=Nf7;
series x=group y=Nf8; run;

proc sgplot data=F1b  ;
    reg x=group y=Nf7  ;
    reg x=group y=Nf8  ;
    reg x=group y=Nf9  ;
run;

proc sgplot data=F1b  ;
    series x=group y=Nf7 ;
    series x=group y=Nf8 ;
    series x=group y=Nf9 ;
run;
proc boxplot data=F1b;
plot Nf7*group/CBOXFILL=pink;
plot Nf8*group/CBOXFILL=pink;
plot Nf9*group/CBOXFILL=pink
cboxes=blue
boxwidth=10;
run;
proc sgscatter data=F1b;
compare 
x= group
y=(Nf7 Nf8 Nf9);
run;

/*1-(7)*/
proc ttest data=F1b;
paired mean1*mean2;
run;


/*1-(8)*/
PROC TABULATE data=F1b;
CLASS group type ;
var mean2 ;
table group ,type*mean2*( mean='キА计'  stddev='夹非畉'  max='程' min='程')
all*mean2*( mean='キА计'  stddev='夹非畉'  max='程' min='程');
run;
PROC TABULATE data=F1b;
CLASS group type dept	;
var mean1 mean2 ;
table group*dept all ,type*mean1*( mean='キА计'  stddev='夹非畉'  )
type*mean2*( mean='キА计'  stddev='夹非畉'  );
run;
/*2-(1)*/
data F2;
infile "C:\Users\kurt chuang\Desktop\SAS\midterm\statpack107fm2.TXT";
input 
Id	1-2
Info	$ 5-30
Method	$ 35-39
Result1	$ 40-43
Result2	$ 44-47
Result3	$ 48-51;
run;
data F2a;
set F2;
array Result Result1-Result3;
sex=substr(Info,1,4);
group=substr(Info,5,6);
dept1=scan(Info,-1,'(');
dept=compress(dept1,')');
drop dept1;
count=0;
do i =1 to 3;
if Result{i}^=' ' then count=count+1;
end;
drop i;
run;

/*2-(3)*/
data F2b;
set F2;
array Result Result1-Result3;
array a a1-a3;
array b b1-b3;
array nResult nResult1-nResult3;
do i=1 to 3;
	a{i}=(input(scan(Result{i},1,'m'),1.));
	b{i}=(input(scan(Result{i},-1,'m'),2.));
	nResult{i}=a{i}+b{i}*0.01;
end;
	max=max(of nResult1- nResult3);
	min=min(of nResult1- nResult3);
	diff=max-min;
run;
proc print data=F2b label; run;

/*3-(1)*/
data F3;
infile "C:\Users\kurt chuang\Desktop\SAS\midterm\statpack107fm3.dat" delimiter=';' FIRSTOBS=2;
input 
Id $ Info $ Method $ measure1 $ measure2 $ measure3 $ ;
run;

/*3-(2)*/
data F3a;
set F3;
array measure $ measure1-measure3;
array  nmeasure $ nmeasure1-nmeasure3;
do i=1 to 3;
	if measure{i}='-' then nmeasure{i}=' ';
	else nmeasure{i}=measure{i};
end;
run;

/*4.*/
libname F4 "C:\Users\kurt chuang\Desktop\SAS\midterm";
data F4;
set F4.statpack107fm4;
run;
data F4a;
set F4;
array  ameasure $ ameasure1- ameasure6;
do i=1 to 6;
	ameasure{i}=scan( allmeasure,i,',');
end;
run;

/*5-(1)*/
libname F5 "C:\Users\kurt chuang\Desktop\SAS\midterm";
data F5;
set F5.statpack107fm5;
run;
data F5a;
set F5;
first=mdy(input(substr(adm_date,1,2),2.),input(substr(adm_date,4,2),2.),input(substr(adm_date,7,4),4.));
birth=mdy(input(substr(bod,1,2),2.),input(substr(bod,4,2),2.),input(substr(bod,7,4),4.));
thr_day=round((first-birth)/365.25);
run;
proc print data=F5 label; run;
/*5-(2)*/
data F5b;
set F5;
array Day Day0-Day7;
array nDay nDay0-nDay7;
array ndiarrhea ndiarrhea0-ndiarrhea7;
do i = 1 to 8;
	if  Day{i}='y' then nDay{i}=1;
	else nDay{i}=0;
ndiarrhea{i}=scan(diarrhea,i,',');
end;
stomach=sum(of nDay0-nDay7);
dia=sum(of ndiarrhea0-ndiarrhea7);
run;

/*6.*/
data F7;
infile "C:\Users\kurt chuang\Desktop\SAS\midterm\statpack107fm6.dat" ;
input 
Id dept group $ type M1 M2 M3 N1 N2 N3  ;
run;
data F7a;
set F7;
array M M1-M3;
array nM $ nM1-nM3;
array N N1-N3;
array nN $ nN1-nN3;
do i=1 to 3;
if M{i}<6.2 then nM{i}='だ舱';
if  6.2<=M{i}<7 then nM{i}='舱';
if  7<=M{i} then nM{i}='蔼だ舱';
if N{i}<6.2 then nN{i}='だ舱';
if  6.2<=N{i}<7 then nN{i}='舱';
if  7<=N{i} then nN{i}='蔼だ舱';
end;
run;

/*7.*/
data F8;
infile "C:\Users\kurt chuang\Desktop\SAS\midterm\statpack107fm7.TXT";
input 
id $ age sex serum var1 $ var2 $ var3 $ var4 $ end_year 38-41 end_month 43-44 end_day 45-46 ; 
run;
data F8a;
set F8;
array var $ var1-var4;
count=0;
do i=1 to 4;
	if var{i}='Τ' then count=count+1;
	else count=count+0;
end;
duration=int(mdy(12,31,1990)-(mdy(end_month,end_day,end_year)));
run;

proc print data=F8a label; run;
