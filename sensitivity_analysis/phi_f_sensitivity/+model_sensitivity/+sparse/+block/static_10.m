function [y, T] = static_10(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(69)=params(1)*y(58)+params(2)*y(62)+params(3)*y(66);
  y(67)=y(35)+y(15)+y(45)*y(13)+y(12)*y(48)/(1+y(50));
  y(63)=y(42)*y(7);
  y(59)=y(33)+y(41)*y(2)+y(3)*y(46)/(1+y(50))+y(4)*y(48)/(1+y(50));
  T(36)=params(1)*params(2)*(y(63)-y(59))+params(1)*params(3)*(y(67)-y(59))+params(2)*params(3)*(y(67)-y(63));
  y(74)=T(36)/(params(1)*y(59)+params(2)*y(63)+params(3)*y(67));
  y(73)=(params(1)*params(2)*(y(64)-y(60))+params(1)*params(3)*(y(68)-y(60))+params(2)*params(3)*(y(68)-y(64)))/(params(1)*y(60)+params(2)*y(64)+params(3)*y(68));
  y(16)=y(1)*params(1)+y(6)*params(2)+y(10)*params(3);
  y(72)=params(3)*y(68)*100/y(71);
  y(70)=100*(params(1)*y(59)+params(2)*y(63)+params(3)*y(67));
  y(56)=y(48)-y(46);
  y(75)=y(24)+y(16)-y(22)+y(37)*y(49)-y(48)*(y(38)+y(4)*params(1));
end
