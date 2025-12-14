%% We show how the beta/alpha affects 1bPR.  
rng(100) 
n = 30;
mlist = 500:500:2500;
repe = 50;
etamode = 0; T = 150; % we use fixed step size with no projection, with 150 iterations
seed = -1; % we do not adjust seed due to repetition

errlist_pl =  zeros(size(mlist)); 
errlist_pl_norm = zeros(size(mlist));
errlist_pl_norm_2 = zeros(size(mlist));
errlist_pl_norm_3 = zeros(size(mlist));
errlist_pl_norm_4 = zeros(size(mlist));

l = length(mlist);

%% 1bPR
alpha = 1; beta = 1; tau = sqrt(alpha*beta); 
for i = 1:l
    m = mlist(i);
    errlist_pl(i) = GD_albe_repe(n,m,alpha,beta,tau,etamode,T,seed,repe);
end
figure;
linepr = plot(log(mlist),log(errlist_pl),'-or','LineWidth',1);
hold on;
 
%% 1bprwithnorm
alpha = 1; beta = 3; tau = sqrt(alpha*beta);
for i = 1:l
    m = mlist(i);
    errlist_pl_norm(i) = GD_albe_repe(n,m,alpha,beta,tau,etamode,T,seed,repe);
end
linepr_norm1  = plot(log(mlist),log(errlist_pl_norm),'-sb','LineWidth',1);
 
%% 1bprwithnorm2
alpha = 1; beta = 6; tau = sqrt(alpha*beta);
for i = 1:l
    m = mlist(i);
    errlist_pl_norm_2(i) = GD_albe_repe(n,m,alpha,beta,tau,etamode,T,seed,repe);
end
linepr_norm2 = plot(log(mlist),log(errlist_pl_norm_2),'-hg','LineWidth',1);
 
%% 1bprwithnorm3
alpha = 1; beta = 10;  tau = sqrt(alpha*beta);
for i = 1:l
    m = mlist(i);
    errlist_pl_norm_3(i) = GD_albe_repe(n,m,alpha,beta,tau,etamode,T,seed,repe);
end
linepr_norm3 = plot(log(mlist),log(errlist_pl_norm_3),'->c','LineWidth',1);
 
%% 1bprwithnorm4
alpha = 1; beta = 15;  tau = sqrt(alpha*beta);
for i = 1:l
    m = mlist(i);
    errlist_pl_norm_4(i) = GD_albe_repe(n,m,alpha,beta,tau,etamode,T,seed,repe);
end
linepr_norm4 = plot(log(mlist),log(errlist_pl_norm_4),'-^k','LineWidth',1);
 
 