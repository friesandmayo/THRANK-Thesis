function [T_order, T] = static_g1_tt(y, x, params, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = model_irf.sparse.static_resid_tt(y, x, params, T_order, T);
T_order = 1;
if size(T, 1) < 74
    T = [T; NaN(74 - size(T, 1), 1)];
end
T(52) = getPowerDeriv(y(1),(-params(7)),1);
T(53) = params(12)*getPowerDeriv(y(2),1+params(10),1);
T(54) = getPowerDeriv(T(7),T(8),1);
T(55) = getPowerDeriv(y(5)*params(40)/y(3),T(3),1);
T(56) = getPowerDeriv(y(5)*(1-params(40))/y(4),T(3),1);
T(57) = params(14)*getPowerDeriv(y(5),(-params(8)),1);
T(58) = getPowerDeriv(y(6),(-params(7)),1);
T(59) = y(54)*T(58);
T(60) = params(13)*getPowerDeriv(y(7),1+params(10),1);
T(61) = getPowerDeriv(T(15),T(8),1);
T(62) = getPowerDeriv(params(40)*y(12)/y(10),T(3),1);
T(63) = getPowerDeriv((1-params(40))*y(12)/y(11),T(3),1);
T(64) = params(14)*getPowerDeriv(y(12),(-params(8)),1);
T(65) = getPowerDeriv(y(13),(-params(7)),1);
T(66) = y(54)*T(65);
T(67) = getPowerDeriv(T(21),T(8),1);
T(68) = getPowerDeriv(params(40)*y(21)/y(19),T(3),1);
T(69) = getPowerDeriv((1-params(40))*y(21)/y(20),T(3),1);
T(70) = params(14)*getPowerDeriv(y(21),(-params(8)),1);
T(71) = (1+(y(48))-(1+y(48)))/((1+(y(48)))*(1+(y(48))))/((1+y(48))/(1+(y(48))));
T(72) = (-(1+y(45)))/(T(1)*T(1));
T(73) = getPowerDeriv(T(1),params(22),1);
T(74) = getPowerDeriv(T(1),params(22)-1,1);
end
