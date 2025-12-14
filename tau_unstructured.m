%% This shows the dependence on 1bPR on tau
rng(100) 

n = 30;
m = 1500;
repe = 50;
alpha = 1; beta = 1;  
taulist = 0.1:0.1:3; 
taulist = [0.01,0.05,taulist];
etamode = 0; T = 150; % we use fixed step size with no projection, with 150 iterations
seed = -1; % we do not adjust seed due to repetition

errlist_pl =  zeros(size(taulist)); 
l = length(taulist);

%% 1bPR under different tau
for i = 1:l
    tau = taulist(i);
    errlist_pl(i) = GD_albe_repe(n,m,alpha,beta,tau,etamode,T,seed,repe);
end
figure;
linepr = plot(taulist,errlist_pl,'-ob','LineWidth',1.2);
hold on;


legend(linepr ,{'1bPR: error v.s. $\tau$'},'Interpreter','latex','FontSize',12);
xlabel('$\tau$','Interpreter','latex','FontSize',12);
ylabel('$\ell_2\textrm{-error}$','Interpreter','latex','FontSize',12);
