% product transportation

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


load ('data.mat')

%% create productSums
% fill the product information for different scenarios from Viljami's excel

% 2NYK300HTC

STFtype = ["HTC","HTC"];
fromSTF = [12,72];
lbgMass = [3148,2313]; %t/a
lbgEnergy = [46,35];
Ntype = ["NH4OH","NH4OH"];
Nmass = [15908,6535];
% N = 0.2*0.777778.*Nmass;
N = [2486,1021];
Ctype = ["HTCcoal","HTCcoal"];
Cmass = [117295,35395];
PinCproduct = [2328,739];
CinCproduct = [21113,6371];
NinCproduct = [1283,367];

productSum2NYK300HTC = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 4NYK300HTC

STFtype = ["HTC","HTC","HTC","HTC"];
fromSTF = [6,21,34,72];
lbgMass = [1122,1367,1760,1389]; %t/a
lbgEnergy = [17,20,26,20]; % t GWh/a
Ntype = ["NH4OH","NH4OH","NH4OH","NH4OH"];
Nmass = [8193,5184,5935,4177];
N = [1280,810,927,653];
Ctype = ["HTCcoal","HTCcoal"];
Cmass = [66256,31517,36448,23590];
PinCproduct = [1288,605,775,493];
CinCproduct = [11926,5673,6561,4246];
NinCproduct = [664,338,389,243];

productSum4NYK300HTC = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);
    

% 2RAA300HTC

STFtype = ["HTC","HTC"];
fromSTF = [12,65];
lbgMass = [9267,3754]; %t/a
lbgEnergy = [135,55];
water = [291506,153799];
Ntype = ["NH4OH","NH4OH"];
Nmass = [22191,9349];
N = [3467,1461];
Ctype = ["HTCcoal","HTCcoal"];
Cmass = [110826,46567];
PinCproduct = [2204,952];

productSum2RAA300HTC = table(STFtype,fromSTF,lbgMass,lbgEnergy,water,Ntype,Nmass,N,Ctype,Cmass,PinCproduct);

% 4RAA300HTC

STFtype = ["HTC","HTC","HTC","HTC"];
fromSTF = [7,25,39,83];
lbgMass = [6549,3119,2217,1558]; %t/a
lbgEnergy = [96,46,33,23]; % t GWh/a
water = [198262,113030,82524,68123];
Ntype = ["NH4OH","NH4OH","NH4OH","NH4OH"];
Nmass = [15049,7558,5285,3751];
% N = 0.2*0.777778.*Nmass;
N = [2351,1181,826,586];
Ctype = ["HTCcoal","HTCcoal"];
Cmass = [77678,37872,27704,19417];
PinCproduct = [1471,803,544,417];

productSum4RAA300HTC = table(STFtype,fromSTF,lbgMass,lbgEnergy,water,Ntype,Nmass,N,Ctype,Cmass,PinCproduct);


% 2TUL300HTC

STFtype = ["HTC","HTC"];
fromSTF = [12,65];
lbgMass = [3730,4009]; %t/a
lbgEnergy = [55,59];
Ntype = ["NH4OH","NH4OH"];
Nmass = [14507,8913];
N = [2267,1393];
Ctype = ["HTCcoal","HTCcoal"];
Cmass = [108727,47126];
PinCproduct = [2142,944];
CinCproduct = [19571,8483];
NinCproduct = [1133,485];

productSum2TUL300HTC = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 4TUL300HTC

STFtype = ["HTC","HTC","HTC","HTC"];
fromSTF = [7,17,39,83];
lbgMass = [1924,2467,2048,1743]; %t/a
lbgEnergy = [28,36,30,26]; % GWh/a
Ntype = ["NH4OH","NH4OH","NH4OH","NH4OH"];
Nmass = [8485,7306,4923,3961];
N = [1326,1142,769,619];
Ctype = ["HTCcoal","HTCcoal"];
Cmass = [64329,49044,28110,20461];
PinCproduct = [1221,1009,522,436];
CinCproduct = [11579,8828,5060,3683];
NinCproduct = [648,470,280,227];

productSum4TUL300HTC = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 2RAV300HTC

