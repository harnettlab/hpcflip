function [yend,sqrtr] = plot1ipmov(alpha,tprime,phi)
%Generate x/w and y/w vectors for single inflection point solution
% Alpha, tprime and phi are in degrees
%Here phi is an array, alpha is the critical angle and tprime is the
%previously calculated value of the inflection point

    converto=pi/180;
    alpha=alpha*converto;
    tprime=tprime*converto;
    phi=phi*converto;
    yend=[];
sqrtr=[];
for i=1:length(phi)
    xw=[0];
    yw=[0];
    theta1=linspace(alpha,tprime(i));
    theta2=linspace(tprime(i),0);
    w=quadgk(@(theta) fn2ip(theta,tprime(i),phi(i)),alpha,tprime(i))-quadgk(@(theta) fn2ip(theta,tprime(i),phi(i)),tprime(i),0);
    for j=2:length(theta1)
        xwplus=quadgk(@(theta)fn2ip(theta,tprime(i),phi(i)),theta1(j-1),theta1(j));
        ywplus=quadgk(@(theta)fn3ip(theta,tprime(i),phi(i)),theta1(j-1),theta1(j));
        xw=[xw xw(end)+xwplus];
        yw=[yw yw(end)+ywplus];
    end;
    for j=2:length(theta2)
        xwplus=-quadgk(@(theta)fn2ip(theta,tprime(i),phi(i)),theta2(j-1),theta2(j));
        ywplus=-quadgk(@(theta)fn3ip(theta,tprime(i), phi(i)),theta2(j-1),theta2(j));
        xw=[xw xw(end)+xwplus];
        yw=[yw yw(end)+ywplus];    
    end;
    %scale it
    xw=xw/w;
    yw=yw/w;
    %plot(xw,yw,'m');
    %hold on
    %plot(xw(length(theta1)),yw(length(theta1)),'ro')
    yend(i)=yw(end);
    sqrtr(i)=w; %save w to normalize with later
end;
end

