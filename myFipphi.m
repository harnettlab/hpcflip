function myquotient = myFipphi(tprime,alpha,beta,phi)
%solve for beta for one inflection point
alpha=alpha*pi/180;

if (tprime >= 2*phi-alpha)
    tprime = 2*phi-alpha;
end  

if (tprime <=-70*pi/180) %avoid a singularity around alpha-180
    tprime=-70*pi/180;
end

myquotient=quadgk(@(theta) fn1ip(theta,tprime,phi),alpha,tprime)-quadgk(@(theta) fn1ip(theta,tprime,phi),tprime,0);
myquotient=myquotient/(quadgk(@(theta) fn2ip(theta,tprime,phi),alpha,tprime)-quadgk(@(theta) fn2ip(theta,tprime,phi),tprime,0));
myquotient=(myquotient)-beta;
