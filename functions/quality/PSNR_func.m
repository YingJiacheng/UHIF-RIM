function [out_avg, out_ind] = PSNR_func(ref,tar)
%**************************************************************************
% USAGE: Calculate the Peak Signal to Noise Ration Metric  
%        
% INPUT:
    %  ref-> the ground truth multispectral image
    %  tar-> the reconstructed multispectral image
% OUTPUT:
    %  out -> peak signal to noise ration metric   
%**************************************************************************  
tar = double(tar);
ref = double(ref);
[R,C,L] = size(ref);
out_avg = 0;
out_ind = zeros(L,1);
for kk = 1:L
    I = tar(:,:,kk);
    Igt = ref(:,:,kk);
    MAX = max(Igt(:));
    mse = sum(sum((I-Igt).^2))/(R*C);
    psnr_temp = 10 * log10(MAX^2/ mse);
    out_ind(kk,1) = psnr_temp;
    out_avg = out_avg + psnr_temp;
end
out_avg = out_avg/L;