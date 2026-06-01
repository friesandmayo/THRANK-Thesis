function [y, T] = static_5(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(65)=y(10)^(1-params(8))/(1-params(8))+params(16)*y(11)^(1-params(10))/(1-params(10));
  y(60)=y(3)+y(4);
  y(64)=y(43)*y(8)-y(9);
end
