data ch1p1;
infile "C:\Users\NTPU\Downloads\statpack107ch1p1.TXT";
input 
FFID $ 1-6 
MEMBERTYPE $ 8-13 
NAME $ 15-39 
PHONENUMBER $ 40-51
CITY $55-75 
STATE $85-87 
ZIPCODE $88-92 
MILESTRAVELED 100-104 
POINTSEARNED 110-114
POINTUSED 120-124 
ADDRESS $127-145;
run;
proc print data=ch1p1;
run;



/*用%let可以免去每次要重新去程式碼中改設定*/

%let newd=C:\Users\NTPU\Downloads;
%let filen=statpack107fch1p1.txt;
data ch1p1;

/*若資料的最後一筆字元長短不一，他會吃到設定的所有欄位所以需要用TRUNCOVER */
infile "&newd\&filen" TRUNCOVER ;
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
proc print data=ch1p1;
run;


/*幾個變數後接@@ ，表示幾個變數後要換行*/
data death;
input trt mi count @@;
cards;
0 1 18 0 2 171 0 3 10845
1 1 5 1 2 99 1 3 10933
run;
proc print data= death;
run;

/*firstobs代表從第40列開始讀資料*/

%let newd=C:\Users\NTPU\Downloads\statpackch1;
data ch1d6;
infile "&newd\statpackch1d6.txt"
	firstobs=40;
	input  FTP    UEMP     MAN     LIC      GR    CLEAR     WM    NMAN     GOV     HE    WE    HOM      ACC     ASR  ;
	run;
proc print data= ch1d6;
run;

/*#1表示只取這幾個變數，否則會變成...*/

%let newd=C:\Users\NTPU\Downloads\statpackch1;
data ch1d6;
infile "&newd\statpackch1d6.txt"
	firstobs=40;
	input  #1 FTP 1-6   LIC 25-30
			  #2 WE 1-6   ACC 17-21 ;
	run;
proc print data= ch1d6;
run;

/*missover避免數值變數因為資料遺失往下，自動補上.往下一筆*/

%let newd=C:\Users\NTPU\Downloads\statpackch1;
data ch1d8;
infile "&newd\statpackch1d8.txt" missover ;
	input 
Order_num $7-11
Cust_id  $12-19
Amount  20-32 
region $33-41 
prepay 42-52 
Emp_id  $53-58 
@59 Bill_date  date9.
@68 Due_date date9.  ;
	run;
proc print data= ch1d8;
run;


proc print data= ch1d9;
run;

/*所跑的資料都暫時存在檔案總管的work中*/
/*如果要永久存在資料館如下*/

libname ch1"d:\";
data ch1.bmi;
set ch1d9;
run;


/*label把變數的名稱改變成為標籤*/

data ch1d6;
set ch1d6;
label
FTP = 'Full-time police per 100,000 population'
UEMP = '% unemployed in the population'
MAN  = 'number of manufacturing workers in thousands'
LIC  = 'Number of handgun licences per 100,000 population'
GR   =' Number of handgun registrations per 100,000 population'
CLEAR = '% homicides cleared by arrests'
WM   =' Number of white males in the population';

run;


proc print data= ch1d6;
run;

/*下面部分沒有跟上*/
proc format;
value trtf
0='安慰劑'
1='阿斯匹寧';
value mif
1='死亡'
2='心肌梗塞'
3='沒病';
run;
proc print data= death;run;
proc print data= death;
format trt trtf. mi mif.;
run;

proc format

data ch1d10;
infile "C:\Users\NTPU\Downloads\statpackch1\statpackch1d10.txt";
input name $ 1-17
		id $ 19-22
@24 salary
		areacode $ 30-32
@34 hiredate data7.;
run;
proc print data= ch1d10;
run;

