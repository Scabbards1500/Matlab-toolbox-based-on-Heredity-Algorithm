%% ������ת����
%����
%SelCh ��ѡ��ĸ���
%D     ����ľ������
%���
%SelCh  ������ת��ĸ���
function SelCh=HA_Reverse(SelCh,D)
[row,col]=size(SelCh);
ObjV=HA_PathLength(D,SelCh);  %����·������
SelCh1=SelCh;
for i=1:row
    r1=randsrc(1,1,[1:col]);
    r2=randsrc(1,1,[1:col]);
    mininverse=min([r1 r2]);
    maxinverse=max([r1 r2]);
    SelCh1(i,mininverse:maxinverse)=SelCh1(i,maxinverse:-1:mininverse);
end
ObjV1=HA_PathLength(D,SelCh1);  %����·������
index=ObjV1<ObjV;
SelCh(index,:)=SelCh1(index,:);



