function [y, T] = static_5(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(63)=y(1)^(1-params(7))/(1-params(7))+params(14)*y(5)^(1-params(8))/(1-params(8))-T(24)/(1+params(10));
  y(67)=y(6)^(1-params(7))/(1-params(7))+params(14)*y(12)^(1-params(8))/(1-params(8))+params(15)*y(8)^(1-params(9))/(1-params(9))-T(27)/(1+params(10));
end
