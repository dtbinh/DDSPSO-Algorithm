function[best,x_best,dds_swarm_flag]=DDSFORSWARM_7(IC,MAXJ,MINJ,r,NI)


N=length(MINJ);
x_best(:,1)=IC;
x=IC;
J=1:N;
F_best=fit7(x);
F=fit7(x);

for i=1:NI

	P_i=1-(log(i)/log(NI));
	randomnumber=rand(N,1);
	J=find(randomnumber<P_i);

	if(isempty(J))

		J=floor(1+length(IC)*rand);
	end

	%fprintf('Old Fitness value is %f and iteration is %d \n',F,i);
	%fflush(stdout);

	SIGMA=r.*(MAXJ-MINJ);
	%SIGMA=r;
	%x_new(J)=exp(log(x_new(J))+SIGMA.*randn(length(J),1));
   	x_new=x;
	x_new(J)=(x(J))+SIGMA(J).*randn(length(J),1);
	x_new=bind(x_new,MAXJ,MINJ);

	F_new=fit7(x_new);

	%Greedy step
	if(F_new<F)
	    x=x_new;
	    F=F_new;

		if(F_new<=F_best)
			F_best=F_new;
			x_best(:,i)=x_new;
        else
            if i>1
                x_best(:,i)=x_best(:,i-1);
            end
        end

    else
        if i>1
            x_best(:,i)=x_best(:,i-1);
        end
	end


best(i)=F_best;
fprintf('Best value is %f and iteration is %d \n',best(i),i);

end

dds_swarm_flag=1;
end



function [p]=bind(p,MAXJ,MINJ)

	JMIN_NEW=find(p<MINJ);
	p(JMIN_NEW)=MINJ(JMIN_NEW)+(MINJ(JMIN_NEW)-p(JMIN_NEW));

	JTEMP1=find(p>MAXJ);
	p(JTEMP1)=MINJ(JTEMP1);

	JMAX_NEW=find(p>MAXJ);
	p(JMAX_NEW)=MAXJ(JMAX_NEW)-(p(JMAX_NEW)-MAXJ(JMAX_NEW));

	JTEMP2=find(p<MINJ);
	p(JTEMP2)=MAXJ(JTEMP2);

	%CHKMAX=find(x>MAXJ);
	%x(CHKMAX)=MINJ(CHKMAX);

	%CHKMIN=find(x<MINJ);
	%x(CHKMIN)=MAXJ(CHKMIN);

end
