% vertailugraafit
close all

[~, minInd] = min(sum(transportInfo2NYK.currentGroupDist,2));
best2NYK = transportInfo2NYK(minInd,:);
best2NYK.currentMassTotal = best2NYK.currentMassRaw+best2NYK.currentMassDigested;

[~, minInd] = min(sum(transportInfo2NYK300.currentGroupDist,2));
best2NYK300 = transportInfo2NYK300(minInd,:);
best2NYK300.currentMassTotal = best2NYK300.currentMassRaw+best2NYK300.currentMassDigested;

[~, minInd] = min(sum(transportInfo2RAA.currentGroupDist,2));
best2RAA = transportInfo2RAA(minInd,:);
best2RAA.currentMassTotal = best2RAA.currentMassRaw+best2RAA.currentMassDigested;

[~, minInd] = min(sum(transportInfo2RAA300.currentGroupDist,2));
best2RAA300 = transportInfo2RAA300(minInd,:);
best2RAA300.currentMassTotal = best2RAA300.currentMassRaw+best2RAA300.currentMassDigested;

[~, minInd] = min(sum(transportInfo2KUI.currentGroupDist,2));
best2KUI = transportInfo2KUI(minInd,:);
best2KUI.currentMassTotal = best2KUI.currentMassRaw+best2KUI.currentMassDigested;

[~, minInd] = min(sum(transportInfo2KUI300.currentGroupDist,2));
best2KUI300 = transportInfo2KUI300(minInd,:);
best2KUI300.currentMassTotal = best2KUI300.currentMassRaw+best2KUI300.currentMassDigested;

[~, minInd] = min(sum(transportInfo4NYK.currentGroupDist,2));
best4NYK = transportInfo4NYK(minInd,:);
best4NYK.currentMassTotal = best4NYK.currentMassRaw+best4NYK.currentMassDigested;

[~, minInd] = min(sum(transportInfo4NYK300.currentGroupDist,2));
best4NYK300 = transportInfo4NYK300(minInd,:);
best4NYK300.currentMassTotal = best4NYK300.currentMassRaw+best4NYK300.currentMassDigested;

[~, minInd] = min(sum(transportInfo4KUI.currentGroupDist,2));
best4KUI = transportInfo4KUI(minInd,:);
best4KUI.currentMassTotal = best4KUI.currentMassRaw+best4KUI.currentMassDigested;

[~, minInd] = min(sum(transportInfo4KUI300.currentGroupDist,2));
best4KUI300 = transportInfo4KUI300(minInd,:);
best4KUI300.currentMassTotal = best4KUI300.currentMassRaw+best4KUI300.currentMassDigested;

[~, minInd] = min(sum(transportInfo4RAA.currentGroupDist,2));
best4RAA = transportInfo4RAA(minInd,:);
best4RAA.currentMassTotal = best4RAA.currentMassRaw+best4RAA.currentMassDigested;

[~, minInd] = min(sum(transportInfo4RAA300.currentGroupDist,2));
best4RAA300 = transportInfo4RAA300(minInd,:);
best4RAA300.currentMassTotal = best4RAA300.currentMassRaw+best4RAA300.currentMassDigested;

[~, minInd] = min(sum(transportInfo2TUL.currentGroupDist,2));
best2TUL = transportInfo2TUL(minInd,:);
best2TUL.currentMassTotal = best2TUL.currentMassRaw+best2TUL.currentMassDigested;

[~, minInd] = min(sum(transportInfo2TUL300.currentGroupDist,2));
best2TUL300 = transportInfo2TUL300(minInd,:);
best2TUL300.currentMassTotal = best2TUL300.currentMassRaw+best2TUL300.currentMassDigested;

[~, minInd] = min(sum(transportInfo4TUL.currentGroupDist,2));
best4TUL = transportInfo4TUL(minInd,:);
best4TUL.currentMassTotal = best4TUL.currentMassRaw+best4TUL.currentMassDigested;

[~, minInd] = min(sum(transportInfo4TUL300.currentGroupDist,2));
best4TUL300 = transportInfo4TUL300(minInd,:);
best4TUL300.currentMassTotal = best4TUL300.currentMassRaw+best4TUL300.currentMassDigested;

% ravita
[~, minInd] = min(sum(transportInfo2RAV.currentGroupDist,2));
best2RAV = transportInfo2RAV(minInd,:);
best2RAV.currentMassTotal = best2RAV.currentMassRaw+best2RAV.currentMassRavita;

[~, minInd] = min(sum(transportInfo2RAV300.currentGroupDist,2));
best2RAV300 = transportInfo2RAV300(minInd,:);
best2RAV300.currentMassTotal = best2RAV300.currentMassRaw+best2RAV300.currentMassRavita;

