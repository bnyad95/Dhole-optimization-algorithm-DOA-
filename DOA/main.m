%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers
% To run dhole: [Best_score,Best_pos,DOA_cg_curve]=dhole(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

clear all 
clc
SearchAgents_no=30; % Number of search agents

Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=1000; % Maximum numbef of iterations
    
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[Best_score,Best_pos,DHOLE_cg_curve]=dhole(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    

Best_score

figure (1)
%Draw search space
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])
hold on,

%Draw objective space
figure (2)
semilogy(DHOLE_cg_curve,'Color','r')
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');

axis tight
grid on
box on
legend('DHOLEO')

display(['The best solution obtained by DHOLE is : ', num2str(Best_pos)]);
display(['The best optimal value of the objective funciton found by DHOLE is : ', num2str(Best_score)]);
