% Add sections headings with %%
% Add PARAM cases for function
% Vectorize for two intervals (a,b)
% minor change 
clear; close all; clc; 
rng('default');
t_start = 0;                    % start time 
t_end = 4;                      % end time
N = 500;                        % number of time instances
t = linspace(t_start,t_end,N);  % time (s)

% Problem 3
% Generating Z(t) (AWGN)
realizations = 100;             % number of realizations
figure(1)
for ii = 1:realizations
    mu = [0];
    stdev = [2*pi]; 
    Zt(ii,:) = mu + stdev.*randn(1,length(t)); 
    % Only plot first 5 realizations 
    if ii < 6
        plot3(t,ii*ones(1,length(t)),Zt(ii,:),'LineWidth',2); hold on;
    end
end

wt = Zt; 

% Problem 3 (cont)
% Generating X(t) (cosine + AWGN)
A = 5; 
a = [0]; 
b = [2*pi];
figure(2)
Xt = zeros(realizations,N);    % preallocate
for ii = 1:realizations
    theta = a + (b-a).*rand(1,1); 
    Xt(ii,:) = A*(cos(pi.*t + theta*ones(1,length(t)))).^2+wt(ii,:); 
    if ii < 6
        plot3(t,ii*ones(1,length(t)),Xt(ii,:),'LineWidth',2); hold on; 
    end
end
grid on; 

% Problem 4
% Compute mean of RP X(t)
sim_rpmean = (1/realizations)*sum(Xt,1); 
figure(3)
subplot(2,1,1)
plot(t,sim_rpmean); hold on; 
% Overlay plot of theoretical mean (later variance)
for ii = 1:length(a)
    theor_rpmean = (A/(4*(b-a)))*...
        (sin(2*b+2*pi.*t)-sin(2*a+2*pi.*t))+A/2;
    plot(t,theor_rpmean);hold on; 
end
title('Empirical Mean of Random Process X(t) Overlayed with Theoretical Mean')
xlabel('t'); ylabel('m_{X}(t)'); 
% May need to change theta for theoretical...
h1_legend = legend('Empirical Mean of RP with AWGN & uniform RV \theta ([a,b]=[0,2\pi])','Theoretical Mean of RP with (a,b)=(0,2\pi)');
set(h1_legend,'FontSize',15);

% Problem 4 (cont)
% Compute variance of RP X(t)
sim_rpvariance = var(Xt,1); 
subplot(2,1,2)
plot(t,sim_rpvariance); hold on; 
% Overlay plot of theoretical variance
% % Need to do theoretical math for variance
% for ii = 1:length(a)
%     theor_rpmean = (A/(4*(b-a)))*...
%         (sin(2*b+2*pi.*t)-sin(2*a+2*pi.*t))+A/2;
%     plot(t,theor_rpmean);hold on; 
% end
% title('Empirical Variance of Random Process X(t) Overlayed with Theoretical Variance')
% % Need to change ylabel
% xlabel('t'); ylabel('Variance'); 
% % May need to change theta for theoretical...
% h2_legend = legend('Empirical Variance of RP with AWGN & uniform RV \theta ([a,b]=[0,2\pi])',...
%     'Theoretical Variance of RP with (a,b)=(0,2\pi)');
% set(h2_legend,'FontSize',15);
