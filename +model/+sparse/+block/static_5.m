function [y, T] = static_5(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(60)=y(6)^(1-params(8))/(1-params(8))+params(15)*y(8)^(1-params(10))/(1-params(10))-T(2)/(1+params(11));
end
