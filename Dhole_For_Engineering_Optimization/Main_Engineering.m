
clear
close all
clc
%%
N = 30;                              % Number of Searcher Agents "
Max_Iteration  = 100;                % Maximum number of "iterations"
Q=1;            % ACO Parameter
tau0=10;        % Initial Phromone             (ACO)
alpha=0.3;      % Phromone Exponential Weight  (ACO)
rho=0.1;        % Evaporation Rate             (ACO)
 ElitistCheck=1; % GSA Parameter
 Rpower=1;       % GSA Parameter
 min_flag=1; % 1: minimization, 0: maximization (GSA)
%%

Benchmark_Function_ID=1 %Benchmark function ID

RunNo  = 30; 
    
for k = [ 1 : 1 : RunNo ]   
% % %   
[gBestScore,gBest,GlobalBestCost]= CPSOGSA(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions1(k) = gBestScore;

[Fbest,Lbest,BestChart]=GSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower);
BestSolutions2(k) = Fbest;

[PcgCurve,GBEST]=pso(Benchmark_Function_ID,N,Max_Iteration);
 BestSolutions3(k) = GBEST.Cost;

[BestCost,BestSol] = bbo( Benchmark_Function_ID, N, Max_Iteration);
 BestSolutions4(k) = BestSol.Cost;

