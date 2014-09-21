% SQRTCOS Plot stream line, path line and streak line for 
%         Elements of Fluid Mechanics homework.
% 
%  For problem 6.2 figure 11
%
%  $Author: Zhou Lvwen, zhou.lv.wen@gmail.com$
%  $Date: 10/25/2011$    
%

theta = -pi+pi/100:pi/100:pi-pi/100;
for d = 2:20:200;
    r = d./(cos(theta/2).^2);
    h1=polar(theta(r<=200),r(r<=200),'b--');
    set(h1,'linewidth',2);
    hold on
end

theta = pi/100:pi/100:2*pi-pi/100;
for d = 2:20:200;
    r = d./(sin(theta/2).^2);
    h2=polar(theta(r<=200),r(r<=200),'r');
    set(h2,'linewidth',2);
end

h=legend([h1;h2],'$\varphi = K_1$','$\psi = K_2$')
set(h,'Interpreter','latex','fontsize',13)
