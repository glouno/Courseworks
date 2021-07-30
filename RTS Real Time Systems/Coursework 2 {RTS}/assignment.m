clear all; close all; clc;
% Please do not change the template code before this line.

% Please complete the following with your details
firstname ='Paul';
surname   ='Beglin';
number    ='k1889054'; % this should be your 'k' number, e.g., 'k1234567'

% Please complete Question 1 here.
%{
    x1 = I(t)
    x2 = d/dt*I(t) = x1'
    x2' = d^2/dt^2*I(t) (= x1''), this has no coefficients in front 
(no R, L, C)
    u = dV/dt

In the Ac Bc matrices: column 0 is for x1 (no derivative), 1 for x2 (first
derivative) etc.

%}
L  = 20;                    % Inductance
c  = 0.1;                   % Capacitance
R  = 4;                     % Resistance
Ac = [0 1; -1/(L*c) -R/L];  % Continuous time A matrix, we use ';' to make a column
Bc = [0; 1/L];              % Continuous time B matrix, and this too


% Please complete Question 2 here.
%{
    To transform from continuous time to discrete time, we use the
    ss() function and then the c2d() function, to convert Ac and Bc into discrete time
    continuousSys = ss(Ac, Bc, [1 0], 0);
    discreteSys = c2d(continuousSys, dt);

%}

dt = 0.002;                 % Sampling rate. (2ms)
T  = 20;                    % Simulation duration. 20 seconds simulation
A  = [1 0.002; -0.0009998 0.9996];  % Discrete time A matrix.
B  = [9.999e-08; 9.998e-05];        % Discrete time B matrix.
u  = 1;                % Control input.
x  = [0; 0];                % Initial state.
S  = T/dt;                     % Number of simulation steps.
X  = zeros(2,S);            % Matrix for storing data

counter = 1;
axisX = 0:dt:T; %for graph
C = [1 0];
D = 0;


for s = 1:S
    x = A*x + B*u;
    X(:,s) = x;
end

% Please complete Question 3 here.
%{
    We know that Y(t) = C*x(t) + D*u(t)
    From the equation given and what we wrote in Question 1:

    Also, we can use ss2tf() to get the transfer function:
    [numerator, denominator] = ss2tf(A, B, [1 0], 0);
    And then use tf() to get the system
    tfSys = tf(numerator, denominator)
    Finally, we can find the poles
    z = pole(tfSys)
%}

C = [1 0]; % Observer ('C') matrix
H = [C; C*A]; % Observability matrix
z = [0.9998 + 0.0014i; 0.9998 - 0.0014i]; % Vector containing poles in order of increasing size.

% Please do not change the template code after this line.
save(['rlc_',number,'_',firstname,'_',surname]);
