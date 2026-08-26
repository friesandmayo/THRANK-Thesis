function [y, T] = dynamic_5(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(154)=y(92)^(1-params(7))/(1-params(7))+params(14)*y(96)^(1-params(8))/(1-params(8))-T(40)/(1+params(10));
  y(158)=y(97)^(1-params(7))/(1-params(7))+params(14)*y(103)^(1-params(8))/(1-params(8))+params(15)*y(99)^(1-params(9))/(1-params(9))-T(21)/(1+params(10));
end
