function [Broute,TabuList] = HA_Tabu(N,S0,TabuList,dmat)
CandidatesNum = 200;
Bdist = CalDistofS(dmat,S0);
TabuLength = round((N*(N-1)/2)^0.5);
Twocity = zeros(CandidatesNum,2);
    i = 1;
    while i<= CandidatesNum
        M = ceil(N*rand(1,2)); %随机生成两个城市序号
        if M(1) ~= M(2)
            Twocity(i,1) = max(M(1),M(2)); %最小值存在1，最大值存在2
            Twocity(i,2) = min(M(1),M(2));
            if i ==1
                isa = 0; %是否生成相同的城市互换对，1为生成了
            else
                for j = 1:i-1
                    if Twocity(i,1)==Twocity(j,1)&&Twocity(i,2)==Twocity(j,2)
                        %若相同
                        isa =1;
                        break;
                    else
                        isa =0;
                    end
                end
            end
            if ~isa %若生成的城市对与之前的都不相同则可以继续生成城市对
                i =i+1;
            end
        end
    end
   %% 产生领域解，选取前100个为候选解 
     %保留前100个最好领域解为候选解
     BestCandNum = 100;
     %定义一个表格，四列，分别存储领域解序号i,路径长度L(i),Twocity(i,1),Twocity(i,2)
     BCandidate = Inf * ones(BestCandNum,4);
     L = zeros(1,CandidatesNum);
     %相当于产生一个S0的解，包含有200个领域解，从中找出最佳的100个才是候选解
     for i = 1:CandidatesNum
         Candidates(i,:) = S0;  %领域解
         Candidates(i,[Twocity(i,2),Twocity(i,1)]) = S0([Twocity(i,1),Twocity(i,2)]); %在当前解S0上交换两个城市的位置
         %计算当前领域解路径的距离
         L(i) = CalDistofS(dmat,Candidates(i,:));
         %选出100个最好的领域解充当候选解
         if i<= BestCandNum
            BCandidate(i,1) = i;
            BCandidate(i,2) = L(i);
            BCandidate(i,3) = S0(Twocity(i,1));
            BCandidate(i,4) = S0(Twocity(i,2));
         else
             for j =1:BestCandNum
                if L(i) < BCandidate(j,2)  %领域解超出100个，则需要比较选取较小距离的
                    BCandidate(j,1) = i;
                    BCandidate(j,2) = L(i);
                    BCandidate(j,3) = S0(Twocity(i,1));
                    BCandidate(j,4) = S0(Twocity(i,2));
                    break;
                end
             end
         end
     end
     %根据距离，对候选解进行排序
     [~,Index] = sort(BCandidate(:,2));  %Index是BCandidate中距离升序排列后的索引
     SBest = BCandidate(Index,:);
     BCandidate = SBest;  %此时的BCandidate是按第二列路径长度升序排列的
     %% 特赦准则是否满足，更新禁忌表
     if BCandidate(1,2)< Bdist  %如果小于当前最优
         Bdist = BCandidate(1,2);
         %当前最优解变为候选解中的第BCandidate（1,1）行
         S0 = Candidates(BCandidate(1,1),:);
         Broute = S0;
         for m = 1:N
             for n = 1:N
                 if TabuList(m,n) ~=0
                     TabuList(m,n) = TabuList(m,n) -1;  %更新禁忌表，禁忌长度减1
                 end
             end
         end
         TabuList(BCandidate(1,3),BCandidate(1,4)) = TabuLength;  %更新禁忌表
     else   %若没有找到比当前最优解更好的解
         for i = 1:BestCandNum
             if TabuList(BCandidate(i,3),BCandidate(i,4)) == 0  %如果已经解禁了
                 Broute = Candidates(BCandidate(i,1),:);
                 for m = 1:N
                     for n = 1:N
                         if TabuList(m,n) ~=0
                           TabuList(m,n) = TabuList(m,n) -1;  %更新禁忌表，禁忌长度减1
                         end
                     end
                 end
                 TabuList(BCandidate(i,3),BCandidate(i,4)) = TabuLength;  %更新禁忌表
                 break; 
             end
         end
     end
end

function L = CalDistofS(dmat,S)
     dist = 0;
     n = size(S,2);
     for k = 1:(n-1)
         dist = dist +dmat(S(k),S(k+1)); %中间路径的距离
     end
     L = dist + dmat(S(n),S(1)); %回到起点的距离
end

