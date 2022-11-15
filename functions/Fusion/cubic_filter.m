function [x_temp,y_temp,value_temp]=cubic_filter(i,j,m,n,M,N,u,v);

y_temp=((j-1)*m+i)*ones(1,16);
x_temp=zeros(1,16);
value_temp=zeros(1,16);

u1=floor(u);
u2=ceil(u);
v1=floor(v);
v2=ceil(v);

if u1==1
   u1=1;u2=2;u3=3;u4=4;
elseif u2==M
    u1=M-3;u2=M-2;u3=M-1;u4=M;
elseif u1<M/2
    u2=u1;u1=u2-1;u3=u2+1;u4=u2+2;
else
    u3=u2;u1=u3-2;u2=u3-1;u4=u3+1;    
end


if v1==1
   v1=1;v2=2;v3=3;v4=4;
elseif v2==M
    v1=M-3;v2=M-2;v3=M-1;v4=M;
elseif v1<M/2
    v2=v1;v1=v2-1;v3=v2+1;v4=v2+2;
else
    v3=v2;v1=v3-2;v2=v3-1;v4=v3+1;    
end


x_temp(1,1)=(v1-1)*M+u1;x_temp(1,2)=(v2-1)*M+u1;x_temp(1,3)=(v3-1)*M+u1;x_temp(1,4)=(v4-1)*M+u1;
x_temp(1,5)=(v1-1)*M+u2;x_temp(1,6)=(v2-1)*M+u2;x_temp(1,7)=(v3-1)*M+u2;x_temp(1,8)=(v4-1)*M+u2;
x_temp(1,9)=(v1-1)*M+u3;x_temp(1,10)=(v2-1)*M+u3;x_temp(1,11)=(v3-1)*M+u3;x_temp(1,12)=(v4-1)*M+u3;
x_temp(1,13)=(v1-1)*M+u4;x_temp(1,14)=(v2-1)*M+u4;x_temp(1,15)=(v3-1)*M+u4;x_temp(1,16)=(v4-1)*M+u4;


value_temp(1,1)=BiCubic(u-u1)*BiCubic(v-v1);value_temp(1,2)=BiCubic(u-u1)*BiCubic(v-v2);value_temp(1,3)=BiCubic(u-u1)*BiCubic(v-v3);value_temp(1,4)=BiCubic(u-u1)*BiCubic(v-v4);
value_temp(1,5)=BiCubic(u-u2)*BiCubic(v-v1);value_temp(1,6)=BiCubic(u-u2)*BiCubic(v-v2);value_temp(1,7)=BiCubic(u-u2)*BiCubic(v-v3);value_temp(1,8)=BiCubic(u-u2)*BiCubic(v-v4);
value_temp(1,9)=BiCubic(u-u3)*BiCubic(v-v1);value_temp(1,10)=BiCubic(u-u3)*BiCubic(v-v2);value_temp(1,11)=BiCubic(u-u3)*BiCubic(v-v3);value_temp(1,12)=BiCubic(u-u3)*BiCubic(v-v4);
value_temp(1,13)=BiCubic(u-u4)*BiCubic(v-v1);value_temp(1,14)=BiCubic(u-u4)*BiCubic(v-v2);value_temp(1,15)=BiCubic(u-u4)*BiCubic(v-v3);value_temp(1,16)=BiCubic(u-u4)*BiCubic(v-v4);



end

