%% 变异操作
%输入：
%SelCh  被选择的个体 （待变异的种群）
%Pm     变异概率
%输出：
% SelCh 变异后的个体（变异后的种群）

function SelCh=GA_Mutate(SelCh,Pm)
[NSel,L]=size(SelCh);
for i=1:NSel
    if Pm>=rand
        R=randperm(L);
        SelCh(i,R(1:2))=SelCh(i,R(2:-1:1));
    end
end

% 12345 ---- 12435
% 0.9 
% % P(rand()>0.9) = 0.1 
%  if pm >= rand 