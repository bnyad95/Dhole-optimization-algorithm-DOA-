function [BestSolDE,BestCost]=DE( Benchmark_Function_ID, N, T)

[lb,ub,dim]=benchmark_functions_details(Benchmark_Function_ID);
lb=ones(1,dim).*transpose(lb);                              % Lower limit for variables
ub=ones(1,dim).*transpose(ub);
%% Problem Definition

nVar=dim;            % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=lb;          % Lower Bound of Decision Variables
VarMax= ub;          % Upper Bound of Decision Variables

%% DE Parameters

MaxIt=T;      % Maximum Number of Iterations

nPop=N;        % Population Size

beta_min=0.2;   % Lower Bound of Scaling Factor
beta_max=0.8;   % Upper Bound of Scaling Factor

pCR=0.2;        % Crossover Probability

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];

BestSol.Cost=inf;

pop=repmat(empty_individual,nPop,1);

for i=1:nPop

    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    pop(i).Cost=benchmark_functions(pop(i).Position,Benchmark_Function_ID,dim);
    
    if pop(i).Cost<BestSol.Cost
        BestSol=pop(i);
    end
    
end

BestCost=zeros(MaxIt,1);

%% DE Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        x=pop(i).Position;
        
        A=randperm(nPop);
        
        A(A==i)=[];
        
        a=A(1);
        b=A(2);
        c=A(3);
        
        % Mutation
        %beta=unifrnd(beta_min,beta_max);
        beta=unifrnd(beta_min,beta_max,VarSize);
        y=pop(a).Position+beta.*(pop(b).Position-pop(c).Position);
        y = max(y, VarMin);
		y = min(y, VarMax);
		
        % Crossover
        z=zeros(size(x));
        j0=randi([1 numel(x)]);
        for j=1:numel(x)
            if j==j0 || rand<=pCR
                z(j)=y(j);
            else
                z(j)=x(j);
            end
        end
        
        NewSol.Position=z;
        NewSol.Cost=benchmark_functions(NewSol.Position,Benchmark_Function_ID,dim);
        
        if NewSol.Cost<pop(i).Cost
            pop(i)=NewSol;
            
            if pop(i).Cost<BestSol.Cost
               BestSol=pop(i);
            end
        end
        
    end
    
    % Update Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    % disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end
BestSolDE=BestSol;
end
