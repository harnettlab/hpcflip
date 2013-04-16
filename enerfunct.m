function du = enerfunct(theta,tprime,phi)
%all angles must be in radians
   du=sqrt(cos(theta-phi)-cos(tprime-phi));