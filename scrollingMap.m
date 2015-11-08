%Matlab script.
%Scrolling map with wrap around demo.
%Tested with Matlab R2007a.
%Samil Korkmaz, November 2015.
%Licence: Public Domain.
clc; clear all;
n=15; 
%generate x coordinates:
ax = 0.1; bx = 2;
ddx = ax + (bx-ax) * rand(1,n); %distances between x coordinates
xList(1) = 1;
for i=2:n
    xList(i) = xList(i-1) + ddx(i);
end
% xList = [1 2.5 3 4 6];

%generate y coordinates:
ay = 0.5; by = 15;
yList = ay + (by-ay) * rand(1,n);
% yList = [0 1 1 0 2];

%size of screen:
screenXMin = min(xList); screenXMax = max(xList); xlim([screenXMin screenXMax]);
%screenXMin = 2; screenXMax = 4.5; xlim([screenXMin screenXMax]);
screenYMin = 0; screenYMax = max(yList); ylim([screenYMin screenYMax])

clf; subplot(2,1,1); plot(xList, yList, '.-'); grid on; xlim([min(xList) max(xList)]);
xlabel('x');ylabel('y')

scrollX = ax;
dispXlist = xList;
dxLastAndFirstPoint = (ax+bx)/2; %can be any value, I choose to set it to average
dispXDiff = [diff(xList) dxLastAndFirstPoint]; %add x distance between last point and first point to the end of vector
dispYlist = yList;

%axes('Parent',gcf,'Position',[0.28 0.11 0.395 0.341]); %create smaller second plot
axes('Parent',gcf,'Position',[0.13 0.11 0.775 0.341]); %create smaller second plot
plot(dispXlist, dispYlist, '.-'); grid on; xlim([screenXMin screenXMax]); ylim([screenYMin screenYMax]);
pause
%scroll to right
for i = 1:5*length(xList)
    dispXlist = dispXlist + scrollX;
    if dispXlist(1) >= screenXMin %leftmost point is on screen, create point at beginning of list and delete point at end of list.
        disp(['shift list right ', num2str(i)])
        dispXlist = [dispXlist(1) - dispXDiff(end) dispXlist];
        dispXDiff = [dispXDiff(end) dispXDiff];
        
        dispXDiff(end) = [];
        dispXlist(end) = [];        
        
        dispYlist = [dispYlist(end) dispYlist]; dispYlist(end) = [];     
    end    
    plot(dispXlist, dispYlist, '.-'); grid on;
%     title(['dispXDiff = ', sprintf('%1.2f, ', dispXDiff)]);
    xlim([screenXMin screenXMax]); ylim([screenYMin screenYMax]);
    pause
end
%scroll to left
for i = 1:5*length(xList)    
    dispXlist = dispXlist - scrollX;
    if dispXlist(end) <= screenXMax %rightmost point is on screen, create point at end of list and delete point at beginning of list.        
        disp(['shift list left ', num2str(i)])
        dispXlist = [dispXlist dispXlist(end) + dispXDiff(end)];
        dispXDiff = [dispXDiff dispXDiff(1) ];
         
        dispXDiff(1) = [];        
        dispXlist(1) = [];        
        
        dispYlist = [dispYlist dispYlist(1)]; dispYlist(1) = [];        
    end    
    plot(dispXlist, dispYlist, '.-'); grid on;
%     title(['dispXDiff = ', sprintf('%1.2f, ', dispXDiff)]); 
    xlim([screenXMin screenXMax]); ylim([screenYMin screenYMax]);
    pause  
end
