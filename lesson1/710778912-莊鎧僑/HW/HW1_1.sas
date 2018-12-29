data hw1;

input drug  $  gender $  symptom $ count ;
cards;
N F IP 16                                                                                                                                
N F SA 11                                                                                                                                
N M IP 12                                                                                                                                
N M SA 16                                                                                                                                
P F IP 5                                                                                                                                 
P F SA 20                                                                                                                                
P M IP 7                                                                                                                                 
P M SA 19 
run;
proc print data=hw1;run;
