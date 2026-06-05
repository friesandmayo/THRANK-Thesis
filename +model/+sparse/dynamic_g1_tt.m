function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = model.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 85
    T = [T; NaN(85 - size(T, 1), 1)];
end
T(65) = getPowerDeriv(y(75),(-params(9)),1);
T(66) = getPowerDeriv(y(149)/y(75),(-params(9)),1);
T(67) = getPowerDeriv(y(149),(-params(9)),1);
T(68) = params(14)*getPowerDeriv(y(76),1+params(12),1);
T(69) = getPowerDeriv(y(79)*x(3)/y(77),T(7),1);
T(70) = getPowerDeriv(T(16),params(13)/(params(13)-1),1);
T(71) = getPowerDeriv(y(79)*(1-x(3))/y(78),T(7),1);
T(72) = params(15)*getPowerDeriv(y(79),(-params(10)),1);
T(73) = getPowerDeriv(y(80),(-params(9)),1);
T(74) = getPowerDeriv(y(154)/y(80),(-params(9)),1);
T(75) = getPowerDeriv(y(154),(-params(9)),1);
T(76) = params(14)*getPowerDeriv(y(81),1+params(12),1);
T(77) = getPowerDeriv(y(84),(-params(9)),1);
T(78) = getPowerDeriv(y(158),(-params(9)),1);
T(79) = params(19)/2*(-y(98))/(y(24)*y(24))*2*(T(35)-1);
T(80) = params(19)/2*2*(T(35)-1)*1/y(24);
T(81) = 1/(1+y(124));
T(82) = y(93)*y(120)*params(29)/2*(-y(120))/(y(46)*y(46))*2*T(43);
T(83) = y(93)*(T(44)+y(120)*params(29)/2*2*T(43)*1/y(46));
T(84) = y(94)*y(121)*params(28)/2*(-y(121))/(y(47)*y(47))*2*T(39);
T(85) = y(94)*(T(40)+y(121)*params(28)/2*2*T(39)*1/y(47));
end
