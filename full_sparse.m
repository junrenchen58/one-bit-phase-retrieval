%%  We show how the beta/alpha affects 1bSPR.  
rng(573) 
act_k =3;
k=4;
n = 500; 
mlist = 1000:500:3000; 
 
repe = 50;

alpha = 1;
beta = 1;
tau = 1;
etamode = 0; T = 150; % we use fixed step size with no projection, with 150 iterations
seed = -1; % we do not adjust seed due to repetition

errlist_pr =  zeros(size(mlist));
errlist_pr_1 =  zeros(size(mlist));
errlist_pr_2 =  zeros(size(mlist));
errlist_pr_3 =  zeros(size(mlist));
errlist_pr_4 =  zeros(size(mlist));

l = length(mlist);

%% 1bSPR
for i = 1:l
    m = mlist(i);
    errlist_pr(i) =  SPGD_albe_repe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed,repe);
end
figure;
linepr = plot(log(mlist),log(errlist_pr),'-or','LineWidth',1);
hold on;
 
%% 1bSPR
alpha = 1; beta = 1.2;tau = sqrt(alpha*beta);
for i = 1:l
    m = mlist(i);
    errlist_pr_1(i) =  SPGD_albe_repe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed,repe);
end
linepr1 = plot(log(mlist),log(errlist_pr_1),'-sb','LineWidth',1);
hold on;
slopespr1 = (log(errlist_pr_1(1))-log(errlist_pr_1(end)))/(log(mlist(1))-log(mlist(end)))

%% 1bSPR
alpha = 1; beta = 1.5;tau = sqrt(alpha*beta);
for i = 1:l
    m = mlist(i);
    errlist_pr_2(i) =  SPGD_albe_repe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed,repe);
end
linepr2 = plot(log(mlist),log(errlist_pr_2),'-hg','LineWidth',1);
hold on;
 

%% 1bSPR
alpha = 1; beta = 2.5;tau = sqrt(alpha*beta);
for i = 1:l
    m = mlist(i);
    errlist_pr_3(i) =  SPGD_albe_repe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed,repe);
end
linepr3 = plot(log(mlist),log(errlist_pr_3),'->c','LineWidth',1);
hold on;
  
%% 1bSPR
alpha = 1; beta = 3.5;tau = sqrt(alpha*beta);
for i = 1:l
    m = mlist(i);
    errlist_pr_4(i) =  SPGD_albe_repe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed,repe);
end
linepr4 = plot(log(mlist),log(errlist_pr_4),'-^k','LineWidth',1);
hold on;
  
xlabel('$\log(m)$','Interpreter','latex','FontSize',12);
ylabel('$\log(\ell_2\textrm{-error})$','Interpreter','latex','FontSize',12);