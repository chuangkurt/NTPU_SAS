proc format;
VALUE ageF
0='5-6' 1='8-9' ;
VALUE GenderF
0='女童' 1='男童';
VALUE LocationF
1='住家' 2='學校'  3='警察局' 4='特殊地點'
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
Age ='年齡'
Gender  ='性別'
Location ='訪視地點'
Coherence ='相關性'
Maturity ='成熟度'
Delay  ='延誤天數'
Quality ='品質'
;
proc print data=pr4 LABEL;
run;
PROC TABULATE data=pr4;
CLASS Age Gender   ;
var Maturity Delay;
table age,Gender*(Maturity Delay) *(n='人數' mean='平均數'  stddev='標準差' )
all*(Maturity Delay) *(n='人數' mean='平均數'  stddev='標準差')
;
run;
proc means data=pr4;
var Coherence  Maturity Delay  Quality ;
run;
/*在ch3b中*/
/*如果要看資料有沒有常態，可以看Shapiro-Wilk 值會在0到1之間，越靠近1代表越接近常態*/
proc univariate data=pr4 normal;
var Quality;
histogram quality/normal;
probplot quality;
run;
/*以下???????*/
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
/*if chartno^=2712558      上下兩個都是將編號2712558資料刪除*/
if 0<u1sbp<140 then du1sbp=0;
else du1xbp=1;
if 0<u1sbp<140 then du1sbp1=1;
/*format s_u1sbp $10   需要定義s_u1sbp最多有10個位元*/
format s_u1sbp $10;
if 0<u1sbp<120 & if 0<u1dbp<80
	then s_ulsbp='血壓正常';
else if 120<u1sbp<140 & if 80<u1dbp<90
	then s_ulsbp='高血壓前期';
	else s_ulsbp='高血壓';
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
	/*設定陣列*/
do i=1 to 6;
	if 0<sbp{i}<140 then ssbp{i}='正常';
		else if sbp{i}>=140 then ssbp{i}='異常';
	if 0<sbp{i}<120 & 0<dbp{i}<80 then bp{i}='血壓正常';
		else if 120<sbp{i}<140 & 80<dbp{i}<90 then bp{i}='高血壓前期';
	else bp{i}='高血壓';
end;
run; 
	/**/
