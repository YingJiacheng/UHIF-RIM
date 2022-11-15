function E = cal_E(Y, X, R, V, S,eta,gamma)
%this function is used to calculate the coefficient by solving Sylvetser
%and using L2 norm
%equation
%input : Y: MS pic 
%        X: RGB pic
%        R: spectral response matrix
%        V: spectral basis
%        S: filter matrix
%        yita,lambda: coeffient
%output: E: the coeffient of basis
% 

[M,N,~]=size(X);
[m,n,L]=size(Y);
[L,K]=size(V);

Y=cube2mat(Y);
X=cube2mat(X);

MN=M*N;
I_MN=sparse(1:MN,1:MN,1,MN,MN);


A=(V'*V)\(eta*V'*R'*R*V+gamma*eye(K));
B=S*S';
C=(V'*V)\(V'*Y*S'+eta*V'*R'*X);

E=Sylvester(A,B,C);

end