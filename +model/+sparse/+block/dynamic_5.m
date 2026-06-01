function [y, T] = dynamic_5(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(133)=y(79)^(1-params(8))/(1-params(8))+params(15)*y(81)^(1-params(10))/(1-params(10))-T(2)/(1+params(11));
end
