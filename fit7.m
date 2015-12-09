function fitness = fit7(x)
	DF=DataFile(0,0,0,[]);
	DFIN=DF;
	DFIN.RATE_CONSTANT_VECTOR=x;
    %fitness=(1/6)*ObjFunctionFig2B3(DFIN)+(1/6)*ObjFunctionFig2B4(DFIN)+(1/6)*ObjFunctionFig2D2(DFIN)+(1/6)*ObjFunctionFig2D3(DFIN)+(1/6)*ObjFunctionFig2E1(DFIN)+(1/6)*ObjFunctionFig2E5(DFIN);
    fitness=(1/2)*ObjFunctionFig2E1(DFIN)+(1/2)*ObjFunctionFig2E5(DFIN);
    %fitness=ackleyfcn(x');
end
