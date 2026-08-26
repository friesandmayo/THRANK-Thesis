function [y, T] = dynamic_9(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(171)=(params(1)*params(2)*(y(160)-y(156))+params(1)*params(3)*(y(164)-y(156))+params(2)*params(3)*(y(164)-y(160)))/(params(1)*y(156)+params(2)*y(160)+params(3)*y(164));
  y(170)=(params(1)*params(2)*(y(161)-y(157))+params(1)*params(3)*(y(165)-y(157))+params(2)*params(3)*(y(165)-y(161)))/(params(1)*y(157)+params(2)*y(161)+params(3)*y(165));
  y(168)=params(1)*y(157)+params(2)*y(161)+params(3)*y(165);
  y(113)=y(92)*params(1)+y(97)*params(2)+y(104)*params(3);
  y(135)=y(49)/(1+y(148))*y(42)-T(67)*(y(48)*y(43)+y(4)*y(86)*params(1)+y(11)*y(87)*params(2)+y(20)*y(88)*params(3));
  y(166)=params(1)*y(155)+params(2)*y(159)+params(3)*y(163);
  y(169)=params(3)*y(165)/y(168);
  y(167)=params(1)*y(156)+params(2)*y(160)+params(3)*y(164);
  y(176)=(y(164)-y(104))/y(164);
  y(175)=(y(160)-y(97))/y(160);
  y(174)=(y(156)-y(92))/y(156);
end
