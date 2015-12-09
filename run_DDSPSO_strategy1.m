clear all;
more off;
warning('off','all');

%IC=load("guess6.dat"); %Initial guess vector

bounds=load('bounds.txt'); %Bounds on the rate constants
MAXJ=bounds(:,2);
MINJ=bounds(:,1);
NP=40; %Number of particles in the swarm
NI=100; %Number of iterations

NS=4; %Number of sub swarms
G=10; %Number of iterations after which swarms are redistributed
r=0.2;


%se=load('randnseed.txt');
%randn('seed',se);
%rand('seed',se);

%pop=load('pop_coagulation_1.mat');
%pop=pop.pop;


for i=1:25
   %Z=pop(:,:,i);
    tstart=tic();
    [g_best_solution,bestparticle,particle,fitness,bestval_dds_swarm,best_particle_dds_swarm,best_particles_ls]=DDSPSO_strategy1(MAXJ,MINJ,NP,NI,NS,G,r);

    timeDDSPSO(i)=toc(tstart);

   if(~mod(i,1))
        cmd1 = ['save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_solution_iter',num2str(i),'.mat bestparticle'];
    	eval(cmd1)

        cmd2 = ['save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_particle_iter',num2str(i),'.mat particle'];
    	eval(cmd2)

        cmd3 = ['save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_fitness_iter',num2str(i),'.mat fitness'];
    	eval(cmd3)


		cmd4 = ['save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_error_iter',num2str(i),'.mat g_best_solution'];
    	eval(cmd4)


		cmd5 = ['save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_time_iter',num2str(i),'.mat timeDDSPSO'];
    	eval(cmd5)

        cmd6 = ['save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_errordds_iter',num2str(i),'.mat bestval_dds_swarm'];
    	eval(cmd6)

		cmd7 = ['save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_particledds_iter',num2str(i),'.mat best_particle_dds_swarm'];
    	eval(cmd7)

        cmd8 = ['save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_bestparticles_ls_iter',num2str(i),'.mat best_particles_ls'];
    	eval(cmd8)



   end


end

%save ./DDSPSO_strategy1_Results/DDSPSO_strategy1_solution.mat bestparticle;
%save ./DDSPSO_strategy1_Results/DDSPSO_strategy1_particle.mat particle;
%save ./DDSPSO_strategy1_Results/DDSPSO_strategy1_fitness.mat fitness;
%save ./DDSPSO_strategy1_Results/DDSPSO_strategy1_errordds.mat bestval_dds_swarm;
%save ./DDSPSO_strategy1_Results/DDSPSO_strategy1_particledds.mat best_particle_dds_swarm;
%save  ./DDSPSO_strategy1_Results/DDSPSO_strategy1_bestparticles_ls_iter.mat best_particles_ls


%save -ascii ./DDSPSO_strategy1_Results/DDSPSO_strategy1_error.txt g_best_solution;
%save -ascii ./DDSPSO_strategy1_Results/DDSPSO_strategy1_time.txt timeDDSPSO;
