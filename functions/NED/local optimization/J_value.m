function y = J_value(fr1,fr2)

m = func_rho(fr1-fr2,0) ;
n = func_rho(fr1,0) + func_rho(fr2,0) ;
y = m/(n+eps);

