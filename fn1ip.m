function dsdtheta = fn1ip(theta,tprime,phi)
dsdtheta=1./sqrt(cos(theta-phi)-cos(tprime-phi)+eps);