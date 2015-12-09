function [TSIM,XSIM] = SimFunctionFig2A1(DF)
	
    DFIN = DF;

	% ========= YOU MODIFY HERE (BELOW) ========================================== %
	IC = DFIN.INITIAL_CONDITIONS;
    IC(39,1)=90;		%39 IX
    IC(41,1)=170;		%41 X
    IC(43,1)=20;		%43 V
    IC(45,1)=0.7;		%45 VIII

    % The following initial conditions are to be varied for different experiments
    IC(38,1)=0.00125; 	%38 VIIa_TF
    IC(47,1)=1700; 		%47 II
    IC(49:54,1)=50;  	%49 P9s	%50 P9s_specific %51 P10s %52 P5s %54 P2s
    IC(53,1)=(5e-10);	%53 P8s
    IC(71,1)=100;		%71 Psub
    IC(72,1)=150; 		%72 PL
    IC(76,1)=65; 		%76 PC
    %IC(77,1)=10; 		%77 TM
    %IC(79,1)=3400;      %79 ATIII
    %IC(81,1)=5.0;       %81 TFPI 
    

	DFIN.INITIAL_CONDITIONS = IC;
	% ========= YOU MODIFY HERE (ABOVE) ========================================== %
    
    [TSIM,XSIM]=SolveMassBalancesODE15S(DFIN,1,720,1,DFIN);

	
return;
