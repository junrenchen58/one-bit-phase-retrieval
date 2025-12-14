function [error,errl,x,xhat] = GD_albe(n,m,alpha,beta,tau,etamode,T,seed)

% etamode == 0, fixed stepsize, 
% etamode == others means adaptive step size - this is not included here
% because we decided not to treat adaptive step size in the paper 
 
if seed >=0
    rng(seed);
end

%% data generation;

% We let x be signal with random norm in [alpha,beta]
x = randn(n,1); 
x = x/norm(x); 

r = alpha+rand(1,1)*(beta-alpha); % let the norm be uniformly distributed
x = x * r;
%% sensing process
A = randn(m,n);
y = sign(abs(A*x)- tau);
errl = zeros(T+1,1);

%% SI: direction

% We estimate the direction
yA = y .* A;
Sin = yA' * A / m;
[U,~,~] = svd(Sin);
xhat = U(:,1);

% We estimate the norm
yy = y>0;
yy = double(yy);
hatlambda = mean(yy);
lambda_SI = -tau / norminv(hatlambda/2);

% final SI
xhat = lambda_SI * xhat;

errl(1) = min(norm(xhat - x),norm(xhat+x));


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
    errl(i+1) = min(norm(xhat - x),norm(xhat+x));
end
error = errl(T+1);
end
