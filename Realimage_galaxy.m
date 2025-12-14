%% Implementation of the 1-bit phase retrieval on "galaxy"

% The code below builds on top of the implementation of the Wirtinger Flow algorithm designed and implemented by E. Candes, X. Li, and M. Soltanolkotabi
clear all;
%% Set Parameters
if exist('Params')                == 0,  Params.L           = 64;   end
if isfield(Params, 'L')           == 0,  Params.tau         = 0;   end             % number of measurements

if isfield(Params, 'mu')          == 0,  Params.mu          = 0;  end		% step size / learning parameter
if isfield(Params, 'npower_iter') == 0,  Params.npower_iter = 50;   end		% number of power iterations
if isfield(Params, 'iter') == 0,  Params.iter = 100;   end

%%  Read Image 

% Below X is n1 x n2 x 3; i.e. we have three n1 x n2 images, one for each of the 3 color channels  
namestr = 'galaxy' ;
stanstr = 'jpg'      ;
X       = mat2gray(imread([namestr,'.',stanstr])) ;
figure; imshow(X,[]);
n1      = size(X,1)                               ;
n2      = size(X,2)                               ;
Params.tau = 1/3*(norm(X(:,:,1))+norm(X(:,:,2))+norm(X(:,:,3)));
Params.mu =  sqrt(pi * exp(1) * 2) * Params.tau;
 

%% Make masks and linear sampling operators  

% Each mask has iid entries following the octanary pattern in which the entries are 
% distributed as uniform over {1, -1, i, -i} (phase) 

randn('state',2024);
rand ('state',2024);

L = Params.L;                  % Number of masks  
Masks = zeros(n1,n2,L);        % Storage for L masks, each of dim n1 x n2
m = n1* n2* L;

% Sample phases: each symbol in alphabet {1, -1, i , -i} has equal prob. 
for ll = 1:L, Masks(:,:,ll) = randsrc(n1,n2,[1i -1i 1 -1]); end

% Make linear operators; 
A = @(I)  fft2(conj(Masks) .* reshape(repmat(I,[1 L]), size(I,1), size(I,2), L));  % Input is n1 x n2 image, output is n1 x n2 x L array
At = @(Y) sum(Masks .* ifft2(Y), 3)* size(Y,1) * size(Y,2);                       % Input is n1 x n2 x L array, output is n1 x n2 image
%(be careful about the scaling at At --- the relation between ifft and conj transpose)

%% Prepare structure to save intermediate results 

ttimes   = [10:10:Params.iter];        % Iterations at which we will save info 
ntimes   = length(ttimes)+1;           % +1 because we will save info after the initialization 
Xhats    = cell(1,ntimes);
for mm = 1:ntimes, Xhats{mm} = zeros(size(X));  end
Times    = zeros(3,ntimes);

%% SI-1bPR + GD-1bPR  

T = max(ttimes);                           % Max number of iterations
 
for rgb = 1:3, 
    fprintf('Color band %d\n', rgb)
    x = squeeze(X(:,:,rgb));               % Image x is n1 x n2 
    Y = sign(abs(A(x))-Params.tau);        % Measured data 
    
    %% Initialization
    % Estimate norm to scale eigenvector 
    YY = Y>0;
    YY = double(YY);
    hatlambda = sum(YY(:))/numel(YY);   
    normest =  -Params.tau / norminv(hatlambda/2);

    % Initial direction guess 
    z0 = randn(n1,n2); z0 = z0/norm(z0,'fro');  
    tic
    % Truncated power iterations
    for tt = 1: Params.npower_iter, 
        z0 = At(Y.*A(z0)); z0 = z0/norm(z0,'fro');
    end
    Times(rgb,1) = toc;

    z = normest * z0;                                    % Apply scaling 
    Xhats{1}(:,:,rgb) = exp(-1i*angle(trace(x'*z))) * z; % Initial guess after global phase adjustment 
 
    % Loop    
    fprintf('Done with initialization, starting loop\n')
    tic
    for t = 1:T,
        Bz = A(z);
        absBz = abs(Bz);
        Yz = sign(absBz-Params.tau);
        factor = (Yz - Y).* sign(Bz);  
        grad = At(factor) / (4*numel(factor));   
        z    = z - Params.mu * grad;   
        
        ind =  find(t == ttimes);             
        if ~isempty(ind), 
             Xhats{ind+1}(:,:,rgb) = exp(-1i*angle(trace(x'*z))) * z; 
             Times(rgb,ind+1) = toc;
        end       
    end    
end
fprintf('All done!\n')

%% Show results 

iter = [0 ttimes];
Relerrs = zeros(1,ntimes);
for mm = 1:ntimes; 
    fprintf('Mean running times after %d iterations: %.1f\n', iter(mm), mean(Times(:,mm)))
    Relerrs(mm) = norm(Xhats{mm}(:)-X(:))/norm(X(:)); 
    fprintf('Relative error after %d iterations: %f\n', iter(mm), Relerrs(mm))  
    fprintf('\n')
end


figure; imshow(mat2gray(abs(Xhats{1})),[]);
figure; imshow(mat2gray(abs(Xhats{ntimes})),[]);

load chirp
sound(y,Fs)