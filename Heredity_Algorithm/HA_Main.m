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
D=HA_Distanse(X);  %生成距离矩阵
N=size(D,1);    %花朵个数
%% 遗传参数
NIND=100;       %种群大小
MAXGEN=500;     %最大遗传代数
Pc=0.9;         %交叉概率
Pm=0.05;        %变异概率
GGAP=0.9;       %代沟

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%禁忌算法参数
a = meshgrid(1:N); %生成N*N升序矩阵
dmat = reshape(sqrt(sum((X(a,:)-X(a',:)).^2,2)),N,N); % '为矩阵的转置，reshape把数据生成N*N的矩阵
TabuLength = round((N*(N-1)/2)^0.5); %round四舍五入
TabuList = zeros(N); %禁忌表设置为城市互换对，为N*N的矩阵，矩阵中的值代表禁忌长度，初始禁忌长度为0
CandidatesNum = 200; %领域解的个数，由领域解选出候选解
Candidates = zeros(CandidatesNum,N); %领域解集合
S0 = randperm(N); %随机产生一个初始解
Broute = S0; %当前最佳的路劲
Bdist = Inf; %当前最佳路径总距离
%%BLHistory = zeros(IterNum,1); %记录最优路径长度
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 初始化种群
Chrom=HA_InitPop(NIND,N);
%% 画出随机解的路径图
HA_DrawPath(Chrom(1,:),X)
pause(0.0001)
%% 输出随机解的路径和总距离
disp('初始种群中的一个随机值:')
HA_OutputPath(Chrom(1,:));
Rlength=HA_PathLength(D,Chrom(1,:));
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
ObjV=HA_PathLength(D,Chrom);  %计算无人机路径长度
preObjV=min(ObjV);
while gen<MAXGEN
    %% 计算适应度
    ObjV=HA_PathLength(D,Chrom);  %计算路径长度
    line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    preObjV=min(ObjV);
    FitnV=HA_Fitness(ObjV);
    %% 选择
    SelCh=HA_Select(Chrom,FitnV,GGAP);
    %% 交叉操作
    SelCh=HA_Recombin(SelCh,Pc);
    %% 变异
    SelCh=HA_Mutate(SelCh,Pm);
    %% 逆转操作
    SelCh=HA_Reverse(SelCh,D);
    
    %% 禁忌算法
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [SelCh(1,:),TabuList] = HA_Tabu(N,SelCh(1,:),TabuList,dmat);
    [SelCh(2,:),TabuList] = HA_Tabu(N,SelCh(2,:),TabuList,dmat);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% 重插入子代的新种群
    Chrom=HA_Reins(Chrom,SelCh,ObjV);
    %% 更新迭代次数
    gen=gen+1 ;
end
%% 画出最优解的路径图
ObjV=HA_PathLength(D,Chrom);  %计算无人机路程路径长度
[minObjV,minInd]=min(ObjV);
HA_DrawPath(Chrom(minInd(1),:),X)
%% 输出最优解的路径和总距离
disp('最优解:')
p=HA_OutputPath(Chrom(minInd(1),:));
disp(['无人机路程总距离：',num2str(ObjV(minInd(1)))]);
disp('-------------------------------------------------------------')
