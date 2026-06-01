function [y, T] = dynamic_5(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(140)=y(85)^(1-params(8))/(1-params(8))+params(16)*y(86)^(1-params(10))/(1-params(10));
  y(135)=y(78)+y(79);
  y(139)=y(118)*y(83)-y(84);
end
