function [y, T] = dynamic_7(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(138)=y(84)^(1-params(9))/(1-params(9))+params(17)*y(85)^(1-params(11))/(1-params(11));
  y(134)=y(80)^(1-params(9))/(1-params(9))+params(16)*y(82)^(1-params(11))/(1-params(11))-T(35)/(1+params(12));
  y(137)=y(117)*y(82)-y(83);
  y(136)=y(116)*y(81)+y(108);
  y(133)=y(77)+y(78);
  y(132)=y(107)+y(115)*y(76)+y(3)*y(46)/(1+y(124))+y(4)*y(48)/(1+y(124));
end
