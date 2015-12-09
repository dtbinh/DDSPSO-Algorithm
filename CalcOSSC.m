function [OSSC]=CalcOSSC(X,T,SA,PINDEX,DF)
	
	% EPSILON 
	EPS = 1e-4;

	% Get the cols corresponding to PINDEX -
	SA_PINDEX = SA(:,PINDEX);

	% Get the dimensions -
	NP = DF.NUMBER_PARAMETERS;
	NS = DF.NUMBER_OF_STATES;
	NT = length(T);
	[NR,NC]=size(SA_PINDEX);

	SAS = zeros(NS,1);
	SASC = [];
	
	% Scale by the nominal state -
	offset = 0;
	for time_index = 1:NT-1
		
		% Get the nominal state vector at this time -
		XNOM = X(time_index,:);
			
		%keyboard;	
		% Do the scalng operation -
		for state_index = 1:NS
			XNOM_STATE = XNOM(state_index);
			
			if (XNOM_STATE<EPS)
				XNOM_STATE = EPS;
			end;

			SAS(state_index,1) = ((1/XNOM_STATE)*SA_PINDEX(state_index+offset))^2;
		end;
		
		% Scaled sensitivity array column -
		SASC = [SASC ; SAS];
		
		% update the offset -
		offset = offset + NS;
		
		%[offset time_index]
		
		%keyboard;
	end;
	
	% Get the nominal parameter value -
	kV = DF.RATE_CONSTANT_VECTOR;
	PNOMINAL = kV(PINDEX);
	
	% Calculate the OOSC value -
	OSSC = (PNOMINAL/NS)*(sum(SASC))^(0.5);
return;
