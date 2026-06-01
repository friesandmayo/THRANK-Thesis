function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = model.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 79
    T = [T; NaN(79 - size(T, 1), 1)];
end
T(63) = getPowerDeriv(y(74),(-params(8)),1);
T(64) = getPowerDeriv(y(147)/y(74),(-params(8)),1);
T(65) = getPowerDeriv(y(147),(-params(8)),1);
T(66) = params(13)*getPowerDeriv(y(75),1+params(11),1);
T(67) = getPowerDeriv(y(78)*x(3)/y(76),T(7),1);
T(68) = getPowerDeriv(T(16),params(12)/(params(12)-1),1);
T(69) = getPowerDeriv(y(78)*(1-x(3))/y(77),T(7),1);
T(70) = params(14)*getPowerDeriv(y(78),(-params(9)),1);
T(71) = getPowerDeriv(y(79),(-params(8)),1);
T(72) = getPowerDeriv(y(152)/y(79),(-params(8)),1);
T(73) = getPowerDeriv(y(152),(-params(8)),1);
T(74) = params(13)*getPowerDeriv(y(80),1+params(11),1);
T(75) = getPowerDeriv(y(83),(-params(8)),1);
T(76) = getPowerDeriv(y(156),(-params(8)),1);
T(77) = params(18)/2*(-y(97))/(y(24)*y(24))*2*(T(35)-1);
T(78) = params(18)/2*2*(T(35)-1)*1/y(24);
T(79) = 1/(1+y(123));
end
