PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpack107fp8.xlsx"
out=pr8a replace;
getnames=yes;
SHEET="statpack107fp8_1";
run;
PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpack107fp8.xlsx"
out=pr8b replace;
getnames=yes;
SHEET="statpack107fp8_2";
run;
data pr8aa p8_1b1 p8_1b2;
set pr8a;
zip_code=scan( all_county_weights,2,'"');
weight=scan( all_county_weights,2,':');
weight_1=scan( weight,1,',');
weight_2 = COMPRESS (weight_1,'}');
drop weight weight_1;
if zcta=1 then output p8_1b1;
else output p8_1b2;
run;
proc print data=pr8aa;
run;






/******************************http://120.126.135.53*************************/
/*不確定會有幾個weight和zip，先將所有中間分隔符號去到只剩下一種，再用scan來找要的值*/
/* 120.126.135.53 */
%let dirclass=D:\Dropbox\School\statpack\107fall;
%let filename=statpack107fp8.xlsx;
proc import 
	datafile="&dirclass\graduate\practice\&filename"
	out=p8_2 replace;
sheet='statpack107f4p8_2';
run;
proc import 
	datafile="&dirclass\graduate\practice\&filename"
	out=p8_1 replace;
sheet='statpack107fp8_1';
run;
data p8_1a;
set p8_1;
count=count(all_county_weights,':');
run;
proc freq data=p8_1a;
tables count; run;
data p8_1b1  p8_1b2;
set p8_1a;
array weight wt1-wt4;
array zp $ zip1-zip4;
temp=compress(all_county_weights,'{}""');
if temp^=' ' then do;
	do i=1 to (count);
		temp1=scan(temp,i,',');
		weight{i}=input(scan(temp1,2,':'),6.);
		zp{i}=scan(temp1,1,':');
	end;
end;
if zcta=1 then output p8_1b1;
else output p8_1b2;
run;
proc print data=p8_1b1 (obs=10);
run;
data p8_2a p8_2b;
set p8_2;
if county=0 then output p8_2a;
else output p8_2b;
run;
data p8_2b1;
set p8_2b;
county_name=scan(CTYNAME,1,' ');
run;
proc print data=p8_2b1 (obs=10);
run;
proc sort data=p8_1b1;
by state county_name;
proc sort data=p8_2b1;
by state1 county_name;
data p8_all;
length county_name $40.;
merge p8_1b1 (in=in1 rename=(state=state1)) 
	p8_2b1 (in=in2);
by state1 county_name;
if in1 & in2;
run;
data p8_2b1;
set p8_2b;
/*county_name=scan(CTYNAME,1,' ');*/
format county_name $20.;
county_name=tranwrd(CTYNAME,'County','');
county_index=index(CTYNAME,'County');
county_name1=substr(CTYNAME,1,county_index-1);
run;
proc print data=p8_2b1;
run;
proc sort data=p8_1b1;
by state county_name;
proc sort data=p8_2b1;
by state1 county_name;
data p8_all;
length county_name $40.;
merge p8_1b1 (in=in1 rename=(state=state1)) 
	p8_2b1 (in=in2);
by state1 county_name;
if in1 & in2;
run;
%let dirclass=D:\Dropbox\School\statpack\107fall;
%let hw7a=statpack107fhw7a.xls;
proc import 
	datafile="&dirclass\graduate\project\&hw7a"
	out=hw7a replace;
run;
data hw7a1;
set hw7a;
array q4 qq4_1-qq4_8;
do i=1 to 8;
	if q4_1=i or q4_2=i or q4_3=i then q4{i}=1;
end;
run;
data hw7a2;
set hw7a;
array qq4 qq4_1-qq4_8;
array q4 q4_1-q4_3;
do i=1 to 3;
	do j=1 to 8;
		if q4{i}=j then qq4{j}=1;
	end;
end;
run;
data hw7a3;
set hw7a;
array qq4 qq4_1-qq4_8;
array q4 q4_1-q4_3;
do j=1 to 8;
	qq4{j}=0;
end;
do i=1 to 3;
	if q4{i}^=0 then qq4{q4{i}}=1;
end;
/*do j=1 to 8;*/
/*	if qq4{j}=. then qq4{j}=0;*/
/*end;*/
run;
