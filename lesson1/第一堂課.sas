/*mistatus1�O�n�g�i�h����Ʈw�W��*/
/* drug  $ status count  �O�T�����A$�O�N�ƭȧאּ�r��榡*/
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
/*���`�ӻ��|�b�ɮ��a�ު���Ʈw�̭��i�H�ݨ���A���Oproc print data=mistatus1���O�i�H�����L�X��*/

proc print data=mistatus1;run;

/*�b�˵��A�{���s�边���A���W�襴number�X�Ӫ��s�边�b�Ʀr�̭���cols�i�H�ΥX�ثת��A�i�H����ƹ��*/
/*����榡 @8���N��O�q�ĤK��}�l�Ammddyy10. **�@�w�n���*/

data bank;
input id @8 tdata mmddyy10. amount;
cards;
124325 08/11/2003 1250.03                                                                                                               
     7 08/11/2003 12500.02                                                                                                              
114565 08/11/2003 5.11                                                                                                                  
run;
/*�Ʊ��l��Ƨe�{���榡�A��format �N mmddyy10.���ܦ��ڭ̭n���榡�A **�@�w�n���*/
proc print data=bank;
format tdata yymmdd10.;
run;

/*infile���ƿ�J*/

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
