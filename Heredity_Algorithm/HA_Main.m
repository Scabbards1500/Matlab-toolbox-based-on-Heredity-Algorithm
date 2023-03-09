clear
clc
close all
%% ������ݲ���
r=100;    %�����С
a0=0;b0=0;    %���˻���ʼλ��
H=10;
X(:,1)=rand(50,1);X(:,2)=rand(50,1);  %����50���������λ��
X=X.*r;
X(1,1)=a0;X(1,2)=b0;
D=HA_Distanse(X);  %���ɾ������
N=size(D,1);    %�������
%% �Ŵ�����
NIND=100;       %��Ⱥ��С
MAXGEN=500;     %����Ŵ�����
Pc=0.9;         %�������
Pm=0.05;        %�������
GGAP=0.9;       %����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%�����㷨����
a = meshgrid(1:N); %����N*N�������
dmat = reshape(sqrt(sum((X(a,:)-X(a',:)).^2,2)),N,N); % 'Ϊ�����ת�ã�reshape����������N*N�ľ���
TabuLength = round((N*(N-1)/2)^0.5); %round��������
TabuList = zeros(N); %���ɱ�����Ϊ���л����ԣ�ΪN*N�ľ��󣬾����е�ֵ������ɳ��ȣ���ʼ���ɳ���Ϊ0
CandidatesNum = 200; %�����ĸ������������ѡ����ѡ��
Candidates = zeros(CandidatesNum,N); %����⼯��
S0 = randperm(N); %�������һ����ʼ��
Broute = S0; %��ǰ��ѵ�·��
Bdist = Inf; %��ǰ���·���ܾ���
%%BLHistory = zeros(IterNum,1); %��¼����·������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ��ʼ����Ⱥ
Chrom=HA_InitPop(NIND,N);
%% ����������·��ͼ
HA_DrawPath(Chrom(1,:),X)
pause(0.0001)
%% ���������·�����ܾ���
disp('��ʼ��Ⱥ�е�һ�����ֵ:')
HA_OutputPath(Chrom(1,:));
Rlength=HA_PathLength(D,Chrom(1,:));
disp(['���˻�·���ܾ��룺',num2str(Rlength)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%% �Ż�
gen=0;
figure;
hold on;box on
xlim([0,MAXGEN])
title('�Ż�����')
xlabel('����')
ylabel('����ֵ')
ObjV=HA_PathLength(D,Chrom);  %�������˻�·������
preObjV=min(ObjV);
while gen<MAXGEN
    %% ������Ӧ��
    ObjV=HA_PathLength(D,Chrom);  %����·������
    line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    preObjV=min(ObjV);
    FitnV=HA_Fitness(ObjV);
    %% ѡ��
    SelCh=HA_Select(Chrom,FitnV,GGAP);
    %% �������
    SelCh=HA_Recombin(SelCh,Pc);
    %% ����
    SelCh=HA_Mutate(SelCh,Pm);
    %% ��ת����
    SelCh=HA_Reverse(SelCh,D);
    
    %% �����㷨
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [SelCh(1,:),TabuList] = HA_Tabu(N,SelCh(1,:),TabuList,dmat);
    [SelCh(2,:),TabuList] = HA_Tabu(N,SelCh(2,:),TabuList,dmat);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% �ز����Ӵ�������Ⱥ
    Chrom=HA_Reins(Chrom,SelCh,ObjV);
    %% ���µ�������
    gen=gen+1 ;
end
%% �������Ž��·��ͼ
ObjV=HA_PathLength(D,Chrom);  %�������˻�·��·������
[minObjV,minInd]=min(ObjV);
HA_DrawPath(Chrom(minInd(1),:),X)
%% ������Ž��·�����ܾ���
disp('���Ž�:')
p=HA_OutputPath(Chrom(minInd(1),:));
disp(['���˻�·���ܾ��룺',num2str(ObjV(minInd(1)))]);
disp('-------------------------------------------------------------')
