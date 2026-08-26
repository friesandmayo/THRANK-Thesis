function T = dynamic_g2_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g2_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 268);

T = model_irf.dynamic_g1_tt(T, y, x, params, steady_state, it_);

T(232) = (-((-(1+y(20)))*(T(1)+T(1))))/(T(221)*T(221));
T(233) = getPowerDeriv(T(7),T(8),2);
T(234) = getPowerDeriv(y(34),(-params(7)),2);
T(235) = getPowerDeriv(y(125),(-params(7)),2);
T(236) = getPowerDeriv(y(38)*params(40)/y(36),T(3),2);
T(237) = params(14)*getPowerDeriv(y(38),(-params(8)),2);
T(238) = getPowerDeriv(y(38)*(1-params(40))/y(37),T(3),2);
T(239) = getPowerDeriv(y(39),(-params(7)),2);
T(240) = getPowerDeriv(y(126),(-params(7)),2);
T(241) = (-(params(5)*(-T(16))/(T(13)*T(13))));
T(242) = getPowerDeriv(T(17),T(8),2);
T(243) = getPowerDeriv(params(40)*y(45)/y(43),T(3),2);
T(244) = params(14)*getPowerDeriv(y(45),(-params(8)),2);
T(245) = getPowerDeriv((1-params(40))*y(45)/y(44),T(3),2);
T(246) = getPowerDeriv(y(46),(-params(7)),2);
T(247) = getPowerDeriv(y(127),(-params(7)),2);
T(248) = (-(params(6)*(-T(22))/(T(13)*T(13))));
T(249) = getPowerDeriv(T(24),T(8),2);
T(250) = getPowerDeriv(params(40)*y(54)/y(52),T(3),2);
T(251) = params(14)*getPowerDeriv(y(54),(-params(8)),2);
T(252) = getPowerDeriv((1-params(40))*y(54)/y(53),T(3),2);
T(253) = getPowerDeriv(y(125)/y(34),(-params(7)),2);
T(254) = params(12)*getPowerDeriv(y(35),1+params(10),2);
T(255) = getPowerDeriv(y(126)/y(39),(-params(7)),2);
T(256) = params(13)*getPowerDeriv(y(40),1+params(10),2);
T(257) = (-((-y(64))*(y(16)+y(16))))/(y(16)*y(16)*y(16)*y(16));
T(258) = T(54)*(2*(T(55)-1)*T(257)+T(171)*2*T(171));
T(259) = T(172)+y(64)*T(54)*(2*(T(55)-1)*(-1)/(y(16)*y(16))+T(171)*2*T(173));
T(260) = y(58)*y(78)*T(66)*(2*T(67)*(-((-y(78))*(y(20)+y(20))))/(y(20)*y(20)*y(20)*y(20))+T(181)*2*T(181));
T(261) = y(58)*(T(66)*T(181)*2*T(67)+y(78)*T(66)*(2*T(67)*(-1)/(y(20)*y(20))+T(181)*2*T(186)));
T(262) = y(61)*y(79)*T(71)*(2*T(72)*(-((-y(79))*(y(21)+y(21))))/(y(21)*y(21)*y(21)*y(21))+T(194)*2*T(194));
T(263) = y(61)*(T(71)*T(194)*2*T(72)+y(79)*T(71)*(2*T(72)*(-1)/(y(21)*y(21))+T(194)*2*T(197)));
T(264) = y(60)*y(80)*T(61)*(2*T(62)*(-((-y(80))*(y(22)+y(22))))/(y(22)*y(22)*y(22)*y(22))+T(205)*2*T(205));
T(265) = y(60)*(T(61)*T(205)*2*T(62)+y(80)*T(61)*(2*T(62)*(-1)/(y(22)*y(22))+T(205)*2*T(208)));
T(266) = (T(21)*T(21)*(-(params(6)*T(22)*T(246)))-(-(params(6)*T(22)*T(140)))*(T(21)*T(140)+T(21)*T(140)))/(T(21)*T(21)*T(21)*T(21));
T(267) = (-(T(140)*params(6)*T(150)))/(T(21)*T(21));
T(268) = (-((-y(20))*(T(1)+T(1))))/(T(221)*T(221));

end
