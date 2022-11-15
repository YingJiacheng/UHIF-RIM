function [S]=cal_S(p,M,N,m,n,bin)

MASK=ones(M,N);
MASK_warp= affine_transform(MASK,p);
MASK_warp=MASK_warp(1:bin:M,1:bin:N);

pt      = inverse_affine_param(p);
[X,Y]   = meshgrid(1:N,1:M);
x_shift  = (1+N)/2;
y_shift  = (1+M)/2;
X       = X - x_shift;
Y       = Y - y_shift;
V       = pt(1)*X + pt(2)*Y + pt(3) + x_shift;
U       = pt(4)*X + pt(5)*Y + pt(6) + y_shift;
U = U(1:bin:M,1:bin:N);
V = V(1:bin:M,1:bin:N);


start=1;
inf=zeros(3,m*n*16);
for i=1:m
    for j=1:n
        if MASK_warp(i,j)~=0
            [x_temp,y_temp,value_temp]=linear_filter(i,j,m,n,M,N,U(i,j),V(i,j));
            %[x_temp,y_temp,value_temp]=cubic_filter(i,j,m,n,M,N,U(i,j),V(i,j));
            [~,num]=size(x_temp);
            inf(1,start:start+num-1)=x_temp;
            inf(2,start:start+num-1)=y_temp;
            inf(3,start:start+num-1)=value_temp;
            start=start+num;
        end
    end
end
inf=inf(:,1:start-1);

S=sparse(inf(1,:),inf(2,:),inf(3,:),M*N,m*n);
end

