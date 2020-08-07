function beta = calBeta(beta, A, b, T, N, tCurve)
%calculate beta(induction step)
beta = zeros(N, T);
beta(:,T) = ones(N,1); %时刻T的beta初始化为1

    for t = T-1:-1:1
       %for i = 1:N
           tmp_sum = 0;
           %for j = 1:N
               %beta(:, t) = A * (b(:, t+1) .* beta(:, t+1));
           %end
           %beta(i, t) = tmp_sum;
           beta(:, t) = A * (b(:, t+1).*beta(:,t+1));
           beta(:,t) = normalise(beta(:,t));
       %end
    end
end