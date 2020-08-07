function xi = calXi(xi, alpha, beta, A, b, N, T)
   %xi size:states*states: (N, N) 已对1：T-1时刻求和
   
   xi = zeros(N, N);
   
   for t = 1:T-1
    %{   
       pro = 0;
       tmp = zeros(N, N);
     for i = 1:N
       for j = 1:N
          tmp(i, j) = alpha(i, t) * A(i,j) * b(j,t+1) * beta(j, t+1);
          pro = pro + tmp(i, j);
       end
     end
     xi = xi + tmp./pro;
     %}  
     tmp = beta(:,t+1) .* b(:,t+1);
     xi = xi + normalise((A .* (alpha(:,t) * tmp')));
   end
end