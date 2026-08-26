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
    T = model_irf.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(91, 1);
    residual(1) = (y(34)+y(36)+y(37)+y(73)) - (y(85)*y(35)+T(2)*y(1)+(1+y(31))/T(1)*y(2));
    residual(2) = (y(38)) - (T(7)^T(8));
    residual(3) = (T(9)) - (T(10)*T(11)+params(4)*T(12)*(1+y(78))/T(13));
    residual(4) = (T(9)) - (T(10)*T(14)+params(4)*T(12)*(1+y(119))/T(13));
    residual(5) = (y(39)+y(87)*y(41)+y(43)+y(44)+(1+y(22))/T(1)*y(4)+y(74)) - (y(86)*y(40)+y(87)*y(3)+y(42)+T(2)*y(5)+(1+y(32))/T(1)*y(6));
    residual(6) = (y(42)) - (y(41)*T(13)*params(16)*y(137)/(1+y(80)));
    residual(7) = (y(87)*T(15)) - (params(15)*y(41)^(-params(9))+params(5)*y(137)*T(16)+T(13)*y(137)*params(16)*y(93)/(1+y(80)));
    residual(8) = (T(15)) - (y(93)+params(5)*(1+y(80))*T(16)/T(13));
    residual(9) = (y(45)) - (T(17)^T(8));
    residual(10) = (T(15)) - (T(18)*T(19)+params(5)*(1+y(78))*T(16)/T(13));
    residual(11) = (T(15)) - (T(18)*T(20)+params(5)*T(16)*(1+y(120))/T(13));
    residual(12) = (y(46)+y(87)*y(47)+y(88)*y(50)+y(48)+y(52)+y(53)) - (y(89)*y(9)+y(51)+(1+y(21))/T(1)*y(8)+y(87)*y(7)+T(2)*y(10)+(1+y(33))/T(1)*y(11));
    residual(13) = (y(49)) - (y(50)+y(9)*(1-params(20)));
    residual(14) = (y(87)*T(21)) - (params(15)*y(47)^(-params(9))+params(6)*y(137)*T(22));
    residual(15) = (y(88)*T(21)) - (params(6)*T(22)*(y(139)+(1-params(20))*y(138)));
    residual(16) = (T(21)) - (params(6)*T(22)*T(23)/T(13));
    residual(17) = (y(54)) - (T(24)^T(8));
    residual(18) = (T(21)) - (T(25)*T(26)+params(6)*(1+y(78))*T(22)/T(13));
    residual(19) = (T(21)) - (T(25)*T(27)+params(6)*T(22)*(1+y(121))/T(13));
    residual(20) = (y(73)) - (y(85)*T(28)*T(29));
    residual(21) = (y(74)) - (y(86)*T(28)*T(30));
    residual(22) = (1+y(91)) - (T(1)*y(85)/y(25));
    residual(23) = (1+y(92)) - (T(1)*y(86)/y(26));
    residual(24) = ((1+y(91))*params(23)*y(91)) - (y(35)*(1-params(24))+params(24)*T(31)/T(9)/y(85)+T(34)/T(13));
    residual(25) = ((1+y(92))*params(23)*y(92)) - (y(40)*(1-params(24))+params(24)*T(35)/T(15)/y(86)+T(38)/T(13));
    residual(26) = (y(67)) - (y(62)-y(84)*y(65)-y(89)*y(15));
    residual(27) = (y(62)*y(70)) - (T(40)*T(41));
    residual(28) = (y(65)) - (T(42)*T(43));
    residual(29) = (y(35)*y(85)*params(1)) - (y(65)*y(84)*params(25));
    residual(30) = (y(40)*y(86)*params(2)) - (y(65)*y(84)*(1-params(25)));
    residual(31) = (y(66)) - (T(46)*T(47));
    residual(32) = (y(89)/y(84)) - (T(48)*y(65)/y(15));
    residual(33) = (y(71)) - (y(66)*T(21)*y(62)+params(6)*params(19)*T(49)*y(132));
    residual(34) = (y(72)) - (T(21)*y(62)+params(6)*params(19)*T(50)*y(133));
    residual(35) = (y(83)) - (T(51)*y(71)/y(72));
    residual(36) = (y(83)) - (T(52)^(1/(1-params(22))));
    residual(37) = (y(70)) - ((1-params(19))*y(83)^(-params(22))+T(53)*y(17));
    residual(38) = (y(68)) - (y(88)*y(64)-y(64)*(1+T(56)));
    residual(39) = (y(88)) - (T(56)+1+T(55)*params(21)*(T(55)-1)-params(6)*T(59)*T(60));
    residual(40) = (y(76)+y(60)) - (y(75)+y(58)+y(61));
    residual(41) = (y(76)) - (y(58)*params(34));
    residual(42) = (y(69)) - ((y(22)-y(24))/T(1)*y(13)-(y(20)-params(34)*y(23)-y(24)*(1-params(34)))/T(1)*y(12)-(y(21)-y(24))/T(1)*y(14)-T(65)-T(70)-T(75));
    residual(43) = (y(80)) - (params(29)/(params(29)-1)*y(82)-T(62)*T(76)*T(77)/y(22)+T(23)*T(82)/y(60));
    residual(44) = (y(78)) - (params(30)/(params(30)-1)*(params(34)*y(81)+(1-params(34))*y(82))+T(85)/y(20)-T(23)*T(90)/y(58));
    residual(45) = (y(79)) - (y(82)*params(31)/(params(31)-1)+T(93)/y(21)-T(23)*T(98)/y(61));
    residual(46) = (y(75)) - (y(59));
    residual(47) = (y(77)) - (y(24)/T(1)*y(18)-T(99)*(y(23)*y(19)+y(2)*y(31)*params(1)+y(6)*y(32)*params(2)+y(11)*y(33)*params(3)));
    residual(48) = (log(T(100))) - (params(35)*log(T(101))+(1-params(35))*params(32)*log(T(1))+y(95));
    residual(49) = (y(82)) - (y(81)+params(33));
    residual(50) = (y(59)) - (y(76)+y(37)*params(1)+y(44)*params(2)+y(53)*params(3));
    residual(51) = (y(57)) - (y(69)+y(67)+y(68));
    residual(52) = (y(55)) - (y(34)*params(1)+y(39)*params(2)+y(46)*params(3));
    residual(53) = (y(58)) - (y(36)*params(1)+y(43)*params(2)+y(52)*params(3));
    residual(54) = (y(56)) - (y(41)*params(2)+y(47)*params(3));
    residual(55) = (y(60)) - (y(42)*params(2));
    residual(56) = (y(64)) - (y(50)*params(3));
    residual(57) = (y(63)) - (y(49)*params(3));
    residual(58) = (y(61)) - (y(48)*params(3));
    residual(59) = (y(57)) - (y(51)*params(3));
    residual(60) = (y(56)) - (params(17));
    residual(61) = (y(114)) - (T(75)+T(70)+T(65)+y(77)+y(64)+y(55)-y(62)+y(64)*T(56)+y(85)*T(29)*T(28)*params(1)+y(86)*T(30)*T(28)*params(2));
    residual(62) = (log(y(94))) - (params(36)*log(y(29))+x(it_, 1));
    residual(63) = (y(95)) - (params(37)*y(30)+x(it_, 2));
    residual(64) = (1+y(115)) - ((1+y(81))/T(13));
    residual(65) = (y(98)) - (y(85)*y(35)+y(1)*T(102)+y(2)*y(31)/T(1)-y(73));
    residual(66) = (y(99)) - (y(36)+y(37));
    residual(67) = (y(116)) - ((y(98)-y(34))/y(98));
    residual(68) = (y(102)) - (y(86)*y(40)+y(3)*(y(87)-y(27))-y(4)*y(22)/T(1)+y(5)*T(102)+y(6)*y(32)/T(1)-y(74));
    residual(69) = (y(103)) - (y(44)+y(43)+y(87)*y(41)-y(42));
    residual(70) = (y(117)) - ((y(102)-y(39))/y(102));
    residual(71) = (y(106)) - (y(51)+y(89)*y(9)+y(7)*(y(87)-y(27))+y(9)*(y(88)-y(28))+y(8)*y(21)/T(1)+y(10)*T(102)+y(11)*y(33)/T(1));
    residual(72) = (y(107)) - (y(53)+y(52)+y(48)+y(87)*y(47)+y(88)*y(49));
    residual(73) = (y(118)) - ((y(106)-y(46))/y(106));
    residual(74) = (y(109)) - (T(103));
    residual(75) = (y(110)) - (T(104));
    residual(76) = (y(111)) - (params(3)*y(107)/y(110));
    residual(77) = (y(96)) - (y(34)^(1-params(7))/(1-params(7))+params(14)*y(38)^(1-params(8))/(1-params(8))-T(31)/(1+params(10)));
    residual(78) = (y(100)) - (y(39)^(1-params(7))/(1-params(7))+params(14)*y(45)^(1-params(8))/(1-params(8))+params(15)*y(41)^(1-params(9))/(1-params(9))-T(35)/(1+params(10)));
    residual(79) = (y(104)) - (y(46)^(1-params(7))/(1-params(7))+params(14)*y(54)^(1-params(8))/(1-params(8))+params(15)*y(47)^(1-params(9))/(1-params(9)));
    residual(80) = (y(97)) - (y(96)+params(4)*y(143));
    residual(81) = (y(101)) - (y(100)+params(5)*y(144));
    residual(82) = (y(105)) - (y(104)+params(6)*y(145));
    residual(83) = (y(108)) - (params(1)*y(97)+params(2)*y(101)+params(3)*y(105));
    residual(84) = (y(113)) - (T(105)/T(103));
    residual(85) = (y(112)) - (T(106)/T(104));
    residual(86) = (y(122)) - ((y(37)-params(41)+T(107))/2);
    residual(87) = (y(123)) - ((y(44)-params(41)+T(108))/2);
    residual(88) = (y(124)) - ((y(53)-params(41)+T(109))/2);
    residual(89) = (y(119)) - (y(81)-y(122)*params(42));
    residual(90) = (y(120)) - (y(81)-y(123)*params(42));
    residual(91) = (y(121)) - (y(81)-y(124)*params(42));

end
