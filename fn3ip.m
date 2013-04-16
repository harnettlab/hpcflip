function dydtheta = fn3ip(theta,tprime,phi)
dydtheta=sin(theta)./sqrt(cos(theta-phi)-cos(tprime-phi)+eps);