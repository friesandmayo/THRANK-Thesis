function [y, T] = static_11(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(68)=params(1)*y(57)+params(2)*y(61)+params(3)*y(65);
  y(70)=100*(params(1)*y(59)+params(2)*y(63)+params(3)*y(67));
  y(73)=(params(1)*params(2)*(y(62)-y(58))+params(1)*params(3)*(y(66)-y(58))+params(2)*params(3)*(y(66)-y(62)))/(params(1)*y(58)+params(2)*y(62)+params(3)*y(66));
  y(72)=(params(1)*params(2)*(y(63)-y(59))+params(1)*params(3)*(y(67)-y(59))+params(2)*params(3)*(y(67)-y(63)))/(params(1)*y(59)+params(2)*y(63)+params(3)*y(67));
  y(71)=params(3)*y(67)*100/y(70);
  y(69)=100*(params(1)*y(58)+params(2)*y(62)+params(3)*y(66));
  y(16)=y(1)*params(1)+y(6)*params(2)+y(10)*params(3);
end
