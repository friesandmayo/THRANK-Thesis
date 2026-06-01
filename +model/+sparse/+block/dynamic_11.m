function [y, T] = dynamic_11(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(141)=params(1)*y(130)+params(2)*y(134)+params(3)*y(138);
  y(143)=100*(params(1)*y(132)+params(2)*y(136)+params(3)*y(140));
  y(146)=(params(1)*params(2)*(y(135)-y(131))+params(1)*params(3)*(y(139)-y(131))+params(2)*params(3)*(y(139)-y(135)))/(params(1)*y(131)+params(2)*y(135)+params(3)*y(139));
  y(145)=(params(1)*params(2)*(y(136)-y(132))+params(1)*params(3)*(y(140)-y(132))+params(2)*params(3)*(y(140)-y(136)))/(params(1)*y(132)+params(2)*y(136)+params(3)*y(140));
  y(144)=params(3)*y(140)*100/y(143);
  y(142)=100*(params(1)*y(131)+params(2)*y(135)+params(3)*y(139));
  y(89)=y(74)*params(1)+y(79)*params(2)+y(83)*params(3);
end