[~, minInd] = min(sum(transportInfo4RAV.currentGroupDist,2));
best4RAV = transportInfo4RAV(minInd,:);
best4RAV.currentMassTotal = best4RAV.currentMassRaw+best4RAV.currentMassRavita;

[~, minInd] = min(sum(transportInfo4RAV300.currentGroupDist,2));
best4RAV300 = transportInfo4RAV300(minInd,:);
best4RAV300.currentMassTotal = best4RAV300.currentMassRaw+best4RAV300.currentMassRavita;

%% distance

% one option (2 STFs, no dist limit), different scenarios (current, raw, better TS)
% Finnish
% names = categorical({'Nykytilanne','Raakalietettä','Kuivempaa lietettä'});
% names = reordercats(names,{'Nykytilanne','Raakalietettä','Kuivempaa lietettä'});
% bar(names, [sum(best2NYK.currentGroupDist),sum(best2RAA.currentGroupDist),sum(best2KUI.currentGroupDist)],0.5,'red')

% ylabel("Transported distance (km/a)")
% title('Comparison of transported distance')

ylabel("Kuljetusmatka (km/a)")
title('Kuljetusmatkan vertailu')

% exportgraphics(gcf,'comparisondistNYK.png')


%% graphs distances continues

% English
% distance comparison, one scenario, different options
% names = categorical({'2RAV','2RAV300','4RAV','4RAV300'});
% names = reordercats(names,{'2RAV','2RAV300','4RAV','4RAV300'});
% Finnish
% distance comparison, one scenario, different options
% names = categorical({'2 laitosta','2 laitosta+rajoite','4 laitosta','4 laitosta+rajoite'});
% names = reordercats(names,{'2 laitosta','2 laitosta+rajoite','4 laitosta','4 laitosta+rajoite'});
% 
% b = bar(names, [sum(best2RAV.currentGroupDist),sum(best2RAV300.currentGroupDist),sum(best4RAV.currentGroupDist),sum(best4RAV300.currentGroupDist)],0.5);


% 2/4 STFs, current & raw
% English
% names = categorical({'2 plants, current','4 plants, current','2 plants, raw','4 plants, raw'});
% names = reordercats(names,{'2 plants, current','4 plants, current','2 plants, raw','4 plants, raw'});
% b = bar(names, [sum(best2NYK.currentGroupDist),sum(best4NYK.currentGroupDist),sum(best2RAA.currentGroupDist),sum(best4RAA.currentGroupDist)],0.5);


% basic+limit, different scenarios (current, better TS, raw, future)
% Finnish
names = categorical({'Nykytilanne','Rajoite, nykytilanne','Kuivempi','Rajoite, kuivempi','Raakaliete','Rajoite, raakaliete','Tulevaisuus','Rajoite, tulevaisuus'});
names = reordercats(names,{'Nykytilanne','Rajoite, nykytilanne','Kuivempi','Rajoite, kuivempi','Raakaliete','Rajoite, raakaliete','Tulevaisuus','Rajoite, tulevaisuus'});
b = bar(names, [sum(best2NYK.currentGroupDist),sum(best2NYK300.currentGroupDist),sum(best2KUI.currentGroupDist),sum(best2KUI300.currentGroupDist),sum(best2RAA.currentGroupDist),sum(best2RAA300.currentGroupDist),sum(best2TUL.currentGroupDist),sum(best2TUL300.currentGroupDist)],0.5);

% ylabel("Transported distance (km/a)")
% title('Comparison of transported distance')
ylabel("Kuljetusmatka (km/a)")
title('Kuljetusmatkan vertailu')


b.FaceColor = 'flat';
b.CData(3,:) = [0.8500 0.3250 0.0980];
b.CData(4,:) = [0.8500 0.3250 0.0980];
if numel(names) > 4
    b.CData(5,:) = [.5 0 .5];
    b.CData(6,:) = [.5 0 .5];
end
if numel(names) > 6
    b.CData(7,:) = [0.6350 0.0780 0.1840];
    b.CData(8,:) = [0.6350 0.0780 0.1840];
end

width = 1300;
height = 700;

b.Parent.FontSize = 15;  

set(gcf,'position',[50,50,width,height])

% exportgraphics(gcf,'matka-2-skenaariot.png')

%% graphs energy

figure

% 2/4 STFs, one scenario, limit & no limit
% English
% names = categorical({'2RAV','2RAV300','4RAV','4RAV300'});
% names = reordercats(names,{'2RAV','2RAV300','4RAV','4RAV300'});
% b = bar(names,[sum(best2RAV.currentEnergyPotential),sum(best2RAV300.currentEnergyPotential),sum(best4RAV.currentEnergyPotential),sum(best4RAV300.currentEnergyPotential)],0.5);

