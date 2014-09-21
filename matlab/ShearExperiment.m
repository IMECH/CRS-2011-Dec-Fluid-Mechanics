function [F, V] = ShearExperiment(H,U)
%
%SHEAREXPERIMENT Simulation of shear experiment for Elements of Fluid 
%                Mechanics homework. 
%
%  For problem 1.1 figure 3 and figure 4
%
%  The simple shear experiment the fluid is confined between two large
%  parallel plates of area A,in order to ignore edge effects,separated
%  by a distance H. At a certain time, a force, F, is exerted on the 
%  upper plate so that it moves relative to the other with a constant 
%  velocity,V. This function produces two figure by simulate the shear 
%  experiment process. The first figure is about F and time, and anthor
%  is about velocity(function of y) and y.
%
%             --------> F
%  ======================================  ---> U 
%  /|\ ______|____/______________________
%   |  ______|___/_______________________ dh
%  H|        |  /    ...                 
%   |        | /
%  \|/ ______|/__________________________
%  ======================================
% 
%  $Author: Zhou Lvwen, zhou.lv.wen@gmail.com$
%  $Date: 09/15/2011$             

if nargin == 0
    H = 0.05;            % distance between parallel plates (m)
    U = 1;               % velocity of the upper plate (m/s)
end

n = 100;                 % number of layers 
dh = H/n;                % hight of one layer
A = 1;                   % area of each layer (m^2)
rho = 1000;              % density of wather (kg/m^3)
m =  rho * (A * dh);     % mass of one layer
v(n) = U;                % initialize velocity of each layer
dt = 0.02;               % simulation time step (s)

mu = 17500e-7;           % viscosity of water (kg/(ms))
F = []; V = [];
t = 0:dt:1000;           % time from 0s to 1000s 
for i = t
    f = mu*diff(v)/dh*A; % viscosity force between each layer
    a = diff(f)/m;       % acceleration of each layer
    v(2:end-1) = v(2:end-1) + a*dt; % update the velocity
    F = [F;f(end)];      % trace the force
    if sum(i == [50, 100, 200, 500, 1000]);
       V = [V;v];        % trace the velocity
    end
end

% show the results
subplot(1,2,1)
plot(t,F,'k',[-2,1000],[min(F),min(F)],'b:','linewidth',2)
axis([-2,1000,-0.005,0.5])
set(gca,'ytick',[min(F),0.1:0.1:0.5])
xlabel('Time(s)');ylabel('Force(N)')

subplot(1,2,2)
linestyle = {'k.','k:','k-.','k--','k-'};
for i = 1:size(V,1)
    plot([1:n]*dh,V(i,:),linestyle{i},'linewidth',2); hold on
end
legend('t=50s','t=100s','t=200s','t=500s','t=1000s',0)
xlabel('H(m)');ylabel('Velocity(m/s)')
