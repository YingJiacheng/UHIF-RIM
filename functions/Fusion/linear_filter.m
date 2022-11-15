function [x_temp,y_temp,value_temp]=linear_filter(i,j,m,n,M,N,u,v);

y_temp=((j-1)*m+i)*ones(1,4);
x_temp=zeros(1,4);
value_temp=zeros(1,4);

u0=floor(u);
u1=ceil(u);
v0=floor(v);
v1=ceil(v);

if u0==u1
    if u0==1
         u1=u1+1;
    else
         u0=u0-1; 
    end
end
if v0==v1
    if v0==1
        v1=v1+1;
    else
        v0=v0-1;
    end
end


x_temp(1,1)=(v0-1)*M+u0;
x_temp(1,2)=(v0-1)*M+u1;
x_temp(1,3)=(v1-1)*M+u0;
x_temp(1,4)=(v1-1)*M+u1;

value_temp(1,1)=(u1-u)*(v1-v)/((u1-u0)*(v1-v0));
value_temp(1,2)=(u-u0)*(v1-v)/((u1-u0)*(v1-v0));
value_temp(1,3)=(u1-u)*(v-v0)/((u1-u0)*(v1-v0));
value_temp(1,4)=(u-u0)*(v-v0)/((u1-u0)*(v1-v0));



end

