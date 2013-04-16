function myquotient = myeps(alpha,beta)
%Use fzero with this, with respect to alpha to find the smallest value for alpha having a
%no-inflection-point compressive solution.
alpha=alpha*pi/180;
B=-cos(alpha)+eps;
myquotient=quadgk(@(theta) fn1(theta,B),alpha,0)/quadgk(@(theta) fn2(theta,B),alpha,0) - beta;