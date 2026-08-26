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

assert(length(T) >= 109);

T(1) = 1+y(90);
T(2) = (1+y(20))/T(1);
T(3) = 1/params(11);
T(4) = params(40)^T(3);
T(5) = (params(11)-1)/params(11);
T(6) = (1-params(40))^T(3);
T(7) = T(4)*y(36)^T(5)+T(6)*y(37)^T(5);
T(8) = params(11)/(params(11)-1);
T(9) = y(34)^(-params(7));
T(10) = params(14)*y(38)^(-params(8));
T(11) = (y(38)*params(40)/y(36))^T(3);
T(12) = y(125)^(-params(7));
T(13) = 1+y(140);
T(14) = (y(38)*(1-params(40))/y(37))^T(3);
T(15) = y(39)^(-params(7));
T(16) = y(126)^(-params(7));
T(17) = T(4)*y(43)^T(5)+T(6)*y(44)^T(5);
T(18) = params(14)*y(45)^(-params(8));
T(19) = (params(40)*y(45)/y(43))^T(3);
T(20) = ((1-params(40))*y(45)/y(44))^T(3);
T(21) = y(46)^(-params(7));
T(22) = y(127)^(-params(7));
T(23) = 1+y(79);
T(24) = T(4)*y(52)^T(5)+T(6)*y(53)^T(5);
T(25) = params(14)*y(54)^(-params(8));
T(26) = (params(40)*y(54)/y(52))^T(3);
T(27) = ((1-params(40))*y(54)/y(53))^T(3);
T(28) = params(23)/2;
T(29) = y(91)^2;
T(30) = y(92)^2;
T(31) = params(12)*y(35)^(1+params(10));
T(32) = params(4)*params(23)*(y(125)/y(34))^(-params(7));
T(33) = (1+y(141))^2;
T(34) = T(32)*y(141)*T(33);
T(35) = params(13)*y(40)^(1+params(10));
T(36) = params(5)*params(23)*(y(126)/y(39))^(-params(7));
T(37) = (1+y(142))^2;
T(38) = T(36)*y(142)*T(37);
T(39) = y(15)^params(18);
T(40) = y(94)*T(39);
T(41) = y(65)^(1-params(18));
T(42) = (y(35)*params(1))^params(25);
T(43) = (y(40)*params(2))^(1-params(25));
T(44) = 1/y(94);
T(45) = (y(84)/(1-params(18)))^(1-params(18));
T(46) = T(44)*T(45);
T(47) = (y(89)/params(18))^params(18);
T(48) = params(18)/(1-params(18));
T(49) = T(13)^params(22);
T(50) = T(13)^(params(22)-1);
T(51) = params(22)/(params(22)-1);
T(52) = (1-params(19)*T(1)^(params(22)-1))/(1-params(19));
T(53) = params(19)*T(1)^params(22);
T(54) = params(21)/2;
T(55) = y(64)/y(16);
T(56) = T(54)*(T(55)-1)^2;
T(57) = params(21)*T(22)/T(21);
T(58) = y(131)/y(64)-1;
T(59) = T(57)*T(58);
T(60) = (y(131)/y(64))^2;
T(61) = params(26)/2;
T(62) = y(80)/y(22)-1;
T(63) = T(61)*T(62)^2;
T(64) = y(80)*T(63);
T(65) = y(60)*T(64);
T(66) = params(27)/2;
T(67) = y(78)/y(20)-1;
T(68) = T(66)*T(67)^2;
T(69) = y(78)*T(68);
T(70) = y(58)*T(69);
T(71) = params(28)/2;
T(72) = y(79)/y(21)-1;
T(73) = T(71)*T(72)^2;
T(74) = y(79)*T(73);
T(75) = y(61)*T(74);
T(76) = T(23)*params(26)/(params(29)-1);
T(77) = y(80)^2;
T(78) = params(26)*params(6)*T(22)/T(21)/(params(29)-1);
T(79) = y(136)/y(80)-1;
T(80) = y(136)^2;
T(81) = T(78)*T(79)*T(80)/y(80);
T(82) = T(81)*y(129);
T(83) = T(23)*params(27)/(params(30)-1);
T(84) = y(78)^2;
T(85) = T(67)*T(83)*T(84);
T(86) = params(27)*params(6)*T(22)/T(21)/(params(30)-1);
T(87) = y(134)/y(78)-1;
T(88) = y(134)^2;
T(89) = T(86)*T(87)*T(88)/y(78);
T(90) = T(89)*y(128);
T(91) = T(23)*params(28)/(params(31)-1);
T(92) = y(79)^2;
T(93) = T(72)*T(91)*T(92);
T(94) = params(28)*params(6)*T(22)/T(21)/(params(31)-1);
T(95) = y(135)/y(79)-1;
T(96) = y(135)^2;
T(97) = T(94)*T(95)*T(96)/y(79);
T(98) = T(97)*y(130);
T(99) = 1/T(1);
T(100) = (1+y(81))/(1+(steady_state(48)));
T(101) = (1+y(23))/(1+(steady_state(48)));
T(102) = y(20)/T(1);
T(103) = params(1)*y(98)+params(2)*y(102)+params(3)*y(106);
T(104) = params(1)*y(99)+params(2)*y(103)+params(3)*y(107);
T(105) = params(1)*params(2)*(y(102)-y(98))+params(1)*params(3)*(y(106)-y(98))+params(2)*params(3)*(y(106)-y(102));
T(106) = params(1)*params(2)*(y(103)-y(99))+params(1)*params(3)*(y(107)-y(99))+params(2)*params(3)*(y(107)-y(103));
T(107) = sqrt((y(37)-params(41))^2);
T(108) = sqrt((y(44)-params(41))^2);
T(109) = sqrt((y(53)-params(41))^2);

end
