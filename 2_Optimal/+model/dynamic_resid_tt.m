function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 96);

T(1) = (1+y(20))/(1+y(90));
T(2) = 1/params(11);
T(3) = x(it_, 3)^T(2);
T(4) = (params(11)-1)/params(11);
T(5) = y(36)^T(4);
T(6) = (1-x(it_, 3))^T(2);
T(7) = y(37)^T(4);
T(8) = T(3)*T(5)+T(6)*T(7);
T(9) = params(11)/(params(11)-1);
T(10) = y(34)^(-params(7));
T(11) = params(14)*y(38)^(-params(8));
T(12) = (y(38)*x(it_, 3)/y(36))^T(2);
T(13) = y(125)^(-params(7));
T(14) = (y(38)*(1-x(it_, 3))/y(37))^T(2);
T(15) = y(39)^(-params(7));
T(16) = y(126)^(-params(7));
T(17) = y(43)^T(4);
T(18) = y(44)^T(4);
T(19) = T(3)*T(17)+T(6)*T(18);
T(20) = params(14)*y(45)^(-params(8));
T(21) = (x(it_, 3)*y(45)/y(43))^T(2);
T(22) = ((1-x(it_, 3))*y(45)/y(44))^T(2);
T(23) = y(46)^(-params(7));
T(24) = y(127)^(-params(7));
T(25) = y(52)^T(4);
T(26) = y(53)^T(4);
T(27) = T(3)*T(25)+T(6)*T(26);
T(28) = params(14)*y(54)^(-params(8));
T(29) = (x(it_, 3)*y(54)/y(52))^T(2);
T(30) = ((1-x(it_, 3))*y(54)/y(53))^T(2);
T(31) = params(23)/2;
T(32) = y(91)^2;
T(33) = y(92)^2;
T(34) = params(12)*y(35)^(1+params(10));
T(35) = params(4)*params(23)*(y(125)/y(34))^(-params(7));
T(36) = (1+y(141))^2;
T(37) = T(35)*y(141)*T(36);
T(38) = params(13)*y(40)^(1+params(10));
T(39) = params(5)*params(23)*(y(126)/y(39))^(-params(7));
T(40) = (1+y(142))^2;
T(41) = T(39)*y(142)*T(40);
T(42) = y(15)^params(18);
T(43) = y(94)*T(42);
T(44) = y(65)^(1-params(18));
T(45) = (y(35)*params(1))^params(25);
T(46) = (y(40)*params(2))^(1-params(25));
T(47) = (y(84)/(1-params(18)))^(1-params(18));
T(48) = 1/y(94)*T(47);
T(49) = (y(89)/params(18))^params(18);
T(50) = (1+y(140))^params(22);
T(51) = (1+y(140))^(params(22)-1);
T(52) = (1-params(19)*(1+y(90))^(params(22)-1))/(1-params(19));
T(53) = params(19)*(1+y(90))^params(22);
T(54) = y(64)/y(16);
T(55) = params(21)/2*(T(54)-1)^2;
T(56) = params(21)*T(24)/T(23)*(y(131)/y(64)-1);
T(57) = (y(131)/y(64))^2;
T(58) = y(80)/y(22)-1;
T(59) = params(26)/2*T(58)^2;
T(60) = y(80)*T(59);
T(61) = y(60)*T(60);
T(62) = y(78)/y(20)-1;
T(63) = params(27)/2*T(62)^2;
T(64) = y(78)*T(63);
T(65) = y(58)*T(64);
T(66) = y(79)/y(21)-1;
T(67) = params(28)/2*T(66)^2;
T(68) = y(79)*T(67);
T(69) = y(61)*T(68);
T(70) = (1+y(79))*params(26)/(params(29)-1);
T(71) = y(80)^2;
T(72) = params(26)*params(6)*T(24)/T(23)/(params(29)-1);
T(73) = y(136)^2;
T(74) = T(72)*(y(136)/y(80)-1)*T(73)/y(80);
T(75) = T(74)*y(129);
T(76) = (1+y(79))*params(27)/(params(30)-1);
T(77) = y(78)^2;
T(78) = T(62)*T(76)*T(77);
T(79) = params(27)*params(6)*T(24)/T(23)/(params(30)-1);
T(80) = y(134)^2;
T(81) = T(79)*(y(134)/y(78)-1)*T(80)/y(78);
T(82) = T(81)*y(128);
T(83) = (1+y(79))*params(28)/(params(31)-1);
T(84) = y(79)^2;
T(85) = T(66)*T(83)*T(84);
T(86) = params(28)*params(6)*T(24)/T(23)/(params(31)-1);
T(87) = y(135)^2;
T(88) = T(86)*(y(135)/y(79)-1)*T(87)/y(79);
T(89) = T(88)*y(130);
T(90) = 1/(1+y(90));
T(91) = y(20)/(1+y(90));
T(92) = params(1)*params(2)*(y(102)-y(98))+params(1)*params(3)*(y(106)-y(98))+params(2)*params(3)*(y(106)-y(102));
T(93) = params(1)*params(2)*(y(103)-y(99))+params(1)*params(3)*(y(107)-y(99))+params(2)*params(3)*(y(107)-y(103));
T(94) = sqrt((y(37)-params(41))^2);
T(95) = sqrt((y(44)-params(41))^2);
T(96) = sqrt((y(53)-params(41))^2);

end
