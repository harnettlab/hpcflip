function [phiarray2, movingthetarray2,phiarray2b,movingthetarray2b]=phiarunner(alpha,beta)
%Phiarunner; for two inflection point solution, hold alpha and adjust phi
%from zero to calculate the moving shape
%Look at positive inflection points greater than alpha


%hold off
%for a bunch of phi values, find the inflection angle tprime that makes a
%zero crossing
phiarray2=[];
phiarray2b=[];
movingthetarray2=[];
movingthetarray2b=[];
%figure()

phi=-50:0.2:50;

parfor k=1:length(phi)
  tprimedeg=alpha:0.1:60;
  tprime=tprimedeg*pi/180;
  myfout=[];
  for i=1:length(tprime)
     myfout(i)=myaFipphi(tprime(i),alpha,beta,phi(k)*pi/180);
  end
  %plot(180*tprime/pi,myfout)
  %hold on
  [ymin,imin]=min(myfout);
  [ymax,imax]=max(myfout);
  if ((ymin<0) & (ymax>0))%there may be a zero crossing
    phiarray2=[phiarray2 phi(k)];
    theta=fzero ( @(theta) myaFipphi (theta,alpha, beta, phi(k)*pi/180),[tprime(imin) tprime(imax)]);
    movingthetarray2=[movingthetarray2 180*theta/pi];
  end
  if (myfout(1)>0 & (ymin<0))%there may be a second zero crossing--these are where the 2nd inflection point approaches 0 deg
      phiarray2b=[phiarray2b phi(k)];
      theta=fzero( @(theta) myaFipphi (theta,alpha, beta, phi(k)*pi/180),[tprime(1) tprime(imin)]);
      movingthetarray2b=[movingthetarray2b 180*theta/pi];
  end    
end    
