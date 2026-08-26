function [y, T] = static_10(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(80)=(params(1)*params(2)*(y(69)-y(65))+params(1)*params(3)*(y(73)-y(65))+params(2)*params(3)*(y(73)-y(69)))/(params(1)*y(65)+params(2)*y(69)+params(3)*y(73));
  y(79)=(params(1)*params(2)*(y(70)-y(66))+params(1)*params(3)*(y(74)-y(66))+params(2)*params(3)*(y(74)-y(70)))/(params(1)*y(66)+params(2)*y(70)+params(3)*y(74));
  y(77)=params(1)*y(66)+params(2)*y(70)+params(3)*y(74);
  y(22)=y(1)*params(1)+y(6)*params(2)+y(13)*params(3);
  y(44)=y(42)*y(49)/T(2)-T(45)*(y(43)*y(48)+y(4)*y(86)*params(1)+y(11)*y(87)*params(2)+y(20)*y(88)*params(3));
  y(75)=params(1)*y(64)+params(2)*y(68)+params(3)*y(72);
  y(78)=params(3)*y(74)/y(77);
  y(76)=params(1)*y(65)+params(2)*y(69)+params(3)*y(73);
  y(85)=(y(73)-y(13))/y(73);
  y(84)=(y(69)-y(6))/y(69);
  y(83)=(y(65)-y(1))/y(65);
end
