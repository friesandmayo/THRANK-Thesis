function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = model_sensitivity.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 85
    T = [T; NaN(85 - size(T, 1), 1)];
end
T(65) = getPowerDeriv(y(76),(-params(8)),1);
T(66) = getPowerDeriv(y(151)/y(76),(-params(8)),1);
T(67) = getPowerDeriv(y(151),(-params(8)),1);
T(68) = params(13)*getPowerDeriv(y(77),1+params(11),1);
T(69) = getPowerDeriv(y(80)*x(3)/y(78),T(7),1);
T(70) = getPowerDeriv(T(16),params(12)/(params(12)-1),1);
T(71) = getPowerDeriv(y(80)*(1-x(3))/y(79),T(7),1);
T(72) = params(14)*getPowerDeriv(y(80),(-params(9)),1);
T(73) = getPowerDeriv(y(81),(-params(8)),1);
T(74) = getPowerDeriv(y(156)/y(81),(-params(8)),1);
T(75) = getPowerDeriv(y(156),(-params(8)),1);
T(76) = params(13)*getPowerDeriv(y(82),1+params(11),1);
T(77) = getPowerDeriv(y(85),(-params(8)),1);
T(78) = getPowerDeriv(y(160),(-params(8)),1);
T(79) = params(18)/2*(-y(99))/(y(24)*y(24))*2*(T(35)-1);
T(80) = params(18)/2*2*(T(35)-1)*1/y(24);
T(81) = 1/(1+y(125));
T(82) = y(94)*y(121)*params(28)/2*(-y(121))/(y(46)*y(46))*2*T(43);
T(83) = y(94)*(T(44)+y(121)*params(28)/2*2*T(43)*1/y(46));
T(84) = y(95)*y(122)*params(27)/2*(-y(122))/(y(47)*y(47))*2*T(39);
T(85) = y(95)*(T(40)+y(122)*params(27)/2*2*T(39)*1/y(47));
end
