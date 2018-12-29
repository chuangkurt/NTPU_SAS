/*mistatus1是要寫進去的資料庫名稱*/
/* drug  $ status count  是三個欄位，$是將數值改為字串格式*/
data mistatus1;

input drug  $ 1-1 status 3-3  count 5-9 ;
cards;
P 1 18
P 2 171
P 3 10845
A 1 5
A 2 99
A 3 10933
run;
/*正常來說會在檔案縱管的資料庫裡面可以看到表格，但是proc print data=mistatus1指令可以直接印出來*/

proc print data=mistatus1;run;

/*在檢視，程式編輯器中，左上方打number出來的編輯器在數字裡面打cols可以用出尺度表格，可以讓資料對齊*/
/*日期格式 @8的意思是從第八格開始，mmddyy10. **一定要對齊*/

data bank;
input id @8 tdata mmddyy10. amount;
cards;
124325 08/11/2003 1250.03                                                                                                               
     7 08/11/2003 12500.02                                                                                                              
114565 08/11/2003 5.11                                                                                                                  
run;
/*希望原始資料呈現的格式，用format 將 mmddyy10.轉變成我們要的格式， **一定要對齊*/
proc print data=bank;
format tdata yymmdd10.;
run;

/*infile把資料輸入*/

data mistatus3;
infile "C:\Users\NTPU\Downloads\SAS01\statpackch1\statpackch1d1.DAT";
input drug  status  count  ;
run;
proc print data=mistatus3;run;


data ch1d5;
infile "C:\Users\NTPU\Downloads\SAS01\statpackch1\statpackch1d5.DAT";
delimiter=', ';
input id $ grade1 grade2 grade3 grade4 ;
run;
proc print data=ch1d5;run;
