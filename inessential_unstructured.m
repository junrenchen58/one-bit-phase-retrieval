%% This shows 1-bit pr outperforms 1-bit linear system
rng(100) 

n = 30;
mlist = 200:300:2100;
repe = 50;
alpha = 1; beta = 1; tau = 1; 
etamode = 0; T = 150; % we use fixed step size with no projection, with 150 iterations
seed = -1; % we do not adjust seed due to repetition

errlist_pl =  zeros(size(mlist));
errlist_linear = zeros(size(mlist));
l = length(mlist);

%% 1bPR
for i = 1:l
    m = mlist(i);
    errlist_pl(i) = GD_albe_repe(n,m,alpha,beta,tau,etamode,T,seed,repe);
end
figure;
linepr = plot(log(mlist),log(errlist_pl),'-ob','LineWidth',1.2);
hold on;
slopepr = (log(errlist_pl(1))-log(errlist_pl(end)))/(log(mlist(1))-log(mlist(end)))

%% 1blinearsystem
for i = 1:l
    m = mlist(i);
    errlist_linear(i) = onebitlinear_repe(n,m,repe);
end
linelinear = plot(log(mlist),log(errlist_linear),'-sr','LineWidth',1.2);
slopelinear = (log(errlist_linear(1))-log(errlist_linear(end)))/(log(mlist(1))-log(mlist(end)))


%% theoretical line for comparison
ytheory = -1.83 - (log(mlist)-log(mlist(1)));
theoryline = plot(log(mlist),ytheory,'--k','LineWidth',0.8);

legend([linepr,linelinear,theoryline],{'1bPR $(\eta_t=\sqrt{\frac{\pi e}{2}}\tau)$',...
    '1bLS','$\mathcal{O}(\frac{1}{m})$'},'Interpreter','latex','FontSize',12);
xlabel('$\log(m)$','Interpreter','latex','FontSize',12);
ylabel('$\log(\ell_2\textrm{-error})$','Interpreter','latex','FontSize',12);
