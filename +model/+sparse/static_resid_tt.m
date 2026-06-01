function [T_order, T] = static_resid_tt(y, x, params, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 32
    T = [T; NaN(32 - size(T, 1), 1)];
end
T(1) = params(13)*y(2)^(1+params(11));
T(2) = y(1)^(-params(8));
T(3) = (1+y(51))^2;
T(4) = y(51)*params(20)*params(4)*T(3);
T(5) = params(14)*y(5)^(-params(9));
T(6) = 1/params(12);
T(7) = (y(5)*x(3)/y(3))^T(6);
T(8) = (y(5)*(1-x(3))/y(4))^T(6);
T(9) = x(3)^T(6);
T(10) = (params(12)-1)/params(12);
T(11) = (1-x(3))^T(6);
T(12) = T(9)*y(3)^T(10)+T(11)*y(4)^T(10);
T(13) = params(13)*y(7)^(1+params(11));
T(14) = y(6)^(-params(8));
T(15) = (1+y(52))^2;
T(16) = y(52)*params(20)*params(5)*T(15);
T(17) = y(10)^(-params(8));
T(18) = y(43)*T(17);
T(19) = y(23)^params(24);
T(20) = y(54)*T(19);
T(21) = y(25)^(1-params(24));
T(22) = 1/y(54);
T(23) = (y(40)/(1-params(24)))^(1-params(24));
T(24) = T(22)*T(23);
T(25) = (y(45)/params(24))^params(24);
T(26) = (1+y(50))^params(19);
T(27) = (1+y(50))^(params(19)-1);
T(28) = params(7)/(1-params(7));
T(29) = (y(2)*params(1))^params(22);
T(30) = (y(7)*params(2))^(1-params(22));
T(31) = params(1)*params(2)*(y(62)-y(58))+params(1)*params(3)*(y(66)-y(58))+params(2)*params(3)*(y(66)-y(62));
T(32) = params(1)*params(2)*(y(63)-y(59))+params(1)*params(3)*(y(67)-y(59))+params(2)*params(3)*(y(67)-y(63));
end
