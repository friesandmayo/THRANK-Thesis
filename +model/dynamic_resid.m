function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(73, 1);
    residual(1) = (y(22)+y(24)+y(25)) - (y(62)*y(23)+(1+y(16))/(1+y(71))*y(1)+(1+y(18))/(1+y(71))*y(2)+y(54));
    residual(2) = (params(20)*y(72)*(1+y(72))) - (y(23)*(1-params(21))+params(21)*T(1)/T(2)/y(62)+T(5)/(1+y(108)));
    residual(3) = (T(2)) - (T(6)*T(8)+params(4)*T(9)*(1+y(67))/(1+y(108)));
    residual(4) = (T(2)) - (T(6)*T(10)+params(4)*T(9)*(1+y(69))/(1+y(108)));
    residual(5) = (y(26)) - (T(16)^(params(12)/(params(12)-1)));
    residual(6) = (y(27)+y(64)*y(29)+(1+y(17))/(1+y(71))*y(4)) - (y(63)*y(28)+y(64)*y(3)+y(30));
    residual(7) = (y(30)) - (y(29)*(1+y(108))*params(23)*y(103)/(1+y(68)));
    residual(8) = (params(20)*y(73)*(1+y(73))) - ((1-params(21))*y(28)+params(21)*T(17)/T(18)/y(63)+T(21)/(1+y(108)));
    residual(9) = (y(64)*T(18)) - (params(15)*y(29)^(-params(10))+params(5)*y(103)*T(22)+(1+y(108))*y(103)*params(23)*y(74)/(1+y(68)));
    residual(10) = (T(18)) - (y(74)+params(5)*(1+y(68))*T(22)/(1+y(108)));
    residual(11) = (y(31)+y(64)*y(32)+y(65)*y(35)+y(33)) - (y(66)*y(7)+y(36)+(1+y(18))/(1+y(71))*y(6)+y(64)*y(5)+y(56));
    residual(12) = (y(34)) - (y(35)+y(7)*(1-params(17)));
    residual(13) = (y(64)*T(23)) - (params(16)*y(32)^(-params(10))+params(6)*y(103)*T(24));
    residual(14) = (y(65)*T(23)) - (params(6)*T(24)*(y(105)+(1-params(17))*y(104)));
    residual(15) = (T(23)) - (params(6)*(1+y(69))*T(24)/(1+y(108)));
    residual(16) = (1+y(72)) - ((1+y(71))*y(62)/y(14));
    residual(17) = (1+y(73)) - ((1+y(71))*y(63)/y(15));
    residual(18) = (y(23)*y(62)*params(1)) - (params(22)*y(61)*y(46));
    residual(19) = (y(28)*y(63)*params(2)) - (y(46)*y(61)*(1-params(22)));
    residual(20) = (y(43)*y(51)) - (T(26)*T(27));
    residual(21) = (y(47)) - (T(29)*T(30));
    residual(22) = (y(66)/y(61)) - (params(24)/(1-params(24))*y(46)/y(11));
    residual(23) = (y(52)) - (y(47)*T(23)*y(43)+params(6)*params(25)*T(31)*y(101));
    residual(24) = (y(53)) - (T(23)*y(43)+params(6)*params(25)*T(32)*y(102));
    residual(25) = (y(60)) - (params(19)/(params(19)-1)*y(52)/y(53));
    residual(26) = (y(60)) - (T(33)^(1/(1-params(19))));
    residual(27) = (y(51)) - ((1-params(25))*y(60)^(-params(19))+T(34)*y(13));
    residual(28) = (y(65)) - (1+T(35)*params(18)*(T(35)-1)+T(36)-params(6)*T(37)*T(38));
    residual(29) = (y(48)) - (y(43)-y(61)*y(46)-y(66)*y(11));
    residual(30) = (y(49)) - (y(65)*y(45)-y(45)*(1+T(36)));
    residual(31) = (y(59)+y(41)) - (y(58)+y(40)+y(42));
    residual(32) = (y(59)) - (y(40)*params(26));
    residual(33) = (y(50)) - ((y(17)-y(19))/(1+y(71))*y(9)-(y(16)-y(18)*params(26)-y(19)*(1-params(26)))/(1+y(71))*y(8)-(y(18)-y(19))/(1+y(71))*y(10)-y(41)*T(41)-y(40)*T(44));
    residual(34) = (y(68)) - (params(29)/(params(29)-1)*y(70)-T(47)/y(17)+(1+y(69))*T(51)/y(41));
    residual(35) = (y(67)) - (params(30)/(params(30)-1)*(y(69)*params(26)+(1-params(26))*y(70))+T(54)/y(16)-(1+y(69))*T(58)/y(40));
    residual(36) = (y(39)) - (y(50)+y(48)+y(49));
