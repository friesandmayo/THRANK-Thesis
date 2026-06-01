function [y, T] = dynamic_9(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(144)=params(1)*y(133)+params(2)*y(137)+params(3)*y(141);
  y(142)=y(110)+y(90)+y(120)*y(13)+y(12)*y(48)/(1+y(125));
  y(138)=y(117)*y(82);
  y(134)=y(108)+y(116)*y(77)+y(3)*y(46)/(1+y(125))+y(4)*y(48)/(1+y(125));
  T(62)=params(1)*params(2)*(y(138)-y(134))+params(1)*params(3)*(y(142)-y(134))+params(2)*params(3)*(y(142)-y(138));
  y(149)=T(62)/(params(1)*y(134)+params(2)*y(138)+params(3)*y(142));
  y(148)=(params(1)*params(2)*(y(139)-y(135))+params(1)*params(3)*(y(143)-y(135))+params(2)*params(3)*(y(143)-y(139)))/(params(1)*y(135)+params(2)*y(139)+params(3)*y(143));
  y(91)=y(76)*params(1)+y(81)*params(2)+y(85)*params(3);
  y(147)=params(3)*y(143)*100/y(146);
  y(145)=100*(params(1)*y(134)+params(2)*y(138)+params(3)*y(142));
  y(131)=y(123)-y(121);
  y(150)=y(94)*T(14)+y(95)*y(122)*T(12)+y(99)+y(91)-y(97)+y(112)*y(124)-y(123)*(y(113)+y(79)*params(1))+y(99)*T(11);
end
