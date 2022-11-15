function [cube] =mat2cube(mat,M,N)
%this function is uused to transform a matrix into a cube
[L,MN]=size(mat);
cube=reshape(mat',[M,N,L]);

end

