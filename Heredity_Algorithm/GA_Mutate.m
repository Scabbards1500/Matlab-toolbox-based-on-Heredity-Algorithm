%% �������
%���룺
%SelCh  ��ѡ��ĸ��� �����������Ⱥ��
%Pm     �������
%�����
% SelCh �����ĸ��壨��������Ⱥ��

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