function hmm_train()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
train_data1 = readtable('C:\工作\dobi_score\T曲线数据class1.csv');
train_data2 = readtable('C:\工作\dobi_score\T曲线数据class2.csv');
train_data3 = readtable('C:\工作\dobi_score\T曲线数据class3.csv');

train_data1 = train_data1{:,:};
train_data2 = train_data2{:,:};
train_data3 = train_data3{:,:};

% O：观察状态数
O = 10;
% Q：HMM状态数
Q = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Training process..
% initial guess of parameters
% 初始化参数
%prior1 = normalise(rand(Q,1));
%transmat1 = mk_stochastic(rand(Q,Q));
%obsmat1 = mk_stochastic(rand(Q,O));
%用保存好的模型时用下面的
hmm_param = load('D:\Data\hmm_param_test.mat');
prior1 = hmm_param.hmm.prior1;
transmat1 = hmm_param.hmm.transmat1;
obsmat1 = hmm_param.hmm.obsmat1;

% improve guess of parameters using EM
% 用data数据集训练参数矩阵形成新的HMM模型
[LL_class1, prior_class1, transmat_class1, obsmat_class1] = dhmm_em(train_data1, prior1, transmat1, obsmat1, 'max_iter', size(train_data1,1));

prior2 = normalise(rand(Q,1));
transmat2 = mk_stochastic(rand(Q,Q));
obsmat2 = mk_stochastic(rand(Q,O));
%prior2 = hmm_param.hmm_param.prior;
%transmat2 = hmm_param.hmm_param.transmat;
%obsmat2 = hmm_param.hmm_param.obsmat;

[LL_class2, prior_class2, transmat_class2, obsmat_class2] = dhmm_em(train_data2, prior2, transmat2, obsmat2, 'max_iter', size(train_data2,1));

%hmm_param = load('D:\Data\hmm\hmm_param3_80_78_50.mat');
prior3 = normalise(rand(Q,1));
transmat3 = mk_stochastic(rand(Q,Q));
obsmat3 = mk_stochastic(rand(Q,O));
%prior3 = hmm_param.hmm_param.prior;
%transmat3 = hmm_param.hmm_param.transmat;
%obsmat3 = hmm_param.hmm_param.obsmat;

[LL_class3, prior_class3, transmat_class3, obsmat_class3] = dhmm_em(train_data3, prior3, transmat3, obsmat3, 'max_iter', size(train_data3,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing
% Testing Data..
%{
S2_test = load([folder,'S2_test.mat']);
S2_test_data = S2_test.y1;

S1_test = load([folder, 'S1_test.mat']);
S1_test_data = S1_test.y1;

S0_test = load([folder, 'S0_test.mat']);
S0_test_data = S0_test.y1;
%}
correct_prob = zeros([1,3]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%order: class1, class2, class3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% class1 testing loop..
testNum = size(train_data1, 1);
loglik1 = zeros([3, testNum]);
class1 = zeros([1, testNum]);

for i = 1:testNum
loglik1(1, i) = dhmm_logprob(train_data1(i,:), prior_class1, transmat_class1, obsmat_class1);
loglik1(2, i) = dhmm_logprob(train_data1(i,:), prior_class2, transmat_class2, obsmat_class2);
loglik1(3, i) = dhmm_logprob(train_data1(i,:), prior_class3, transmat_class3, obsmat_class3);
class1(1, i) = find(loglik1(:, i) == max([loglik1(1, i), loglik1(2, i), loglik1(3, i)]));
end
correct_prob(1,1) = size(find(class1 == 1), 2) / testNum;
disp(['class1 correct probability: ', num2str(correct_prob(1,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% class2 testing loop..
testNum = size(train_data2, 1);
loglik2 = zeros([3, testNum]);
class2 = zeros([1, testNum]);

for i = 1:testNum
loglik2(1, i) = dhmm_logprob(train_data2(i,:), prior_class1, transmat_class1, obsmat_class1);
loglik2(2, i) = dhmm_logprob(train_data2(i,:), prior_class2, transmat_class2, obsmat_class2);
loglik2(3, i) = dhmm_logprob(train_data2(i,:), prior_class3, transmat_class3, obsmat_class3);
class2(1, i) = find(loglik2(:, i) == max([loglik2(1, i), loglik2(2, i), loglik2(3, i)]));
end
correct_prob(1,2) = size(find(class2 == 2), 2) / testNum;
disp(['class2 correct probability: ', num2str(correct_prob(1,2))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% class2 testing loop..
testNum = size(train_data3, 1);
loglik3 = zeros([3, testNum]);
class3 = zeros([1, testNum]);

for i = 1:testNum
loglik3(1, i) = dhmm_logprob(train_data3(i,:), prior_class1, transmat_class1, obsmat_class1);
loglik3(2, i) = dhmm_logprob(train_data3(i,:), prior_class2, transmat_class2, obsmat_class2);
loglik3(3, i) = dhmm_logprob(train_data3(i,:), prior_class3, transmat_class3, obsmat_class3);
class3(1, i) = find(loglik3(:, i) == max([loglik3(1, i), loglik3(2, i), loglik3(3, i)]));
end
correct_prob(1,3) = size(find(class3 == 3), 2) / testNum;
disp(['class3 correct probability: ', num2str(correct_prob(1,3))]);

end