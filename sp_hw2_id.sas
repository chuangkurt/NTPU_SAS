
proc format;
value $CITYF
'A'='北京'
'B'='上海'
'C'='瀋陽'
'D'='南京'
'E'='哈爾濱'
'F'='鄭州'
'G'='太原'
'H'='蘭州';
value SMOKEF
0='沒有'
1='有';
value LUNG_CANCERF
0='沒有'
1='有';
run;
proc import 
datafile="C:\Users\kurt chuang\Desktop\SAS\lesson2\statpack107fhw2_3.csv"
out=HW2_3
dbms=CSV REPLACE; 
getnames=no;
run;
data HW2_3;
	set HW2_3;
format
		VAR1 $CITYF.
		VAR2 SMOKEF.
		VAR3 LUNG_CANCERF.
	;
label
		VAR1='城市'
		VAR2='吸菸情況'
		VAR3='肺癌狀況'
		VAR4='人數'
	;
run;
proc print data=HW2_3 label;
run;
