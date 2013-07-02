function [yend,sqrtr] = plot2ipmov(alpha,tprime,phi)
%Generate displacement for 2 inflection point solution
% Alpha, tprime and phi are in degrees
%Here phi is an array, alpha is the critical angle and tprime is the
%previously calculated value of the inflection point

    converto=pi/180;
    alpha=alpha*converto;
    tprime=tprime*converto;
    phi=phi*converto;
    %hold off
    yend=[];
    sqrtr=[];
for i=1:length(phi)
    xw=[0];
    yw=[0];
    theta1=linspace(alpha,tprime(i));
    theta2=linspace(tprime(i),2*phi(i)-tprime(i));
    theta3=linspace(2*phi(i)-tprime(i),0);
    w=quadgk(@(theta) fn2ip(theta,tprime(i),phi(i)),alpha,tprime(i))-quadgk(@(theta) fn2ip(theta,tprime(i),phi(i)),tprime(i),2*phi(i)-tprime(i))...
        +quadgk(@(theta) fn2ip(theta,tprime(i),phi(i)), 2*phi(i)-tprime(i),0);
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
    for j=2:length(theta3)
        xwplus=quadgk(@(theta)fn2ip(theta,tprime(i),phi(i)),theta3(j-1),theta3(j));
        ywplus=quadgk(@(theta)fn3ip(theta,tprime(i), phi(i)),theta3(j-1),theta3(j));
        xw=[xw xw(end)+xwplus];
        yw=[yw yw(end)+ywplus];    
    end;
    %scale it
    xw=xw/w;
    yw=yw/w;
    %plot(xw,yw);
    %hold on
    %plot(xw(length(theta1)),yw(length(theta1)),'ro')
    %plot(xw(length(theta1)+length(theta2)-1),yw(length(theta1)+length(theta2)-1),'mo')
    yend(i)=yw(end);%
    sqrtr(i)=w;%save w so we can normalize with it later
end;
end

