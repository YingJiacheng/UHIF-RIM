function ERGAS = ERGAS_func(I,I_Fus,Resize_fact)
%**************************************************************************
% USAGE: Calculate Relative Dimensionless Global Error in Synthesis Metric
%        
% INPUT:
    %  ref-> the ground truth multispectral image
    %  tar-> the reconstructed multispectral image
    %  Resize_fact -> binning factor
% OUTPUT:
    %  ERGAS -> relative dimensionless global error in synthesis metric
%**************************************************************************  
I = double(I);
I_Fus = double(I_Fus);

Err=I-I_Fus;
ERGAS=0;
for iLR=1:size(Err,3)
    ERGAS=ERGAS+mean2(Err(:,:,iLR).^2)/(mean2((I(:,:,iLR))))^2;   
end

ERGAS = (100/Resize_fact) * sqrt((1/size(Err,3)) * ERGAS);

end