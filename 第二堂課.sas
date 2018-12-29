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



/*��%let�i�H�K�h�C���n���s�h�{���X����]�w*/

%let newd=C:\Users\NTPU\Downloads;
%let filen=statpack107fch1p1.txt;
data ch1p1;

/*�Y��ƪ��̫�@���r�����u���@�A�L�|�Y��]�w���Ҧ����ҥH�ݭn��TRUNCOVER */
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


/*�X���ܼƫᱵ@@ �A��ܴX���ܼƫ�n����*/
data death;
input trt mi count @@;
cards;
0 1 18 0 2 171 0 3 10845
1 1 5 1 2 99 1 3 10933
run;
proc print data= death;
run;

/*firstobs�N��q��40�C�}�lŪ���*/

%let newd=C:\Users\NTPU\Downloads\statpackch1;
data ch1d6;
infile "&newd\statpackch1d6.txt"
	firstobs=40;
	input  FTP    UEMP     MAN     LIC      GR    CLEAR     WM    NMAN     GOV     HE    WE    HOM      ACC     ASR  ;
	run;
proc print data= ch1d6;
run;

/*#1��ܥu���o�X���ܼơA�_�h�|�ܦ�...*/

%let newd=C:\Users\NTPU\Downloads\statpackch1;
data ch1d6;
infile "&newd\statpackch1d6.txt"
	firstobs=40;
	input  #1 FTP 1-6   LIC 25-30
			  #2 WE 1-6   ACC 17-21 ;
	run;
proc print data= ch1d6;
run;

/*missover�קK�ƭ��ܼƦ]����ƿ򥢩��U�A�۰ʸɤW.���U�@��*/

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

/*�Ҷ]����Ƴ��Ȯɦs�b�ɮ��`�ު�work��*/
/*�p�G�n�ä[�s�b����]�p�U*/

libname ch1"d:\";
data ch1.bmi;
set ch1d9;
run;


/*label���ܼƪ��W�٧��ܦ�������*/

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

/*�U�������S����W*/
proc format;
value trtf
0='�w����'
1='�����ǹ�';
value mif
1='���`'
2='�ߦٱ��'
3='�S�f';
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

