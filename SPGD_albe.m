function [error,errl,x,xhat] = SPGD_albe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed)
% etamode == 0, fixed stepsize; 
% etamode == others means adaptive step size -- this is not included here
% as we decide not to treat adaptive step size in the paper
% We let act_k be the actual signal, k be the sparsity in the thresholding

if seed >= 0
    rng(seed);
end

%% data generation
x = randn(n,1); 
xx = randsample(n,n-act_k);
x(xx) = 0; % let support be uniformly distributed
x = x/norm(x); 

r = alpha+rand(1,1)*(beta-alpha); % let the norm be uniformly distributed
x = x * r;
%  Sensing process
A = randn(m,n);
y = sign(abs(A*x)- tau);
errl = zeros(T+1,1);


% We estimate the signal direction
yA = y .* A;
Sin = yA' * A / m;
D = diag(Sin);
[~,Supp] = maxk(D,k);
Sin_S = Sin(Supp,Supp); %% take a smaller matrix
[U,~,~] = svd(Sin_S);
xhat = zeros(n,1); 
xhat(Supp) = U(:,1);
xhat = xhat / norm(xhat,2); %%Spectral initial

% We estimate the signal norm
yy = y>0;
yy = double(yy);
hatlambda = mean(yy);
lambda_SI = -tau / norminv(hatlambda/2);

% final SI
xhat = lambda_SI * xhat;
errl(1) = min(norm(xhat - x),norm(xhat+x));

xhatt = zeros(n,1);
%% LOOP
for i = 1:T
    vec_m = (sign(abs(A*xhat)-tau)-y)/2;
    vec_m = vec_m .* sign(A*xhat);
    grad = mean(vec_m .* A)';
    if etamode == 0
        % fixed step size
        eta = sqrt(pi*exp(1)/2)*tau; 
        xhat = xhat - eta * grad;  
    end
    [~,suppx] = maxk(abs(xhat),k);  
    xhatt(suppx) = xhat(suppx); 
    xhat = xhatt;
    xhatt = zeros(n,1);  
    errl(i+1) = min(norm(xhat - x),norm(xhat+x));
end
error = errl(T+1);
end

