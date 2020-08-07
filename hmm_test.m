function hmm_test()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
train_data1 = readtable('C:\工作\dobi_score\T曲线数据class1.csv');
train_data2 = readtable('C:\工作\dobi_score\T曲线数据class2.csv');
train_data3 = readtable('C:\工作\dobi_score\T曲线数据class3.csv');

train_data1 = train_data1{:,:};
train_data2 = train_data2{:,:};
train_data3 = train_data3{:,:};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%导入参数

hmm_param1 = load('D:\Data\hmm_param1.mat');
hmm_param2 = load('D:\Data\hmm_param2.mat');
hmm_param3 = load('D:\Data\hmm_param3.mat');
prior_class1 = hmm_param1.hmm_param.pai;
transmat_class1 = hmm_param1.hmm_param.A;
obsmat_class1 = hmm_param1.hmm_param.B;

prior_class2 = hmm_param2.hmm_param.pai; %自己实现的HMM测试
transmat_class2 = hmm_param2.hmm_param.A; %自己实现的HMM测试
obsmat_class2 = hmm_param2.hmm_param.B; %自己实现的HMM测试

prior_class3 = hmm_param3.hmm_param.pai;
transmat_class3 = hmm_param3.hmm_param.A;
obsmat_class3 = hmm_param3.hmm_param.B;
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