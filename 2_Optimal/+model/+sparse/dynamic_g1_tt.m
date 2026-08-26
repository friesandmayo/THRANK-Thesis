function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = model.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 133
    T = [T; NaN(133 - size(T, 1), 1)];
end
T(97) = getPowerDeriv(y(92),(-params(7)),1);
T(98) = getPowerDeriv(y(183)/y(92),(-params(7)),1);
T(99) = getPowerDeriv(y(183),(-params(7)),1);
T(100) = params(12)*getPowerDeriv(y(93),1+params(10),1);
T(101) = getPowerDeriv(T(8),T(9),1);
T(102) = getPowerDeriv(y(96)*x(3)/y(94),T(2),1);
T(103) = getPowerDeriv(y(96)*(1-x(3))/y(95),T(2),1);
T(104) = params(14)*getPowerDeriv(y(96),(-params(8)),1);
T(105) = getPowerDeriv(y(97),(-params(7)),1);
T(106) = getPowerDeriv(y(188)/y(97),(-params(7)),1);
T(107) = getPowerDeriv(y(188),(-params(7)),1);
T(108) = params(13)*getPowerDeriv(y(98),1+params(10),1);
T(109) = getPowerDeriv(T(19),T(9),1);
T(110) = getPowerDeriv(x(3)*y(103)/y(101),T(2),1);
T(111) = getPowerDeriv((1-x(3))*y(103)/y(102),T(2),1);
T(112) = params(14)*getPowerDeriv(y(103),(-params(8)),1);
T(113) = getPowerDeriv(y(104),(-params(7)),1);
T(114) = (-(params(6)*T(24)*T(113)))/(T(23)*T(23));
T(115) = getPowerDeriv(y(195),(-params(7)),1);
T(116) = getPowerDeriv(T(27),T(9),1);
T(117) = getPowerDeriv(x(3)*y(112)/y(110),T(2),1);
T(118) = getPowerDeriv((1-x(3))*y(112)/y(111),T(2),1);
T(119) = params(14)*getPowerDeriv(y(112),(-params(8)),1);
T(120) = params(21)/2*(-y(122))/(y(31)*y(31))*2*(T(54)-1);
T(121) = params(21)/2*2*(T(54)-1)*1/y(31);
T(122) = y(116)*y(136)*params(27)/2*(-y(136))/(y(45)*y(45))*2*T(62);
T(123) = (-(params(5)*T(16)/(1+y(239))));
T(124) = (-(params(6)*T(24)/(1+y(239))));
T(125) = y(116)*(T(63)+y(136)*params(27)/2*2*T(62)*1/y(45));
T(126) = y(119)*y(137)*params(28)/2*(-y(137))/(y(46)*y(46))*2*T(66);
T(127) = y(119)*(T(67)+y(137)*params(28)/2*2*T(66)*1/y(46));
T(128) = y(118)*y(138)*params(26)/2*(-y(138))/(y(47)*y(47))*2*T(58);
T(129) = y(118)*(T(59)+y(138)*params(26)/2*2*T(58)*1/y(47));
T(130) = (1+y(148))*(1+y(148));
T(131) = (-(1+y(45)))/T(130);
T(132) = getPowerDeriv(x(3),T(2),1);
T(133) = (-(getPowerDeriv(1-x(3),T(2),1)));
end
