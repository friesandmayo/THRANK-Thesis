function [y, T] = dynamic_9(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(142)=params(1)*y(131)+params(2)*y(135)+params(3)*y(139);
  y(144)=100*(params(1)*y(133)+params(2)*y(137)+params(3)*y(141));
  y(147)=(params(1)*params(2)*(y(136)-y(132))+params(1)*params(3)*(y(140)-y(132))+params(2)*params(3)*(y(140)-y(136)))/(params(1)*y(132)+params(2)*y(136)+params(3)*y(140));
  y(146)=(params(1)*params(2)*(y(137)-y(133))+params(1)*params(3)*(y(141)-y(133))+params(2)*params(3)*(y(141)-y(137)))/(params(1)*y(133)+params(2)*y(137)+params(3)*y(141));
  y(90)=y(75)*params(1)+y(80)*params(2)+y(84)*params(3);
  y(145)=params(3)*y(141)*100/y(144);
  y(143)=100*(params(1)*y(132)+params(2)*y(136)+params(3)*y(140));
  y(148)=y(93)*T(18)+y(94)*y(121)*T(16)+y(98)+y(90)-y(96)+y(111)*y(123)-y(122)*(y(112)+y(78)*params(1))+y(98)*T(15);
end