residual(37) = y(57);
    residual(38) = (y(54)) - (params(7)/(1-params(7))*((steady_state(41))*(steady_state(2))+(steady_state(46))*(steady_state(3))+(steady_state(48))*(steady_state(4))));
residual(39) = y(55);
    residual(40) = (log((1+y(69))/(1+params(34)))) - (params(37)*log((1+y(18))/(1+params(34)))+(1-params(37))*params(31)*log(1+y(71))+y(76));
    residual(41) = (y(70)) - (y(69)+y(58)*params(32));
    residual(42) = (y(58)) - (y(59)+y(25)*params(1));
    residual(43) = (y(37)) - (y(22)*params(1)+y(27)*params(2)+y(31)*params(3));
    residual(44) = (y(46)) - (T(59)*T(60));
    residual(45) = (y(40)) - (y(24)*params(1));
    residual(46) = (0) - (y(54)*params(1)+y(56)*params(3));
    residual(47) = (y(38)) - (y(29)*params(2)+y(32)*params(3));
    residual(48) = (y(41)) - (y(30)*params(2));
    residual(49) = (y(45)) - (y(35)*params(3));
    residual(50) = (y(44)) - (y(34)*params(3));
    residual(51) = (y(42)) - (y(33)*params(3));
    residual(52) = (y(39)) - (y(36)*params(3));
    residual(53) = (y(38)) - (params(33));
    residual(54) = (log(y(75))) - (params(35)*log(y(20))+x(it_, 1));
    residual(55) = (y(76)) - (params(36)*y(21)+x(it_, 2));
    residual(56) = (y(79)) - (y(54)+y(62)*y(23)+y(1)*y(16)/(1+y(71))+y(2)*y(18)/(1+y(71)));
    residual(57) = (y(80)) - (y(24)+y(25));
    residual(58) = (y(83)) - (y(63)*y(28));
    residual(59) = (y(84)) - (y(64)*y(29)-y(30));
    residual(60) = (y(87)) - (y(56)+y(36)+y(66)*y(7)+y(6)*y(18)/(1+y(71)));
    residual(61) = (y(88)) - (y(33)+y(64)*y(32)+y(65)*y(34));
    residual(62) = (y(90)) - (100*(params(1)*y(79)+params(2)*y(83)+params(3)*y(87)));
    residual(63) = (y(91)) - (100*(params(1)*y(80)+params(2)*y(84)+params(3)*y(88)));
    residual(64) = (y(92)) - (params(3)*y(88)*100/y(91));
    residual(65) = (y(77)) - (y(22)^(1-params(8))/(1-params(8))+params(14)*y(26)^(1-params(9))/(1-params(9))-T(1)/(1+params(11)));
    residual(66) = (y(81)) - (y(27)^(1-params(8))/(1-params(8))+params(15)*y(29)^(1-params(10))/(1-params(10))-T(17)/(1+params(11)));
    residual(67) = (y(85)) - (y(31)^(1-params(8))/(1-params(8))+params(16)*y(32)^(1-params(10))/(1-params(10)));
    residual(68) = (y(78)) - (y(77)+params(4)*y(111));
    residual(69) = (y(82)) - (y(81)+params(5)*y(112));
    residual(70) = (y(86)) - (y(85)+params(6)*y(113));
    residual(71) = (y(89)) - (params(1)*y(78)+params(2)*y(82)+params(3)*y(86));
    residual(72) = (y(94)) - (T(61)/(params(1)*y(79)+params(2)*y(83)+params(3)*y(87)));
    residual(73) = (y(93)) - (T(62)/(params(1)*y(80)+params(2)*y(84)+params(3)*y(88)));

end
