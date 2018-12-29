proc format;
	value age
		0="5-6"
		1="8-9";
	value gender
		0="�k��"
		1="�k��";
run;
data quiz3;
infile "C:\Users\NTPU\Downloads\statpack107fp4.txt" firstobs=2 missover;
input 
	@2 age
	@7 gender
	@15 location
	@24 coherence
	@33 maturity
	@42 delay
	@48 quality
;
label
	age='�~�� '
	gender='�ʧO'
	location='�X���a�I'
	coherence='������'
	maturity='������'
	delay='���~�Ѽ�'
	quality='�~��'
;
format
	age age.
	gender gender.
;
run;
proc print data = quiz3 label;
run;

proc tabulate data = quiz3;
class age gender;
var maturity delay;
table
	age all="��ڤ��ʧO",
	gender*(maturity delay)*(n="�H��" mean="������" std="�зǮt")
	all="��ڤ��~��"*(maturity delay)*(n="�H��" mean="������" std="�зǮt")
;
run;

proc freq data = quiz3;
table age gender;
run;

proc means data=quiz3;
var coherence maturity;
run;

proc univariate data=quiz3 normal; /* normal: use shapiro-Wilk to test fit normal dist or not */
/*********************************
(shapiro-Wilk value between 0 to 1, close to 1=> fit normal)
�`�A���˩w 
�˩w �έp�� p �� 
Shapiro-Wilk W 0.986479 Pr < W 0.6735 
Kolmogorov-Smirnov D 0.046522 Pr > D >0.1500 
Cramer-von Mises W-Sq 0.02517 Pr > W-Sq >0.2500 
Anderson-Darling A-Sq 0.197304 Pr > A-Sq >0.2500 
*********************************/
var quality;
histogram quality/normal;
probplot quality; /* y axis = empirical distribution, x axis = normalize; we can use it to tell the sample fit normal distribution or not. */
run;

data p4a (drop=delay1);
set quiz3;
all=coherence+maturity;
sq_delay=delay1**(1/2);
run;

proc print data=p4a;
run;

proc import
	datafile="C:\Users\NTPU\Downloads\statpackch4\statpackch4d1.xlsx"
	out=ch4d1 replace;
	dbdsopts="obs=60";
run;

proc print data=ch4d1;
run;

proc contents data=ch4d1;
run;

data ch4d1a;
set ch4d1;
sbp1=mean(of u1sbp u3sbp u5sbp u7sbp u9sbp u11sbp);
sbp2=(u1sbp+u3sbp+u5sbp+u7sbp+u9sbp+u11sbp)/6;
run;

proc print data=ch4d1a;
var u1sbp u3sbp u5sbp u7sbp u9sbp u11sbp sbp1 sbp2;
run;

data ch4d1b;
set ch4d1a;

if U1SBP=. OR U3SBP=. OR U5SBP=. OR U7SBP=. OR U9SBP=. OR U11SBP=.  then delete; 

if u1sbp<140 then du1sbp=0;
else du1sbp=1;

if u1sbp<140 then du1sbp=0;
else if u1sbp>=140 then du1sbp=1;

format s_u1sbp $10.;

if 0<u1sbp<120 & 0<u1dbp<80 then s_u1sbp="�������`";
else if 120<u1sbp<140 & 80<u1dbp<90 then s_u1sbp="�������e��";
else s_u1sbp="������";

run;

proc print data=ch4d1b;
var u1sbp u1dbp s_u1sbp;
run;

data ch4d1c;
set ch4d1b;
array mysbp u1sbp u3sbp u5sbp u7sbp u9sbp u11sbp;
format status1-status6 $10.;
array myssbp $ status1-status6;

array mydbp u1dbp u3dbp u5dbp u7dbp u9dbp u11dbp;
format status_bp1-status_bp6 $10.;
array mysdbp $ status_bp1-status_bp6;

do i = 1 to 6;
	if 0<mysbp{i}<140 then myssbp{i}="���`";
	else if mysbp{i}>=140 then myssbp{i}="���`";
end;

do i = 1 to 6;
	if 0<mysbp{i}<120 & 0<mydbp{i}<80 then mysdbp{i}="�������`";
	else if 120<mysbp{i}<140 & 80<mydbp{i}<90 then mysdbp{i}="�������e��";
	else mysdbp{i}="���`";
end;

run;

proc print data=ch4d1c;
var u1sbp u3sbp u5sbp u7sbp u9sbp u11sbp status1-status6 u1dbp u3dbp u5dbp u7dbp u9dbp u11dbp status_bp1-status_bp6 i;
run;

data ch4d1d;
set ch4d1c;

if sex='F' then
	do;
		if 0<u1hr<75 then du1hr=0;
		else du1hr=1;

		if 0<u3hr<75 then du3hr=0;
		else du3hr=1;
	end;
else if sex='M' then
	do;
		if 0<u1hr<70 then du1hr=0;
		else du1hr=1;

		if 0<u3hr<70 then du3hr=0;
		else du3hr=1;
	end;
run;

proc print data=ch4d1d;
var u1hr du1hr u3hr du3hr;
run;
