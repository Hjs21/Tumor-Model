function TUMOR_MAIN_2
clear all
%TUMOR_MAIN_1: Main program for tumor model
%TUMOR_ODE defines the ODEs for tumor model

% Input Parameters
s = 0.33;       % Influx of Immune cells when tumor cells present
d1 = 0.2;       % Death rate of immune cells in the absence of tumors
d2 = 1.0;       % Death rate of the drug
r1 = 1.5;       % Growth rate associated with tumor cells
r2 = 1.0;       % Growth rate associated with normal cells
b1 = 1.0;       % Reciprocol carrying capacities for tumor cells
b2 = 1.0;       % Reciprocol carrying capacities for normal cells
c1 = 1.0;       % Competitive coefficient between tumor on immune cells
c2 = 0.5;       % Competitive coefficient between immune on tumor cells
c3 = 1.0;       % Competitive coefficient between normal on tumor cells
c4 = 1.0;       % Competitive coefficient between tumor on normal cells
alpha = 0.3;    % Immune threshold rate
ro = 0.01;      % Immune response rate 
a1 = 0.2;       % cell kill rate for drugs on immune cells
a2 = 0.3;       % cell kill rate for drugs on tumor cells
a3 = 0.1;       % cell kill rate for drugs on normal cells
v = 0;          % amount of drug dose v(t)

% Initial Conditions
N10 = 1;            % Initial normal cell population
N20 = 0.25;         % Initial tumor cell population
N30 = 0.10;         % Initial immune cell population for 10% healthy person
N40 = 0;            % Initial drug concentration
tend = 100;         % Simulation length (time)

N0 = [N10 N20 N30 N40];

[t, N] = ode45('TUMOR_ODE2',[0 tend], N0,[],s,d1,d2,r1,r2,b1,b2,c1,c2,c3,c4,a1,a2,a3,alpha,ro,v);


% Plots the normal cell population over time t
subplot(3,1,1)
plot(t,N(:,1));
    xlabel('time')
    ylabel('normal cells')

% Plots the tumor cell population over time t
subplot(3,1,2)
plot(t,N(:,2));
    xlabel('time')
    ylabel('tumor cells')

% Plots the immune cell population over time t
subplot(3,1,3)
plot(t,N(:,3));
    xlabel('time')
    ylabel('immune cells')

figure

% Plots for Nullclines

subplot(2,1,1)
%T=N(:,2);
T = linspace(0,1,20);
%I=N(:,3);
I= linspace(0,1,20);
N= linspace(0,1,20);
Xnull= (r2-c4.*T)./(r2.*b2);%nullcline of N
Tnull= (r1-c2.*I-c3.*N)./(r1.*b1); %nullcline of T
Inull= (s.*alpha+s.*T)/((c1.*T+d1).*(alpha+T)-(ro.*T)); %nullcline of I


plot(T,Xnull,'b') %plot ofnd tumor cells on axes
hold on
plot(T,Tnull,'r')
hold off
xlim([.44 .55]); ylim([0 1]); xlabel('Tumor Cell Population'), ylabel('Normal Cell Population')
legend('Xnull', 'Tnull')
hold off

%plot of immune and tumor cell nullclines
subplot(2,1,2)
plot(I,Tnull,'b') %plot ofnd tumor cells on axes
hold on
plot(I,Inull,'r')
hold off
xlim([.44 .55]); ylim([0 1]); xlabel('Immune Cell Population'), ylabel('Tumor Cell Population')
legend('Inull', 'Tnull')

