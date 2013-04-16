function dxdtheta = fn2ip(theta,tprime,phi)
dxdtheta=cos(theta)./sqrt(cos(theta-phi)-cos(tprime-phi)+eps);