[BestSolDE,BestCostDE] = DE(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions5(k) = BestSolDE.Cost ;

[BestSolACO,BestAnt,BestCostACO] = ACO(Benchmark_Function_ID, N, Max_Iteration,Q,tau0,alpha,rho);
BestSolutions6(k) = BestSolACO.Cost ;

[Best_score,Best_pos,SSA_cg_curve]=SSA(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions7(k) = Best_score ;

[Best_scoreSCA,Best_pos,SCA_cg_curve]=SCA(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions8(k) = Best_scoreSCA ;

[Best_scoreDhole,Best_pos,Dhole_cg_curve]=dhole(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions11(k) = Best_scoreDhole ;

%    
     disp(['Run # ' , num2str(k), ' gBestScore:  ' , num2str( gBestScore)]);
     disp(['Run # ' , num2str(k), ' Fbest:  ' , num2str( Fbest)]);
     disp(['Run # ' , num2str(k), ' GBEST.Cost: ' , num2str( GBEST.Cost)]);
     disp(['Run # ' , num2str(k), ' BestSol.Cost:  ' , num2str( BestSol.Cost)]);
     disp(['Run # ' , num2str(k), ' BestSolDE.Cost :  ' , num2str( BestSolDE.Cost)]);
     disp(['Run # ' , num2str(k), ' BestSolACO.Cost:  ' , num2str( BestSolACO.Cost )]);
     disp(['Run # ' , num2str(k), ' Best_score :  ' , num2str( Best_score)]);
     disp(['Run # ' , num2str(k), ' Best_scoreSCA :  ' , num2str( Best_scoreSCA)]);
     disp(['Run # ' , num2str(k), ' Best_scoreDhole :  ' , num2str( Best_scoreDhole)]);      
end


    D_Average= mean(BestSolutions1);
    D_StandDP=std(BestSolutions1);
    D_Med = median(BestSolutions1); 
    [D_BestValueP D_I] = min(BestSolutions1);
    [D_WorstValueP D_IM]=max(BestSolutions1);
    aCPSOGSA=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]
    
    D_Average= mean(BestSolutions2);
    D_StandDP=std(BestSolutions2);
    D_Med = median(BestSolutions2); 
    [D_BestValueP D_I] = min(BestSolutions2);
    [D_WorstValueP D_IM]=max(BestSolutions2);
    aGSA=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]
    

    D_Average= mean(BestSolutions3);
    D_StandDP=std(BestSolutions3);
    D_Med = median(BestSolutions3); 
    [D_BestValueP D_I] = min(BestSolutions3);
    [D_WorstValueP D_IM]=max(BestSolutions3);
    apso=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]

    D_Average= mean(BestSolutions4);
    D_StandDP=std(BestSolutions4);
    D_Med = median(BestSolutions4); 
    [D_BestValueP D_I] = min(BestSolutions4);
    [D_WorstValueP D_IM]=max(BestSolutions4);
    abbo=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]

    D_Average= mean(BestSolutions5);
    D_StandDP=std(BestSolutions5);
    D_Med = median(BestSolutions5); 
    [D_BestValueP D_I] = min(BestSolutions5);
    [D_WorstValueP D_IM]=max(BestSolutions5);
    aDE=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]

    D_Average= mean(BestSolutions6);
    D_StandDP=std(BestSolutions6);
    D_Med = median(BestSolutions6); 
    [D_BestValueP D_I] = min(BestSolutions6);
    [D_WorstValueP D_IM]=max(BestSolutions6);
    aACO=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]

    D_Average= mean(BestSolutions7);
    D_StandDP=std(BestSolutions7);
    D_Med = median(BestSolutions7); 
    [D_BestValueP D_I] = min(BestSolutions7);
    [D_WorstValueP D_IM]=max(BestSolutions7);
    aSSA=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]
    
    D_Average= mean(BestSolutions8);
    D_StandDP=std(BestSolutions8);
    D_Med = median(BestSolutions8); 
    [D_BestValueP D_I] = min(BestSolutions8);
    [D_WorstValueP D_IM]=max(BestSolutions8);
    aSCA=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]

    %%%%%%% Dhole %%%%%%%%%%%%%%
    D_Average= mean(BestSolutions11);
    D_StandDP=std(BestSolutions11);
    D_Med = median(BestSolutions11); 
    [D_BestValueP D_I] = min(BestSolutions11);
    [D_WorstValueP D_IM]=max(BestSolutions11);
    aDOA=[D_Average,D_StandDP,D_Med, D_BestValueP, D_WorstValueP]

    
    
    figure
    
   semilogy(1:Max_Iteration,GlobalBestCost,'DisplayName','CPSOGSA', 'Color', [0.0, 0.5, 0.5],'LineStyle','--','LineWidth',2);
   hold on
   semilogy(1:Max_Iteration,BestChart,'DisplayName','GSA','Color','g','LineStyle','--','LineWidth',2);
   semilogy(1:Max_Iteration,PcgCurve,'DisplayName','PSO','Color','c','LineStyle','--','LineWidth',2);
   semilogy(1:Max_Iteration,BestCost,'DisplayName','BBO','Color','b','LineStyle','--','LineWidth',2);
   semilogy(1:Max_Iteration,BestCostDE,'DisplayName','DE','Color',[0.5, 0.0, 0.1],'LineStyle','--','LineWidth',2);
   semilogy(1:Max_Iteration,BestCostACO,'DisplayName','ACO','Color','m','LineStyle','--','LineWidth',2);
   semilogy(1:Max_Iteration,SSA_cg_curve,'DisplayName','SSA','Color','black','LineStyle','--','LineWidth',2);
   semilogy(1:Max_Iteration,SCA_cg_curve,'DisplayName','SCA','Color','y','LineStyle','--','LineWidth',2);
   semilogy(1:Max_Iteration,Dhole_cg_curve,'DisplayName','Dhole','Color','r','Marker','diamond','LineStyle','--','LineWidth',2,...
   'MarkerEdgeColor','r','MarkerFaceColor',[.39 1 .53],'MarkerSize',2);

    

title ('\fontsize{15}\bf Welded Beam Design');
% title ('\fontsize{15}\bf Compression Spring Design');
% title ('\fontsize{15}\bf Pressure Vessel Design');
 title ('\fontsize{15}\bf StringDesign');
 xlabel('\fontsize{15}\bf Iteration');
 ylabel('\fontsize{15}\bf Fitness(Best-so-far)');

 

legend('\fontsize{12}\bf CPSOGSA','\fontsize{12}\bf GSA','\fontsize{12}\bf PSO','\fontsize{12}\bf BBO',...
    '\fontsize{12}\bf DE','\fontsize{12}\bf ACO','\fontsize{12}\bf SSA','\fontsize{12}\bf SCA','\fontsize{12}\bf Dhole');
    