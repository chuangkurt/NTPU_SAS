data hw2;
infile "C:\Users\kurt chuang\Desktop\SAS\lesson1\statpack107fhw1_2.dat";
input id $  State $   Postal $   Balance  Score  Class $  Credit  Loan  $ ;
run;
proc print data=hw2;
run;
