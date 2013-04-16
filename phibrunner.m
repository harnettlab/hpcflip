function [phiarray,movingthetarray,phiarrayb,movingthetarrayb]=phibrunner(alpha,beta)
%Phibrunner; for one inflection point solution, hold alpha and decrease phi
%from zero to calculate the moving shape
%hold off
%for a bunch of phi values, find the inflection angle tprime that makes a
%zero crossing
phiarray=[];
movingthetarray=[];
phiarrayb=[];
movingthetarrayb=[];
%movingthetarray2=[];

phi=-50:0.2:50;

parfor k=1:length(phi)

  tprime=0:-1:-70;
  tprime=tprime*pi/180;
  myfout=[];
  for i=1:length(tprime)
     myfout(i)=myFipphi(tprime(i),alpha,beta,phi(k)*pi/180);
  end
  %plot(180*tprime/pi,myfout)
  %hold on
  [ymin,imin]=min(myfout);
  [ymax,imax]=max(myfout);
  if ((ymin<0) & (ymax>0))%there may be a zero crossing
    phiarray=[phiarray phi(k)];
    theta=fzero ( @(theta) myFipphi (theta,alpha, beta, phi(k)*pi/180),[tprime(imin) tprime(imax)]);
    movingthetarray=[movingthetarray 180*theta/pi];
  end
  if (myfout(1)>0 & (ymin<0))%there may be a second zero crossing--these are where the 2nd inflection point approaches 0 deg
      phiarrayb=[phiarrayb phi(k)];
      theta=fzero( @(theta) myFipphi (theta,alpha, beta, phi(k)*pi/180),[tprime(1) tprime(imin)]);
      movingthetarrayb=[movingthetarrayb 180*theta/pi];
  end    

end    
