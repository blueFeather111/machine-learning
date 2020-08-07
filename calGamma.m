function gamma = calGamma(gamma, alpha, beta, N, T)
%alpha size:(N, T) beta size:(N, T)
    for t = 1:T
%         for i = 1:N
%             gamma(t,i) = alpha(t,i)*beta(t,i)/((alpha(t,:)*beta(t,:)')+0.0001);
%         end
          gamma(:,t) = normalise(alpha(:,t) .* beta(:,t));
    end
end