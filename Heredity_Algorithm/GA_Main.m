clear
clc
close all
%% 随机数据参数
r=100;    %区域大小
a0=0;b0=0;    %无人机起始位置
H=10;


X(:,1)=rand(50,1);X(:,2)=rand(50,1);  %生成50个花朵随机位置


X=X.*r;
X(1,1)=a0;X(1,2)=b0;

D=GA_Distanse(X);  %生成距离矩阵
N=size(D,1);    %花朵个数
%% 遗传参数
NIND=100;       %种群大小
MAXGEN=350;     %最大遗传代数
Pc=0.9;         %交叉概率
Pm=0.05;        %变异概率
GGAP=0.9;       %代沟
%% 初始化种群

% Chrom 种群
Chrom = GA_InitPop(NIND,N);

%% 画出随机解的路径图
GA_DrawPath(Chrom(1,:),X)
pause(0.0001)
%% 输出随机解的路径和总距离
disp('初始种群中的一个随机值:')
GA_OutputPath(Chrom(1,:));
Rlength=GA_PathLength(D,Chrom(1,:));
disp(['无人机路程总距离：',num2str(Rlength)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%% 优化
gen=0;
figure;
hold on;box on
xlim([0,MAXGEN])
title('优化过程')
xlabel('代数')
ylabel('最优值')
ObjV=GA_PathLength(D,Chrom);  %计算无人机路径长度
preObjV=min(ObjV);
while gen<MAXGEN  % generation
    %% 计算适应度
    ObjV=GA_PathLength(D,Chrom);  %计算路径长度
    line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    preObjV=min(ObjV);
    FitnV=GA_Fitness(ObjV);

    %% 选择 (因为有代沟，需要从100个里面选90个)
    SelCh=GA_Select(Chrom,FitnV,GGAP);
% 100 个 - 90个出来 -》 90个 共190个
    %% 交叉操作
    SelCh=GA_Recombin(SelCh,Pc);

    %% 变异
    SelCh=GA_Mutate(SelCh,Pm);

    %% 逆转操作
    SelCh=GA_Reverse(SelCh,D);

    %% 重插入子代的新种群 把190个里面重新选100个作为新种群
    Chrom=GA_Reins(Chrom,SelCh,ObjV);

    %% 更新迭代次数
    gen=gen+1 ;

end
%% 画出最优解的路径图
ObjV=GA_PathLength(D,Chrom);  %计算无人机路程路径长度
[minObjV,minInd]=min(ObjV);
GA_DrawPath(Chrom(minInd(1),:),X)
%% 输出最优解的路径和总距离
disp('最优解:')
p=GA_OutputPath(Chrom(minInd(1),:));
disp(['无人机路程总距离：',num2str(ObjV(minInd(1)))]);
disp('-------------------------------------------------------------')