STFtype = ["HTC","HTC"];
fromSTF = [12,72];
lbgMass = [8462,2733]; %t/a
lbgEnergy = [124,40];
struvite = [2553,484];
PinStruvite = [76,14];
NinStruvite = [34,7];
Ntype = ["NH4OH","NH4OH"];
Nmass = [23255,7177];
N = [3634,1121];
Ctype = ["HTCcoal","HTCcoal"];
Cmass = [100433,32692];
PinCproduct = [884,475];
CinCproduct = [18078,5885];
NinCproduct = [1270,377];

productSum2RAV300HTC = table(STFtype,fromSTF,lbgMass,lbgEnergy,struvite,PinStruvite,NinStruvite,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 4RAV300HTC

STFtype = ["HTC","HTC","HTC","HTC"];
fromSTF = [7,25,39,83];
lbgMass = [3785,2703,1999,1498]; %t/a
lbgEnergy = [55,40,29,22];
struvite = [1621,797,459,211];
PinStruvite = [49,24,14,6];
NinStruvite = [22,11,6,3];
Ntype = ["NH4OH","NH4OH"];
Nmass = [15440,7536,5559,3849];
N = [2413,1178,869,601];
Ctype = ["HTCcoal","HTCcoal","HTCcoal","HTCcoal"];
Cmass = [65442,32383,23833,18063];
PinCproduct = [521,356,285,304];
CinCproduct = [11780,5829,4290,3251];
NinCproduct = [810,389,278,199];

productSum4RAV300HTC = table(STFtype,fromSTF,lbgMass,lbgEnergy,struvite,PinStruvite,NinStruvite,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 2RAA300PYR

STFtype = ["PYR","PYR"];
fromSTF = [12,65];
lbgMass = [10965,4476]; %t/a
lbgEnergy = [160,65];
Ntype = ["NH4OH","NH4OH"];
Nmass = [11038,5169];
% N = 0.2*0.777778.*Nmass;
N = [1725,808];
Ctype = ["PYRcoal","PYRcoal"];
Cmass = [44252,18560];
PinCproduct = [2069,904];
CinCproduct = [14579,6084];
NinCproduct = [1689,658];

productSum2RAA300PYR = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 4RAA300PYR

STFtype = ["PYR","PYR","PYR","PYR"];
fromSTF = [7,25,39,83];
lbgMass = [7727,2755,2665,1856]; %t/a
lbgEnergy = [113,40,39,27]; % t GWh/a
Ntype = ["NH4OH","NH4OH","NH4OH","NH4OH"];
Nmass = [7642,3853,2823,1972];
% N = 0.2*0.777778.*Nmass;
N = [1194,602,441,308];
Ctype = ["PYRcoal","PYRcoal","PYRcoal","PYRcoal"];
Cmass = [30984,15105,10907,7766];
PinCproduct = [1398,763,517,396];
CinCproduct = [7086,3437,2481,1763];
NinCproduct = [1179,568,414,289];

productSum4RAA300PYR = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 2NYK300PYR

STFtype = ["PYR","PYR"];
fromSTF = [12,72];
lbgMass = [4798,2601]; %t/a
lbgEnergy = [70,38];
Ntype = ["NH4OH","NH4OH"];
Nmass = [5212,3163];
% N = 0.2*0.777778.*Nmass;
N = [814,494];
Ctype = ["PYRcoal","PYRcoal"];
Cmass = [47294,14241];
PinCproduct = [2212,702];
CinCproduct = [11020,3306];
NinCproduct = [1714,520];

productSum2NYK300PYR = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 4NYK300PYR

STFtype = ["PYR","PYR","PYR","PYR"];
fromSTF = [6,21,34,72];
lbgMass = [2010,1825,2311,1772]; %t/a
lbgEnergy = [29,27,34,26]; % GWh/a
Ntype = ["NH4OH","NH4OH","NH4OH","NH4OH"];
Nmass = [2183,1955,2449,1944];
N = [341,305,383,304];
Ctype = ["PYRcoal","PYRcoal","PYRcoal","PYRcoal"];
Cmass = [26616,12708,14407,9420];
PinCproduct = [1225,576,736,468];
CinCproduct = [6238,2916,3358,2169];
NinCproduct = [935,484,538,343];

productSum4NYK300PYR = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 2TUL300PYR

STFtype = ["PYR","PYR"];
fromSTF = [12,65];
lbgMass = [5026,4779]; %t/a
lbgEnergy = [73,70];
Ntype = ["NH4OH","NH4OH"];
Nmass = [4886,4442];
N = [763,694];
Ctype = ["PYRcoal","PYRcoal"];
Cmass = [40981,18729];
PinCproduct = [2035,896];
CinCproduct = [10396,4295];
NinCproduct = [1542,685];

productSum2TUL300PYR = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 4TUL300PYR

STFtype = ["PYR","PYR","PYR","PYR"];
fromSTF = [7,17,39,83];
lbgMass = [2712,3107,2467,2042]; %t/a
lbgEnergy = [40,45,36,30]; % GWh/a
Ntype = ["NH4OH","NH4OH","NH4OH","NH4OH"];
Nmass = [2618,2984,2223,2031];
N = [409,466,347,317];
Ctype = ["PYRcoal","PYRcoal","PYRcoal","PYRcoal"];
Cmass = [24169,18812,11024,8163];
PinCproduct = [1160,958,496,414];
CinCproduct = [6162,4620,2587,1865];
NinCproduct = [915,672,406,305];

productSum4TUL300PYR = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct);

% 2RAV300PYR

STFtype = ["PYR","PYR"];
fromSTF = [12,72];
lbgMass = [10091,1919]; %t/a
lbgEnergy = [148,28];
Ntype = ["NH4OH","NH4OH"];
Nmass = [11786,1927];
N = [1842,301];
Ctype = ["PYRcoal","PYRcoal"];
Cmass = [41630,9494];
PinCproduct = [930,477];
CinCproduct = [10927,3433];
NinCproduct = [1808,353];
struvite = [2553,0];
PinStruvite = [76,0];
NinStruvite = [34,0];

productSum2RAV300PYR = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct,struvite,PinStruvite,NinStruvite);

