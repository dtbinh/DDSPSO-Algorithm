function [PM]=CalculatePMatrixLSQ(pMassBalances,TN,XN,DF)
% ---------------------------------------------------------------------------- %
% Calculate the Jacobian matrix (first partial derivative with
% respect to state) using a centered finite difference approximation.
%
% Arguments:
%	INPUTS
%	------
%	pMassBalances 		Pointer to the mass balance function
%	TN			Nominal time point around which I'm linearizing
%	XN			Nominal state about which I'm linearizing
%	DFIN			Data struct which holds the parameter vector (PN)
%
%	OUTPUTS
%	-------
%	JM			Jacobian matrix (dim(XN) x dim(XN)) eval at XN,PN
% ---------------------------------------------------------------------------- %
% 
% 	global DF;
% 	global kV;
% 	global S;
% 	global NRATES;
% 	global NSTATES;
% 	global IDX_BOUND_PLATELETS;
% 	global IDX_FREE_PLATELETS;
% 	global IDX_SURFACE;

	% Ok, here we go - size of the perturbation (SIGMA%)
	SIGMA=0.05;
	
	% Get the number of states -
	NSTATES=length(XN);
	
	% Get the number of parameters --
	NPARAMETERS_k=DF.NUMBER_PARAMETERS;
	
	% Total number of states -
	NPARAMETERS = NPARAMETERS_k+NSTATES;
	
%     keyboard
	% Initialize the jacobian
	PM=zeros(NSTATES,NPARAMETERS);
	
	% Get the nominal parameters 
	PN=DF.PARAMETER_VECTOR;
	
	% Initialize -
	PBLOCK=[];
	PBLOCK_TRANS=[];
	
	SIGMA = 0.05;
	
	% Precompute the NSTATE random perturbation vectors -
	for pindex=1:(NPARAMETERS)
		PV=PN;
		
		if (PN(pindex,1)<=1e-6)
			PV(pindex,1)=0.01*rand;
		else
			PV(pindex,1)=PN(pindex,1)+PN(pindex,1)*(SIGMA);
		end;
		
		PBLOCK=[PBLOCK PV];
		PBLOCK_TRANS=[PBLOCK_TRANS (PV-PN)];
	end;
	
	
	% Ok, so evaluate F(mass_balance) at *each* of the perturbed X's
	FA=[];
	for pindex=1:(NPARAMETERS)
		DF.PARAMETER_VECTOR=PBLOCK(:,pindex);
		DF.RATE_CONSTANT_VECTOR=PBLOCK(1:NPARAMETERS_k,pindex);
		
		% reset the parameters -
		kV = PBLOCK(:,pindex);
		Y=feval(pMassBalances,TN,XN,DF);
		FA=[FA Y];
	end;
	
	% Do the nom case -
	DF.PARAMETER_VECTOR = PN;
    DF.RATE_CONSTANT_VECTOR=PBLOCK(1:NPARAMETERS_k,pindex);
% 	kV = PN;
	Y=feval(pMassBalances,TN,XN,DF);
	FNOMINAL=Y;
	
	% Ok, here we go -
	for mass_balance=1:NSTATES
		
		% Ok, so now I'm ready to solve the least-squares problem -
		% Formulate the A matrix -		
		AMATRIX=[
			transpose(PBLOCK_TRANS)
		];
		
		
		% Get the bVector -
		bV=transpose(FA(mass_balance,:))-FNOMINAL(mass_balance);
		
		% Solve the system -
		L=AMATRIX\bV;
		
		% Add this row to the JM -
		PM(mass_balance,1:(NPARAMETERS))=transpose(L);
		
		%[mass_balance]
	end;
	
return;
