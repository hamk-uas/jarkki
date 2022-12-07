function h = plotBarStackGroups(stackData, groupLabels)
%% Plot a set of stacked bars, but group them according to labels provided.
%%
%% Params: 
%%      stackData is a 3D matrix (i.e., stackData(i, j, k) => (Group, Stack, StackElement)) 
%%      groupLabels is a CELL type (i.e., { 'a', 1 , 20, 'because' };)
%%
%% Copyright 2011 Evan Bollig (bollig at scs DOT fsu ANOTHERDOT edu
%%
%% Example usage
% NumStacksPerGroup = 3;
% NumGroupsPerAxis = 6;
% NumStackElements = 4;
% 
% % labels to use on tick marks for groups
% groupLabels = { 'Test'; 2; 4; 6; 8; -1; };
% stackData = rand(NumGroupsPerAxis,NumStacksPerGroup,NumStackElements);
% 
% plotBarStackGroups(stackData, groupLabels);
% set(gca,'FontSize',18)
% set(gcf,'Position',[100 100 720 650])
% grid on
% set(gca,'Layer','top') % put grid lines on top of stacks
%% 
NumGroupsPerAxis = size(stackData, 1);
NumStacksPerGroup = size(stackData, 2);


% Count off the number of bins
groupBins = 1:NumGroupsPerAxis;
MaxGroupWidth = 0.65; % Fraction of 1. If 1, then we have all bars in groups touching
% MaxGroupWidth = 0.85; % oma muokkaus
groupOffset = MaxGroupWidth/NumStacksPerGroup;
figure
    hold on; 
for i=1:NumStacksPerGroup
    
    Y = squeeze(stackData(:,i,:));
    
    % Center the bars:
    
    internalPosCount = i - ((NumStacksPerGroup+1) / 2);
    
    % Offset the group draw positions:
    groupDrawPos = (internalPosCount)* groupOffset + groupBins;
    
    h(i,:) = bar(Y, 'stacked');
    set(h(i,:),'BarWidth',groupOffset);
    set(h(i,:),'XData',groupDrawPos);
    % ------------ LISÄYS LABEL LISÄÄMISEEN JOKA BAARILLE ---------- %
    barLabels={'1','2','3','4'};
    % Bar Labeling
    for j=1:NumGroupsPerAxis
        text(groupDrawPos(j),0,...
        barLabels{i},'VerticalAlignment','bottom',...
        'HorizontalAlignment','center');
    end
    % -------------------------------------------------------------- %
end
hold off;
set(gca,'XTickMode','manual');
set(gca,'XTick',1:NumGroupsPerAxis);
set(gca,'XTickLabelMode','manual');
set(gca,'XTickLabel',groupLabels);
end 
