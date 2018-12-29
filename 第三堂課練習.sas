proc format;
value $sexf
'M'='男性'
'F'='女性';
value grbedf
0='沒有'
1='有';
value phsf
0='沒有'
1='有';
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
id='編號'
sex='性別'
 excamdata='檢查日期'
s0sbp ='收縮壓'
s0dbp='舒張壓'
grbed='床邊復健'
phs='疾病狀態'
drugs ='藥物';
run;

proc print data=practice2 label;
run;
/*依照疾病狀態，性別排序 ，descending是將資料反序排列*/
proc sort data=practice2 ;
by phs sex descending s0sbp ;
proc print data=practice2 label;
run;
/*依照var id sex s0sbp grbed phs 來分別列印出來*/
proc sort data=practice2 ;
by  excamdata;
proc print data=practice2 label;
by  excamdata;
var id sex s0sbp grbed phs;
run;


/* 上下相同 */

%let dirp=d:\dropbox\school\statpack\107fall\graduate;
data p2;
infile "&dirp\chapter1\statpack107fp2.txt" truncover;
input @1 id $  @5 sex $ @8 examdate mmddyy10. 
	@20 s0sbp	@25 s0dbp @30 grbed @32 phs 
	@35 drugs $;
label
id='編號'
sex='性別'
examdate='檢查日期'
s0sbp='收縮壓'
s0dbp='舒張壓'
grbed='床邊復健' 
phs='狀態'
drugs='用藥';
run;
proc format;
value $sexf
'M'='男'
'F'='女';
value yesnof
0='沒有'
1='有';
run;
data p2a;
set p2;
format sex $sexf. grbed phs yesnof. examdate date10.;
run;
proc print data=p2a label; run;

/* nodupkey 只保留排序後第一筆資料*/
/*nodup刪除一筆重複資料*/

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
/*把debt的值加起來*/
proc sort data=ch2d1 ;
by town;
proc print data=ch2d1 noobs n='人數= ' '總人數= ';
by town;
pageby town;
sum debt;
var Company Debt  AccountNumber  ;
run;

/**/

PROC IMPORT
DATAFILE="C:\Users\NTPU\Downloads\statpackch2\statpackch2d3.xlsx"
/* replace 是如果裡面有一樣名稱的資料可以將他複寫*/
out=ch2d3 replace;
/*第一列是不是變數名稱，要不要讀第一列的資料*/
getnames=yes;
/*讀xlsx中d3的表單*/
sheet='d3';
/*如果資料中有可能有數值或字串時*/
mixed=no;
run;
proc print data=ch2d3 ;
run;

/*將SAS中處理好的資料輸出*/
PROC export
DATA=ch2d3
outfile="C:\Users\NTPU\Downloads\statpackch2\temp.xlsx" replace;
sheet='text';
run;
proc print data=ch2d3 ;
run;

/*已表格形式輸出*/
/*(*n rowpctn='%')以百分比形式輸出*/
/*all 會產生邊際*/
PROC TABULATE  data=practice2;
class sex phs;
table sex, phs*(n rowpctn='%') all*(n pctn='%')  ;
run;

PROC TABULATE  data=practice2;
class sex phs;
var s0sbp;
table sex, phs*s0sbp*(n mean='平均值')  ;
run;

/*烈變數一定要是類別變數，欄變數(var)一定要是連續型的*/
/*烈變數,行*分析*/
PROC sort data=practice2;
by grbed;
PROC TABULATE  data=practice2;
class sex phs;
var s0sbp s0dbp;
table sex, phs*(s0sbp*(n mean='平均值')
s0dbp*(n mean='平均值' std='標準差'))
all*s0sbp*(n mean='平均值')
;
run;
