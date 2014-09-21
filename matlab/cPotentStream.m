function cPotentStream(plotype)
%
% CPOTENTSTREAM plot contour lines of potential and streamfunction
%               for Elements of Fluid Mechanics homework. 
%
%  plotSimplyFluid('vortex');              % for problem 6.1 fig.09
%  plotSimplyFluid('source');              % for problem 6.1 fig.10
%  plotSimplyFluid('semi-infinite plate'); % for problem 6.2 fig.11
%  plotSimplyFluid('source & vortex');     % for problem 6.3 fig.12
%  plotSimplyFluid('doublet');             % for problem 6.8 fig.19
%
%  $Author: Zhou Lvwen, zhou.lv.wen@gmail.com$
%  $Date: 10/25/2011$    
%

if nargin==0; plotype = 'doublet'; end

switch plotype
    case 'vortex'
        [x,y,z,c]=simplyfluid('vortex', 100, 0,0);
        [C1,h1]=contour(x,y,z,[-40:4:40],'b');
        hold on
        [C2,h2]=contour(x,y,c,[-45:5:45],'r');
    case 'source'
        [x,y,z,c]=simplyfluid('source', 100, 0,0);
        [C1,h1]=contour(x,y,z,[-45:5:45],'b');
        hold on
        [C2,h2]=contour(x,y,c,[-40:4:40],'r');
    case 'semi-infinite plate'
        [x,y,z,c]=simplyfluid('semi-infinite plate', 100, 0,0);
        [C1,h1]=contour(x,y,z,[0:16:800],'b');
        hold on
        [C2,h2]=contour(x,y,c,[-400:16:400],'r');
    case 'source & vortex'
        [x,y,z1,c1]=simplyfluid('vortex', 100, 0,0);
        [x,y,z2,c2]=simplyfluid('source', 100, 0,0);
        [C1,h1]=contour(x,y,z1+z2,20,'b');
        hold on
        [C1,h2]=contour(x,y,c1+c2,20,'r');
    case 'doublet'
        level = [-500 -200 -100 -50 -30 -20:5:-5];
        level = [-level,0,level];
        [x,y,z,c]=simplyfluid('doublet', 100, 0,0);
        [C1,h1]=contour(x,y,z,level,'b');
        hold on
        [C1,h2]=contour(x,y,c,level,'r');
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
    case 'vortex'
        streamfun =-strense * log(r)/(2*pi);
        potentfun = strense * theta /(2*pi);
    case 'doublet'
        streamfun =-strense * sin(theta)./r;
        potentfun =-strense * cos(theta)./r;
    case 'semi-infinite plate'
        streamfun = strense * sqrt(r).*cos(theta/2);
        potentfun = strense * sqrt(r).*sin(theta/2);
end
