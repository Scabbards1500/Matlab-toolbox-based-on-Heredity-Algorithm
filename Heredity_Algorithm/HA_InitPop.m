%% ��ʼ����Ⱥ
%���룺
% NIND����Ⱥ��С
% N��   ����Ⱦɫ�峤��
%�����
%��ʼ��Ⱥ
function Chrom=HA_InitPop(NIND,N)
Chrom=zeros(NIND,N);%���ڴ洢��Ⱥ
for i=1:NIND
    Chrom(i,:)=randperm(N);%������ɳ�ʼ��Ⱥ
end