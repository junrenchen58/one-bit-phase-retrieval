% this generates the geometric interpretation of 1-bit phase retrieval

figure;
theta = 0:0.01:2*pi+0.01;
%% alpha = 1, beta = sqrt(2)
circle1 = plot(sin(theta),cos(theta),'LineWidth',1.0,'Color','k');
xlim([-3,3]);ylim([-3,3]);
hold on;
circle2 = plot(sqrt(2)*sin(theta),sqrt(2)*cos(theta),'LineWidth',1.0,'Color','k');


xlist = -2:0.01:0.74;
line1 = plot(xlist,xlist+1.224,'LineWidth',1,'Color','b');
xlist = -0.74:0.01:2;
line11 = plot(xlist,xlist-1.224,'LineWidth',1,'Color','b');
xlist = -0.74:0.01:2;
line2 = plot(xlist,-xlist+1.224,'LineWidth',1,'Color','r');
xlist = -2:0.01:0.74;
line22 = plot(xlist,-xlist-1.224,'LineWidth',1,'Color','r');



text(0.75,1.72,'$\mathcal{H}_{|\mathbf{a}_1|}:|-x_1+x_2|=\sqrt{\frac{3}{2}}$','FontSize',9,'Color','b','Interpreter','latex');
text(0.75,-1.9,'$\mathcal{H}_{|\mathbf{a}_2|}:|x_1+x_2|=\sqrt{\frac{3}{2}}$','FontSize',9,'Color','r','Interpreter','latex');

text(0.68,0.78,'$-+$','Color','m','FontSize',10,'Interpreter','latex','FontWeight','bold');
text(-0.98,-0.90,'$-+$','Color','m','FontSize',10,'Interpreter','latex')
text(-1.09,0.78,'$+-$','Color','m','FontSize',10,'Interpreter','latex')
text(0.6,-0.9,'$+-$','Color','m','FontSize',10,'Interpreter','latex')

text(-0.2,1.53,{'$++$','$~\downarrow$'},'Color','m','FontSize',10,'Interpreter','latex')
text(-0.2,0.83,{'$~\uparrow$','$--$'},'Color','m','FontSize',10,'Interpreter','latex')
text(-0.2,-0.89,{'$--$','$~\downarrow$'},'Color','m','FontSize',10,'Interpreter','latex')
text(-0.2,-1.58,{'$~\uparrow$','$++$'},'Color','m','FontSize',10,'Interpreter','latex')

text(-1.98,0,'$++\rightarrow$','Color','m','FontSize',10,'Interpreter','latex')
text(0.46,0,'$--\rightarrow$','Color','m','FontSize',10,'Interpreter','latex')
text(-1.1,0,'$\leftarrow--$','Color','m','FontSize',10,'Interpreter','latex')
text(1.33,0,'$\leftarrow++$','Color','m','FontSize',10,'Interpreter','latex')

axis equal
axis off
