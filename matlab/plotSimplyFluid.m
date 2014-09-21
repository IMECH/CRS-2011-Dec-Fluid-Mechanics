function plotSimplyFluid(plotype)
%
% PLOTSIMPLYFLUID plot field of vortex and source for Elements
%                 of Fluid Mechanics homework. 
%
%  plotSimplyFluid('vortex');          % for problem 6.1 figure  9
%  plotSimplyFluid('source');          % for problem 6.1 figure 10
%  plotSimplyFluid('vortex & source'); % for problem 6.3 figure 12
%  plotSimplyFluid('vortex & vortex'); % for problem 6.8 figure 19
%
%  $Author: Zhou Lvwen, zhou.lv.wen@gmail.com$
%  $Date: 10/25/2011$    
%

if nargin==0; plotype = 'vortex & vortex'; end

switch plotype
    case 'vortex'
        [x,y,z1,c1]=simplyfluid('vortex', 100, 0,0);
        [C,h1]=contour(x,y,z1,[-40:4:40],'b');
        hold on
        [C,h2]=contour(x,y,c1,[-45:5:45],'r');
    case 'source'
        [x,y,z1,c1]=simplyfluid('source', 100, 0,0);
        [C,h1]=contour(x,y,z1,[-45:5:45],'b');
        hold on
        [C,h2]=contour(x,y,c1,[-40:4:40],'r');
    case 'vortex & source'
        [x,y,z1,c1]=simplyfluid('vortex', 100, 0,0);
        [x,y,z2,c2]=simplyfluid('source', 100, 0,0);
        [C,h1]=contour(x,y,z1+z2,20,'b');
        hold on
        [C,h2]=contour(x,y,c1+c2,20,'r');
    case 'vortex & vortex'
        level = [1:2:6 7:3:13  20:10:45];
        level = [-level,0,level];
        [x,y,z1,c1]=simplyfluid('vortex', 100, 1,0);
        [x,y,z2,c2]=simplyfluid('vortex',-100,-1,0);
        [C,h1]=contour(x,y,z1+z2,level,'b');
        hold on
        [C,h2]=contour(x,y,c1+c2,level,'r');
end

h=legend([h2,h1],'$\varphi = K_1$','$\psi = K_2$');
set(h,'Interpreter','latex','fontsize',13)
xlabel('x'); ylabel('y'); axis image;

% ---------------------------------------------------------------------

function [x,y,streamfun,potentfun]=simplyfluid(ftype,strense,x0,y0)
%
% reference: http://ilovematlab.cn/thread-11431-1-1.html
%
nx=200; ny=200;
xmin=-5;xmax=5;
ymin=-5;ymax=5;
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));
radius=inline('sqrt((x-x0).^2+(y-y0).^2)','x','y','x0','y0');
r=radius(x,y,x0,y0);
theta=atan2(y-y0,x-x0);
switch ftype
    case 'uniform'
        streamfun = strense * y;
        potentfun =-strense * x;
    case 'source'
        streamfun = strense * theta /(2*pi);
        potentfun = strense * log(r)/(2*pi);
    case 'doublet'
        streamfun =-strense * sin(theta)./r;
        potentfun =-strense * cos(theta)./r;
    case 'vortex'
        streamfun =-strense * log(r)/(2*pi);
        potentfun = strense * theta /(2*pi);
end
