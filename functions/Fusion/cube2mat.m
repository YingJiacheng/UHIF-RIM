function [mat] = cube2mat(cube)
%transform a datacube into a matrix
[M,N,L]=size(cube);
mat=reshape(cube,[M*N,L])';

end

