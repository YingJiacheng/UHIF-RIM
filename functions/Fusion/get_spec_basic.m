function A=get_spec_basic(LR_mat,k)
%unmix the LR_mat to get the Specetral basic

   param.K = k;
   param.numThreads = -1;
   param.iter = 3000;
   param.mode = 1;
   param.lambda = 10e-9;
   param.posD = 1; 
   param.posAlpha = 1;
%    param.D = A_vca;
   param.verbose = 0;

   A = mexTrainDL(LR_mat,param);
end

