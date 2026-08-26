function [T_order, T] = dynamic_g2_tt(y, x, params, steady_state, T_order, T)
if T_order >= 2
    return
end
[T_order, T] = model_irf.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
T_order = 2;
if size(T, 1) < 268
    T = [T; NaN(268 - size(T, 1), 1)];
end
T(232) = (-((-(1+y(45)))*(T(1)+T(1))))/(T(221)*T(221));
T(233) = getPowerDeriv(T(7),T(8),2);
T(234) = getPowerDeriv(y(92),(-params(7)),2);
T(235) = getPowerDeriv(y(183),(-params(7)),2);
T(236) = getPowerDeriv(y(96)*params(40)/y(94),T(3),2);
T(237) = params(14)*getPowerDeriv(y(96),(-params(8)),2);
T(238) = getPowerDeriv(y(96)*(1-params(40))/y(95),T(3),2);
T(239) = getPowerDeriv(y(97),(-params(7)),2);
T(240) = getPowerDeriv(y(188),(-params(7)),2);
T(241) = (-(params(5)*(-T(16))/(T(13)*T(13))));
T(242) = getPowerDeriv(T(17),T(8),2);
T(243) = getPowerDeriv(params(40)*y(103)/y(101),T(3),2);
T(244) = params(14)*getPowerDeriv(y(103),(-params(8)),2);
T(245) = getPowerDeriv((1-params(40))*y(103)/y(102),T(3),2);
T(246) = getPowerDeriv(y(104),(-params(7)),2);
T(247) = getPowerDeriv(y(195),(-params(7)),2);
T(248) = (-(params(6)*(-T(22))/(T(13)*T(13))));
T(249) = getPowerDeriv(T(24),T(8),2);
T(250) = getPowerDeriv(params(40)*y(112)/y(110),T(3),2);
T(251) = params(14)*getPowerDeriv(y(112),(-params(8)),2);
T(252) = getPowerDeriv((1-params(40))*y(112)/y(111),T(3),2);
T(253) = getPowerDeriv(y(183)/y(92),(-params(7)),2);
T(254) = params(12)*getPowerDeriv(y(93),1+params(10),2);
T(255) = getPowerDeriv(y(188)/y(97),(-params(7)),2);
T(256) = params(13)*getPowerDeriv(y(98),1+params(10),2);
T(257) = (-((-y(122))*(y(31)+y(31))))/(y(31)*y(31)*y(31)*y(31));
T(258) = T(54)*(2*(T(55)-1)*T(257)+T(171)*2*T(171));
T(259) = T(172)+y(122)*T(54)*(2*(T(55)-1)*(-1)/(y(31)*y(31))+T(171)*2*T(173));
T(260) = y(116)*y(136)*T(66)*(2*T(67)*(-((-y(136))*(y(45)+y(45))))/(y(45)*y(45)*y(45)*y(45))+T(181)*2*T(181));
T(261) = y(116)*(T(66)*T(181)*2*T(67)+y(136)*T(66)*(2*T(67)*(-1)/(y(45)*y(45))+T(181)*2*T(186)));
T(262) = y(119)*y(137)*T(71)*(2*T(72)*(-((-y(137))*(y(46)+y(46))))/(y(46)*y(46)*y(46)*y(46))+T(194)*2*T(194));
T(263) = y(119)*(T(71)*T(194)*2*T(72)+y(137)*T(71)*(2*T(72)*(-1)/(y(46)*y(46))+T(194)*2*T(197)));
T(264) = y(118)*y(138)*T(61)*(2*T(62)*(-((-y(138))*(y(47)+y(47))))/(y(47)*y(47)*y(47)*y(47))+T(205)*2*T(205));
T(265) = y(118)*(T(61)*T(205)*2*T(62)+y(138)*T(61)*(2*T(62)*(-1)/(y(47)*y(47))+T(205)*2*T(208)));
T(266) = (T(21)*T(21)*(-(params(6)*T(22)*T(246)))-(-(params(6)*T(22)*T(140)))*(T(21)*T(140)+T(21)*T(140)))/(T(21)*T(21)*T(21)*T(21));
T(267) = (-(T(140)*params(6)*T(150)))/(T(21)*T(21));
T(268) = (-((-y(45))*(T(1)+T(1))))/(T(221)*T(221));
end
