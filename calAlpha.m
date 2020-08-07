function [alpha, loglik] = calAlpha(alpha, pai, A, b, tCurve)
    %calculate alpha matrix(induction step)
    %alpha size: state * time
    T = size(alpha, 2);
    scale = ones(1, T); %alpha第t列求和
    
    alpha(:, 1) = pai(:).*b(:,1);
    [alpha(:,1), scale(1)] = normalise(alpha(:,1));
    scaled = 1;
    %loop t
    %for j = 1:N
        for t = 1:T-1  %loop j:state
            %alpha(j, t+1) = (A(:,j)'*alpha(:,t)).*B(j,tCurve(t));   
            %A的每一行是Sj->S1~SN的概率，转置后每行是S1~SN->Sj的概率
            alpha(:, t+1) = A' * alpha(:,t).* b(:,t+1);
            [alpha(:, t+1), scale(t+1)] = normalise(alpha(:,t+1));
        end
    %end
% scale(t) = Pr(O(t) | O(1:t-1)) = 1/c(t) as defined by Rabiner(1989).这里是loglik
% Hence prod_t scale(t) = Pr(O(1)) Pr(O(2)|O(1)) Pr(O(3) | O(1:2)) ... = Pr(O(1), ... ,O(T))
% or log P = sum_t log scale(t).   
 if scaled
     if any(scale==0)
         loglik = -inf;
     else
         loglik = sum(log(scale));
     end
 else
     loglik = log(sum(alpha(:,T)));
 end
end