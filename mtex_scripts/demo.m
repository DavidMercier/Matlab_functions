%% Copyright 2014 MERCIER David

% Matlab code using MTEX toolbox for analysis of EBSD data
% Source code : https://github.com/mtex-toolbox/mtex
% Doc : http://mtex-toolbox.github.io/
% Doc : http://mtex-toolbox.github.io/files/doc/funcref_cat.html

% author: david9684@gmail.com

%% Initialization
clc; clear all;

%% Check MTEX installation
try
    startup_mtex;
catch
    warndlg('MTEX not installed or check_mtex not found/failing!');
    disp('Proceeding without MTEX functionalities...');
    disp('Download MTEX here: http://mtex-toolbox.github.io/');
end

%% Loading of EBSD dataset with MTEX wizard
% or just reuse the matlab output file saved in your repository...
try
    import_wizard('EBSD');

catch err
    commandwindow;
    display(err.message);
    
end
uiwait(gcf);

% Create a Matlab variable called 'ebsd'...
save('ebsd_dataset');

%% Definiton of EBSD datasets in function of the phase
ebsdAll = ebsd('indexed');
ebsd_Ph1 = ebsd('Phase_1');
ebsd_Ph2 = ebsd('Phase_2');
save('ebsd_dataset');

%% Phase plot
figure('Name', 'Phase'); hold on;
plot(ebsd, 'property', 'phase');
% for empty plots...
set(gcf,'renderer','zBuffer');

%% Crop step
region = [10 10 3 3];
rectangle('position',region,'edgecolor','r','linewidth',2);
condition = inpolygon(ebsd,region);
ebsdCropped_All = ebsdAll(condition);
ebsd_Ph1_cropped = ebsdCropped_All('Phase_1');
ebsdCropped_Ph1 = ebsd_Ph1_cropped;
ebsd_Ph2_cropped = ebsdCropped_All('Phase_2');
ebsdCropped_Ph2 = ebsd_Ph2_cropped;

%% Some plots...
% Plot Inverse Pole Figure
mtex_plotIPF(ebsd('Phase_1').orientations);
mtex_plotIPF(ebsd('Phase_2').orientations);

% Orientation of Grains 'Phase_1'
figure('Name', 'EBSDmap'); hold on;
oM = ipdfHSVOrientationMapping(ebsd('Phase_1'));
plot(ebsd('Phase_1'),oM.orientation2color(ebsd('Phase_1').orientations));

% Orientation of Grains 'Phase_2'
figure('Name', 'EBSDmap'); hold on;
oM = ipdfHSVOrientationMapping(ebsd('Phase_2'));
plot(ebsd('Phase_2'),oM.orientation2color(ebsd('Phase_2').orientations));

%% Grains extraction
MisorAngleMin = 1;
[allGrains,ebsdAll.grainId] = calcGrains(ebsdAll,'angle',MisorAngleMin*degree);
%[Ph1Grains,ebsd_Ph1.grainId] = calcGrains(ebsd_Ph1,'angle',MisorAngleMin*degree);
Ph1Grains = allGrains('Phase_1');
% [Ph2Grains,ebsd_Ph2.grainId] = calcGrains(ebsd_Ph2);
% Doesn't work ??!! Takes forever.... --> see with cropped dataset ?
% ebsd_Ph2.grainId is the problem ?!
Ph2Grains = allGrains('Phase_2');

% To remove for example triple junctions ?
allGrainsSmoothed = smooth(allGrains);

% Other method to extract grains...
[allGrains, ebsdAll.grainId] = calcGrains(ebsd,'FMC',3.5);

% Grains extraction with cropped dataset
[allGrains,ebsdCropped_All.grainId] = calcGrains(ebsdCropped_All);
Ph1Grains = allGrains('Phase_1');
Ph2Grains = allGrains('Phase_2');

%% Grain boundaries extraction
figure;
allGBs = allGrains.boundary;
plot(allGrains,'translucent',.3); hold on;
plot(allGBs); hold on;
allGBs_inner = allGrains.innerBoundary;
plot(allGBs_inner);

figure;
% Ph1 - Ph1
Ph1GBs = Ph1Grains.boundary;
Ph1GBs_inner = Ph1Grains.innerBoundary;
Ph1GBs_indexed = Ph1Grains.boundary('Phase_1', 'Phase_1');
Ph1GBs_indexed_inner = Ph1Grains.innerBoundary('Phase_1', 'Phase_1');
plot(Ph1GBs_indexed,'linecolor','r','linewidth',1.5);
hold on;
plot(Ph1GBs_indexed_inner,'linecolor','r','linewidth',1.5, ...
    'displayName','Phase1-Phase1 GBs');
hold on;

% Ph2 - Ph2
Ph2GBs = Ph2Grains.boundary;
Ph2GBs_inner = Ph2Grains.innerBoundary;
Ph2GBs_indexed = Ph2Grains.boundary('Phase_2', 'Phase_2');
Ph2GBs_indexed_inner = Ph2Grains.innerBoundary('Phase_2', 'Phase_2');
plot(Ph2GBs_indexed,'linecolor','b','linewidth',1.5);
hold on;
plot(Ph2GBs_indexed_inner,'linecolor','b','linewidth',1.5, ...
    'displayName','Phase2-Phase2 GBs');
hold on;

