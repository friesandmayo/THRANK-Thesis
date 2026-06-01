function [y, T] = dynamic_7(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(143)=y(87)+y(118)*y(86)+y(119)*y(88);
  y(146)=100*(params(1)*y(135)+params(2)*y(139)+params(3)*y(143));
  y(132)=y(76)^(1-params(8))/(1-params(8))+params(14)*y(80)^(1-params(9))/(1-params(9))-T(21)/(1+params(11));
  y(136)=y(81)^(1-params(8))/(1-params(8))+params(15)*y(83)^(1-params(10))/(1-params(10))-T(40)/(1+params(11));
end
