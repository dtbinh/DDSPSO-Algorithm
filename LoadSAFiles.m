% Script to load the SA files and compute the overall state sensitvity coefficients -
NTRIALS = 100;
TSTART = 10.0;
TSTOP = 480.0;
Ts = 10;
OSSC = [];
OSSC_COL=[];
for trial_index = 1:NTRIALS
	% load the datafile -
	DF=DataFile(TSTART,TSTOP,Ts,trial_index);
	
	% Run the model with the new parameter set -
	[TN,XN]=SolveMassBalancesODE15S(@DataFile,TSTART,TSTOP,Ts,DF);
	
	% Load the SA file -
	cmd=['load ./ODE15S/SA_CONTROL_',num2str(trial_index),'.mat'];
	eval(cmd);
	
	% Ok, Calculate the OOSC value -
	% How many parameters do I have ?
	NP = DF.NUMBER_PARAMETERS;
	OSSC_TRIAL = zeros(NP,1);
	for parameter_index = 1:NP
		OSSC_TRIAL(parameter_index,1)=CalcOSSC(XN,TN,SA,parameter_index,DF);
	end;
	
	OSSC_TOTAL = [OSSC_TRIAL ; OSSC_COL];
	OSSC = [OSSC OSSC_TOTAL];	
	
	% mem management -
	clear SA;
	

	cmd = ['Completed trial_index = ',num2str(trial_index),' of ',num2str(NTRIALS)];
	disp(cmd);	
end;

% Ok, so I need to find the mean and stdev of the scaled OSSC values -
SOSSC = [];
for trial_index = 1:NTRIALS
	COL = OSSC(:,trial_index);
	max_val = max(COL);
	
	% Scaled column -
	SCOL = COL.*(1/max_val);
	
	SOSSC = [SOSSC SCOL];
end;

% Ok, when I get here I need to dump to the results to disk -
save -mat SCALED_OSSC_CONTROL.mat SOSSC;
save -mat OSSC_CONTROL.mat OSSC;
