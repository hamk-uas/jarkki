% sludge transportation statistics

% Copyright (c) 2022 Marianne Honkasaari, HAMK Smart
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.


load('data')

%% loads

close all

transportInfo = transportInfo2KUI300;

[minDist, minInd] = min(sum(transportInfo.currentGroupDist,2));
bestInd = transportInfo.gridPointCombs(minInd,:);

isRaw = 0;
betterTS = 1;
isFuture = 0;
isRavita = 0;

% if scenario has a distance limit (optimized or cut), mark it here
isDistLimit = 1;
kmlimit = 300;

%---------%

% täällä muutos jos Raw
if isRaw == 1
    sludgeLoadsCurrent = sludgeLoadsRAA;
elseif betterTS == 1
    sludgeLoadsCurrent = sludgeLoadsKUI;
elseif isFuture == 1
    sludgeLoadsCurrent = sludgeLoadsTUL;
elseif isRavita == 1
    sludgeLoadsCurrent = sludgeLoadsRAV;
else
    sludgeLoadsCurrent = sludgeLoadsNYK;
end

for i = 1:size(sludgeLoadsCurrent,1)

    if isFuture == 1
        transportToPoints = distancesTUL(sludgeLoadsCurrent.indWWTP(i),bestInd);
    elseif isRavita == 1
        transportToPoints = distancesRAV(sludgeLoadsCurrent.indWWTP(i),bestInd);
    else
        transportToPoints = distancesNYK(sludgeLoadsCurrent.indWWTP(i),bestInd);
    end

    % find to which STF the distance is the smallest
    [distClosest, STFclosest] = min(transportToPoints);

    % tämä, jos 300 km rajoitus
    if isDistLimit == 1
        if distClosest <= kmlimit
            sludgeLoadsCurrent.toSTF(i) = bestInd(STFclosest);
        end
    else
        sludgeLoadsCurrent.toSTF(i) = bestInd(STFclosest);
    end

end

laitoksia = numel(bestInd);

sludgeLoadsTo1 = sludgeLoadsCurrent(sludgeLoadsCurrent.toSTF == bestInd(1),:);
sludgeLoadsTo2 = sludgeLoadsCurrent(sludgeLoadsCurrent.toSTF == bestInd(2),:);
if laitoksia == 4
    sludgeLoadsTo3 = sludgeLoadsCurrent(sludgeLoadsCurrent.toSTF == bestInd(3),:);
    sludgeLoadsTo4 = sludgeLoadsCurrent(sludgeLoadsCurrent.toSTF == bestInd(4),:);
end

loadsTo = zeros(365,laitoksia);

for day = 1:365
    loadsTo(day,1) = sum(sludgeLoadsTo1.numOfLoads(sludgeLoadsTo1.t == day));
    loadsTo(day,2) = sum(sludgeLoadsTo2.numOfLoads(sludgeLoadsTo2.t == day));
    if laitoksia == 4
        loadsTo(day,3) = sum(sludgeLoadsTo3.numOfLoads(sludgeLoadsTo3.t == day));
        loadsTo(day,4) = sum(sludgeLoadsTo4.numOfLoads(sludgeLoadsTo4.t == day));
    end
end

% statistics

laitos = zeros(laitoksia,1);
kapasiteetti = repmat(45,laitoksia,1);
lastityht = zeros(laitoksia,1);
lastitkeskiarvo = zeros(laitoksia,1);
lastitmediaani = zeros(laitoksia,1);

% figures
for i = 1:laitoksia
    
    figure
    histogram(loadsTo(:,i))
    xlabel('Number of loads')
    ylabel('Number of days')
    title(sprintf('Laitos %d',bestInd(i)))

    laitos(i,1) = bestInd(i);
    lastityht(i,1) = sum(loadsTo(:,i));
    lastitkeskiarvo(i,1) = mean(loadsTo(:,i));
    lastitmediaani(i,1) = median(loadsTo(:,i));

end

% results
tulokset = table(laitos,kapasiteetti,lastityht,lastitkeskiarvo,lastitmediaani);

% write them to excel
!del results.xls
writetable(tulokset,'results.xls')

%% fuel consumption

transportInfo = transportInfo4KUI300;

% LBG consumption, full and empty truck
consumptionLBGfull = 30; %kg/100km
consumptionLBGempty = 27; %kg/100km

% diesel consumption
consumptiondieselfull = 37.5; %l/100km
consumptiondieselempty = 35; %l/100km

[~, minInd] = min(sum(transportInfo.currentGroupDist,2));
best = transportInfo(minInd,:);
kms = best.currentGroupDist;

% how much total
LBGfull = kms/100*consumptionLBGfull/1000; % t kg
LBGempty = kms/100*consumptionLBGempty/1000; % t kg
dieselfull = kms/100*consumptiondieselfull/1000; % t l
dieselempty = kms/100*consumptiondieselempty/1000; % t l
LBGtotal = LBGfull + LBGempty; % t kg
dieseltotal = dieselfull + dieselempty; % t l

% results
consumption = table(LBGfull,LBGempty,LBGtotal,dieselfull,dieselempty,dieseltotal);
