function [y, T] = static_7(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(64)=y(10)^(1-params(9))/(1-params(9))+params(17)*y(11)^(1-params(11))/(1-params(11));
  y(60)=y(6)^(1-params(9))/(1-params(9))+params(16)*y(8)^(1-params(11))/(1-params(11))-T(2)/(1+params(12));
  y(63)=y(43)*y(8)-y(9);
  y(62)=y(42)*y(7)+y(34);
  y(59)=y(3)+y(4);
  y(58)=y(33)+y(41)*y(2)+y(3)*y(46)/(1+y(50))+y(4)*y(48)/(1+y(50));
end
