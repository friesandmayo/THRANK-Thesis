function T = static_g1_tt(T, y, x, params)
% function T = static_g1_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 47);

T = model.static_resid_tt(T, y, x, params);

T(33) = getPowerDeriv(y(1),(-params(9)),1);
T(34) = params(14)*getPowerDeriv(y(2),1+params(12),1);
T(35) = getPowerDeriv(y(5)*x(3)/y(3),T(6),1);
T(36) = getPowerDeriv(T(12),params(13)/(params(13)-1),1);
T(37) = getPowerDeriv(y(5)*(1-x(3))/y(4),T(6),1);
T(38) = params(15)*getPowerDeriv(y(5),(-params(10)),1);
T(39) = getPowerDeriv(y(6),(-params(9)),1);
T(40) = params(14)*getPowerDeriv(y(7),1+params(12),1);
T(41) = getPowerDeriv(y(10),(-params(9)),1);
T(42) = y(43)*T(41);
T(43) = 1/(1+y(50));
T(44) = 1/(1+params(35))/((1+y(48))/(1+params(35)));
T(45) = (1+y(50))*(1+y(50));
T(46) = getPowerDeriv(1+y(50),params(20),1);
T(47) = getPowerDeriv(1+y(50),params(20)-1,1);

end
