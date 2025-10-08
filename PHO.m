%Main code for 
% Philosophy Optimizer (PhO)
% Journal: Artificial Intelligence Review (2025)
% Authors: S. TalatAhari, H. Bayzidi, P. Sareh

function Output=PHO(nDim,MaxIter,nPop)

Convergence = zeros(MaxIter,1);

% Problem Information
[LB, UB] = ProbInfo;
LB = LB.*ones(1,nDim);
UB = UB.*ones(1,nDim);

%% Initialization
X = nan(nPop,nDim);
Obj = nan(nPop, 1);

for i = 1:nPop
    X(i,:) = LB + rand(1,nDim).*(UB - LB);
    Obj(i) = Objective(X(i,:));
end

%% PhO Main Loop
for Iter = 1:MaxIter
    for i = 1:nPop
        % Philisopical Selection
        [~,idsorted]=sort(Obj);
        idsorted(idsorted==i)=[];
        jkid=randperm(fix((nPop-1)/2),2)+ [0,fix((nPop-1)/2)];
        jk=idsorted(jkid);
        
        % Philosophical State
        m = [i jk];
        m = m(randperm(3));
        
        % r1,r2,r3,s1,s2,s3
        r1=rand(1,nDim);
        r2=rand(1,nDim);
        r3=rand(1,nDim);
        s1=randi([0,1]);
        s2=randi([0,1]);
        s3=sign(Obj(m(2))-Obj(m(3)));
        
        % New Solution Gereation
        NewX = X(m(1),:)...
            + s1.*r1.*(X(m(2),:)-X(m(1),:)) ...
            + s2.*r2.*(X(m(3),:)-X(m(1),:)) ...
            + s3.*r3.*(X(m(3),:)-X(m(2),:));
        
        % Clamp New Solution
        NewX = min(max(NewX,LB),UB);
         
        % Evaluation
        NewObj =  Objective(NewX);
      
        if NewObj <= Obj(i)
            Obj(i) = NewObj;
            X(i, :) = NewX;
        end
    end
    
    % Find The Best Theory
        [ObjBest,bestid] = min(Obj);    
       

    % Dispaly Result In Each Iteration
    disp([' Iter: ' num2str(Iter) ' fmin = ' num2str(ObjBest)])
    
    Convergence(Iter)=ObjBest;
end
Output.ObjBest=ObjBest;
Output.Conve=Convergence;
end
%% addational functions
function obj=Objective(X)
    obj=sum(X.^2);
end

function [LB,UB]=ProbInfo
    LB=-5;
    UB=+5;
end
