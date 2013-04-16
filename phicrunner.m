function [phiarray3,movingthetarray3,phiarray3b,movingthetarray3b]=phicrunner(alpha,beta)
%Phicrunner; for one inflection point solution, solve for positive-angle
%inflection point solution

%hold off
%for a bunch of phi values, find the inflection angle tprime that makes a
%zero crossing
phiarray3=[];
movingthetarray3=[];
phiarray3b=[];
movingthetarray3b=[];
%figure()

phi=-50:0.2:50;
parfor k=1:length(phi)
  tprime=alpha:1:70;%in phicrunner we are searching for a single inflection point at an angle greater than alpha.
  tprime=tprime*pi/180;
  myfout=[];
  for i=1:length(tprime)
     myfout(i)=mycFipphi(tprime(i),alpha,beta,phi(k)*pi/180);
  end
  %plot(180*tprime/pi,myfout)
  %hold on
  [ymin,imin]=min(myfout);
  [ymax,imax]=max(myfout);
  if ((ymin<0) & (ymax>0))%there may be a zero crossing
    if(isreal(ymin)&isreal(ymax)) %Getting some complex values here
      
      theta=fzero ( @(theta) mycFipphi (theta,alpha, beta, phi(k)*pi/180),[tprime(imin) tprime(imax)]);
      if(isreal(theta))
        phiarray3=[phiarray3 phi(k)];
        movingthetarray3=[movingthetarray3 180*theta/pi];
      end
    end  
  end
  
end    
