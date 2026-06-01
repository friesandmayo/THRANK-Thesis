function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 79);

T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(63) = getPowerDeriv(y(22),(-params(8)),1);
T(64) = getPowerDeriv(y(95)/y(22),(-params(8)),1);
T(65) = getPowerDeriv(y(95),(-params(8)),1);
T(66) = params(13)*getPowerDeriv(y(23),1+params(11),1);
T(67) = getPowerDeriv(y(26)*x(it_, 3)/y(24),T(7),1);
T(68) = getPowerDeriv(T(16),params(12)/(params(12)-1),1);
T(69) = getPowerDeriv(y(26)*(1-x(it_, 3))/y(25),T(7),1);
T(70) = params(14)*getPowerDeriv(y(26),(-params(9)),1);
T(71) = getPowerDeriv(y(27),(-params(8)),1);
T(72) = getPowerDeriv(y(96)/y(27),(-params(8)),1);
T(73) = getPowerDeriv(y(96),(-params(8)),1);
T(74) = params(13)*getPowerDeriv(y(28),1+params(11),1);
T(75) = getPowerDeriv(y(31),(-params(8)),1);
T(76) = getPowerDeriv(y(97),(-params(8)),1);
T(77) = params(18)/2*(-y(45))/(y(12)*y(12))*2*(T(35)-1);
T(78) = params(18)/2*2*(T(35)-1)*1/y(12);
T(79) = 1/(1+y(71));

end
