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

assert(length(T) >= 231);

T = model_irf.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(110) = getPowerDeriv(y(34),(-params(7)),1);
T(111) = (-y(125))/(y(34)*y(34));
T(112) = getPowerDeriv(y(125)/y(34),(-params(7)),1);
T(113) = getPowerDeriv(y(125),(-params(7)),1);
T(114) = params(12)*getPowerDeriv(y(35),1+params(10),1);
T(115) = params(1)*getPowerDeriv(y(35)*params(1),params(25),1);
T(116) = T(4)*getPowerDeriv(y(36),T(5),1);
T(117) = getPowerDeriv(T(7),T(8),1);
T(118) = (-(y(38)*params(40)))/(y(36)*y(36));
T(119) = getPowerDeriv(y(38)*params(40)/y(36),T(3),1);
T(120) = T(6)*getPowerDeriv(y(37),T(5),1);
T(121) = (-(y(38)*(1-params(40))))/(y(37)*y(37));
T(122) = getPowerDeriv(y(38)*(1-params(40))/y(37),T(3),1);
T(123) = 2*(y(37)-params(41))/(T(107)+T(107));
T(124) = params(14)*getPowerDeriv(y(38),(-params(8)),1);
T(125) = getPowerDeriv(y(39),(-params(7)),1);
T(126) = (-y(126))/(y(39)*y(39));
T(127) = getPowerDeriv(y(126)/y(39),(-params(7)),1);
T(128) = getPowerDeriv(y(126),(-params(7)),1);
T(129) = params(13)*getPowerDeriv(y(40),1+params(10),1);
T(130) = params(2)*getPowerDeriv(y(40)*params(2),1-params(25),1);
T(131) = T(4)*getPowerDeriv(y(43),T(5),1);
T(132) = getPowerDeriv(T(17),T(8),1);
T(133) = (-(params(40)*y(45)))/(y(43)*y(43));
T(134) = getPowerDeriv(params(40)*y(45)/y(43),T(3),1);
T(135) = T(6)*getPowerDeriv(y(44),T(5),1);
T(136) = (-((1-params(40))*y(45)))/(y(44)*y(44));
T(137) = getPowerDeriv((1-params(40))*y(45)/y(44),T(3),1);
T(138) = 2*(y(44)-params(41))/(T(108)+T(108));
T(139) = params(14)*getPowerDeriv(y(45),(-params(8)),1);
T(140) = getPowerDeriv(y(46),(-params(7)),1);
T(141) = params(21)*(-(T(22)*T(140)))/(T(21)*T(21));
T(142) = T(58)*T(141);
T(143) = (-(params(6)*T(22)*T(140)))/(T(21)*T(21));
T(144) = T(80)*T(79)*params(26)*T(143)/(params(29)-1)/y(80);
T(145) = y(129)*T(144);
T(146) = T(88)*T(87)*params(27)*T(143)/(params(30)-1)/y(78);
T(147) = y(128)*T(146);
T(148) = T(96)*T(95)*params(28)*T(143)/(params(31)-1)/y(79);
T(149) = y(130)*T(148);
T(150) = getPowerDeriv(y(127),(-params(7)),1);
T(151) = params(26)*params(6)*T(150)/T(21)/(params(29)-1);
T(152) = T(80)*T(79)*T(151)/y(80);
T(153) = y(129)*T(152);
T(154) = params(27)*params(6)*T(150)/T(21)/(params(30)-1);
T(155) = T(88)*T(87)*T(154)/y(78);
T(156) = y(128)*T(155);
T(157) = params(28)*params(6)*T(150)/T(21)/(params(31)-1);
T(158) = T(96)*T(95)*T(157)/y(79);
T(159) = y(130)*T(158);
T(160) = T(4)*getPowerDeriv(y(52),T(5),1);
T(161) = getPowerDeriv(T(24),T(8),1);
T(162) = (-(params(40)*y(54)))/(y(52)*y(52));
T(163) = getPowerDeriv(params(40)*y(54)/y(52),T(3),1);
T(164) = T(6)*getPowerDeriv(y(53),T(5),1);
T(165) = (-((1-params(40))*y(54)))/(y(53)*y(53));
T(166) = getPowerDeriv((1-params(40))*y(54)/y(53),T(3),1);
T(167) = 2*(y(53)-params(41))/(T(109)+T(109));
T(168) = params(14)*getPowerDeriv(y(54),(-params(8)),1);
T(169) = getPowerDeriv(y(15),params(18),1);
T(170) = y(94)*T(169);
T(171) = (-y(64))/(y(16)*y(16));
T(172) = T(54)*T(171)*2*(T(55)-1);
T(173) = 1/y(16);
T(174) = T(54)*2*(T(55)-1)*T(173);
T(175) = (-y(131))/(y(64)*y(64));
T(176) = 2*y(131)/y(64);
T(177) = T(175)*T(176);
T(178) = 1/y(64);
T(179) = T(176)*T(178);
T(180) = getPowerDeriv(y(65),1-params(18),1);
T(181) = (-y(78))/(y(20)*y(20));
T(182) = y(78)*T(66)*T(181)*2*T(67);
T(183) = y(58)*T(182);
T(184) = (-(params(5)*T(16)/T(13)));
T(185) = (-(params(6)*T(22)/T(13)));
T(186) = 1/y(20);
T(187) = T(66)*2*T(67)*T(186);
T(188) = T(68)+y(78)*T(187);
T(189) = y(58)*T(188);
T(190) = (y(78)*T(88)*T(86)*(-y(134))/(y(78)*y(78))-T(86)*T(87)*T(88))/(y(78)*y(78));
T(191) = y(128)*T(190);
T(192) = (T(88)*T(86)*1/y(78)+T(86)*T(87)*2*y(134))/y(78);
T(193) = y(128)*T(192);
T(194) = (-y(79))/(y(21)*y(21));
T(195) = y(79)*T(71)*T(194)*2*T(72);
T(196) = y(61)*T(195);
T(197) = 1/y(21);
T(198) = T(71)*2*T(72)*T(197);
T(199) = T(73)+y(79)*T(198);
T(200) = y(61)*T(199);
T(201) = (y(79)*T(96)*T(94)*(-y(135))/(y(79)*y(79))-T(94)*T(95)*T(96))/(y(79)*y(79));
T(202) = y(130)*T(201);
T(203) = (T(96)*T(94)*1/y(79)+T(94)*T(95)*2*y(135))/y(79);
T(204) = y(130)*T(203);
T(205) = (-y(80))/(y(22)*y(22));
T(206) = y(80)*T(61)*T(205)*2*T(62);
T(207) = y(60)*T(206);
T(208) = 1/y(22);
T(209) = T(61)*2*T(62)*T(208);
T(210) = T(63)+y(80)*T(209);
T(211) = y(60)*T(210);
T(212) = (y(80)*T(80)*T(78)*(-y(136))/(y(80)*y(80))-T(78)*T(79)*T(80))/(y(80)*y(80));
T(213) = y(129)*T(212);
T(214) = (T(80)*T(78)*1/y(80)+T(78)*T(79)*2*y(136))/y(80);
T(215) = y(129)*T(214);
T(216) = 1/(1+(steady_state(48)));
T(217) = (-1)/T(1);
T(218) = 1/(1-params(18))*getPowerDeriv(y(84)/(1-params(18)),1-params(18),1);
T(219) = T(44)*T(218);
T(220) = 1/params(18)*getPowerDeriv(y(89)/params(18),params(18),1);
T(221) = T(1)*T(1);
T(222) = (-(1+y(20)))/T(221);
T(223) = (-(params(19)*getPowerDeriv(T(1),params(22)-1,1)))/(1-params(19));
T(224) = getPowerDeriv(T(52),1/(1-params(22)),1);
T(225) = params(19)*getPowerDeriv(T(1),params(22),1);
T(226) = (-1)/T(221);
T(227) = (-y(20))/T(221);
T(228) = getPowerDeriv(T(13),params(22),1);
T(229) = getPowerDeriv(T(13),params(22)-1,1);
T(230) = T(103)*T(103);
T(231) = T(104)*T(104);

end
