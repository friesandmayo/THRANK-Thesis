function [y, T] = dynamic_7(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(140)=y(85)+y(116)*y(84)+y(117)*y(86);
  y(129)=y(74)^(1-params(8))/(1-params(8))+params(14)*y(78)^(1-params(9))/(1-params(9))-T(41)/(1+params(11));
end
