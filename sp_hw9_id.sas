PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lessson9\statpack107fhw9a.csv"
out=HW9a replace;
getnames=yes;
run;
PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lessson9\statpack107fhw9b.csv"
out=HW9b replace;
getnames=yes;
run;
PROC IMPORT
DATAFILE="C:\Users\kurt chuang\Desktop\SAS\lessson9\statpack107fhw9c.csv"
out=HW9c replace;
getnames=yes;
run;
proc sort 
data=HW9b
out=HW9sb;
by id;
run;
proc sort 
data=HW9c
out=HW9sc;
by id;
run;
data mgbc;
merge HW9sb HW9sc;
by id;
data mgbca;
set mgbc;
array ans  A1-A50;
if A1=' '  then attend=1;
else attend=0;
run;
proc freq data=mgbca;
table attend;
run;
data mgbc_1 mgbc_2;
set mgbca;
if attend=1 then output mgbc_1;
else output mgbc_2;
run;
data solA;
set HW9a;
rename A1-A50= nA1-nA50;
if Q='A' then id=000;
else  id=001;
run;
proc sort 
data= mgbc_2
out= mgbc_s2;
by group;
run;
data mgabc;
merge solA( rename=(Q=group))  mgbc_s2;
by group;
run;

data mgabc_1;
set mgabc;
array ans A1-A50;
array nans nA1-nA50;
array cns C1-C50;
	do i=1 to 50;
		if ans{i}=nans{i} then cns{i}=1;
	else cns{i}=0;
	end;
	total=sum(of C1-C50);
if group='A' then A_1=sum(of C1,C2, C3,C7);
if group='A' then A_2=sum(of C4, C5,C6,C8,C9, C12, C15,C16);
if group='A' then A_3=sum(of C10, C11, C13, C14, C17, C18, C30);
if group='A' then A_4=sum(of C19, C20, C25, C26, C27, C28, C39);
if group='A' then A_5=sum(of C21, C22, C23, C24, C31, C32, C36, C37, C38);
if group='A' then A_6=sum(of C33, C34, C35, C40, C41, C42, C44, C45);
if group='A' then A_7=sum(of C29,C43, C46, C47, C48, C50);
if group='A' then A_8=sum(of C49);
if group='B' then A_1=sum(of C1, C11, C16, C32);
if group='B' then A_2=sum(of C15, C23, C24, C25, C26, C35, C39, C45);
if group='B' then A_3=sum(of  C10, C19, C28, C31, C37, C44, C46);
if group='B' then A_4=sum(of C2,C9, C13, C30, C34, C40,C48);
if group='B' then A_5=sum(of C5, C6, C7, C8, C20,C29, C36, C43, C47);
if group='B' then A_6=sum(of C3, C12,C21, C22, C33, C38, C41,C50);
if group='B' then A_7=sum(of C14, C17, C18, C27, C42, C49);
if group='B' then A_8=sum(of C4);
drop A1-A50 nA1-nA50;
run;
data mgabc_2;
set mgabc_1;
array chA A_1-A_8;
array chB B_1-B_8;
array cns C1-C50;
array chD D_1-D_8;
D_1=A_1/4;
D_2=A_2/8;
D_3=A_3/7;
D_4=A_4/7;
D_5=A_5/9;
D_6=A_6/8;
D_7=A_7/6;
D_8=A_8/1;
do i=1 to 8;
	chB{i}=chA{i}*2;
end;
ansrate=total/50;
total=total*2;
drop C1-C50 attend;
run;
proc means data= mgabc_2;
run;

data groupA groupB;
set mgabc_2;
if group='A' then output groupA;
else output groupB;
run;
proc means data= groupA;
run;
proc means data= groupB;
run;





