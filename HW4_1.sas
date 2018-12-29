
proc format;
value groupF
1='北舱'
2='臟警睰';
value yesnoF
0='⊿Τ'
1='Τ';
run;
data HW4_1;
infile "C:\Users\kurt chuang\Desktop\SAS\lesson4\statpack107fhw4_1.dat"; 
input 
id
anemia
pregnancy
pregnancy_week
serum
group
;
format
anemia pregnancy yesnoF.
group  groupF.
;
label
		id='絪腹'
		anemia='纯竒砲﹀'
		pregnancy='纯竒胔ゥ'
		pregnancy_week='胔ゥ㏄Ω'
		serum='﹀睲臟矹フ秖'
		group='舱'
	;
run;

proc print data=HW4_1 label;
run;

PROC TABULATE data=HW4_1;
CLASS group pregnancy_week ;
var serum;
table group,pregnancy_week*serum*(n='计' mean='キА计'  stddev='夹非畉' MEDIAN='い计')
all*serum*(n='计' mean='キА计'  stddev='夹非畉'MEDIAN='い计')
;
run;

PROC TABULATE data=HW4_1;
CLASS group anemia pregnancy_week ;
var serum;
table group,anemia*pregnancy_week*serum*(n='计' mean='キА计'  stddev='夹非畉' MEDIAN='い计')
all*serum*(n='计' mean='キА计'  stddev='夹非畉'MEDIAN='い计')
;
run;
PROC MEANS data=HW4_1 MAXDEC=2 MIN MEDIAN MAX MEAN STD ;
CLASS anemia pregnancy group;
VAR  pregnancy_week serum ;
RUN;
PROC SORT data=HW4_1 out=HW4_1a nodupkey; 
by id;
proc print data=HW4_1a LABEL;
run;
proc export
data=HW4_1a
outfile='C:\Users\kurt chuang\Desktop\SAS\lesson4\HW4_1a.dat'
dbms=dlm replace;
delimiter=' ';
run;
