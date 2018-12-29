proc format;
value $sexf
'M'='�k��'
'F'='�k��';
value grbedf
0='�S��'
1='��';
value phsf
0='�S��'
1='��';
run;

data practice2;

infile"C:\Users\NTPU\Downloads\statpack107fp2.txt" truncover;
input
@1 id $
@5 sex $
@8 excamdata mmddyy10.
@20 s0sbp 
@25 s0dbp
@30 grbed
@32 phs
@35 drugs $
;
format
	sex $sexf.
	grbed grbedf.
	phs phsf.
	excamdata date10.
	;
label
id='�s��'
sex='�ʧO'
 excamdata='�ˬd���'
s0sbp ='���Y��'
s0dbp='�αi��'
grbed='����_��'
phs='�e�f���A'
drugs ='�Ī�';
run;

proc print data=practice2 label;
run;
/*�̷ӯe�f���A�A�ʧO�Ƨ� �Adescending�O�N��ƤϧǱƦC*/
proc sort data=practice2 ;
by phs sex descending s0sbp ;
proc print data=practice2 label;
run;
/*�̷�var id sex s0sbp grbed phs �Ӥ��O�C�L�X��*/
proc sort data=practice2 ;
by  excamdata;
proc print data=practice2 label;
by  excamdata;
var id sex s0sbp grbed phs;
run;


/* �W�U�ۦP */

%let dirp=d:\dropbox\school\statpack\107fall\graduate;
data p2;
infile "&dirp\chapter1\statpack107fp2.txt" truncover;
input @1 id $  @5 sex $ @8 examdate mmddyy10. 
	@20 s0sbp	@25 s0dbp @30 grbed @32 phs 
	@35 drugs $;
label
id='�s��'
sex='�ʧO'
examdate='�ˬd���'
s0sbp='���Y��'
s0dbp='�αi��'
grbed='����_��' 
phs='���A'
drugs='����';
run;
proc format;
value $sexf
'M'='�k'
'F'='�k';
value yesnof
0='�S��'
1='��';
run;
data p2a;
set p2;
format sex $sexf. grbed phs yesnof. examdate date10.;
run;
proc print data=p2a label; run;

/* nodupkey �u�O�d�Ƨǫ�Ĥ@�����*/
/*nodup�R���@�����Ƹ��*/

data ch2d1;

infile"C:\Users\NTPU\Downloads\statpackch2\statpackch2d1.dat" truncover;
input 
Company $1-22
Debt 28-34
AccountNumber 37-40
Town $43-55
;
run;
proc print data=ch2d1; run;
proc sort data=ch2d1 out=ch2d1a nodupkey;
by town;
proc print data=ch2d1a;
run;
proc sort data=ch2d1 out=ch2d1a nodup;
by _all_;
proc print data=ch2d1a;
run;
/*��debt���ȥ[�_��*/
proc sort data=ch2d1 ;
by town;
proc print data=ch2d1 noobs n='�H��= ' '�`�H��= ';
by town;
pageby town;
sum debt;
var Company Debt  AccountNumber  ;
run;

/**/

PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpackch2\statpackch2d3.xlsx"
/* replace �O�p�G�̭����@�˦W�٪���ƥi�H�N�L�Ƽg*/
out=ch2d3 replace;
/*�Ĥ@�C�O���O�ܼƦW�١A�n���nŪ�Ĥ@�C�����*/
getnames=yes;
/*Ūxlsx��d3�����*/
sheet='d3';
/*�p�G��Ƥ����i�঳�ƭȩΦr���*/
mixed=no;
run;
proc print data=ch2d3 ;
run;

/*�NSAS���B�z�n����ƿ�X*/
PROC export
DATA=ch2d3
outfile="C:\Users\NTPU\Downloads\statpackch2\temp.xlsx" replace;
sheet='text';
run;
proc print data=ch2d3 ;
run;

/*�w���Φ���X*/
/*(*n rowpctn='%')�H�ʤ���Φ���X*/
/*all �|�������*/
PROC TABULATE  data=practice2;
class sex phs;
table sex, phs*(n rowpctn='%') all*(n pctn='%')  ;
run;

PROC TABULATE  data=practice2;
class sex phs;
var s0sbp;
table sex, phs*s0sbp*(n mean='������')  ;
run;

/*�P�ܼƤ@�w�n�O���O�ܼơA���ܼ�(var)�@�w�n�O�s�򫬪�*/
/*�P�ܼ�,��*���R*/
PROC sort data=practice2;
by grbed;
PROC TABULATE  data=practice2;
class sex phs;
var s0sbp s0dbp;
table sex, phs*(s0sbp*(n mean='������')
s0dbp*(n mean='������' std='�зǮt'))
all*s0sbp*(n mean='������')
;
run;
