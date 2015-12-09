clear all;
more off;
warning('off','all');

%IC=load("guess6.dat"); %Initial guess vector
 
bounds=load('bounds.txt'); %Bounds on the rate constants
MAXJ=bounds(:,2);
MINJ=bounds(:,1);
NP=40; %Number of particles in the swarm
NI=100; %Number of iterations

NS=5; %Number of sub swarms
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
    [g_best_solution(i,:),bestparticle(:,:,i),particle(:,:,:,i),fitness(:,:,i),bestval_dds_swarm(i,:),best_particle_dds_swarm(:,:,i),best_particles_ls(:,:,i)]=DDSMLSPSO_23(MAXJ,MINJ,NP,NI,NS,G,r);
    timeDDSMLSPSO(i)=toc(tstart); 
    
   if(~mod(i,5))
        cmd1 = ['save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_solution_iter',num2str(i),'.mat bestparticle'];
    	eval(cmd1)

        cmd2 = ['save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_particle_iter',num2str(i),'.mat particle'];
    	eval(cmd2)

        cmd3 = ['save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_fitness_iter',num2str(i),'.mat fitness'];
    	eval(cmd3)
        
        
		cmd4 = ['save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_error_iter',num2str(i),'.mat g_best_solution'];
    	eval(cmd4)

        
		cmd5 = ['save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_time_iter',num2str(i),'.mat timeDDSMLSPSO'];
    	eval(cmd5)
        
        cmd6 = ['save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_errordds_iter',num2str(i),'.mat bestval_dds_swarm'];
    	eval(cmd6)

		cmd7 = ['save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_particledds_iter',num2str(i),'.mat best_particle_dds_swarm'];
    	eval(cmd7)
        
        cmd8 = ['save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_bestparticles_ls_iter',num2str(i),'.mat best_particles_ls'];
    	eval(cmd8)


        
   end		

 
end

save ./DDSMLSPSO_Results_v23/DDSMLSPSO_solution.mat bestparticle;
save ./DDSMLSPSO_Results_v23/DDSMLSPSO_particle.mat particle;
save ./DDSMLSPSO_Results_v23/DDSMLSPSO_fitness.mat fitness;
save ./DDSMLSPSO_Results_v23/DDSMLSPSO_errordds.mat bestval_dds_swarm;
save ./DDSMLSPSO_Results_v23/DDSMLSPSO_particledds.mat best_particle_dds_swarm;
save  ./DDSMLSPSO_Results_v23/DDSMLSPSO_bestparticles_ls_iter.mat best_particles_ls


save -ascii ./DDSMLSPSO_Results_v23/DDSMLSPSO_error.txt g_best_solution;
save -ascii ./DDSMLSPSO_Results_v23/DDSMLSPSO_time.txt timeDDSMLSPSO;
