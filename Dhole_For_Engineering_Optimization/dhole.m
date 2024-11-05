
function [best_fun,prey_global,cuve_f]  =dhole(Benchmark_Function_ID, N, T)
%% Define Parameters
[lb,ub,dim]=benchmark_functions_details(Benchmark_Function_ID);
lb=ones(1,dim).*transpose(lb);                              % Lower limit for variables
ub=ones(1,dim).*transpose(ub);
cuve_f=zeros(1,T); 
% X=initialization(N,dim,ub,lb); %Initialize population
%% INITIALIZATION
for i=1:dim
    X(:,i) = lb(i)+rand(N,1).*(ub(i) - lb(i));                          % Initial population
end

global_Cov = zeros(1,T);
Best_fitness = inf;
% best_position = zeros(1,dim);
fitness_f = zeros(1,N);
for i=1:N
    L=X(i,:);
   fitness_f(i) = benchmark_functions(L,Benchmark_Function_ID,dim); %Calculate the fitness value of the function
   if fitness_f(i)<Best_fitness
       Best_fitness = fitness_f(i);
       localBest_position = X(i,:);
   end
end
%%
prey_global = localBest_position; 
% global_fitness = Best_fitness;
cuve_f(1)=Best_fitness;
t=1;
% explotation=0;
% 
% exploration=0;

while(t<=T)
%     explote=0;
%     explor=0;
    C = 1-(t/T); %Eq.(7)
    PWN = round(rand*15+5); %Eq.(3)
    prey = (prey_global+localBest_position)/2; %Eq.(5)
    prey_local = localBest_position;
        
    for i = 1:N
        
        if rand()<0.5
%             explor=explor+1;
%             exploration(t)=explor;
            if PWN<10
            %% Searching stage
              for j = 1:dim  
                Xnew(i,:) = X(i,:)+C*rand.*(prey(j)-X(i,:)); %Eq.(6)
              end
            else
            %% Encircling stage
                for j = 1:dim
                    z = round(rand*(N-1))+1;  %Eq.(9)
                    Xnew(i,j) = X(i,j)-X(z,j)+prey(j);  %Eq.(8)
                end
            end
        else
            %% Hunting stage
%              explote=explote+1;
%             explotation(t)=explote;
            %D_prey=global_position; %Eq.(10)
            Q = 3*rand*fitness_f(i)/benchmark_functions(prey_local,Benchmark_Function_ID,dim); %Eq.(10)
            if Q>2   % The prey is too big
                 W_prey = exp(-1/Q).*prey_local;   %Eq.(11)
                for j = 1:dim
                    Xnew(i,j) = X(i,j)+cos(2*pi*rand)*W_prey(j)*p_obj(PWN)-sin(2*pi*rand)*W_prey(j)*p_obj(PWN); %Eq.(12)
                end
            else
                Xnew(i,:) = (X(i,:)-prey_global)*p_obj(PWN)+p_obj(PWN).*rand(1,dim).*X(i,:); %Eq.(13)
            end
        end
    end
    %% boundary conditions
    for i=1:N
        for j =1:dim
            if length(ub)==1
                Xnew(i,j) = min(ub,Xnew(i,j));
                Xnew(i,j) = max(lb,Xnew(i,j));
            else
                Xnew(i,j) = min(ub(j),Xnew(i,j));
                Xnew(i,j) = max(lb(j),Xnew(i,j));
            end
        end
    end
   
    localBest_position = Xnew(1,:);%%local
    localBest_fitness =  benchmark_functions(localBest_position,Benchmark_Function_ID,dim);%%local
 
    for i =1:N
         %% Obtain the optimal solution for the updated population
        local_fitness =  benchmark_functions(Xnew(i,:),Benchmark_Function_ID,dim);
        if local_fitness<localBest_fitness
                 localBest_fitness = local_fitness;
                 localBest_position = Xnew(i,:);
        end
        %% Update the population to a new location
        if local_fitness<fitness_f(i)
             fitness_f(i) = local_fitness;
             X(i,:) = Xnew(i,:);
             if fitness_f(i)<Best_fitness
                 Best_fitness=fitness_f(i);
                 prey_global = X(i,:);
             end
        end
    end

    global_Cov(t) = localBest_fitness;
    cuve_f(t) = Best_fitness;
    T_particle(t)= Xnew(1);
    t=t+1;
%     if mod(t,50)==0
%       disp("DOA"+"iter"+num2str(t)+": "+Best_fitness); 
%    end


end
 best_fun = Best_fitness;
 
end


function y = p_obj(x)   %Eq.(4)
PMN=x;
C1 = 1.5;
mu = 25;
k = 0.08;
% D=rand;
y = ((C1 / (1 + exp(-k * (PMN- mu))))^2)* rand;
end

%% Figures %%%%%%%%%%%%%%%%
%figure (1)
%func_c("F1");

% figure (2);
% semilogy (best_fun,'Color','g',"LineWidth",2)
% title('Avarage fitness of all population')
% grid on;

%figure (5); %% trajectory
%plot(T_particle,'Color','r',"LineWidth",2)
%title('Trajectory of the best solution')