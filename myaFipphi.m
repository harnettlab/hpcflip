function myquotient = myaFipphi(tprime,alpha,beta,phi)
%solve for beta for two inflection point
alpha=alpha*pi/180;

%if (tprime <= alpha) %In case fzero is running this
%    tprime = alpha;
%end  
if (2*phi-tprime)>0 %in case fzero is running it --works better
    tprime=2*phi;
end;

myquotient=quadgk(@(theta) fn1ip(theta,tprime,phi),alpha,tprime)-quadgk(@(theta) fn1ip(theta,tprime,phi),tprime,2*phi-tprime)...
    +quadgk(@(theta) fn1ip(theta,tprime,phi),2*phi-tprime,0);
myquotient=myquotient/(quadgk(@(theta) fn2ip(theta,tprime,phi),alpha,tprime)-quadgk(@(theta) fn2ip(theta,tprime,phi),tprime,2*phi-tprime)...
    +quadgk(@(theta) fn2ip(theta,tprime,phi),2*phi-tprime,0)+eps);
myquotient=abs(myquotient)-beta;
