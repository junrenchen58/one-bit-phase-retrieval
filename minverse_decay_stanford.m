%% The results here are recorded by running 'Realimage_StanfordQuad' with different L's

timeslist = 1:8;
Llist = 32 * timeslist;
SIerrlist = zeros(size(Llist));
GDerrlist = zeros(size(Llist));
SIerrlist(1) = 0.06;
GDerrlist(1) = 0.073;
SIerrlist(2) = 0.816;
GDerrlist(2) = 0.037;
GDerrlist(3) = 0.025;
GDerrlist(4) = 0.0183;
GDerrlist(5) = 0.0146;
GDerrlist(6) = 0.0122;
GDerrlist(7) = 0.0104;
GDerrlist(8) = 0.0091;
figure;
lineexp = plot(log(Llist),log(GDerrlist),'-|r','LineWidth',2);
hold on;
line1 = plot(log(Llist),log(0.06) - (log(Llist)-log(Llist(1))),'--k','LineWidth',1);
xlabel('$\log(L)$','Interpreter','latex','FontSize',12);
ylabel('$\log(\textrm{rela. error})$','Interpreter','latex','FontSize',12);
legend([lineexp,line1],{'Relative Error','$\mathcal{O}(\frac{1}{m})$'},'Interpreter','latex','FontSize',12)