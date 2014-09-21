%  STREAMPATHSTREAK Plot stream line, path line and streak line for 
%                   Elements of Fluid Mechanics homework. 
%
%  For problem 2.3 figure 8: u = x(1+2t), v = y, w = 0
%
%  $Author: Zhou Lvwen, zhou.lv.wen@gmail.com$
%  $Date: 10/10/2011$    

y = 0.01:0.02:4;
Xstream = inline('y');
Xstreak = inline('exp((1+2*t)*log(y)+log(y).^2)','t','y');

% stream line 
xstream = Xstream(y);
plot(xstream, y,'k- ','linewidth',2)
hold on

% Path Line / Streak Line(t = 0)
xpath = Xstreak(0,y);
plot(xpath,   y,'k--','linewidth',2)

% Streak Line(t = 0.5)
xstreak2 = Xstreak(0.5,y);
plot(xstreak2,y,'k-.','linewidth',2)

% Streak Line(t = 1.0)
xstreak3 = Xstreak(1,y);
plot(xstreak3,y,'k: ','linewidth',2)

legend('Stream Line','Path Line / Streak Line(t = 0)',...
       'Streak Line(t = 0.5)','Streak Line(t = 1)',2)
axis image; grid on
axis([0,5,0,3.7])
set(gca,'xtick',0:5,'ytick',0:3)
xlabel('x','fontsize',13)
ylabel('y','fontsize',13)


