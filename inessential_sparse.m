%% This code shows 1-bit Spr outperforms 1-bit CS
rng(952)

n = 500;
act_k = 3;
k=4;
mlist = 1000:500:3000;

repe = 50;

alpha = 1;
beta = 1;
tau = 1;
etamode = 0; 
T = 150; % we use fixed step size with no projection, with 150 iterations
seed = -1; % we do not adjust seed due to repetition

errlist_pr =  zeros(size(mlist));
errlist_cs = zeros(size(mlist));
errlist_pr_1 =  zeros(size(mlist));
l = length(mlist);

%% 1bSPR
for i = 1:l
    m = mlist(i);
    errlist_pr(i) =  SPGD_albe_repe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed,repe);
end
figure;
linepr = plot(log(mlist),log(errlist_pr),'-ob','LineWidth',1.2);
hold on;
slopespr = (log(errlist_pr(1))-log(errlist_pr(end)))/(log(mlist(1))-log(mlist(end)))

%% 1bCS
for i = 1:l
    m = mlist(i);
    eta=sqrt(2*pi);
    errlist_cs(i) = onebcs_pgd_repe(n,m,act_k,k,eta,T,repe);
end
linelinear = plot(log(mlist),log(errlist_cs),'-sr','LineWidth',1.2);
slopecs = (log(errlist_cs(1))-log(errlist_cs(end)))/(log(mlist(1))-log(mlist(end)))


%% theoretical line for comparison
ytheory = log(errlist_pr(1)) -0.3-(log(mlist)-log(mlist(1)));
theoryline = plot(log(mlist),ytheory,'--k','LineWidth',0.8);

legend([linepr,linelinear,theoryline],{'1bSPR',...
    '1bCS','$\mathcal{O}(\frac{1}{m})$'},'Interpreter','latex','FontSize',12);
xlabel('$\log(m)$','Interpreter','latex','FontSize',12);
ylabel('$\log(\ell_2\textrm{-error})$','Interpreter','latex','FontSize',12);