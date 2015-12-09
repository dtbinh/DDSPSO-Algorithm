%Particle swarm optimization that implements dynamically dimensioned search

function[g_best_solution,bestparticle,particle,fitness]=DDSPSO_noDDS_swarm1(MAXJ,MINJ,NP,NI)

C1=1.5;C2=1.5; %Acceleration constants
beta=3.3;
N=length(MINJ);

Max_Inertia_weight=0.9;
Min_Inertia_weight=0.4;

%RANGE=MAXJ-MINJ;
%[Z,seed]=latin_random(length(RANGE),NP,123456789);

%for i=1:NP
%    Z(:,i)=Z(:,i).*RANGE;
    %Restricting the perturbation to be amongst the bounds specified
%    [Z(:,i)]=bind(Z(:,i),MINJ,MAXJ);
    %Calculating the cost
%    particle(:,1,i)=Z(:,i);
%    fitness(i,1)=fit(particle(:,1,i));

%end

for i=1:NP
    %Restricting the perturbation to be amongst the bounds specifiedi
    Z(:,i)=MINJ+(MAXJ-MINJ).*rand(N,1);
    [Z(:,i)]=bind(Z(:,i),MINJ,MAXJ);
    %Calculating the cost
    particle(:,1,i)=Z(:,i);
    fitness(i,1)=fit7(particle(:,1,i));

end


%Finding particle best after initialization
[p_best_solution,ITER]=particlebest(fitness);

%Finding global best after initialization
[g_best_solution(1),particlenumber]=globalbest(p_best_solution);
fprintf('Global best is %f and iteration is %d \n',g_best_solution(1),1);
%fflush(stdout);


%Particle update
for j=2:NI
w(j)=((NI - j)*(Max_Inertia_weight - Min_Inertia_weight))/(NI-1) + Min_Inertia_weight;
  	for i=round(1):((1)*NP)
 		 J=1:N;

		 temp=particle(:,j-1,i);
 		 a1=particle(:,j-1,i);
  		 a2=particle(:,ITER(i),i);
  	         a3=particle(:,j-1,i);
    		 a4=particle(:,ITER(particlenumber),particlenumber);
     	         a5=particle(:,j-1,i);

      		 temp(J)=w(j)*a1(J)+(C1.*rand).*(a2(J)-a3(J))+(C2.*rand).*(a4(J)-a5(J));
            	 temp=bind(temp,MINJ,MAXJ);
   	       	particle(:,j,i)=temp;
%		particle(:,j,i)=temp;
		fitness(i,j)=fit7(temp);
       end

	[p_best_solution,ITER]=particlebest(fitness);
	[g_best_solution(j),particlenumber]=globalbest(p_best_solution);

	fprintf('Global best is %f and iteration is %d \n',g_best_solution(j),j);

end

[p_best_solution,ITER]=particlebest(fitness);
[g_best_solution(j),particlenumber]=globalbest(p_best_solution);
bestparticle=particle(:,ITER(particlenumber),particlenumber);

end

function [x]=bind(x,MINJ,MAXJ)

	JMIN_NEW=find(x<MINJ);
	x(JMIN_NEW)=MINJ(JMIN_NEW)+(MINJ(JMIN_NEW)-x(JMIN_NEW));

	JTEMP1=find(x(JMIN_NEW)>MAXJ(JMIN_NEW));
	x(JTEMP1)=MINJ(JTEMP1);

	JMAX_NEW=find(x>MAXJ);
	x(JMAX_NEW)=MAXJ(JMAX_NEW)-(x(JMAX_NEW)-MAXJ(JMAX_NEW));

	JTEMP2=find(x(JMAX_NEW)<MINJ(JMAX_NEW));
	x(JTEMP2)=MAXJ(JTEMP2);

	CHKMAX=find(x>MAXJ);
	x(CHKMAX)=MINJ(CHKMAX);

	CHKMIN=find(x<MINJ);
	x(CHKMIN)=MAXJ(CHKMIN);
end


%function [p]=bind(p,MAXJ,MINJ)

%	JMIN_NEW=find(p<MINJ);
%	p(JMIN_NEW)=MINJ(JMIN_NEW)+(MINJ(JMIN_NEW)-p(JMIN_NEW));

%	JTEMP1=find(p>MAXJ);
%	p(JTEMP1)=MINJ(JTEMP1);

%	JMAX_NEW=find(p>MAXJ);
%	p(JMAX_NEW)=MAXJ(JMAX_NEW)-(p(JMAX_NEW)-MAXJ(JMAX_NEW));

%	JTEMP2=find(p<MINJ);
%	p(JTEMP2)=MAXJ(JTEMP2);

	%CHKMAX=find(x>MAXJ);
	%x(CHKMAX)=MINJ(CHKMAX);

	%CHKMIN=find(x<MINJ);
	%x(CHKMIN)=MAXJ(CHKMIN);

%end

%Find particle best and global best - particle best is the best fitness found by the particle in all iterations and global best is the best fitness found by all particles in all iterations

function[pbest_solution,ITER]=particlebest(fitness)
[pbest_solution,ITER]=min(fitness,[],2);
end

function[gbest_solution,particlenumber]=globalbest(par)
[gbest_solution,particlenumber]=min(par);
end
