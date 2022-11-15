function [upsampled_pic]=Upsample(pic,bin)

[m,n,L]=size(pic);
M=ceil(m*bin);
N=ceil(n*bin);

[X,Y]   = meshgrid(1:n,1:m);
[U,V]   = meshgrid(1:N,1:M);
U=(U+bin-1)/bin;
V=(V+bin-1)/bin;

upsampled_pic=zeros(M,N,L);
for k=1:L
    upsampled_pic(:,:,k)=interp2(X,Y,pic(:,:,k),U,V,'cubic',0);
end


end

