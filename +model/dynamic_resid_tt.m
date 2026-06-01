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

assert(length(T) >= 62);

T(1) = params(13)*y(23)^(1+params(11));
T(2) = y(22)^(-params(8));
T(3) = params(20)*params(4)*(y(95)/y(22))^(-params(8));
T(4) = (1+y(109))^2;
T(5) = T(3)*y(109)*T(4);
T(6) = params(14)*y(26)^(-params(9));
T(7) = 1/params(12);
T(8) = (y(26)*x(it_, 3)/y(24))^T(7);
T(9) = y(95)^(-params(8));
T(10) = (y(26)*(1-x(it_, 3))/y(25))^T(7);
T(11) = x(it_, 3)^T(7);
T(12) = (params(12)-1)/params(12);
T(13) = y(24)^T(12);
T(14) = (1-x(it_, 3))^T(7);
T(15) = y(25)^T(12);
T(16) = T(11)*T(13)+T(14)*T(15);
T(17) = params(13)*y(28)^(1+params(11));
T(18) = y(27)^(-params(8));
T(19) = params(20)*params(5)*(y(96)/y(27))^(-params(8));
T(20) = (1+y(110))^2;
T(21) = T(19)*y(110)*T(20);
T(22) = y(96)^(-params(8));
T(23) = y(31)^(-params(8));
T(24) = y(97)^(-params(8));
T(25) = y(11)^params(24);
T(26) = y(75)*T(25);
T(27) = y(46)^(1-params(24));
T(28) = (y(61)/(1-params(24)))^(1-params(24));
T(29) = 1/y(75)*T(28);
T(30) = (y(66)/params(24))^params(24);
T(31) = (1+y(108))^params(19);
T(32) = (1+y(108))^(params(19)-1);
T(33) = (1-params(25)*(1+y(71))^(params(19)-1))/(1-params(25));
T(34) = params(25)*(1+y(71))^params(19);
T(35) = y(45)/y(12);
T(36) = params(18)/2*(T(35)-1)^2;
T(37) = params(18)*T(24)/T(23)*(y(100)/y(45)-1);
T(38) = (y(100)/y(45))^2;
T(39) = y(68)/y(17)-1;
T(40) = params(27)/2*T(39)^2;
T(41) = y(68)*T(40);
T(42) = y(67)/y(16)-1;
T(43) = params(28)/2*T(42)^2;
T(44) = y(67)*T(43);
T(45) = (1+y(69))*params(27)/(params(29)-1);
T(46) = y(68)^2;
T(47) = T(39)*T(45)*T(46);
T(48) = params(27)*params(6)*T(24)/T(23)/(params(29)-1);
T(49) = y(107)^2;
T(50) = T(48)*(y(107)/y(68)-1)*T(49)/y(68);
T(51) = T(50)*y(99);
T(52) = (1+y(69))*params(28)/(params(30)-1);
T(53) = y(67)^2;
T(54) = T(42)*T(52)*T(53);
T(55) = params(28)*params(6)*T(24)/T(23)/(params(30)-1);
T(56) = y(106)^2;
T(57) = T(55)*(y(106)/y(67)-1)*T(56)/y(67);
T(58) = T(57)*y(98);
T(59) = (y(23)*params(1))^params(22);
T(60) = (y(28)*params(2))^(1-params(22));
T(61) = params(1)*params(2)*(y(83)-y(79))+params(1)*params(3)*(y(87)-y(79))+params(2)*params(3)*(y(87)-y(83));
T(62) = params(1)*params(2)*(y(84)-y(80))+params(1)*params(3)*(y(88)-y(80))+params(2)*params(3)*(y(88)-y(84));

end
