% this generates the geometric interpretation of 1-bit compressed sensing

figure;
theta = 0:0.01:2*pi+0.01;
circle = plot(sin(theta),cos(theta),'LineWidth',1.0,'Color','k');
xlim([-2,2]);ylim([-2,2]);
hold on;
xlist = -1.20:0.01:1.20;
line1 = plot(xlist,xlist,'LineWidth',1,'Color','b');
line2 = plot(xlist,-xlist,'LineWidth',1,'Color','r');

text(0.52,1.35,'$\mathcal{H}_{\mathbf{a}_1}:-x_1+x_2=0$','FontSize',9,'Color','b','Interpreter','latex');
text(0.6,-1.35,'$\mathcal{H}_{\mathbf{a}_2}:x_1+x_2=0$','FontSize',9,'Color','r','Interpreter','latex');

text(-0.97,0,'$+-$','Color','m','FontSize',10,'Interpreter','latex','FontWeight','bold');
text(0.74,0,'$-+$','Color','m','FontSize',10,'Interpreter','latex')
text(-0.13,-0.93,'$--$','Color','m','FontSize',10,'Interpreter','latex')
text(-0.15,0.90,'$++$','Color','m','FontSize',10,'Interpreter','latex')
axis equal
axis off
