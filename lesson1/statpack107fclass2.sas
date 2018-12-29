/* http://120.126.135.53 */
%let newd=D:\Dropbox\School\statpack\107fall\graduate\chapter1;
%let filen=statpack107ch1p1.txt;
data ch1p1;
infile "&newd\&filen" truncover;
input FFID $ 1-6
membertype $ 8-13
name $ 15-39
phonenumber $ 40-51
city $ 55-75
state $ 85-87
zipcode $ 88-92
milestraveled 100-104
pointsearned  110-114
pointused  120-124
address $ 127-145;
run;
data death;
	input trt mi count @@;
cards;
0 1 18 0 2 171 0 3 10845
1 1 5 1 2 99 1 3 10933
run;
data ch1d6;
infile "&newd\statpackch1d6.txt" 
	firstobs=40;
input FTP    UEMP     MAN     LIC      
	    GR    CLEAR     WM    NMAN     GOV     HE  
        WE    HOM      ACC     ASR ;
run;
data ch1d6a;
infile "&newd\statpackch1d6.txt" 
	firstobs=40;
input 
   #1 FTP 1-6   LIC  25-30    
   #2 WE 1-6   ACC 17-21;
run;
proc print; run;
data ch1d8;
infile "&newd\statpackch1d8.txt" missover;
input order_num $7-11
			cust_id $12-19
			amount 20-32
			region $ 33-41
			prepay 42-52
			emp_id $53-58
	@59 bill_date date9.
	@68 due_date date9.;
run;
proc print data=ch1d9; run;
libname ch1 "d:\";
data ch1.bmi;
set ch1d9;
run;
data ch1d9a;
set ch1.bmi;
run;
data ch1d6a;
set ch1d6;
label
FTP='Full-time police per 100,000 population'                                                                                        
UEMP='% unemployed in the population'                                                                                                 
MAN='number of manufacturing workers in thousands'                                                                               
LIC='Number of handgun licences per 100,000 population'                                                                             
GR='Number of handgun registrations per 100,000 population';
run;
proc print data=ch1d6a;
run;
proc print data=ch1d6a label;
run;
proc format;
value trtf
0='安慰劑'
1='阿斯匹靈';
value mif
1='死亡'
2='發作'
3='沒病';
run;
proc print data=death; run;
proc print data=death; 
format trt trtf. mi mif.;
run;
data death_1;
set death;
format trt trtf. mi mif.;
run;
proc format;
value $areacodef
'BR1'='Birmingham UK'
'BR2'='Plymoth UK'
'BR3'='York UK'
'BR5'='Incorrect code'
'US1'='Denver USA'
'US2'='Miami USA';
value salaryf
0-30000='三萬以下'
other='三萬以上';
run;
data ch1d10;
infile "&newd\statpackch1d10.txt";
input name $ 1-17  id $ 19-22
@24	salary  areacode $ 30-32
@34 hiredate date7.;
format hiredate date9. areacode $areacodef. 
	salary salaryf.;
run;
proc print data=ch1d10; run;


