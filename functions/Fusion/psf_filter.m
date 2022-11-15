function  [x_temp,y_temp,value_temp]=psf_filter(i,j,M,N,psf)

[h,w]=size(psf);
y_temp=((j-1)*M+i)*ones(1,h*w);

istart=i-round((h-1)/2);
iend=i+round((h-1)/2);
jstart=j-round((w-1)/2);
jend=j+round((w-1)/2);

[y,x]=meshgrid(jstart:jend,istart:iend);

y=mod(y-1,N);
x=mod(x,M);
x=x+(x==0)*M;
x_mat=y*M+x;
x_temp=x_mat(:)';
        
value_temp=psf(:)';



end

