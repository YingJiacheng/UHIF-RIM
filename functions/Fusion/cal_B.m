function [B]=cal_B(M,N,psf)

[h,w]=size(psf);
start=1;
inf=zeros(3,M*N*h*w);
for i=1:M
    for j=1:N
            [x_temp,y_temp,value_temp]=psf_filter(i,j,M,N,psf);
            [~,num]=size(x_temp);
            inf(1,start:start+num-1)=x_temp;
            inf(2,start:start+num-1)=y_temp;
            inf(3,start:start+num-1)=value_temp;
            start=start+num;
    end
end
inf=inf(:,1:start-1);

B=sparse(inf(1,:),inf(2,:),inf(3,:),M*N,M*N);
end