% 2/4 STFs, current & raw
% English
% names = categorical({'2 plants, current','4 plants, current','2 plants, raw','4 plants, raw'});
% names = reordercats(names,{'2 plants, current','4 plants, current','2 plants, raw','4 plants, raw'});
% b = bar(names, [sum(best2NYK.currentEnergyPotential),sum(best4NYK.currentEnergyPotential),sum(best2RAA.currentEnergyPotential),sum(best4RAA.currentEnergyPotential)],0.5);

% basic+limit, different scenarios (current, better TS, raw, future)
% Finnish
names = categorical({'Nykytilanne','Rajoite, nykytilanne','Kuivempi','Rajoite, kuivempi','Raakaliete','Rajoite, raakaliete','Tulevaisuus','Rajoite, tulevaisuus'});
names = reordercats(names,{'Nykytilanne','Rajoite, nykytilanne','Kuivempi','Rajoite, kuivempi','Raakaliete','Rajoite, raakaliete','Tulevaisuus','Rajoite, tulevaisuus'});
b = bar(names, [sum(best2NYK.currentEnergyPotential),sum(best2NYK300.currentEnergyPotential),sum(best2KUI.currentEnergyPotential),sum(best2KUI300.currentEnergyPotential),sum(best2RAA.currentEnergyPotential),sum(best2RAA300.currentEnergyPotential),sum(best2TUL.currentEnergyPotential),sum(best2TUL300.currentEnergyPotential)],0.5);

% ylabel("Energy potential (GWh/a)")
% title('Comparison of energy potential')
ylabel("Energiapotentiaali (GWh/a)")
title('Energiapotentiaalin vertailu')

b.FaceColor = 'flat';
b.CData(3,:) = [0.8500 0.3250 0.0980];
b.CData(4,:) = [0.8500 0.3250 0.0980];
if numel(names) > 4
    b.CData(5,:) = [.5 0 .5];
    b.CData(6,:) = [.5 0 .5];
end
if numel(names) > 6
    b.CData(7,:) = [0.6350 0.0780 0.1840];
    b.CData(8,:) = [0.6350 0.0780 0.1840];
end

width = 1300;
height = 700;

b.Parent.FontSize = 15;  

set(gcf,'position',[50,50,width,height])

exportgraphics(gcf,'energia-2-skenaariot.png')

%% graphs sludge mass

figure

% 2/4 STFs, one scenario, limit & no limit
% English
% names = categorical({'2RAV','2RAV300','4RAV','4RAV300'});
% names = reordercats(names,{'2RAV','2RAV300','4RAV','4RAV300'});
% b = bar(names,[sum(best2RAV.currentMassTotal),sum(best2RAV300.currentMassTotal),sum(best4RAV.currentMassTotal),sum(best4RAV300.currentMassTotal)],0.5);

% 2/4 STFs, current & raw
% English
% names = categorical({'2 plants, current','4 plants, current','2 plants, raw','4 plants, raw'});
% names = reordercats(names,{'2 plants, current','4 plants, current','2 plants, raw','4 plants, raw'});
% b = bar(names, [sum(best2NYK.currentMassTotal),sum(best4NYK.currentMassTotal),sum(best2RAA.currentMassTotal),sum(best4RAA.currentMassTotal)],0.5);

% basic+limit, different scenarios (current, better TS, raw, future)
% Finnish
names = categorical({'Nykytilanne','Rajoite, nykytilanne','Kuivempi','Rajoite, kuivempi','Raakaliete','Rajoite, raakaliete','Tulevaisuus','Rajoite, tulevaisuus'});
names = reordercats(names,{'Nykytilanne','Rajoite, nykytilanne','Kuivempi','Rajoite, kuivempi','Raakaliete','Rajoite, raakaliete','Tulevaisuus','Rajoite, tulevaisuus'});
b = bar(names, [sum(best2NYK.currentMassTotal),sum(best2NYK300.currentMassTotal),sum(best2KUI.currentMassTotal),sum(best2KUI300.currentMassTotal),sum(best2RAA.currentMassTotal),sum(best2RAA300.currentMassTotal),sum(best2TUL.currentMassTotal),sum(best2TUL300.currentMassTotal)],0.5);

% ylabel("Received sludge (t/a)")
% title('Comparison of sludge mass')
ylabel("Vastaanotettu liete (t/a)")
title('Lietteen määrien vertailu')

b.FaceColor = 'flat';
b.CData(3,:) = [0.8500 0.3250 0.0980];
b.CData(4,:) = [0.8500 0.3250 0.0980];
if numel(names) > 4
    b.CData(5,:) = [.5 0 .5];
    b.CData(6,:) = [.5 0 .5];
end
if numel(names) > 6
    b.CData(7,:) = [0.6350 0.0780 0.1840];
    b.CData(8,:) = [0.6350 0.0780 0.1840];
end

width = 1300;
height = 700;

b.Parent.FontSize = 15;  

set(gcf,'position',[50,50,width,height])

% exportgraphics(gcf,'massa-2-skenaariot.png')
