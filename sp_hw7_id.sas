PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lesson7\statpack107fHW7a.csv"
out=HW7a replace;
getnames=yes;
run;
PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lesson7\statpack107fhw7b.csv"
out=HW7b replace;
getnames=yes;
run;
PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lesson7\statpack107fhw7c.csv"
out=HW7c replace;
getnames=yes;
run;

data HW7aa;
set hw7a;
ARRAY Ans1{8} A_1-A_8;
do i=1 to 8;
 	if q4_1=i or q4_2=i or q4_3=i then Ans1{i}=1;
		else Ans1{i}=0;
	end;
total= sum(of A_1-A_8);
RUN;
PROC MEANS data=HW7aa MAXDEC=2  N  MEAN STD ;
var A_1-A_8;
RUN;

data HW7ab;
set hw7a;
ARRAY Bns1{13} B_1-B_13;
Q2_1=scan(q2,1,';'); Q2_2=scan(q2,2,';'); Q2_3=scan(q2,3,';');
do i=1 to 13;
 	if Q2_1=i or Q2_2=i or Q2_3=i then Bns1{i}=1;
		else Bns1{i}=0;
	end;
RUN;
proc print data=HW7ab;
run;
proc sort 
data=HW7a
out=HW7ma;
by id;
run;
run;
proc sort 
data=HW7b
out=HW7ba;
by id;
run;
proc sort 
data=HW7c
out=HW7ca;
by id;
run;
data mgbc;
merge HW7ba HW7ca;
by id;
run;
data mgbca;
set mgbc;
ARRAY Q9{9} nq9_1-nq9_9;
ARRAY nQ9{9} nnq9_1-nnq9_9;
do i=1 to 9;
 	if Q9{i}='A' then  nQ9{i}=5;
		if Q9{i}='B' then  nQ9{i}=4;
		if Q9{i}='C' then  nQ9{i}=3;
		if Q9{i}='D' then  nQ9{i}=2;
		else if Q9{i}='E' then  nQ9{i}=1;
	end;
if q6=1 then expense='1000元以下';
else  if q6>1 then expense='其他';
drop q6;
RUN;
proc print data=mgbca;
run;
PROC MEANS data=mgbca MAXDEC=2  N  MEAN STD ;
var nnq9_1-nnq9_9;
RUN;

data mgabc;
merge mgbc(in=in1) HW7ma(in=in2);
by id;
flag1=in1;
flag2=in2;
run;
proc print data=mgabc;
run;
data mgabc_a mgabc_b;
set mgabc;
if flag1=flag2 then output mgabc_a;
	else if flag1^=flag2 then output mgabc_b;
	run;
proc print data=mgabc_a;
run;
proc print data=mgabc_b;
run;
data mgbca_va;
set mgbca;
value=sum(of nnq9_1 nnq9_9)/2;
service=sum(of nnq9_2 nnq9_3 nnq9_5 nnq9_7)/4;
rich=sum(of nnq9_4 nnq9_6 nnq9_8 )/3;
label 
	value='商圈價值' service='服務構面' rich='商圈豐富性';
run;
PROC TABULATE data=mgbca_va;
CLASS expense ;
var value service rich;
table  expense all,value*( mean='平均數'  stddev='標準差') service*( mean='平均數'  stddev='標準差') 
rich*( mean='平均數'  stddev='標準差')
;
run;
