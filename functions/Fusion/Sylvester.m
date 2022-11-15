function E=Sylvester(A,B,C)
%solving the Sylvester eqeation AE+EB=C
%A:K*K
%B:MN*MN

[K,MN]=size(C);

[Q,D]=eig(A);
C1=Q\C;

I_MN=sparse(1:MN,1:MN,1,MN,MN);

F=zeros(K,MN);
for i=1:K
    f=(pcg((D(i,i)*I_MN+B)',C1(i,:)',1e-7,20))';
    F(i,:)=f;
end

E=Q*F;
end

