clear all;
more off;
warning('off','all');

%IC=load("guess6.dat"); %Initial guess vector
%Z=load('IC.txt');

%bounds=load('bounds1b1.txt'); %Bounds on the rate constants
bounds=load('bounds.txt');
MAXJ=bounds(:,2);
MINJ=bounds(:,1);
NP=40; %Number of particles in the swarm
NI=100; %Number of iterations


NS=2; %Number of sub swarms
G=10; %Number of iterations after which swarms are redistributed
r=0.2;
%se=load('randnseed.txt');
%randn('seed',se);
%rand('seed',se);

%pop=load('pop_coagulation_1.mat');
%pop=pop.pop;

for i=1:25

    tstart=tic();
    [g_best_solution(i,:),bestparticle(:,:,i),particle(:,:,:,i),fitness(:,:,i)]=DDSPSO_noDDS(MAXJ,MINJ,NP,NI,NS,G);
    timeDDSPSO(i)=toc(tstart);

   if(~mod(i,5))
        cmd1 = ['save  ./DDSPSO_Results_swarms_2/DDSPSO_solution_iter',num2str(i),'.mat bestparticle'];
    	eval(cmd1)

        cmd2 = ['save  ./DDSPSO_Results_swarms_2/DDSPSO_particle_iter',num2str(i),'.mat particle'];
    	eval(cmd2)

        cmd3 = ['save  ./DDSPSO_Results_swarms_2/DDSPSO_fitness_iter',num2str(i),'.mat fitness'];
    	eval(cmd3)


		cmd4 = ['save -ascii ./DDSPSO_Results_swarms_2/DDSPSO_error_iter',num2str(i),'.txt g_best_solution'];
    	eval(cmd4)


		cmd5 = ['save -ascii ./DDSPSO_Results_swarms_2/DDSPSO_time_iter',num2str(i),'.txt timeDDSPSO'];
    	eval(cmd5)

   end
end

save ./DDSPSO_Results_swarms_2/DDSPSO_swarms_2_solution.mat bestparticle;
save ./DDSPSO_Results_swarms_2/DDSPSO_swarms_2_particle.mat particle;
save ./DDSPSO_Results_swarms_2/DDSPSO_swarms_2_fitness.mat fitness;

save -ascii ./DDSPSO_Results_swarms_2/DDSPSO_swarms_2_error.txt g_best_solution;
save -ascii ./DDSPSO_Results_swarms_2/DDSPSO_swarms_2_time.txt timeDDSPSO;
