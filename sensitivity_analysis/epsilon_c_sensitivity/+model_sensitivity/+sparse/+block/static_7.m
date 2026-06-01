function [y, T] = static_7(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(68)=y(12)+y(43)*y(11)+y(44)*y(13);
  y(71)=100*(params(1)*y(60)+params(2)*y(64)+params(3)*y(68));
  y(57)=y(1)^(1-params(8))/(1-params(8))+params(14)*y(5)^(1-params(9))/(1-params(9))-T(13)/(1+params(11));
  y(61)=y(6)^(1-params(8))/(1-params(8))+params(15)*y(8)^(1-params(10))/(1-params(10))-T(2)/(1+params(11));
end
