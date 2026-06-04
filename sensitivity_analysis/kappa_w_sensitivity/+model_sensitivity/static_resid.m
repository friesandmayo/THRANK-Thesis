function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = model_sensitivity.static_resid_tt(T, y, x, params);
end
residual = zeros(74, 1);
    residual(1) = (y(1)+y(3)+y(4)) - (y(41)*y(2)+y(3)*(1+y(46))/(1+y(50))+y(4)*(1+y(48))/(1+y(50))+y(33));
    residual(2) = (params(21)*y(51)*(1+y(51))) - (y(2)*(1-params(22))+params(22)*T(1)/T(2)/y(41)+T(4)/(1+y(50)));
    residual(3) = (T(2)) - (T(5)*T(7)+params(4)*(1+y(46))*T(2)/(1+y(50)));
    residual(4) = (T(2)) - (T(5)*T(8)+params(4)*(1+y(48))*T(2)/(1+y(50)));
    residual(5) = (y(5)) - (T(12)^(params(13)/(params(13)-1)));
    residual(6) = (y(6)+y(43)*y(8)+(1+y(47))/(1+y(50))*y(9)) - (y(9)+y(43)*y(8)+y(42)*y(7)+y(34));
    residual(7) = (y(9)) - (y(8)*(1+y(50))*y(43)*params(24)/(1+y(47)));
    residual(8) = (params(21)*y(52)*(1+y(52))) - ((1-params(22))*y(7)+params(22)*T(13)/T(14)/y(42)+T(16)/(1+y(50)));
    residual(9) = (y(43)*T(14)) - (params(16)*y(8)^(-params(11))+params(5)*y(43)*T(14)+(1+y(50))*y(43)*params(24)*y(53)/(1+y(47)));
    residual(10) = (T(14)) - (y(53)+params(5)*(1+y(47))*T(14)/(1+y(50)));
    residual(11) = (y(10)+y(43)*y(11)+y(44)*y(14)+y(12)) - (y(43)*y(11)+y(45)*y(13)+y(15)+(1+y(48))/(1+y(50))*y(12)+y(35));
    residual(12) = (y(13)) - (y(14)+y(13)*(1-params(18)));
    residual(13) = (T(18)) - (params(17)*y(11)^(-params(11))+T(18)*params(6));
    residual(14) = (y(44)*T(17)) - (params(6)*T(17)*(y(45)+y(44)*(1-params(18))));
    residual(15) = (T(17)) - (params(6)*(1+y(48))*T(17)/(1+y(50)));
    residual(16) = (1+y(51)) - (1+y(50));
    residual(17) = (1+y(52)) - (1+y(50));
    residual(18) = (y(2)*y(41)*params(1)) - (params(23)*y(40)*y(25));
    residual(19) = (y(7)*y(42)*params(2)) - (y(25)*y(40)*(1-params(23)));
    residual(20) = (y(22)*y(30)) - (T(20)*T(21));
    residual(21) = (y(26)) - (T(24)*T(25));
    residual(22) = (y(45)/y(40)) - (params(25)/(1-params(25))*y(25)/y(23));
    residual(23) = (y(31)) - (y(26)*T(17)*y(22)+params(6)*params(26)*y(31)*T(26));
    residual(24) = (y(32)) - (T(17)*y(22)+params(6)*params(26)*y(32)*T(27));
    residual(25) = (y(39)) - (params(20)/(params(20)-1)*y(31)/y(32));
    residual(26) = (y(39)) - (((1-params(26)*T(27))/(1-params(26)))^(1/(1-params(20))));
    residual(27) = (y(30)) - ((1-params(26))*y(39)^(-params(20))+y(30)*params(26)*T(26));
    residual(28) = (y(44)) - (1);
    residual(29) = (y(27)) - (y(22)-y(40)*y(25)-y(45)*y(23));
    residual(30) = (y(28)) - (y(44)*y(24)-y(24));
    residual(31) = (y(38)+y(20)) - (y(37)+y(19)+y(21));
    residual(32) = (y(38)) - (y(19)*params(27));
    residual(33) = (y(29)) - (y(20)*(y(47)-y(49))/(1+y(50))-y(19)*(y(46)-y(48)*params(27)-y(49)*(1-params(27)))/(1+y(50))-y(21)*(y(48)-y(49))/(1+y(50)));
    residual(34) = (y(47)) - (y(49)*params(30)/(params(30)-1));
    residual(35) = (y(46)) - (params(31)/(params(31)-1)*(y(48)*params(27)+y(49)*(1-params(27))));
    residual(36) = (y(18)) - (y(29)+y(27)+y(28));
