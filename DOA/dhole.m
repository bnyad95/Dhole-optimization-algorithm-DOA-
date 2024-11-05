
function [best_fun,prey_global,cuve_f]  =dhole(N,T,lb,ub,dim,fobj)
%% Define Parameters
cuve_f=zeros(1,T); 
X=initialization(N,dim,ub,lb); %Initialize population
global_Cov = zeros(1,T);
Best_fitness = inf;
% best_position = zeros(1,dim);
fitness_f = zeros(1,N);
for i=1:N
   fitness_f(i) =  fobj(X(i,:)); %Calculate the fitness value of the function
   if fitness_f(i)<Best_fitness
       Best_fitness = fitness_f(i);
       localBest_position = X(i,:);
   end
end


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
                Xnew(i,:) = X(i,:)+C*rand.*(prey-X(i,:)); %Eq.(6)
            else
            %% Encircling stage
                for j = 1:dim
                    z = round(rand*(N-1))+1;  %Eq.(9)
                    while (i==z)
                        z = round(rand*(N-1))+1;
                    end
                    Xnew(i,j) = X(i,j)-X(z,j)+prey(j);  %Eq.(8)
                end
            end
        else
            %% Hunting stage
%              explote=explote+1;
%             explotation(t)=explote;
            %D_prey=global_position; %Eq.(10)
            Q = 3*rand*fitness_f(i)/fobj(prey_local); %Eq.(10)
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
    localBest_fitness = fobj(localBest_position);%%local
 
    for i =1:N
         %% Obtain the optimal solution for the updated population
        local_fitness = fobj(Xnew(i,:));
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
 
%  figure (2);
% semilogy ( global_Cov,'Color','g',"LineWidth",2)
% title('Avarage fitness of all population')
% grid on;
% 
% figure (5); %% trajectory
% plot(T_particle,'Color','r',"LineWidth",2)
% title('Trajectory of the best solution')

% figure (6); %% exploration and exploitation persentage
%  semilogy(1:T,exploration*3.33,'DisplayName','exploration','Color','g','LineStyle','-','LineWidth',1);
% hold on
% semilogy(1:T,explotation*3.33,'DisplayName','exploitation','Color','r','LineStyle','-','LineWidth',1);
% legend('exploration','exploitation');
%  xlabel('Iteration');
%  ylabel('percentage');
end


function y = p_obj(x)   %Eq.(4)
% PMN=x;
% C1 = 1;
% mu = 25;
% k = 0.5;
% D=rand;
% y = ((C1 / (1 + exp(-k * (PMN- mu))))^2)* rand;
y = ((1 / (1 + exp(-0.5 * (x- 25))))^2)* rand;
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