% Ph1 - Ph2
Ph1Ph2GBs = allGrains.boundary;
Ph1Ph2GBs_inner = allGrains.innerBoundary;
Ph1Ph2GBs_indexed = allGrains.boundary('Phase_1', 'Phase_2');
Ph1Ph2GBs_indexed_inner = allGrains.innerBoundary('Phase_1', 'Phase_2');
plot(Ph1Ph2GBs_indexed,'linecolor','g','linewidth',1.5);
hold on;
plot(Ph1Ph2GBs_indexed_inner,'linecolor','g','linewidth',1.5, ...
    'displayName','Phase1-Phase2 GBs');

%% Get and plot LAGBs
figure;
plot(allGrains,'translucent',.3); hold on;
plot(allGBs); hold on;
plot(allGBs_inner); hold on

figure;
clearvars('ind_lowPh1GBS', 'ind_Ph1HAGBS');
clearvars('ind_lowPh1GBS_inner', 'ind_Ph1HAGBS_inner');
plot(allGrains,'translucent',.3); hold on;
maxAngle = 20;

% HAGB Ph1 - Ph1
ind_Ph1HAGBS = ...
    angle(Ph1GBs_indexed.misorientation.axis,xvector)>maxAngle*degree;
ind_Ph1HAGBS_inner = ...
    angle(Ph1GBs_indexed_inner.misorientation.axis,xvector)>maxAngle*degree;

plot(Ph1GBs_indexed(ind_Ph1HAGBS), ...
    'linecolor','b','linewidth',2);
hold on;
plot(Ph1GBs_indexed_inner(ind_Ph1HAGBS_inner), ...
    'linecolor','b','linewidth',2, 'displayName','Phase1-Phase1 HAGBs');
hold on;

criticalAngle = 1;
StepSize = 2;
% LAGBs Ph1 - Ph1
for IndexAngle = 1:1:maxAngle;
    criticalAngle = criticalAngle + StepSize;
    ind_Ph1LAGBS(:,IndexAngle) = ...
        angle(Ph1GBs_indexed.misorientation.axis,xvector) <= ...
        criticalAngle*degree;
    ind_Ph1LAGBS_inner(:,IndexAngle) = ...
        angle(Ph1GBs_indexed_inner.misorientation.axis,xvector) <= ...
        criticalAngle*degree;
    plot(Ph1GBs_indexed(ind_Ph1LAGBS(:,IndexAngle)), ...
        'linecolor','r','linewidth',2);
    hold on;
    plot(Ph1GBs_indexed_inner(ind_Ph1LAGBS_inner(:,IndexAngle)), ...
        'linecolor','r','linewidth',2);
    hold on;
end
plot(Ph1GBs_indexed_inner(ind_Ph1LAGBS_inner(:,IndexAngle)), ...
    'linecolor','r','linewidth',2, 'displayName','Phase1-Phase1 LAGBs');
hold on;
% Problem of size ??? Total number of GBs not respected after the loop ?

% Ph1 - Ph2
plot(Ph1Ph2GBs_indexed,'linecolor','g','linewidth',1.5);
hold on;
plot(Ph1Ph2GBs_indexed_inner,'linecolor','g','linewidth',1.5, ...
    'displayName','Phase1-Phase2 GBs');

%% Perimeter
% Need to modifiy perimeter function...
% Not really used in MTEX --> going to be removed...
allSegments_Ph1 = perimeter(Ph1Grains, Ph1GBs_indexed);
allSegments_Ph2 = perimeter(Ph2Grains, Ph2GBs);

% Some calculations of total length of all segments...
sum(allSegments_Ph1);
sum(allSegments_Ph2);
sum(Ph1GBs_indexed.segLength); %segmentsize

%allGrains.boundarySize

%% Coordinates and lengths of GB segments
% Coordinates of GB segments
for ii = 1:1:length(Ph1GBs_indexed)
    Ph1GBs_indexed(ii).x;
    Ph1GBs_indexed(ii).y;
end

% Lengths of GB segments
Ph1Sum = sum(Ph1GBs_indexed(ind_Ph1HAGBS(:,:)).segLength);
Ph1Sum_inner = sum(Ph1GBs_indexed_inner(ind_Ph1HAGBS_inner(:,:)).segLength);
SumPh1 = Ph1Sum + Ph1Sum_inner;

Ph1Ph2Sum = sum(Ph1Ph2GBs_indexed.segLength);
Ph1Ph2Sum_inner = sum(Ph1Ph2GBs_indexed_inner.segLength);
SumPh1Ph2 = Ph1Ph2Sum + Ph1Ph2Sum_inner;

SumPh1Ph2/SumPh1;

%% Vertices (V) and faces (F)
% the vertices of the grain boundary are stored in the field 'V'. In a GrainSet the fields 'x', 'y', 'z' respectively, refer to the spatial ebsd coordinates. so to access vertices of a specific grain one can use
V = get(grains(subset), 'V');
plot(V(:,1),V(:,2),'.');

%however, a move conveniant way would be to make use of the incidency matrix vertices incident to grains
I_VG = get(g,'i_vg');
V = V(any(I_VG,2),:);
plot(V(:,1),V(:,2),'.');
axis('equal','tight');

%nevertheless, the resulting V is not an ordered field. To get Vertices right, you can access the polygons by
V     = get(grains,'V');
order = get(grains,'boundaryEdgeOrder');
V(order{1},:)