residual(37) = y(36);
    residual(38) = (y(33)) - (T(28)*((y(41))*(y(2))+(y(46))*(y(3))+(y(48))*(y(4))));
    residual(39) = (y(34)) - (params(8)/(1-params(8))*(y(42))*(y(7)));
    residual(40) = (log((1+y(48))/(1+params(35)))) - (log((1+y(48))/(1+params(35)))*params(38)+(1-params(38))*params(32)*log(1+y(50))+y(55));
    residual(41) = (y(49)) - (y(48)+0.005+y(37)*params(33));
    residual(42) = (y(37)) - (y(38)+y(4)*params(1));
    residual(43) = (y(16)) - (y(1)*params(1)+y(6)*params(2)+y(10)*params(3));
    residual(44) = (y(25)) - (T(29)*T(30));
    residual(45) = (y(19)) - (y(3)*params(1));
    residual(46) = (0) - (y(33)*params(1)+y(34)*params(2)+y(35)*params(3));
    residual(47) = (y(17)) - (y(8)*params(2)+y(11)*params(3));
    residual(48) = (y(20)) - (y(9)*params(2));
    residual(49) = (y(24)) - (y(14)*params(3));
    residual(50) = (y(23)) - (y(13)*params(3));
    residual(51) = (y(21)) - (y(12)*params(3));
    residual(52) = (y(18)) - (y(15)*params(3));
    residual(53) = (y(17)) - (params(34));
    residual(54) = (y(74)) - (y(24)+y(16)-y(22)+y(37)*y(49)-y(48)*(y(38)+y(4)*params(1)));
    residual(55) = (log(y(54))) - (log(y(54))*params(36)+x(1));
    residual(56) = (y(55)) - (y(55)*params(37)+x(2));
    residual(57) = (y(58)) - (y(33)+y(41)*y(2)+y(3)*y(46)/(1+y(50))+y(4)*y(48)/(1+y(50)));
    residual(58) = (y(59)) - (y(3)+y(4));
    residual(59) = (y(62)) - (y(42)*y(7)+y(34));
    residual(60) = (y(63)) - (y(43)*y(8)-y(9));
    residual(61) = (y(66)) - (y(35)+y(15)+y(45)*y(13)+y(12)*y(48)/(1+y(50)));
    residual(62) = (y(67)) - (y(12)+y(43)*y(11)+y(44)*y(13));
    residual(63) = (y(69)) - (100*(params(1)*y(58)+params(2)*y(62)+params(3)*y(66)));
    residual(64) = (y(70)) - (100*(params(1)*y(59)+params(2)*y(63)+params(3)*y(67)));
    residual(65) = (y(71)) - (params(3)*y(67)*100/y(70));
    residual(66) = (y(56)) - (y(1)^(1-params(9))/(1-params(9))+params(15)*y(5)^(1-params(10))/(1-params(10))-T(1)/(1+params(12)));
    residual(67) = (y(60)) - (y(6)^(1-params(9))/(1-params(9))+params(16)*y(8)^(1-params(11))/(1-params(11))-T(13)/(1+params(12)));
    residual(68) = (y(64)) - (y(10)^(1-params(9))/(1-params(9))+params(17)*y(11)^(1-params(11))/(1-params(11)));
    residual(69) = (y(57)) - (y(56)+params(4)*y(57));
    residual(70) = (y(61)) - (y(60)+params(5)*y(61));
    residual(71) = (y(65)) - (y(64)+params(6)*y(65));
    residual(72) = (y(68)) - (params(1)*y(57)+params(2)*y(61)+params(3)*y(65));
    residual(73) = (y(73)) - (T(31)/(params(1)*y(58)+params(2)*y(62)+params(3)*y(66)));
    residual(74) = (y(72)) - (T(32)/(params(1)*y(59)+params(2)*y(63)+params(3)*y(67)));

end
