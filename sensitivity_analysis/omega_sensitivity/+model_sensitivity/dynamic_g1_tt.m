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

assert(length(T) >= 85);

T = model_sensitivity.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(65) = getPowerDeriv(y(22),(-params(9)),1);
T(66) = getPowerDeriv(y(96)/y(22),(-params(9)),1);
T(67) = getPowerDeriv(y(96),(-params(9)),1);
T(68) = params(14)*getPowerDeriv(y(23),1+params(12),1);
T(69) = getPowerDeriv(y(26)*x(it_, 3)/y(24),T(7),1);
T(70) = getPowerDeriv(T(16),params(13)/(params(13)-1),1);
T(71) = getPowerDeriv(y(26)*(1-x(it_, 3))/y(25),T(7),1);
T(72) = params(15)*getPowerDeriv(y(26),(-params(10)),1);
T(73) = getPowerDeriv(y(27),(-params(9)),1);
T(74) = getPowerDeriv(y(97)/y(27),(-params(9)),1);
T(75) = getPowerDeriv(y(97),(-params(9)),1);
T(76) = params(14)*getPowerDeriv(y(28),1+params(12),1);
T(77) = getPowerDeriv(y(31),(-params(9)),1);
T(78) = getPowerDeriv(y(98),(-params(9)),1);
T(79) = params(19)/2*(-y(45))/(y(12)*y(12))*2*(T(35)-1);
T(80) = params(19)/2*2*(T(35)-1)*1/y(12);
T(81) = 1/(1+y(71));
T(82) = y(40)*y(67)*params(29)/2*(-y(67))/(y(16)*y(16))*2*T(43);
T(83) = y(40)*(T(44)+y(67)*params(29)/2*2*T(43)*1/y(16));
T(84) = y(41)*y(68)*params(28)/2*(-y(68))/(y(17)*y(17))*2*T(39);
T(85) = y(41)*(T(40)+y(68)*params(28)/2*2*T(39)*1/y(17));

end
