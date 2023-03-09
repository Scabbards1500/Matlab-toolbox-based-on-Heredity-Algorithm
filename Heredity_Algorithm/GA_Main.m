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

D=GA_Distanse(X);  %���ɾ������
N=size(D,1);    %�������
%% �Ŵ�����
NIND=100;       %��Ⱥ��С
MAXGEN=350;     %����Ŵ�����
Pc=0.9;         %�������
Pm=0.05;        %�������
GGAP=0.9;       %����
%% ��ʼ����Ⱥ

% Chrom ��Ⱥ
Chrom = GA_InitPop(NIND,N);

%% ����������·��ͼ
GA_DrawPath(Chrom(1,:),X)
pause(0.0001)
%% ���������·�����ܾ���
disp('��ʼ��Ⱥ�е�һ�����ֵ:')
GA_OutputPath(Chrom(1,:));
Rlength=GA_PathLength(D,Chrom(1,:));
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
ObjV=GA_PathLength(D,Chrom);  %�������˻�·������
preObjV=min(ObjV);
while gen<MAXGEN  % generation
    %% ������Ӧ��
    ObjV=GA_PathLength(D,Chrom);  %����·������
    line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    preObjV=min(ObjV);
    FitnV=GA_Fitness(ObjV);

    %% ѡ�� (��Ϊ�д�������Ҫ��100������ѡ90��)
    SelCh=GA_Select(Chrom,FitnV,GGAP);
% 100 �� - 90������ -�� 90�� ��190��
    %% �������
    SelCh=GA_Recombin(SelCh,Pc);

    %% ����
    SelCh=GA_Mutate(SelCh,Pm);

    %% ��ת����
    SelCh=GA_Reverse(SelCh,D);

    %% �ز����Ӵ�������Ⱥ ��190����������ѡ100����Ϊ����Ⱥ
    Chrom=GA_Reins(Chrom,SelCh,ObjV);

    %% ���µ�������
    gen=gen+1 ;

end
%% �������Ž��·��ͼ
ObjV=GA_PathLength(D,Chrom);  %�������˻�·��·������
[minObjV,minInd]=min(ObjV);
GA_DrawPath(Chrom(minInd(1),:),X)
%% ������Ž��·�����ܾ���
disp('���Ž�:')
p=GA_OutputPath(Chrom(minInd(1),:));
disp(['���˻�·���ܾ��룺',num2str(ObjV(minInd(1)))]);
disp('-------------------------------------------------------------')
