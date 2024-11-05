% This function calculates the value of objective function.
function PHI=benchmark_functions(x,Benchmark_Function_ID,dim)

% // Penalty Function Method has been used to deal with Constraints \\

if Benchmark_Function_ID==1 % Welded Beam Design (WBD)

P = 6000; % APPLIED TIP LOAD
E = 30e6; % YOUNGS MODULUS OF BEAM
G = 12e6; % SHEAR MODULUS OF BEAM
tem = 14; % LENGTH OF CANTILEVER PART OF BEAM
PCONST = 100000; % PENALTY FUNCTION CONSTANT
TAUMAX = 13600; % MAXIMUM ALLOWED SHEAR STRESS
SIGMAX = 30000; % MAXIMUM ALLOWED BENDING STRESS
DELTMAX = 0.25; % MAXIMUM ALLOWED TIP DEFLECTION
M =  P*(tem+x(2)/2); % BENDING MOMENT AT WELD POINT
R = sqrt((x(2)^2)/4+((x(1)+x(3))/2)^2); % SOME CONSTANT
J =  2*(sqrt(2)*x(1)*x(2)*((x(2)^2)/4+((x(1)+x(3))/2)^2)); % POLAR MOMENT OF INERTIA
PHI =  1.10471*x(1)^2*x(2)+0.04811*x(3)*x(4)*(14+x(2)); % OBJECTIVE FUNCTION
SIGMA = (6*P*tem)/(x(4)*x(3)^2); % BENDING STRESS
DELTA = (4*P*tem^3)/(E*x(3)^3*x(4)); % TIP DEFLECTION
PC = 4.013*E*sqrt((x(3)^2*x(4)^6)/36)*(1-x(3)*sqrt(E/(4*G))/(2*tem))/(tem^2); % BUCKLING LOAD
TAUP =  P/(sqrt(2)*x(1)*x(2)); % 1ST DERIVATIVE OF SHEAR STRESS
TAUPP = (M*R)/J; % 2ND DERIVATIVE OF SHEAR STRESS
TAU = sqrt(TAUP^2+2*TAUP*TAUPP*x(2)/(2*R)+TAUPP^2); % SHEAR STRESS
G1 = TAU-TAUMAX; % MAX SHEAR STRESS CONSTRAINT
G2 =  SIGMA-SIGMAX; % MAX BENDING STRESS CONSTRAINT
%G3 = L(1)-L(4); % WELD COVERAGE CONSTRAINT
G3=DELTA-DELTMAX;
G4=x(1)-x(4);
G5=P-PC;
G6=0.125-x(1); 
%G4 = 0.10471*L(1)^2+0.04811*L(3)*L(4)*(14+L(2))-5; % MAX COST CONSTRAINT
%G5 =  0.125-L(1); % MAX WELD THICKNESS CONSTRAINT
%G6 =  DELTA-DELTMAX; % MAX TIP DEFLECTION CONSTRAINT
%G7 =  P-PC; % BUCKLING LOAD CONSTRAINT
G7=1.10471*x(1)^2+0.04811*x(3)*x(4)*(14+x(2))-5;
PHI = PHI + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+...
    max(0,G6)^2+max(0,G7)^2); % PENALTY FUNCTION
end
%  disp(['H:' , num2str(x(1)), ' T:' , num2str( x(2)),' L:' , num2str(x(3)),' B:' , num2str(x(4))]);

%%
if Benchmark_Function_ID==2 % Compression Spring Design (CSD)
    
PCONST = 100; % PENALTY FUNCTION CONSTANT

fit=(x(3)+2)*x(2)*(x(1)^2);
G1=1-(x(2)^3*x(3))/(71785*x(1)^4);
G2=(4*x(2)^2-x(1)*x(2))/(12566*(x(2)*x(1)^3-x(1)^4))+1/(5108*x(1)^2);
G3=1-(140.45*x(1))/(x(2)^2*x(3));
G4=((x(1)+x(2))/1.5)-1;

PHI = fit + PCONST*(max(0,G1)^2++max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2); % PENALTY FUNCTION
end
%  disp(['d:' , num2str(x(1)), ' D:' , num2str( x(2)),' N:' , num2str(x(3))]);

%%
if Benchmark_Function_ID==3 % Pressure Vessel Design (PVD)

PCONST=10000;  % PENALTY FUNCTION CONSTANT
fit= 0.6224*x(1)*x(3)*x(4)+ 1.7781*x(2)*x(3)^2 + 3.1661 *x(1)^2*x(4) + 19.84 * x(1)^2*x(3);
G1= -x(1)+ 0.0193*x(3);
G2=  -x(3) + 0.00954* x(3);
G3=  -pi*x(3)^2*x(4)-(4/3)* pi*x(3)^3 +1296000;
G4= x(4) - 240;
PHI =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2); % PENALTY FUNCTION
end
% disp(['Ts:' , num2str(x(1)), ' Th:' , num2str( x(2)),' R:' , num2str(x(3)),' L:' , num2str(x(4))]);

%%

if Benchmark_Function_ID==4 %%StringDesign
y1=x(:,1);%W
y2=x(:,2);%d
y3=x(:,3);%N
%%% opt
fx=(y3+2).*y2.*y1.^2;
%%% const
g(:,1)=1-(y2.^3.*y3)./(71785.*y1.^4);
g(:,2)=(4.*y2.^2-y1.*y2)./...
    (12566.*(y2.*y1.^3-y1.^4))...
    +(1./(5108.*y1.^2))-1;
g(:,3)=1-(140.45.*y1./(y2.^2.*y3));
g(:,4)=(y1+y2)./1.5-1;
%%% Penalty
pp=10^9;
for i=1:size(g,1)
    for j=1:size(g,2)
        if g(i,j)>0
            penalty(i,j)=pp.*g(i,j);
        else
            penalty(i,j)=0;
        end
    end
end
PHI=fx+sum(penalty,2);
end

end