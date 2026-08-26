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

assert(length(T) >= 133);

T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(97) = getPowerDeriv(y(34),(-params(7)),1);
T(98) = getPowerDeriv(y(125)/y(34),(-params(7)),1);
T(99) = getPowerDeriv(y(125),(-params(7)),1);
T(100) = params(12)*getPowerDeriv(y(35),1+params(10),1);
T(101) = getPowerDeriv(T(8),T(9),1);
T(102) = getPowerDeriv(y(38)*x(it_, 3)/y(36),T(2),1);
T(103) = getPowerDeriv(y(38)*(1-x(it_, 3))/y(37),T(2),1);
T(104) = params(14)*getPowerDeriv(y(38),(-params(8)),1);
T(105) = getPowerDeriv(y(39),(-params(7)),1);
T(106) = getPowerDeriv(y(126)/y(39),(-params(7)),1);
T(107) = getPowerDeriv(y(126),(-params(7)),1);
T(108) = params(13)*getPowerDeriv(y(40),1+params(10),1);
T(109) = getPowerDeriv(T(19),T(9),1);
T(110) = getPowerDeriv(x(it_, 3)*y(45)/y(43),T(2),1);
T(111) = getPowerDeriv((1-x(it_, 3))*y(45)/y(44),T(2),1);
T(112) = params(14)*getPowerDeriv(y(45),(-params(8)),1);
T(113) = getPowerDeriv(y(46),(-params(7)),1);
T(114) = (-(params(6)*T(24)*T(113)))/(T(23)*T(23));
T(115) = getPowerDeriv(y(127),(-params(7)),1);
T(116) = getPowerDeriv(T(27),T(9),1);
T(117) = getPowerDeriv(x(it_, 3)*y(54)/y(52),T(2),1);
T(118) = getPowerDeriv((1-x(it_, 3))*y(54)/y(53),T(2),1);
T(119) = params(14)*getPowerDeriv(y(54),(-params(8)),1);
T(120) = params(21)/2*(-y(64))/(y(16)*y(16))*2*(T(54)-1);
T(121) = params(21)/2*2*(T(54)-1)*1/y(16);
T(122) = y(58)*y(78)*params(27)/2*(-y(78))/(y(20)*y(20))*2*T(62);
T(123) = (-(params(5)*T(16)/(1+y(140))));
T(124) = (-(params(6)*T(24)/(1+y(140))));
T(125) = y(58)*(T(63)+y(78)*params(27)/2*2*T(62)*1/y(20));
T(126) = y(61)*y(79)*params(28)/2*(-y(79))/(y(21)*y(21))*2*T(66);
T(127) = y(61)*(T(67)+y(79)*params(28)/2*2*T(66)*1/y(21));
T(128) = y(60)*y(80)*params(26)/2*(-y(80))/(y(22)*y(22))*2*T(58);
T(129) = y(60)*(T(59)+y(80)*params(26)/2*2*T(58)*1/y(22));
T(130) = (1+y(90))*(1+y(90));
T(131) = (-(1+y(20)))/T(130);
T(132) = getPowerDeriv(x(it_, 3),T(2),1);
T(133) = (-(getPowerDeriv(1-x(it_, 3),T(2),1)));

end
