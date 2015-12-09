% Script to generate random parameter sets -

NPSETS = 100;

TSTART = 10.0;
TSTOP = 480.0;
Ts = 10.0;

for pset_index = 1:NPSETS
	% Load DF -
	DF = DataFileCONTROL(TSTART,TSTOP,Ts,[]);
	
	% Number of parameters and states -
	NP = DF.NUMBER_PARAMETERS;
	NS = DF.NUMBER_OF_STATES;
	
	% Get and pertub rate constants -
	k=DF.RATE_CONSTANT_VECTOR;
    Perturb=10.^(randn(NP,1));
	kNew = abs(Perturb.*k);
	%keyboard
    
	% Get and perturb initial condtions -
	ic=DF.INITIAL_CONDITIONS;
	icNew = abs(ic+0.25*randn(NS,1).*ic);
	
	% Dump to disk -
	kP = [kNew ; icNew];
	cmd = ['save -mat ./psets/PSET_',num2str(pset_index),'.mat kP;'];
	eval(cmd);
end;
