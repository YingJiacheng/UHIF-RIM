function [value, map] = RMSE_func(ref,tar)
%**************************************************************************
% USAGE: Evaluate the Quality of Reconstructed Multispectral Image
%        
% INPUT:
    %  ref-> the ground truth multispectral image
    %  tar-> the reconstructed multispectral image
% OUTPUT:
    %  value & map -> root mean squared error metric
%**************************************************************************  
max_I = max(ref(:));
ref = ref/max_I*255;
tar = tar/max_I*255;

[rows,cols,bands] = size(ref);
value = (sum(sum(sum((tar-ref).^2)))/(rows*cols*bands)).^0.5;

map = zeros(rows,cols);
for i = 1:rows
    for j = 1:cols
        map(i,j) = (sum((ref(i,j,:)-tar(i,j,:)).^2)/bands).^0.5;
    end
end

