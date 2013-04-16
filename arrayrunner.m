%Arrayrunner: CKH 2013 Calculate the curvature energy and center y-displacement of a compressed thin
%beam as its angle with the substrate (alpha) changes. It assumes the beam doesn't stretch, only bends. 
%It calculates this over a range of different compression ratios (beta). 
%Beta is defined as the original beam length/length
%between beam supports. (in compression, beta is greater than or equal to 1.)

matlabpool open;%In case running on a cluster, this program can run some loops in parallel--otherwise comment out this and matlabpool close
tic;%start timer

hugeplot=[];%heres where to keep all the values of y-displacement and energy for a grid of beta and alpha values

%This code calls some subfunctions that also have parfor (parallel for) loops, but nested parfor loops aren't allowed and it still runs. 

%The MATLAB documentation says the outermost loop that controls alpha will win and the
%sub-functions will revert to regular for-loops. 
%When there wasn't an outer parfor loop, the inner ones produced about a 2x speedup
%and with the outer (alpha) one, a total 10x speedup vs regular for loops
%on the computing cluster.

k=1;
for beta=1.001:0.02:1.201
	bigplot=[];
    maxalpha=fzero(@(alphatest) myeps(alphatest,beta),25);%for this beta find greatest alpha (in degrees) having a 1-inflection point solution,
    %beyond this angle (which increases with beta) the solutions aren't valid.
    alpha=linspace(0,maxalpha-0.01,21); %Create a customized array of about 20-30  different alphas--in degrees-- for each beta
	
    parfor j=1:length(alpha) 
		
        phiarray=[];
		movingthetarray=[];
		phiarrayb=[];
		movingthetarrayb=[];
		phiarray2=[];
		movingthetarray2=[];
		phiarray2b=[];
		movingthetarray2b=[];
		phiarray3=[];
		movingthetarray3=[];
		phiarray3b=[];
		movingthetarray3b=[];
		I=[];
		[phiarray,movingthetarray,phiarrayb,movingthetarrayb]=phibrunner(alpha(j),beta);
		[phiarray2,movingthetarray2,phiarray2b,movingthetarray2b]=phiarunner(alpha(j),beta);
		[phiarray3,movingthetarray3,phiarray3b,movingthetarray3b]=phicrunner(alpha(j),beta);%beyond the most
		%stable 2-inflection point solution, energy should go up again with some single-inflection
		%point solutions
		U=[];
		U2=[];
		U3=[];
		Ub=[];
		U2b=[];
		U3b=[];
		yend=[];
		yend2=[];
		yend3=[];
		yendb=[];
		yend2b=[];%sometmes don't get this assigned if no 2nd zero crossings are found
		yend3b=[];
		Yall=[];
		Uall=[];
		
		
		for i=1:length(phiarray)
			U(i)=enercalc(1,movingthetarray(i)*pi/180,alpha(j)*pi/180,phiarray(i)*pi/180);
		end
		for i=1:length(phiarrayb)
			Ub(i)=enercalc(1,movingthetarray(i)*pi/180,alpha(j)*pi/180,phiarrayb(i)*pi/180);
		end
		for i=1:length(movingthetarray2)
			U2(i)=enercalc(2,movingthetarray2(i)*pi/180,alpha(j)*pi/180,phiarray2(i)*pi/180);
		end
		for i=1:length(movingthetarray2b)
			U2b(i)=enercalc(2,movingthetarray2b(i)*pi/180,alpha(j)*pi/180,phiarray2b(i)*pi/180);
		end
		for i=1:length(movingthetarray3) %getting some complex values
			test=-enercalc(1,movingthetarray3(i)*pi/180,alpha(j)*pi/180,phiarray3(i)*pi/180);
			if(isreal(test))
				U3(i)=test;
				movingthetarray3(length(U3))=movingthetarray3(i);%insert only valid values of movingthetarray3
				phiarray3(length(U3))=phiarray3(i);%same
			end
		end
		movingthetarray3=movingthetarray3(1:length(U3));%chop off extra pieces
		phiarray3=phiarray3(1:length(U3));
		for i=1:length(movingthetarray3b)
			U3b(i)=-enercalc(1,movingthetarray3b(i)*pi/180,alpha(j)*pi/180,phiarray3b(i)*pi/180);
		end
		
		%figure()
		yend=plot1ipmov(alpha(j),movingthetarray,phiarray);
		%hold on
		yendb=plot1ipmov(alpha(j),movingthetarrayb,phiarrayb);
		yend2=plot2ipmov(alpha(j),movingthetarray2,phiarray2);
		yend2b=plot2ipmov(alpha(j),movingthetarray2b,phiarray2b);
		yend3=plot1ipmov(alpha(j),movingthetarray3,phiarray3);
		yend3b=plot1ipmov(alpha(j),movingthetarray3b,phiarray3b);
		[Yall I]=sort([yend yendb yend2b yend2 yend3 yend3b]);
		Uall=[U Ub U2b U2 U3 U3b];
		Uall=Uall(I);%sort in same order as Yall
		%figure()
		%plot([fliplr(yend) yend2],[fliplr(U) U2])
		%plot([fliplr(yend) fliplr(yendb) yend2b yend2 fliplr(yend3) yend3b],[fliplr(U) fliplr(Ub) U2b U2 fliplr(U3) U3b])
		%plot(Yall,Uall)
		bigplot(j).alpha=alpha(j);
		bigplot(j).yall=Yall;
		bigplot(j).uall=Uall;
	end  %end of parfor

	hugeplot(k).data=bigplot;
	hugeplot(k).beta=beta;
	k=k+1;
end %end of beta loop


elapsedtime=toc;
save hugeout2.mat hugeplot elapsedtime;
matlabpool close;
