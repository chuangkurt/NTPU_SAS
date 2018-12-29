
proc format;
value groupF
1='�����'
2='�K���K�[��';
value yesnoF
0='�S��'
1='��';
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
		id='�s��'
		anemia='���g�h��'
		pregnancy='���g�h��'
		pregnancy_week='�h���P��'
		serum='��M�K�J�էt�q'
		group='�էO'
	;
run;

proc print data=HW4_1 label;
run;

PROC TABULATE data=HW4_1;
CLASS group pregnancy_week ;
var serum;
table group,pregnancy_week*serum*(n='�H��' mean='������'  stddev='�зǮt' MEDIAN='�����')
all*serum*(n='�H��' mean='������'  stddev='�зǮt'MEDIAN='�����')
;
run;

PROC TABULATE data=HW4_1;
CLASS group anemia pregnancy_week ;
var serum;
table group,anemia*pregnancy_week*serum*(n='�H��' mean='������'  stddev='�зǮt' MEDIAN='�����')
all*serum*(n='�H��' mean='������'  stddev='�зǮt'MEDIAN='�����')
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
