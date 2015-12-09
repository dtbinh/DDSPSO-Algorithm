function [JM]=CalculateJacobianLSQ(pMassBalances,TN,XN,DF)
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
	
	EPSILON = 1e-4;
	
	% Initialize the jacobian
	JM=zeros(NSTATES,NSTATES);
	
	% Initailize -
	XBLOCK=[];
	XBLOCK_TRANS=[];
	
	% Precompute the NSTATE random perturbation vectors -
	for pindex=1:(NSTATES)
		XV=transpose(XN);
		
		if (abs(XN(pindex))<EPSILON)
			XV(pindex,1)=EPSILON;
		else
			XV(pindex,1)=XN(pindex)+XN(pindex)*(SIGMA);
		end;
		XBLOCK=[XBLOCK XV];
		XBLOCK_TRANS=[XBLOCK_TRANS (XV-transpose(XN))];
	end;
	
	% Ok, so I need to keep only the visible rows -
	
	% Ok, so evaluate F(mass_balance) at *each* of the perturbed X's
	FA=[];
	for pindex=1:(NSTATES)
		Y=feval(pMassBalances,TN,XBLOCK(:,pindex),DF);
		FA=[FA Y];
	end;
	
	% At the end add on FN =
	Y=feval(pMassBalances,TN,XN,DF);
	FNOMINAL=Y;
	
	
	
	% Ok, he-re we go -
	for mass_balance=1:NSTATES
		
		% Ok, so now I'm ready to solve the least-squares problem -
		% Formulate the A matrix -
		
		AMATRIX=[
			transpose(XBLOCK_TRANS)
		];
		
		% Get the bVector -
		bV=transpose(FA(mass_balance,:))-FNOMINAL(mass_balance);
		
		% Solve the system -
		L=AMATRIX\bV;
		
		% Add this row to the JM -
		JM(mass_balance,1:NSTATES)=transpose(L);
		
		%[mass_balance]
	end;
return;
