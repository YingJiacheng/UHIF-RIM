function [SAM, RMSE, PSNR,ERGAS] = cal_quality(ref,tar,B)
%**************************************************************************
% Author: Zhiwei Pan 
% Zhejiang University, College of Information Science & Electronic Engineering
% Email: pankdda@zju.edu.cn
%
% USAGE: Evaluate the Quality of Reconstructed Multispectral Image
%        
% INPUT:
    %  ref-> the ground truth multispectral image
    %  tar-> the reconstructed multispectral image
    %  B-> binning factor
% OUTPUT:
    %  CC-> cross correlation metric
    %  SAM & SAM_map -> spectral angle mapper metric
    %  RMSE & RMSE_map -> root mean squared error metric
    %  ERGAS -> relative dimensionless global error in synthesis metric
    %  PSNR -> peak signal to noise ration metric   
%**************************************************************************  
% ref(:,:,channel_num) = [];
% tar(:,:,channel_num) = [];

% CC = CC_func(ref, tar);
[SAM, SAM_map] = SAM_func(ref, tar);
[RMSE, RMSE_map] = RMSE_func(ref, tar);
ERGAS = ERGAS_func(ref, tar, B);
[PSNR, psnrall] = PSNR_func(ref, tar);
