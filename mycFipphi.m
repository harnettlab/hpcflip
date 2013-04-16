function myquotient = mycFipphi(tprime,alpha,beta,phi)
%solve for beta for one inflection point, where the angle tprime at the inflection point is
%greater than alpha
alpha=alpha*pi/180;

if (tprime < alpha)
    tprime = alpha;
end  



myquotient=quadgk(@(theta) fn1ip(theta,tprime,phi),alpha,tprime)-quadgk(@(theta) fn1ip(theta,tprime,phi),tprime,0);
myquotient=myquotient/(quadgk(@(theta) fn2ip(theta,tprime,phi),alpha,tprime)-quadgk(@(theta) fn2ip(theta,tprime,phi),tprime,0));
myquotient=(myquotient)-beta;
