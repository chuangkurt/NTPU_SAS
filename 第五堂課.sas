proc format;
VALUE ageF
0='5-6' 1='8-9' ;
VALUE GenderF
0='�k��' 1='�k��';
VALUE LocationF
1='��a' 2='�Ǯ�'  3='ĵ�' 4='�S��a�I'
 ;
run;
data pr4;
infile "C:\Users\NTPU\Downloads\statpack107fp4.txt"
firstobs=2 missover;
input 
Age 
Gender  
Location 
Coherence 
Maturity 
Delay  
Quality 
;
data pr4;
	set pr4;
	format
		age ageF.
		Gender	 GenderF.
		Location LocationF. 
	;
label
Age ='�~��'
Gender  ='�ʧO'
Location ='�X���a�I'
Coherence ='������'
Maturity ='������'
Delay  ='���~�Ѽ�'
Quality ='�~��'
;
proc print data=pr4 LABEL;
run;
PROC TABULATE data=pr4;
CLASS Age Gender   ;
var Maturity Delay;
table age,Gender*(Maturity Delay) *(n='�H��' mean='������'  stddev='�зǮt' )
all*(Maturity Delay) *(n='�H��' mean='������'  stddev='�зǮt')
;
run;
proc means data=pr4;
var Coherence  Maturity Delay  Quality ;
run;
/*�bch3b��*/
/*�p�G�n�ݸ�Ʀ��S���`�A�A�i�H��Shapiro-Wilk �ȷ|�b0��1�����A�V�a��1�N��V����`�A*/
proc univariate data=pr4 normal;
var Quality;
histogram quality/normal;
probplot quality;
run;
/*�H�U???????*/
data=pr4;
set pr4a;
all=Coherence+Maturity ;
sd_delay=delay**(1/2);
run;

proc import datafile="C:\Users\NTPU\Downloads\statpackch4\statpackch4d1.xlsx"
	out=ch4d1 replace;
	run;
	data ch4d1a;
	set ch4d1;
	sbp1=mean(of u1sbp u3sbp u5sbp u7sbp );
	run;
proc print data=ch4d1a;
run;
data ch4d1b;
set ch4d1a;
if chartno=2712558 then delete;
/*if chartno^=2712558      �W�U��ӳ��O�N�s��2712558��ƧR��*/
if 0<u1sbp<140 then du1sbp=0;
else du1xbp=1;
if 0<u1sbp<140 then du1sbp1=1;
/*format s_u1sbp $10   �ݭn�w�qs_u1sbp�̦h��10�Ӧ줸*/
format s_u1sbp $10;
if 0<u1sbp<120 & if 0<u1dbp<80
	then s_ulsbp='�������`';
else if 120<u1sbp<140 & if 80<u1dbp<90
	then s_ulsbp='�������e��';
	else s_ulsbp='������';
	run;
	proc print data=ch4d1b;
	var u1sbp u1dbp  s_ulsbp;
	run;
	data ch4d1c;
	set ch4d1b;
	array sbp u1sbp u3sbp u5sbp u7sbp u9sbp u11sbp;
	array dbp u1dbp u3dbp u5dbp u7dbp u9dbp u11dbp;
	format status1-status6 $10;
	array ssbp $ status1-status6;
	array bp $ status_bp1-status_bp6;
	/*�]�w�}�C*/
do i=1 to 6;
	if 0<sbp{i}<140 then ssbp{i}='���`';
		else if sbp{i}>=140 then ssbp{i}='���`';
	if 0<sbp{i}<120 & 0<dbp{i}<80 then bp{i}='�������`';
		else if 120<sbp{i}<140 & 80<dbp{i}<90 then bp{i}='�������e��';
	else bp{i}='������';
end;
run; 
	/**/
