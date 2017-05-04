function [ax,hl1,hl2] = plotxx(x1,y1,x2,y2,xlabels,ylabels,minX,maxX)
%PLOTXX - Create graphs with x axes on both top and bottom 
%
%Similar to PLOTYY, but ...
%the independent variable is on the y-axis, 
%and both dependent variables are on the x-axis.
%
%Syntax: [ax,hl1,hl2] = plotxx(x1,y1,x2,y2,xlabels,ylabels);
%
%Inputs:  X1,Y1 are the data for the first line (black)
%         X2,Y2 are the data for the second line (red)
%         XLABELS is a cell array containing the two x-labels
%         YLABELS is a cell array containing the two y-labels
%
%The optional output handle graphics objects AX,HL1,HL2
%allow the user to easily change the properties of the plot.
%
%Example: Plot temperature T and salinity S 
%         as a function of depth D in the ocean
%
%D = linspace(-100,0,50);
%S = linspace(34,32,50);
%T = 10*exp(D/40);
%xlabels{1} = 'Temperature (C)';
%xlabels{2} = 'Salinity';
%ylabels{1} = 'Depth(m)';
%ylabels{2} = 'Depth(m)';
%[ax,hlT,hlS] = plotxx(T,D,S,D,xlabels,ylabels);


%The code is inspired from page 10-26 (Multiaxis axes)
%of the manual USING MATLAB GRAPHICS, version 5.
%
%Tested with Matlab 5.3.1 and above on PCWIN

%Author: Denis Gilbert, Ph.D., physical oceanography
%Maurice Lamontagne Institute, Dept. of Fisheries and Oceans Canada
%email: gilbertd@dfo-mpo.gc.ca  Web: http://www.qc.dfo-mpo.gc.ca/iml/
%November 1997; Last revision: 01-Nov-2001

if nargin < 4
   error('Not enough input arguments')
elseif nargin==4
   %Use empty strings for the xlabels
   xlabels{1}=' '; xlabels{2}=' '; ylabels{1}=' '; ylabels{2}=' ';
elseif nargin==5
   %Use empty strings for the ylabel
   ylabels{1}=' '; ylabels{2}=' ';
elseif nargin > 9
   error('Too many input arguments')
end

if length(ylabels) == 1
   ylabels{2} = ' ';
end

if ~iscellstr(xlabels) 
   error('Input xlabels must be a cell array')
elseif ~iscellstr(ylabels) 
   error('Input ylabels must be a cell array')
end

hl1=plot(x1,y1,'r+');
ax(1)=gca;
set(ax(1),'Position',[0.12 0.12 0.75 0.70])
set(ax(1),'XColor','k','YColor','k');
xTickVal1 = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
set(ax(1),'XLim',[minX, maxX],'XTick',xTickVal1);
%, 'XTickLabel',{num2str((xTickVal1(1))), num2str((xTickVal1(2))), ...
%    num2str((xTickVal1(3))), num2str((xTickVal1(4))), num2str((xTickVal1(5)))}

ax(2)=axes('Position',get(ax(1),'Position'),...
   'XAxisLocation','top',...
   'YAxisLocation','right',...
   'Color','none',...
   'XColor','r','YColor','k');

%set(ax,'box','off')
axes(ax(2));
%hl2=line(x2,y2,'Color','r', 'Marker', 'o', 'Linewidth', 2, 'Parent',ax(2));
hl2=line(x2,y2,'Color','w', 'Linewidth', 1e12, 'Parent',ax(2));
%set(ax(2),'xscale','log');
xTickVal2 = round(10*xTickVal1.^(-2))/10;
xTick2 = minX*100:11:maxX*100;
set(ax(2),'XLim',[maxX^(-2), minX^(-2)],'XTick',xTick2, ...
    'XTickLabel',{num2str((xTickVal2(1))), num2str((xTickVal2(2))), ...
    num2str((xTickVal2(3))), num2str((xTickVal2(4))), num2str((xTickVal2(5))), ...
    num2str((xTickVal2(6))), num2str((xTickVal2(7))), num2str((xTickVal2(8))), ...
    num2str((xTickVal2(9))), num2str((xTickVal2(10)))});
%set(ax(2),'Xdir','reverse');

%label the two x-axes
set(get(ax(1),'xlabel'),'string',xlabels{1})
set(get(ax(2),'xlabel'),'string',xlabels{2})
set(get(ax(1),'ylabel'),'string',ylabels{1})
set(get(ax(2),'ylabel'),'string',ylabels{2})
