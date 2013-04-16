function dxdtheta = fn2(theta,B)
dxdtheta=cos(theta)./sqrt(B+cos(theta));