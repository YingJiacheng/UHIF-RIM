clear all;
addpath(genpath('./functions/'));


HS0 = importdata('./datasets/Pavia_University/HS0.mat');
HS1 = importdata('./datasets/Pavia_University/HS1.mat');
R = importdata('./datasets/Pavia_University/R.mat');

bin = 8;
[M,N,L] = size(HS0);
M = floor(M/bin)*bin;
N = floor(N/bin)*bin;
HS1 = HS1(1:M,1:N,:);
HS0 = HS0(1:M,1:N,:);
MS1 = mat2cube(R*cube2mat(HS1),M,N);

psf = fspecial('gaussian',3*bin/2-1,3*bin/8);
LR0_temp = imfilter(HS0, psf, 'circular', 'conv');
LR_HS0 = LR0_temp(1:bin:end,1:bin:end,:);
[m,n,~] = size(LR_HS0);

%%fuse LR_HS0 and MS1, groundtruth is HS1, spectra mapping function is R
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%generate up sampled MSO and degrated RGB0
upsampled_HS0=Upsample(LR_HS0,bin);
upsampled_MS0=mat2cube(R*cube2mat(upsampled_HS0),M,N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%generate down-sampled LR-RGB1 and degrated LR-RGB0
LR_MS0=mat2cube(R*cube2mat(LR_HS0),m,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculate affine parm p:MS1->upsampled MS0
p = estimate_affine_parameter(sum(LR_MS0,3)/size(LR_MS0,3),sum(MS1,3)/size(MS1,3)); %NED

%calculate spatial degration matrix
B = cal_B(M,N,psf);
S = cal_S(p,M,N,m,n,bin);
S = B*S;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculate spectral basis V and coefficient matrix E
K = 6;
V = get_spec_basic(cube2mat(LR_HS0),K);

eta = 0.1;
gamma = 1e-5;
E = cal_E(LR_HS0, MS1, R, V, S, eta, gamma);
Z_res = mat2cube(V*E,M,N);

t=toc;

[SAM, RMSE, PSNR,ERGAS]=cal_quality(HS1,Z_res,bin);
fprintf('SAM: %.4f  RMSE: %.4f  PSNR: %.4f ERGAS: %.4f Time:%.4f\n',SAM, RMSE, PSNR,ERGAS, t);      

