%% ѡ�����
%����
%Chrom ��Ⱥ
%FitnV ��Ӧ��ֵ
%GGAP������
%���
%SelCh  ��ѡ��ĸ���
function SelCh=HA_Select(Chrom,FitnV,GGAP)
NIND=size(Chrom,1);
NSel=max(floor(NIND*GGAP+.5),2);
ChrIx=HA_Sus(FitnV,NSel);
SelCh=Chrom(ChrIx,:);