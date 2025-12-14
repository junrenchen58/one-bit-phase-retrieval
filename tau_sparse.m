%% This code shows the impact of tau on 1-bit sparse PR
rng(952)

n = 500;
act_k = 3;
k=4; % we consider the setting where the actual sparsity is unknown
m = 1500;

repe = 50;

alpha = 1;
beta = 1;
taulist = 0.1:0.1:3; 
taulist = [0.01,0.05,taulist];
etamode = 0; 
T = 150; % we use fixed step size with no projection, with 150 iterations
seed = -1; % we do not adjust seed due to repetition

errlist_pr =  zeros(size(taulist)); 
l = length(taulist);

%% 1bSPR
for i = 1:l
    tau = taulist(i);
    errlist_pr(i) =  SPGD_albe_repe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed,repe);
end
figure;
linepr = plot(taulist, errlist_pr,'-ob','LineWidth',1.2);
hold on;
 
 

legend(linepr ,{'1bSPR: error v.s. $\tau$'},'Interpreter','latex','FontSize',12);
xlabel('$\tau$','Interpreter','latex','FontSize',12);
ylabel('$\ell_2\textrm{-error}$','Interpreter','latex','FontSize',12);