% 4RAV300PYR

STFtype = ["PYR","PYR","PYR","PYR"];
fromSTF = [7,25,39,83];
lbgMass = [6598,3210,2391,1819]; %t/a
lbgEnergy = [96,47,35,27]; % GWh/a
Ntype = ["NH4OH","NH4OH","NH4OH","NH4OH"];
Nmass = [7675,3722,2732,1893];
N = [1199,582,427,296];
Ctype = ["PYRcoal","PYRcoal","PYRcoal","PYRcoal"];
Cmass = [27810,14718,11273,8971];
PinCproduct = [582,424,355,372];
CinCproduct = [6414,3404,2626,2100];
NinCproduct = [1204,620,472,352];
struvite = [1511,693,408,0];
PinStruvite = [45,21,12,0];
NinStruvite = [20,9,5,0];

productSum4RAV300PYR = table(STFtype,fromSTF,lbgMass,lbgEnergy,Ntype,Nmass,N,Ctype,Cmass,PinCproduct,CinCproduct,NinCproduct,struvite,PinStruvite,NinStruvite);

%% ------------------ first nitrogen products ----------%


%% nitrogen product transport

% choose the scenario
productSumCurrent = productSum4RAV300PYR;

% table basis with needed info
ammoniumNeedTable = table((1:size(mills,1))',(mills.Yritys),(mills.Kunta),(mills.Lat),(mills.Lon),(mills.TyppivedenTarve),zeros(size(mills,1),1));
ammoniumNeedTable.Properties.VariableNames = {'MillNumber','Company','Municipality','Lat','Lon','AmmoniumNeed','AmmoniumTransported'};

% let's start transporting ammonium solution
% HERE THE TRUCKLOAD IS 40 T, NOT 45 T
truckLoad = 40;
% how much nitrogen there is in ammonium from different stfs
Npercentage = productSumCurrent.N ./ productSumCurrent.Nmass;

indSTF = productSumCurrent.fromSTF;

% table where to save product transport info
dist = zeros(1,length(indSTF));
distDeNOx = zeros(1,length(indSTF));
transportedLoads = zeros(1,length(indSTF));
transportedAmmonium = zeros(1,length(indSTF));
transportedNitrogen = zeros(1,length(indSTF));
transportedLoadsDeNOx = zeros(1,length(indSTF));
transportedAmmoniumDeNOx = zeros(1,length(indSTF));
transportedNitrogenDeNOx = zeros(1,length(indSTF));
fromSTF = productSumCurrent.fromSTF;
STFtype = productSumCurrent.STFtype;
ammoniumTransportInfo = table(STFtype,fromSTF,dist,transportedLoads,transportedAmmonium,transportedNitrogen,distDeNOx,transportedLoadsDeNOx,transportedAmmoniumDeNOx,transportedNitrogenDeNOx);

% first, let's check if we have more product than what is the need
if sum(ammoniumNeedTable.AmmoniumNeed) < sum(productSumCurrent.Nmass)
    % if so, we will add nitrogen need for DeNOx
    Nextra = sum(productSumCurrent.Nmass) - sum(ammoniumNeedTable.AmmoniumNeed);
    % it is shared for all mills based on their ammonium needs
    % we need to add a bit extra because of the truckload size!
    ammoniumNeedTable.DeNOxneed = ammoniumNeedTable.AmmoniumNeed ./ sum(ammoniumNeedTable.AmmoniumNeed) .* (Nextra*1.3);
    ammoniumNeedTable.DeNOxTransported(:) = 0;
end

% how many loads
loadsLeft = floor(productSumCurrent.Nmass/truckLoad);

% we want to tranport loads from each STF one by one so that they are
% transported to the mills in a smart way

maxLoads = max(loadsLeft);

for i = 1:maxLoads

    % one STF at a time
    for j = 1:length(indSTF)
    %     while loadsLeft(j) > 0
            
        % STF still has loads, one load is transported
        if loadsLeft(j) > 0
    
            % indices of the mills that can still receive phosphorus
            indMills = ammoniumNeedTable.MillNumber(ammoniumNeedTable.AmmoniumNeed >= truckLoad);
            
            % if there is need -> let's transport
            if ~isempty(indMills)
    
                % find the closest citycenter from those that can receive
                % ammonium
                transportToMills = millDistances(indSTF(j),indMills);
                [distClosest, millClosest] = min(transportToMills);    
                indMillClosest = indMills(millClosest);
        
                % let's save info
                ammoniumTransportInfo.dist(j) = ammoniumTransportInfo.dist(j) + distClosest;
                ammoniumTransportInfo.transportedLoads(j) = ammoniumTransportInfo.transportedLoads(j) +1;
        
                % let's update stock and mill's ammonium need
                loadsLeft(j) = loadsLeft(j) - 1;
                productSumCurrent.Nmass(j) = productSumCurrent.Nmass(j) - truckLoad;
        
                ammoniumNeedTable.AmmoniumTransported(indMillClosest) = ammoniumNeedTable.AmmoniumTransported(indMillClosest) + truckLoad;
                ammoniumNeedTable.AmmoniumNeed(indMillClosest) = ammoniumNeedTable.AmmoniumNeed(indMillClosest) - truckLoad;
                
            % if there is no more need, we will use the DeNOx need
            else
                % let's find mills that can receive ammonium for DeNOx
                indMills = ammoniumNeedTable.MillNumber(ammoniumNeedTable.DeNOxneed >= truckLoad);
                
                % find the closest citycenter from those that can receive it
                transportToMills = millDistances(indSTF(j),indMills);
                [distClosest, millClosest] = min(transportToMills);    
                indMillClosest = indMills(millClosest);
        
                % let's save info
                ammoniumTransportInfo.distDeNOx(j) = ammoniumTransportInfo.distDeNOx(j) + distClosest;
                ammoniumTransportInfo.transportedLoadsDeNOx(j) = ammoniumTransportInfo.transportedLoadsDeNOx(j) +1;
        
                % let's update stock and mill's denox ammonium need
                loadsLeft(j) = loadsLeft(j) - 1;
                productSumCurrent.Nmass(j) = productSumCurrent.Nmass(j) - truckLoad;
        
                ammoniumNeedTable.DeNOxTransported(indMillClosest) = ammoniumNeedTable.DeNOxTransported(indMillClosest) + truckLoad;
                ammoniumNeedTable.DeNOxneed(indMillClosest) = ammoniumNeedTable.DeNOxneed(indMillClosest) - truckLoad;
    
            end
    
        end
    end

end

ammoniumTransportInfo.transportedAmmonium = ammoniumTransportInfo.transportedLoads .* truckLoad;
ammoniumTransportInfo.transportedNitrogen = ammoniumTransportInfo.transportedAmmonium .* Npercentage;

ammoniumTransportInfo.transportedAmmoniumDeNOx = ammoniumTransportInfo.transportedLoadsDeNOx .* truckLoad;
ammoniumTransportInfo.transportedNitrogenDeNOx = ammoniumTransportInfo.transportedAmmoniumDeNOx .* Npercentage;

%% visualization

% mills on map

% all the mills
millPoints = geopoint(mills.Lat,mills.Lon);
wmmarker(millPoints,'Icon','point_lightblue.png','IconScale',0.3)

% mills that received the nitrogen product
indSquares = ammoniumNeedTable.MillNumber(ammoniumNeedTable.AmmoniumTransported ~= 0);
millSquares = geopoint(mills.Lat(indSquares),mills.Lon(indSquares));
wmmarker(millSquares,'Icon','square-blue3.png','IconScale',0.4)

% STFs
gridP = geopoint(gridPoints(indSTF,1),gridPoints(indSTF,2));
wmmarker(gridP,'Icon','yellow-dot.png','IconScale',0.4)

%% fuel consumption
% for ammonium transportation

% LBG consumption, full and empty truck
consumptionLBGfull = 30; %kg/100km
consumptionLBGempty = 27; %kg/100km

% diesel consumption
consumptiondieselfull = 37.5; %l/100km
consumptiondieselempty = 35; %l/100km

% VALITSE TÄÄLLÄ
kms = ammoniumTransportInfo.dist;
% kms = transportInfoAmmonium.distDeNOx;

% how much total
LBGfull = kms/100*consumptionLBGfull/1000; % t kg
LBGempty = kms/100*consumptionLBGempty/1000; % t kg
dieselfull = kms/100*consumptiondieselfull/1000; % t l
dieselempty = kms/100*consumptiondieselempty/1000; % t l
LBGtotal = LBGfull + LBGempty; % t kg
dieseltotal = dieselfull + dieselempty; % t l

% results
consumption = table(LBGfull,LBGempty,LBGtotal,dieselfull,dieselempty,dieseltotal);

%% -------------- next coal products -----------%

%% HTC coal / Pyrolysis coal
% Coal is transported to the municipalities for fertilization
% Its need is determined based on its phosphorus contents and
% municipalities' phosphorus needs

% choose the scenario
productSumCurrent = productSum4RAV300PYR;

% if Ravita scenario, run first isCoal, see the results and run after that isStruvite
% if not a Ravita scenario, there is only coal
isCoal = 1;
isStruvite = 0;

%-----------%

% let's create a table that tells how much a municipality can receive
% phosphorus IN ONE YEAR
% it is not created again, if struvite is transported after coal
if isCoal == 1
    phosphorusNeedLeft = table((1:length(muni))',[muni.CenterLat]',[muni.CenterLon]',[muni.PhosphorusNeed]');
    phosphorusNeedLeft.Properties.VariableNames = {'MuniNumber','CenterLat','CenterLon','PhosphorusNeed'};
end

% let's start transporting HTC coal
truckLoad = 45; % t
% nutrient amount in C product is different in different STFs
if isCoal == 1
    PinTruckload = productSumCurrent.PinCproduct./productSumCurrent.Cmass.*truckLoad; % t
    Ppercentage = productSumCurrent.PinCproduct ./ productSumCurrent.Cmass;
    Cpercentage = productSumCurrent.CinCproduct ./ productSumCurrent.Cmass;
    Npercentage = productSumCurrent.NinCproduct ./ productSumCurrent.Cmass;
elseif isStruvite == 1
    PinTruckload = productSumCurrent.PinStruvite./productSumCurrent.struvite.*truckLoad; % t
    Ppercentage = productSumCurrent.PinStruvite ./ productSumCurrent.struvite;
    Cpercentage = 0;
    Npercentage = productSumCurrent.NinStruvite ./ productSumCurrent.struvite;
end
    indSTF = productSumCurrent.fromSTF;

% table where to save the coal product transport info
dist = zeros(size(indSTF));
transportedLoads = zeros(size(indSTF));
transportedMass = zeros(size(indSTF));
transportedPhosphorus = zeros(size(indSTF));
transportedC = zeros(size(indSTF));
coalTransportInfo = table(indSTF,dist,transportedLoads,transportedMass,transportedPhosphorus,transportedC);

% how many loads
if isCoal == 1
    loadsLeft = floor(productSumCurrent.Cmass/truckLoad);
elseif isStruvite == 1
    loadsLeft = floor(productSumCurrent.struvite/truckLoad);
end

% one STF at a time
for j = 1:length(indSTF)
    while loadsLeft(j) > 0
        
        % indices of the municipalities that can still receive phosphorus
        indMunis = phosphorusNeedLeft.MuniNumber(phosphorusNeedLeft.PhosphorusNeed >= PinTruckload(j));
        % find the closest citycenter from those
        transportToCities = muniDistances(indSTF(j),indMunis);
        [distClosest, muniClosest] = min(transportToCities);    
        indMuniClosest = indMunis(muniClosest);

        % let's save info
        coalTransportInfo.dist(j) = coalTransportInfo.dist(j) + distClosest;
        coalTransportInfo.transportedLoads(j) = coalTransportInfo.transportedLoads(j) +1;

        % let's update coal/struvite amount in STF and muni phosphorus need
        loadsLeft(j) = loadsLeft(j) - 1;
        if isCoal == 1
            productSumCurrent.Cmass(j) = productSumCurrent.Cmass(j) - truckLoad;
        elseif isStruvite == 1
            productSumCurrent.struvite(j) = productSumCurrent.struvite(j) - truckLoad;
        end
        % phosphorus need: not coal, but phosphorus in it!
        phosphorusNeedLeft.PhosphorusNeed(indMuniClosest) = phosphorusNeedLeft.PhosphorusNeed(indMuniClosest) - PinTruckload(j);
    end
end
            
% results
coalTransportInfo.transportedMass = coalTransportInfo.transportedLoads .* truckLoad;
coalTransportInfo.transportedPhosphorus = coalTransportInfo.transportedMass .* Ppercentage;
coalTransportInfo.transportedC = coalTransportInfo.transportedMass .* Cpercentage;
coalTransportInfo.transportedN = coalTransportInfo.transportedMass .* Npercentage;

%% fuel consumption
% of coal transportation

% LBG consumption, full and empty truck
consumptionLBGfull = 30; %kg/100km
consumptionLBGempty = 27; %kg/100km

% diesel consumption
consumptiondieselfull = 37.5; %l/100km
consumptiondieselempty = 35; %l/100km

kms = coalTransportInfo.dist;

% how much total
LBGfull = kms/100*consumptionLBGfull/1000; % t kg
LBGempty = kms/100*consumptionLBGempty/1000; % t kg
dieselfull = kms/100*consumptiondieselfull/1000; % t l
dieselempty = kms/100*consumptiondieselempty/1000; % t l
LBGtotal = LBGfull + LBGempty; % t kg
dieseltotal = dieselfull + dieselempty; % t l

% results
consumption = table(LBGfull,LBGempty,LBGtotal,dieselfull,dieselempty,dieseltotal);

%% -------------- next LBG -----------%

%% LBG transport

% choose the scenario
productSumCurrent = productSum4RAV300HTC;

% how much LBG was produced
LBGproduced = productSumCurrent.lbgMass;

% REMEMBER TO UPDATE
% how much different transportations have used LBG
% Found in LCA excel, choose the right tab according to the scenario
% consumption in tn/a for sludge and each product
% separately for each STF, consumption of full truck and empty truck should be summed

% Sludge transportation from excel: Lietteen kuljetus, LBG kulutus tn/a
% if two STFs:
% [1st STF full + 1st STF empty, 2nd STF full + 2nd STF empty]
% if four STFs:
% [1st STF full + 1st STF empty, 2nd STF full + 2nd STF empty, 3rd STF full + 3rd STF empty, 4th STF full + 4th STF empty]
% For example, scenario 4RAV300HTC:
% LBGsludge = [94+85,83+75,78+70,65+58];
LBGsludge = [94+85,83+75,78+70,65+58];

% Product transportation consumptions from 'Tuotteiden kuljetus' in excel
% If ammoniakkiliuos and ammoniakkiliuos DeNOx-käyttöön both exist, they
% are both added in LBGProductN. For example, scenario 4RAV300HTC:
% LBGproductN = [15+14+15+14,13+11,5+5,3+3];
LBGproductN = [15+14+15+14,13+11,5+5,3+3];
% If coal product and struvite both exist (Ravita scenarios), they are both
% added in LBGProductP. For example, scenario 4RAV300HTC:
% LBGproductC = [14+13+1+1,3+3,4+4,5+5];
LBGproductC = [14+13+1+1,3+3,4+4,5+5];

% how much LBG is left after transportations
LBGleft = LBGproduced-LBGsludge-LBGproductN-LBGproductC;

% let's guess how much we need to transport the rest of the LBG to stations
% first you can try this:
% LBGneeded = LBGproductN./3;

% then you can check the results, round them up to the closest integer and fill the real consumption needs for LBG
% For example, scenario 4RAV300HTC:
% LBGneeded = [1,3,3,1];
LBGneeded = [1,3,3,1];

% ---------------- %

% so, the amount of LBG that's transported to the LBG stations:
LBGleft = LBGleft-LBGneeded;

% LBG need in stations
% 200 t/kk -> 2400 t/a each station

LBGstations.LBGtarve(:) = 2400;

% let's start transporting LBG
truckLoad = 40; % t
% it is always transported to two stations: 20 t each

% table where to save the LBG transport info
indSTF = productSumCurrent.fromSTF;
dist = zeros(size(indSTF));
transportedLoads = zeros(size(indSTF));
LBGtransportInfo = table(indSTF,dist,transportedLoads);

% how many loads
loadsLeft = floor(LBGleft./truckLoad);

% one STF at a time
for j = 1:length(indSTF)
    while loadsLeft(j) > 0
        
        % indices of the stations that can still receive LBG
        indStations = LBGstations.stationNumber(LBGstations.LBGtarve >= truckLoad/2);
        % find the closest station from those that can receive LBG
        transportToStations = LBGstationDistances(indSTF(j),indStations);
        [distClosest, stationClosest] = min(transportToStations);    
        indStationClosest = indStations(stationClosest);

        % let's save info
        LBGtransportInfo.dist(j) = LBGtransportInfo.dist(j) + distClosest;

        % let's update the station need
        LBGstations.LBGtarve(indStationClosest) = LBGstations.LBGtarve(indStationClosest) - truckLoad/2;

        % then we still have half of the truckload left

        % we remove the one we just transported the LBG from the list of stations that can still receive LBG
        indStations = indStations(indStations ~= indStationClosest);
        % find the closest station from those that can receive LBG
        % use the distances from station to station!
        transportToStations = station2stationDistances(indStationClosest,indStations);
        [distClosest, stationClosest] = min(transportToStations);    
        % now we have a new station
        indStationClosest = indStations(stationClosest);

        % let's save info
        LBGtransportInfo.dist(j) = LBGtransportInfo.dist(j) + distClosest;
        % only now we have transported the whole load
        LBGtransportInfo.transportedLoads(j) = LBGtransportInfo.transportedLoads(j) +1;

        % let's update LBG amount in STF and station need
        loadsLeft(j) = loadsLeft(j) - 1;
        LBGleft(j) = LBGleft(j) - truckLoad;
        LBGstations.LBGtarve(indStationClosest) = LBGstations.LBGtarve(indStationClosest) - truckLoad/2;
    
    end
end

% results in LBGtransportInfo

%% visualization

% all stations on map
stationPoints = geopoint(LBGstations.Lat,LBGstations.Lon);
wmmarker(stationPoints,'Icon','point_lightblue.png','IconScale',0.3)

% stations that received LBG
indSquares = LBGstations.stationNumber(LBGstations.LBGtarve < 2400);
stationSquares = geopoint(LBGstations.Lat(indSquares),LBGstations.Lon(indSquares));
wmmarker(stationSquares,'Icon','square-blue3.png','IconScale',0.4)

% STFs
gridP = geopoint(gridPoints(indSTF,1),gridPoints(indSTF,2));
wmmarker(gridP,'Icon','yellow-dot.png','IconScale',0.4)

%% fuel consumption
% of LBG transportation

% LBG consumption, full and empty truck
consumptionLBGfull = 30; %kg/100km
consumptionLBGempty = 27; %kg/100km

% diesel consumption
consumptiondieselfull = 37.5; %l/100km
consumptiondieselempty = 35; %l/100km

kms = LBGtransportInfo.dist;

% how much total
LBGfull = kms/100*consumptionLBGfull/1000; % t kg
LBGempty = kms/100*consumptionLBGempty/1000; % t kg
dieselfull = kms/100*consumptiondieselfull/1000; % t l
dieselempty = kms/100*consumptiondieselempty/1000; % t l
LBGtotal = LBGfull + LBGempty; % t kg
dieseltotal = dieselfull + dieselempty; % t l

% results
consumption = table(LBGfull,LBGempty,LBGtotal,dieselfull,dieselempty,dieseltotal);
