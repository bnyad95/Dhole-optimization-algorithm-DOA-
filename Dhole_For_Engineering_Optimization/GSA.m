% Gravitational Search Algorithm.
function [Fbest,Lbest,BestChart]=GSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower)

%V:   Velocity.
%a:   Acceleration.
%M:   Mass.  Ma=Mp=Mi=M;
%dim: Dimension of the test function.
%N:   Number of agents.
%X:   Position of agents. dim-by-N matrix.
%R:   Distance between agents in search space.
%[low-up]: Allowable range for search space.
%Rnorm:  Norm in eq.8.
%Rpower: Power of R in eq.7.
 
 Rnorm=2; 
 
%get allowable range and dimension of the test function.
 [down,up,dim]=benchmark_functions_details(Benchmark_Function_ID);

%random initialization for agents.
X=initialization(dim,N,up,down); 

%create the best so far chart and average fitnesses chart.
BestChart=[];

V=zeros(dim,N);

for iteration=1:Max_Iteration
%     iteration
    
    %Checking allowable range. 
    X=space_bound(X,up,down); 

    %Evaluation of agents. 
    fitness=evaluateF(X,Benchmark_Function_ID); 
    
    if min_flag==1
    [best, best_X]=min(fitness); %minimization.
    else
    [best best_X]=max(fitness); %maximization.
    end        
    
    if iteration==1
       Fbest=best;Lbest=X(:,best_X);
    end
    if min_flag==1
      if best<Fbest  %minimization.
       Fbest=best;Lbest=X(:,best_X);
      end
    else 
      if best>Fbest  %maximization
       Fbest=best;Lbest=X(:,best_X);
      end
    end
      
BestChart=[BestChart Fbest];

%Calculation of M. eq.14-20
[M]=massCalculation(fitness,min_flag); 

%Calculation of Gravitational constant. eq.13.
G=Gconstant(iteration,Max_Iteration); 

%Calculation of accelaration in gravitational field. eq.7-10,21.
a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,Max_Iteration);

%Agent movement. eq.11-12
[X,V]=move(X,a,V);

end %iteration

