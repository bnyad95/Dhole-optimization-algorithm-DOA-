
% This function gives boundaries and dimension of search space for test functions.

function [down,up,dim]=benchmark_functions_details(Benchmark_Function_ID)

if Benchmark_Function_ID==1     % Welded Beam Design (WBD)
    down=[0.10;0.10;0.10;0.10]; % Lower Bound of Variables
    up=[2;10;10;2];             % Upper Bound of Variables
    dim=4;
end
if Benchmark_Function_ID==2  % Compression Spring Design (CSD)
    down=[0.05;0.25;2.00];   % Lower Bound of Variables
    up=[2.00;1.30;15.0];     % Upper Bound of Variables
    dim=3;

end
if Benchmark_Function_ID==3 % Pressure Vessel Design (PVD)
down=[0;0;10;10];           % Lower Bound of Variables
up= [99;99;200;200];        % Upper Bound of Variables
dim=4;
end

if Benchmark_Function_ID==4 % StringDesign
dim=3;
down=[0.05; 0.25; 2];
up=[2; 1.3; 15];
end

end









