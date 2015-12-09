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


%se=load('randnseed.txt');
%randn('seed',se);
%rand('seed',se);

%pop=load('pop_coagulation_1.mat');
%pop=pop.pop;

for i=1:25
    	
    tstart=tic();
    [g_best_solution(i,:),bestparticle(:,:,i),particle(:,:,:,i),fitness(:,:,i)]=PSO_2(MAXJ,MINJ,NP,NI);
    timePSO(i)=toc(tstart); 
    
   if(~mod(i,5))
        cmd1 = ['save  ./PSO_Results_v2/PSO_solution_iter',num2str(i),'.mat bestparticle'];
    	eval(cmd1)

        cmd2 = ['save  ./PSO_Results_v2/PSO_particle_iter',num2str(i),'.mat particle'];
    	eval(cmd2)

        cmd3 = ['save  ./PSO_Results_v2/PSO_fitness_iter',num2str(i),'.mat fitness'];
    	eval(cmd3)
        
        
		cmd4 = ['save -ascii ./PSO_Results_v2/PSO_error_iter',num2str(i),'.txt g_best_solution'];
    	eval(cmd4)

        
		cmd5 = ['save -ascii ./PSO_Results_v2/PSO_time_iter',num2str(i),'.txt timePSO'];
    	eval(cmd5)
       
   end		
end

save ./PSO_Results_v2/PSO_solution.mat bestparticle;
save ./PSO_Results_v2/PSO_particle.mat particle;
save ./PSO_Results_v2/PSO_fitness.mat fitness;

save -ascii ./PSO_Results_v2/PSO_error.txt g_best_solution;
save -ascii ./PSO_Results_v2/PSO_time.txt timePSO;
