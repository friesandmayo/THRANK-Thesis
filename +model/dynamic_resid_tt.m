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

assert(length(T) >= 64);

T(1) = params(14)*y(23)^(1+params(12));
T(2) = y(22)^(-params(9));
T(3) = params(21)*params(4)*(y(96)/y(22))^(-params(9));
T(4) = (1+y(110))^2;
T(5) = T(3)*y(110)*T(4);
T(6) = params(15)*y(26)^(-params(10));
T(7) = 1/params(13);
T(8) = (y(26)*x(it_, 3)/y(24))^T(7);
T(9) = y(96)^(-params(9));
T(10) = (y(26)*(1-x(it_, 3))/y(25))^T(7);
T(11) = x(it_, 3)^T(7);
T(12) = (params(13)-1)/params(13);
T(13) = y(24)^T(12);
T(14) = (1-x(it_, 3))^T(7);
T(15) = y(25)^T(12);
T(16) = T(11)*T(13)+T(14)*T(15);
T(17) = params(14)*y(28)^(1+params(12));
T(18) = y(27)^(-params(9));
T(19) = params(21)*params(5)*(y(97)/y(27))^(-params(9));
T(20) = (1+y(111))^2;
T(21) = T(19)*y(111)*T(20);
T(22) = y(97)^(-params(9));
T(23) = y(31)^(-params(9));
T(24) = y(98)^(-params(9));
T(25) = y(11)^params(25);
T(26) = y(75)*T(25);
T(27) = y(46)^(1-params(25));
T(28) = (y(61)/(1-params(25)))^(1-params(25));
T(29) = 1/y(75)*T(28);
T(30) = (y(66)/params(25))^params(25);
T(31) = (1+y(109))^params(20);
T(32) = (1+y(109))^(params(20)-1);
T(33) = (1-params(26)*(1+y(71))^(params(20)-1))/(1-params(26));
T(34) = params(26)*(1+y(71))^params(20);
T(35) = y(45)/y(12);
T(36) = params(19)/2*(T(35)-1)^2;
T(37) = params(19)*T(24)/T(23)*(y(101)/y(45)-1);
T(38) = (y(101)/y(45))^2;
T(39) = y(68)/y(17)-1;
T(40) = params(28)/2*T(39)^2;
T(41) = y(68)*T(40);
T(42) = y(41)*T(41);
T(43) = y(67)/y(16)-1;
T(44) = params(29)/2*T(43)^2;
T(45) = y(67)*T(44);
T(46) = y(40)*T(45);
T(47) = (1+y(69))*params(28)/(params(30)-1);
T(48) = y(68)^2;
T(49) = T(39)*T(47)*T(48);
T(50) = params(28)*params(6)*T(24)/T(23)/(params(30)-1);
T(51) = y(108)^2;
T(52) = T(50)*(y(108)/y(68)-1)*T(51)/y(68);
T(53) = T(52)*y(100);
T(54) = (1+y(69))*params(29)/(params(31)-1);
T(55) = y(67)^2;
T(56) = T(43)*T(54)*T(55);
T(57) = params(29)*params(6)*T(24)/T(23)/(params(31)-1);
T(58) = y(107)^2;
T(59) = T(57)*(y(107)/y(67)-1)*T(58)/y(67);
T(60) = T(59)*y(99);
T(61) = (y(23)*params(1))^params(23);
T(62) = (y(28)*params(2))^(1-params(23));
T(63) = params(1)*params(2)*(y(83)-y(79))+params(1)*params(3)*(y(87)-y(79))+params(2)*params(3)*(y(87)-y(83));
T(64) = params(1)*params(2)*(y(84)-y(80))+params(1)*params(3)*(y(88)-y(80))+params(2)*params(3)*(y(88)-y(84));

end
