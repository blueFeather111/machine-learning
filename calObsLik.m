function B = calObsLik(data, obsmat)

[Q O] = size(obsmat);
T = prod(size(data)); % length(data);
B = zeros(Q,T);

for t=1:T
  B(:,t) = obsmat(:, data(t));
end
