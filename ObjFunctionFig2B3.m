function [ERR,TSIM,XSIM,TOTAL_THROMBIN,DATA] = ObjFunctionFig2B3(DFIN)

	
	% Ok, call the simulation file associated with this objective -
	[TSIM,XSIM] = SimFunctionFig2B3(DFIN);
	
	% What is the experimental data?
	DATA = DFIN.EXPT_DATA_FIG2B3;
	
   if length(TSIM)~=size(XSIM,1) ||(size(XSIM,1)<=2)
        ERR=1e13;
        return
   else
	
	% What are we going to compare to the data?
	%TOTAL_THROMBIN = XSIM(:,34) + XSIM(:,173).*(sum(XSIM(:,[143 144]),2));
	TOTAL_THROMBIN = XSIM(:,48);
	TSCALED = TSIM(:,1);
	
	% We need to interpolate the simulation results to the experimental time scale -
	[XI] = interp1(TSCALED,TOTAL_THROMBIN,DATA(:,1));
	
	% Compute the error vector -
	ERR_VEC = (DATA(:,2) - XI);
	
	% Compute the ERR -
	ERR = transpose(ERR_VEC)*ERR_VEC;

    return;
   end
   
end
