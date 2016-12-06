% Authors
%   Reza Arfa <rezaarfa (at)gmail.com>
%
%
% Changes
%   01/01/2013
%   21/01/2013

clc; close all; clear all;

% ========== init some variables:
fs = 200;
t = linspace(-1,1,fs);

crossCorrelation = zeros(1,length(t));
convolution      = zeros(1,length(t));

set(gcf,'Color',[1 1 1]);
ax = [-1 1 -0.2 1.1];    

% ========== plot two signals (y1 and y2):
disp('y1: single rectangle pulse with width of 1.0')
disp('y2: single triangle  pulse with width of 0.5')
y1 = rectpuls(t,1);
y2 = tripuls(t,0.5,-1);

subplot(4,2,1);plot(t,y1,'Color','blue','LineWidth',2),axis(ax); 
grid on;
xlabel('t')
ylabel('y1')

subplot(4,2,2);plot(t,y2,'Color','red','LineWidth',2),axis(ax); 
grid on;
xlabel('t')
ylabel('y2')

disp('Press Enter to continue ....');
pause;



% ========== cross correlation of two signals (y1 and y2):
sprintf('\n\nCross Correlation of two signals (y1 and y2):');

iter = length(t);
for i = 1:iter 
    moveStep = (2*i-fs)/fs;
    y2_shifted = tripuls(t-moveStep,0.5,-1);
    crossCorrelation(i) = trapz(t, y1.*y2_shifted);
    
    subplot(4,2,3:4)
    hold off;
    plot(t,y1,'Color','blue','LineWidth',2),axis(ax);
    hold on; 
    plot(t,y2_shifted,'Color','red', 'LineWidth',2),axis(ax); 
    grid on;
    xlabel('t')

    subplot(4,2,5:6)
    hold off
    plot(t(1:i),crossCorrelation(1:i),'Color','black','LineWidth',2); axis([-1 1 -0.2 0.5]); 
    grid on;
    xlabel('t')
    ylabel('CrossCorrelation(y1, y2)(t) ');
    
    pause(0.01);
end


disp('Press Enter to continue ....');
pause;


% ========== convolution of y1 and y2:
sprintf('\n\nConvolution of two signals (y1 and y2):');

for i = 1:iter 
    moveStep = (2*i-fs)/fs;
    y2_shifted = tripuls(-(t-moveStep),0.5,-1);
    convolution(i) = trapz(t, y1.*y2_shifted);
    
    subplot(4,2,3:4)
    hold off;
    plot(t,y1,'Color','blue','LineWidth',2),axis(ax);
    hold on; 
    plot(t,y2_shifted,'Color','red' ,'LineWidth',2),axis(ax);
    grid on;
    xlabel('t');
   
    subplot(4,2,7:8)
    hold off
    plot(t(1:i),convolution(1:i),'Color','black','LineWidth',2); axis([-1 1 -0.2 0.5]);
    grid on;
    xlabel('t')
    ylabel('Convolution(y1, y2)(t) ')
    
    pause(0.01)
end

