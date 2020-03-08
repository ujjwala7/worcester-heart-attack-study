data worcester;
infile "path" ;
input id age gender cpk chf ord time stat ;
run;

proc phreg data = worcester;
   model time*stat(0)= age gender cpk chf ord /ties=breslow;
run;

proc phreg data = worcester;
  model time*stat(0)= age  gender cpk chf ord /ties=efron;
run;
proc phreg data = worcester;
  model time*stat(0)= age  gender cpk chf ord /ties=exact;
run;
title"Exact : Reduced Model";
proc phreg data = worcester;
  model time*stat(0)= age cpk chf ord /ties=efron;
run;
title"Backward selection model";
proc phreg data = worcester;
model time*stat(0)= age  gender cpk chf ord / ties=efron selection=backward;
 run;

data null;
input age cpk chf ord;
datalines;
0 0 0 0				
;
run;

proc phreg data=worcester;
model time*stat(0)=age cpk chf ord/ties=efron;
baseline out=a covariates=null survival=s logsurv=ls lower=lcl upper=ucl
cumhaz=H lowercumhaz=lH uppercumhaz=uH;;
run;

proc print data=a;
run;

title"Baseline cumulative hazard functions";

proc gplot data=a; 
	title "Baseline Cumulative Hazard Function";
	plot H*time;
run;
