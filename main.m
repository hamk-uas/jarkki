% main script of the sludge transport simulation model

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

% load data
load('data.mat');
    % currentDistances: distances (in kms via roads) from each wwtp
    %                   (wastewater treatment plant) to each current plant
    % currentTransportInfo: simulation results of transporting sludge from
    %                       wwtps to current plants
    % distances: distances (in kms via roads) from each wwtp to each gridpoint
        % distancesNYK: current scenario wwtps
        % distancesTUL: future scenario wwtps
        % distancesRAV: Ravita scenario wwtps
    % fieldAreas: all field area info for each municipality (every year, different species)
    % gridPointCombsOK: gridpoint combinations that pass the condition of
    %                   minimum energy, for different scenarios
    % gridPoints: potential locations for centralized sludge treatment facilities (STF)
    % LBGstationDistances: distances (in kms via roads) from each gridpoint to each LBG station
    % LBGstations: current LBG stations from Gasum's website
    % millDistances: distances (in kms via roads) from each gridpoint to each mill
    % mills: potential users for N product
    % muni: information about all the municipalities in Finland
    % muniDistances: distances (in kms via roads) from each gridpoint to each municipality
    % needPhosphorus: yearly phosphorus need for each municipality
    % nutrientClasses: proportions of each nutrient classes in each municipality
    % nutrients: info about nutrients for all the municipalities
    % plants: info about the current treatment plants
    % sludgeLoads: information about sludge loads produced in one year in all wwtps
        % sludgeLoadsNYK: scenario of the current situation
        % sludgeLoadsRAA: scenario where all the sludge is raw
        % sludgeLoadsKUI: scenario of higher total solids percentage
        % sludgeLoadsTUL: future scenario
        % sludgeLoadsRAV: Ravita scenario
    % sludgeWWTP: information about sludge produced in one year in each WWTP
        % similarly for different scenarios
    % soiltypes: info about the soiltypes in municipalities
    % station2stationDistances: distances (in kms via roads) between LBG stations
    % token: Mapbox token that is needed for the distance searches in get_distances
    % transportInfo: simulation results, for different scenarios:
        % 2/4 -> number of STFs
        % NYK -> current, RAA -> raw sludge, KUI -> better TS-%, TUL -> future, RAV -> Ravita
        % if 300 -> maximum transport distance 300 km, sludge from wwtps too far away not transported
        % if opt -> STF locations optimized with maximum distance and minimum energy
    % wwtp: info about wastewater treatment facilities (WWTP)
        % wwtpNYK: current scenario
        % wwtpTUL: future scenario
        % wwtpRAV: Ravita scenario
    
%% updating data

% if some data needs updating, do it here
    % 0 -> no update, 1 -> update
% visualization can be done here as well
    % 0 -> no visualization, 1 -> visualization

% you need to check the filepaths when updating!

% do you want to update info about wastewater treatment facilities (WWTP) from a file?
% remember to update necessary distances if you do this!
% remember to check the range!
WWTPupdateNYK = 0;
WWTPmapNYK = 0;

% do you want to update info about future WWTP scenario from a file?
% remember to update necessary distances if you do this!
% remember to check the range!
WWTPupdateTUL = 0;
WWTPmapTUL = 0;

% do you want to update info about Ravita WWTP scenario from a file?
% remember to update necessary distances if you do this!
% remember to check the range!
WWTPupdateRAV = 0;
WWTPmapRAV = 0;

% do you want to create grid of potential locations for STFs (sludge treatment facilities)?
createGrid = 0;
createGridMap = 0;

% do you want to read current treatment plant locations from a file?
currentPlantsRead = 0;
currentPlantsMap = 0;

% do you want to simulate transportation from WWTPs to current plants?
currentPlantsTransport = 0;

% do you want to get distances from Mapbox from each wwtp to each gridpoint?
% check the token and check that you have free Mapbox searches left or get
% ready to pay for it
distancesGetNYK = 0;

% do you want to get distances from Mapbox from each future wwtp to each gridpoint?
distancesGetTUL = 0; 

% do you want to get distances from Mapbox from each Ravita wwtp to each gridpoint?
distancesGetRAV = 0; 

% do you want to get distances from Mapbox from each wwtp to each current plant?
distancesCurrentGet = 0;

% do you want to update info about municipalities from a shapefile?
% If done, you should update also nutrient, muni center etc info
municipalitiesGet = 0;
% do you want to see municipalities on a map?
municipalitiesMap = 0;

% do you want to read info about phosphorus in municipalities from a file
% and update info to the muni?
phosphorusGet = 0;
% do you want to visualize municipalities' phophorus rate?
phosphorusMap = 0;

% do you want to read info about phosphorus classes in municipalities from a file?
PclassesGet = 0;

% do you want to read info about municipalities' centers from a file
% and update info to the muni?
centersUpdate = 0;
% do you want to see the center on a map?
centersMap = 0;

% do you want to read info about municipalities' field areas from a file
% and update info to the muni?
fieldsUpdate = 0;
% do you want to visualize municipalities' field areas?
fieldsMap = 0;
  
% do you want to read info about municipalities' soiltypes from a file
soiltypesUpdate = 0;

% do you want to calculate municipalities' phosphorus needs
% and update it to the muni?
PneedsUpdate = 0;

% do you want to get distances from Mapbox from each gridpoint to each city center?
% remember to check the token and check that you have free Mapbox searches
% left or get ready to pay for it
muniDistancesGet = 0;

% do you want to get distances from Mapbox between each city center?
centerDistancesGet = 0;

% do you want to read forest industry mills / nitrogen product receivers from a file?
millsUpdate = 0;
% do you want to see them on a map?
millsMap = 0;

% do you want to get distances from gridpoints to mills from Mapbox?
millDistancesGet = 0;

% do you want to read forest industry mills / nitrogen product receivers from a file?
LBGstationsUpdate = 0;
% do you want to find coordinates for the addresses?
LBGstationsGetCoordinates = 0;
% show them on map?
LBGstationsMap = 0;

% do you want to get distances from gridpoints to LBG stations from Mapbox?
LBGstationsDistancesGet = 0;

% do you want to get distances from Mapbox between each LBG station?
stationStationDistancesGet = 0;

%---------------------------------------------------%

%---- WWTP update ----%

if WWTPupdateNYK == 1
    % the path for the file
    filePath = strcat(pwd,'\Järkki datafiles\','Laitostiedot_Qgisiin_10.6.2021.xlsx');
    % range of data in that file
    range = 'A12:BO256';
    % read the file
    wwtpNYK = readtable(filePath,'Range',range,'Sheet','Lietemaarat_laitoksittain');
    % this is used to remove the closed down ones
    wwtpNYK = wwtpNYK(~isnan(wwtpNYK.KoordWGSP_piste),:);    
end

if WWTPmapNYK == 1
    wwtpPoints = geopoint([wwtpNYK.KoordWGSP_piste],[wwtpNYK.KoordiWGSI_piste]);
    wmmarker(wwtpPoints,'Icon','point_magenta.png','IconScale',0.25)
end

%---- WWTP update future scenario ----%

if WWTPupdateTUL == 1
    filePath = strcat(pwd,'\Järkki datafiles\','Laitostiedot_Qgisiin_10.6.2021.xlsx');
    range = 'A6:BO239';
    wwtpTUL = readtable(filePath,'Range',range,'Sheet','Muok_Lietemaarat_laitoksittain');
    % this is used to remove the closed down ones if there are any
    wwtpTUL = wwtpTUL(~isnan(wwtpTUL.KoordWGSP_piste),:);    
end

if WWTPmapTUL == 1
    wwtpPointsFuture = geopoint([wwtpTUL.KoordWGSP_piste],[wwtpTUL.KoordiWGSI_piste]);
    wmmarker(wwtpPointsFuture,'Icon','point_magenta.png','IconScale',0.25)
end

%---- WWTP update Ravita scenario ----%

if WWTPupdateRAV == 1
    filePath = strcat(pwd,'\Järkki datafiles\','Laitostiedot_Qgisiin_10.6.2021.xlsx');
    range = 'A11:BT248';
    wwtpRAV = readtable(filePath,'Range',range,'Sheet','Ravita_Raakaliete');
    % this is used to remove the closed down ones if there are any
    wwtpRAV = wwtpRAV(~isnan(wwtpRAV.KoordWGSP_piste),:);    
end

if WWTPmapRAV == 1
    wwtpPointsRavita = geopoint([wwtpRAV.KoordWGSP_piste],[wwtpRAV.KoordiWGSI_piste]);
    wmmarker(wwtpPointsRavita,'Icon','point_magenta.png','IconScale',0.25)
end

%--- create grid ----%

if createGrid == 1
    % how far from each other the gridpoints should be?
    kmsApart = 50;
    % function requires certain shapefiles
    gridPoints = create_gridpoints(wwtpNYK,kmsApart);
end

if createGridMap == 1
    gridP = geopoint(gridPoints(:,1),gridPoints(:,2));
    wmmarker(gridP,'Icon','yellow-dot.png','IconScale',0.4)
end

%---- current treatment plants ----%

if currentPlantsRead == 1
    filePath = strcat(pwd,'\Järkki datafiles\','käsittelylaitokset2019.xlsx');
    range = 'A1:F92';
    plants = readtable(filePath,'Range',range);
end

if currentPlantsMap == 1
    plantPoints = geopoint([plants.WGSP],[plants.WGSI]);
    wmmarker(plantPoints,'Icon','square-blue3.png','IconScale',0.3) 
end

if currentPlantsTransport == 1
    currentTransportInfo = transport_current_plants(plants,currentDistances,sludgeLoadsNYK);
end

%---- distances to gridpoints ----%

if distancesGetNYK == 1
    % function needs inputs as tables
    Lat = wwtpNYK.KoordWGSP_piste;
    Lon = wwtpNYK.KoordiWGSI_piste;
    wwtpNYKCoord = table(Lat,Lon);
    Lat = gridPoints(:,1);
    Lon = gridPoints(:,2);
    gridPointsCoord = table(Lat,Lon);
    % then call the function
    distancesNYK = get_distances_universal(wwtpNYKCoord,gridPointsCoord,token);
end

%---- distances to gridpoints ----%

if distancesGetTUL == 1
    % function needs inputs as tables
    Lat = wwtpTUL.KoordWGSP_piste;
    Lon = wwtpTUL.KoordiWGSI_piste;
    wwtpTULCoord = table(Lat,Lon);
    Lat = gridPoints(:,1);
    Lon = gridPoints(:,2);
    gridPointsCoord = table(Lat,Lon);
    % then call the function
    distancesTUL = get_distances_universal(wwtpTULCoord,gridPointsCoord,token);
end

%---- distances to gridpoints ----%

if distancesGetRAV == 1
    % function needs inputs as tables
    Lat = wwtpRAV.KoordWGSP_piste;
    Lon = wwtpRAV.KoordiWGSI_piste;
    wwtpRAVCoord = table(Lat,Lon);
    Lat = gridPoints(:,1);
    Lon = gridPoints(:,2);
    gridPointsCoord = table(Lat,Lon);
    % then call the function
    distancesRAV = get_distances_universal(wwtpRAVCoord,gridPointsCoord,token);
end

%---- distances to the current plants ----%

if distancesCurrentGet == 1
    Lat = wwtpNYK.KoordWGSP_piste;
    Lon = wwtpNYK.KoordiWGSI_piste;
    wwtpNYKCoord = table(Lat,Lon);
    Lat = plants.WGSP;
    Lon = plants.WGSI;
    plantsCoord = table(Lat,Lon);
    currentDistances = get_distances_universal(wwtpNYKCoord,plantsCoord,token);
end

%---- municipalities info ----%

if municipalitiesGet == 1
    filePath = strcat(pwd,'\Järkki datafiles\shapefiles\');
    fileName = 'SuomenKuntajako_2021_4500k.shp';
    muni = shaperead(strcat(filePath,fileName));
    info = shapeinfo(strcat(filePath,fileName));
    % shapefiles contains different coordinates
    % we need to make a projection to lat, lon
    proj = info.CoordinateReferenceSystem;
    for i=1:length(muni)
       [muni(i).Lat,muni(i).Lon] = projinv(proj,muni(i).X,muni(i).Y);
    end
    muni = rmfield(muni,{'X','Y'});
end 

if municipalitiesMap == 1
    g = geoshape(muni);
    colors = parula(length(muni));
    wmpolygon(g,'Facecolor',colors);
end

%---- phosphorus in municipalities ----%

if phosphorusGet == 1
    filePath = strcat(pwd,'\Järkki datafiles\Ravinteisuus\tilasto_kunnat_happ_rav.xls');
    range = 'A28:M338';
    nutrients = readtable(filePath,'Range',range);
    muniWithNutrients = muni;
    % let's add phosphorus rate to 'muni' geostruct
    for i = 1:length(muni)
        [~,idx] = ismember(muni(i).NAMEFIN,nutrients.KuntienTiedot);
        % check swedish name if it's not found by finnish name
        if idx == 0
            [~,idx] = ismember(muni(i).NAMESWE,nutrients.KuntienTiedot);
        end
        % if it's found, save the phosphorus info to 'muni'
        if idx ~= 0
            muniWithNutrients(i).Phosphorus = nutrients.Fosfori_P_Mg_l(idx);
        end
    end
    muni = muniWithNutrients;
end

if phosphorusMap == 1
    worldmap([59 71],[18 33])
    setm(gca,'MapProjection','mercator')
    faceColors = makesymbolspec('Polygon',{'Phosphorus',[floor(min(nonzeros([muni.Phosphorus]))) 25],'FaceColor',cool},{'Phosphorus',[25 ceil(max(nonzeros([muni.Phosphorus])))],'FaceColor',[1,0,0]});
    geoshow(muni,'DisplayType','Polygon','SymbolSpec',faceColors)
    caxis([5 25])
    colormap(cool)
    h = colorbar;
    h.Label.String = 'Phosphorus rate in soil (mg/l)';
end
    
%---- phosphorus classes ----%

if PclassesGet == 1
    filePath = strcat(pwd,'\Järkki datafiles\Ravinteisuus\kaikki_rav_luokittain.xls');
    nutrientClasses = readtable(filePath,'ReadRowNames',true,'ReadVariableNames',true);
end

%--- municipalities' centers ----% 

if centersUpdate == 1
    filePath = strcat(pwd,'\Järkki datafiles\Ravinteisuus\kunnat_koordinaatit_keskustat.xlsx');
    range = 'A1:C312';
    centers = readtable(filePath,'Range',range);
    % let's add this info to 'muni' geostruct
    muniWithCenters = muni;
    for i = 1:length(muni)
        [~,idx] = ismember(muni(i).NAMEFIN,centers.Kunta);
        % check swedish name if it's not found by finnish name
        if idx == 0
            [~,idx] = ismember(muni(i).NAMESWE,centers.Kunta);
        end
        % if it's found, save the center lat&lon info
        if idx ~= 0
            muniWithCenters(i).CenterLat = str2double(centers.Lat{idx,1});
            muniWithCenters(i).CenterLon = str2double(centers.Lon{idx,1});
        end
    end
    muni = muniWithCenters;
end

if centersMap == 1
    centerPoints = geopoint([muni.CenterLat],[muni.CenterLon]);
    wmmarker(centerPoints,'Icon','pallo3.png','IconScale',0.3)
end

%---- field areas ----%

if fieldsUpdate == 1
    filePath = strcat(pwd,'\Järkki datafiles\Ravinteisuus\Luke_Maa_KMM_02_20210803-142046.xlsx');
    range = 'A3:AI2571';
    % average of 2018-2020 is calculated in the function
    [muni,fieldAreas,averageAreas] = read_fieldarea(muni,filePath,range);
end

if fieldsMap == 1
    coast = shaperead('landareas.shp','UseGeoCoords',true,'RecordNumbers',2);
    % Files downloaded from Maanmittauslaitos
    valtio = shaperead(strcat(pwd,'\Järkki datafiles\Ravinteisuus\TietoaKuntajaosta_ESRI_2021_4500k\SuomenValtakunta_2021_4500k.shp'));
    valtio_info = shapeinfo(strcat(pwd,'\Järkki datafiles\Ravinteisuus\TietoaKuntajaosta_ESRI_2021_4500k\SuomenValtakunta_2021_4500k.shp'));
    valtio_proj = valtio_info.CoordinateReferenceSystem;
    [valtio.lat,valtio.lon] = projinv(valtio_proj,valtio.X,valtio.Y);
    worldmap([59 71],[18 33])
    setm(gca,'MapProjection','mercator')
    geoshow(coast,'FaceColor',[224/256, 224/256, 224/256]) % light grey
    setm(gca,'ffacecolor',[189/256,228/256,234/256]) % lighter blue
    colors = flipud(summer);
    myColorMap = customcolormap([0 0.5 0.75 1],[colors(256,:); colors(171,:); colors(85,:); colors(1,:)]);
    faceColors = makesymbolspec('Polygon',{'FieldArea',[floor(min(nonzeros([muni.FieldArea]))) ceil(max(nonzeros([muni.FieldArea])))],'FaceColor',myColorMap});
    geoshow(muni,'DisplayType','Polygon','SymbolSpec',faceColors)
    caxis([floor(min(nonzeros([muni.FieldArea]))) ceil(max(nonzeros([muni.FieldArea])))]);
    colormap(myColorMap)
    h = colorbar;
    h.Label.String = 'Field area in a municipality (ha)';
end

%---- soiltypes ----%

if soiltypesUpdate == 1
    filePath = strcat(pwd,'\Järkki datafiles\','maalajit2005-2009.xlsx');
    soiltypes = read_soiltypes(filePath);
end

%---- phosphorus needs ----%

if PneedsUpdate == 1
    [muni,needPhosphorus] = calculate_phosphorus_need(muni,nutrientClasses);
end

%---- distances for phosphorus transport from gridPoints to munis ----%

if muniDistancesGet == 1
    Lat = gridPoints(:,1);
    Lon = gridPoints(:,2);
    gridPointsCoord = table(Lat,Lon);
    Lat = [muni.CenterLat]';
    Lon = [muni.CenterLon]';
    muniCoord = table(Lat,Lon); 
    muniDistances = get_distances_universal(gridPointsCoord,muniCoord,token);
end

%---- distances between city centers ----%

if centerDistancesGet == 1
    Lat = [muni.CenterLat]';
    Lon = [muni.CenterLon]';
    muniCoord = table(Lat,Lon); 
    muni2muniDistances = get_distances_universal(muniCoord,muniCoord,token);
end

%---- forest industry ----%

if millsUpdate == 1
    filePath = strcat(pwd,'\Järkki datafiles\','Metsäteollisuus_tehtaat.xlsx');
    mills = readtable(filePath);
end


if millsMap == 1
    millPoints = geopoint([mills.Lat],[mills.Lon]);
    wmmarker(millPoints,'Icon','pallo4.png','IconScale',0.3) 
end

%---- distances from gridpoints to mills ----%

if millDistancesGet == 1
    Lat = gridPoints(:,1);
    Lon = gridPoints(:,2);
    gridPointsCoord = table(Lat,Lon);
    millDistances = get_distances_universal(gridPointsCoord,mills,token);
end

%---- LBG stations ----%

if LBGstationsUpdate == 1
    filePath = strcat(pwd,'\Järkki datafiles\LBG_tankkausasemat.xlsx');
    LBGstations = readtable(filePath);
    % numbers for stations to identify them
    stationNumber = (1:size(LBGstations,1))';
    LBGstations = addvars(LBGstations,stationNumber,'Before','Yritys');
end

if LBGstationsGetCoordinates == 1
    LBGstations = LBGstations_get_coordinates(LBGstations,token);
end

if LBGstationsMap == 1
    LBGpoints = geopoint([LBGstations.Lat],[LBGstations.Lon]);
    wmmarker(LBGpoints,'Icon','point_red.png','IconScale',0.3)
end

if LBGstationsDistancesGet == 1
    Lat = gridPoints(:,1);
    Lon = gridPoints(:,2);
    gridPointsCoord = table(Lat,Lon);
    LBGstationDistances = get_distances_universal(gridPointsCoord,LBGstations,token);
end

if stationStationDistancesGet == 1
    station2stationDistancesTest = get_distances_universal(LBGstations,LBGstations,token);
end

%% saving variables

% uncomment if you want to save a variable
% save('data.mat','currentTransportInfo','-append')

%% sludge loads
% simulates the sludge production and saves the sludge loads

% no need to run this if there are no changes in the wwtp data
    
% choose max 1 scenario, you cannot mix the scenarios
% if no scenario is chosen, the current situation is simulated

% do we consider the scenario where all the sludge is raw?
isRaw = 1;

% do we consider the scenario where TS for raw is 25 % and for digested 35 %?
betterTS = 0;

% do we consider the future scenario?
isFuture = 0;

% do we consider the Ravita scenario?
isRavita = 0;

if isFuture == 1
    wwtpCurrent = wwtpTUL;
elseif isRavita == 1
    wwtpCurrent = wwtpRAV;
else
    wwtpCurrent = wwtpNYK;
end

% one-year simulation
daysSimulated = 365;
% truck capacity in tons
truckLoad = 45;

% initialize table for sludge production 
    % variables
    day = zeros(size(wwtpCurrent,1),1);
    wwtpName = strcat(wwtpCurrent.Yritys,'; ',wwtpCurrent.KohdeNimi);
    currentMass = zeros(size(wwtpCurrent,1),1);
    sludgeType = strings(size(wwtpCurrent,1),1);
    sludgeType(:) = 'Raw';
    loadNumber = zeros(size(wwtpCurrent,1),1);

if isRavita == 1
    truckLoadsShare = truckLoad ./ wwtpCurrent.RAVITA_KuljetettavaLietem__r__t_a_OletetussaKuiva_ainepitoisuud;
    dailyLoad = wwtpCurrent.RAVITA_KuljetettavaLietem__r__t_a_OletetussaKuiva_ainepitoisuud/365;
    TSpercentageAll = wwtpCurrent.RAVITA_LaskeutetunLietteenKuiva_aine_tTS_a_IlmanM_d_tyst___20__./wwtpCurrent.RAVITA_KuljetettavaLietem__r__t_a_OletetussaKuiva_ainepitoisuud;
    % we need to follow separately ravita sludge
    indRavita = ~cellfun(@isempty,wwtpCurrent.LieteOnRavitaa);
    sludgeType(indRavita) = 'Ravita';
else
    if isFuture == 1
        truckLoadsShare = truckLoad ./ wwtpCurrent.LaitokseltaL_htev_Kokonaispaino_t_a_Sis_Raakalietett_JaM_d_tett;
        dailyLoad = wwtpCurrent.LaitokseltaL_htev_Kokonaispaino_t_a_Sis_Raakalietett_JaM_d_tett/365;
        TSpercentageAll = wwtpCurrent.LaitoksenIlmoittamaL_htev_Kuiva_aine__;
        TSpercentageAll(isnan(TSpercentageAll)) = 0;
        % if the sludge is raw and TS% below 0.25, it is changed to 0.25
        indCR = (TSpercentageAll<0.25 & ~indDigested);
        TSpercentageAll(indCR) = 0.25;
        % if the sludge is digested and Ts% below 0.35, it is changed to 0.35
        indCD = (TSpercentageAll<0.35 & indDigested);
        TSpercentageAll(indCD) = 0.35;
    else
        % methane and nutrients are informed as a yearly production, their share in one truck load needed
        truckLoadsShare = truckLoad ./ wwtpCurrent.LaitoksenIlmoittamaL_htev_Kokonaispaino_t_a_Sis_My_sM_d_tteit_;
        dailyLoad = wwtpCurrent.LaitoksenIlmoittamaL_htev_Kokonaispaino_t_a_Sis_My_sM_d_tteit_/365;
        TSpercentageAll = wwtpCurrent.LaitoksenIlmoittamaL_htev_Kuiva_aine__;
    end
    indDigested = ~cellfun(@isempty,wwtpCurrent.LieteOnM_d_tett_);
    sludgeType(indDigested) = 'Digested';

    if isRaw == 1 % scenario of all sludge is raw
        dailyLoad(indDigested) = wwtpCurrent.KuljetettavaLietem__r__t_a_OletetussaKuiva_ainepitoisuudessa_La(indDigested)/365;
        truckLoadsShare(indDigested) = truckLoad ./ wwtpCurrent.KuljetettavaLietem__r__t_a_OletetussaKuiva_ainepitoisuudessa_La(indDigested);
        TSpercentageAll(indDigested) = 0.25;
        sludgeType(:) = 'Raw';
    end
    if betterTS == 1
        dailyLoad = wwtpCurrent.KuljetettavaLietem__r__t_a_OletetussaKuiva_ainepitoisuudessa__1/365;
        truckLoadsShare = truckLoad ./ wwtpCurrent.KuljetettavaLietem__r__t_a_OletetussaKuiva_ainepitoisuudessa__1;
        TSpercentageAll(isnan(TSpercentageAll)) = 0;
        % if the sludge is raw and TS% below 0.25, it is changed to 0.25
        indCR = (TSpercentageAll<0.25 & ~indDigested);
        TSpercentageAll(indCR) = 0.25;
        % if the sludge is digested and Ts% below 0.35, it is changed to 0.35
        indCD = (TSpercentageAll<0.35 & indDigested);
        TSpercentageAll(indCD) = 0.35;
    end
end

sludgeWwtp = table(wwtpName,currentMass,sludgeType,dailyLoad,loadNumber,day);

% initialize variables
sz = floor(sum(sludgeWwtp.dailyLoad.*daysSimulated)/truckLoad);
counter = 1;
indWWTP = NaN(sz,1);
fromWWTP = strings(sz,1);
type = strings(sz,1);
numOfLoads = NaN(sz,1);
mass = NaN(sz,1);
percentageTS = NaN(sz,1);
energy = NaN(sz,1);
methane = NaN(sz,1);
P = NaN(sz,1);
N = NaN(sz,1);
day = NaN(sz,1);

% index for each WWTP
indicesOfWWTPs = 1:size(wwtpCurrent,1);

% day-by-day simulation of load transportation
for t = 1:daysSimulated

    % follow the production in WWTPs and save the loads that will be transported

    % add daily mass to sludge table
    sludgeWwtp.currentMass = sludgeWwtp.currentMass + sludgeWwtp.dailyLoad;
    % if the sludge mass exceeds truck capacity, a load is transported
    loadsTaken = floor(sludgeWwtp.currentMass/truckLoad);
    % save the number of loads taken
    sludgeWwtp.loadNumber = sludgeWwtp.loadNumber + loadsTaken;
   
    % find indices of the WWTPs where the loads are taken from
    indLoads = find(loadsTaken);
    % number of loads from each of them
    loads = nonzeros(loadsTaken);
    
    % save the loads from each WWTP separately in the load table
    for l = 1:length(loads)
       
        type(counter) = sludgeWwtp.sludgeType(indLoads(l));
        mass(counter) = loads(l)*truckLoad;
        fromWWTP(counter) = sludgeWwtp.wwtpName(indLoads(l));
        indWWTP(counter) = indicesOfWWTPs(indLoads(l));
        percentageTS(counter) = TSpercentageAll(indLoads(l));
        day(counter) = t;
        
        if type(counter) == "Raw"
            % if ravita, phosphorus is in a variable with a different name
            if isRavita == 1
                P(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.RAVITA_Kok_P_tP_a_RaakalietteenKuiva_aineessa(indLoads(l)); % in tns
            else
                P(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.Kok_P_tP_a_RaakalietteenKuiva_aineessa(indLoads(l)); % in tns
            end
            N(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.Kok_N_tN_a_RaakalietteenKuiva_aineessa(indLoads(l)); % in tns
            methane(counter) = truckLoadsShare(indLoads(l)) * loads(l) * (wwtpCurrent.Metaani_Tuotto_m3_a_(indLoads(l)) + wwtpCurrent.M_d_tteenJ__nn_spotentiaali_m3_a_(indLoads(l))); % in m3
        elseif type(counter) == "Digested"
            P(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.Kok_P_tP_a_M_d_tteenKuiva_aineessa(indLoads(l));  % in tns
            N(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.Kok_N_tN_a_M_d_tteenKuiva_aineessa(indLoads(l));  % in tns
            methane(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.M_d_tteenJ__nn_spotentiaali_m3_a_(indLoads(l)); % in m3
        elseif type(counter) == "Ravita"
            P(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.RAVITA_Kok_P_tP_a_RaakalietteenKuiva_aineessa(indLoads(l)); % in tns
            N(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.Kok_N_tN_a_RaakalietteenKuiva_aineessa(indLoads(l)); % in tns
            methane(counter) = truckLoadsShare(indLoads(l)) * loads(l) * (wwtpCurrent.Metaani_Tuotto_m3_a_(indLoads(l)) + wwtpCurrent.M_d_tteenJ__nn_spotentiaali_m3_a_(indLoads(l))); % in m3
        end

        if isRaw == 1 % scenario where all sludge is raw
            energy(counter) = truckLoadsShare(indLoads(l)) * loads(l) * (wwtpCurrent.Energia_sis_lt__MWh_a_(indLoads(l))/1000 + wwtpCurrent.J__nn_spotentiaalinEnergiasis_lt__MWh_a_(indLoads(l))/1000);  % in GWh
        else
            energy(counter) = truckLoadsShare(indLoads(l)) * loads(l) * wwtpCurrent.LietteenEnergiasis_lt_JaJ__nn_spotentiaalinEnergiasi_lt__MWh_a_(indLoads(l))/1000;  % in GWh
        end
        numOfLoads(counter) = loads(l);
        
        counter = counter+1;
         
    end
        
        % reduce transported loads from the current mass
        sludgeWwtp.currentMass = sludgeWwtp.currentMass - loadsTaken*truckLoad;
        % one day passed
        sludgeWwtp.day = sludgeWwtp.day + 1;
    
end

% save the info and remove extra rows
sludgeLoads = table(indWWTP,fromWWTP,type,numOfLoads,mass,percentageTS,energy,methane,P,N,day);
sludgeLoads = rmmissing(sludgeLoads);

% if you want to save the results, uncomment the following and name them

% sludgeLoadsRAV = sludgeLoads;
% sludgeWwtpRAV = sludgeWWTP;
% save('data','sludgeLoadsRAV','-append')
% save('data','sludgeWwtpRAV','-append')

%% transportation
% simulate the sludge transportation

% how many STFs in Finland
numberOfSTF = 2;

%--- limits ---%

% do we have a limit for the transport distances?
% mark this if you want to optimize the STF locations with the limit
% if 0 -> no limit, 1 -> yes limit
distLimit = 0;
% if there is a limit, how many kms it is?
kmlimit = 300;

% do we have a minimum of the total of energy?
% it is needed if there is a distance limit
energyLimitTotal= 0;
% what is the minimum total energy? (in one year)
energyTotalMinimum = 160;

% do we have a minimum requirement for the energy each STF needs to produce?
energyLimit = 1;
% if yes, what is the minimum of energy? (in one year if daysSimulated=365)
energyMinimum = 40;

% do we consider a scenario of all the sludge is raw?
isRaw = 0;

% do we consider a scenario with bigger TS percentages?
betterTS = 1;

% do we consider the future scenario?
isFuture = 0;

% do we consider the Ravita scenario?
isRavita = 0;

%-------------%

% grid point combinations

if numberOfSTF < 4
    gridPointCombs = nchoosek(1:size(gridPoints,1),numberOfSTF);
else
    % if there are 4 or more, we make some eliminations to speed up calculations
    
    % now we don't consider the most northern points -> only 102 first points 
    % and not the island points -> 1-4 out
    gridPointCombs = nchoosek(5:102,numberOfSTF);
    % less combinations: we know that one will be near Helsinki so between 5-20
    % gridPointCombs = gridPointCombs((gridPointCombs(:,1) >= 5 & gridPointCombs(:,1) <= 20),:);
    gridPointCombs = gridPointCombs(any(gridPointCombs <= 20, 2),:);
    % pois pari itäisintä pistettä
    gridPointCombs = gridPointCombs(all(gridPointCombs ~= 96, 2),:);
    gridPointCombs = gridPointCombs(all(gridPointCombs ~= 61, 2),:);
    gridPointCombs = gridPointCombs(all(gridPointCombs ~= 51, 2),:);
end

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

if isFuture == 1
    distancesCurrent = distancesTUL;
elseif isRavita == 1
    distancesCurrent = distancesRAV;
else
    distancesCurrent = distancesNYK;
end

%---- if we already have gridPointCombsOK for this scenario, we can skip this step ----%
%%

% first, we remove the gridpoint combinations that do not fulfill the minimum energy limit
if energyLimit == 1

    gridPointCombsOK = NaN(size(gridPointCombs));

    if numberOfSTF == 2

        if distLimit == 0
            for i = 1:size(gridPointCombs,1)
                
                smallestValues = min(distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,1)),distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,2)));
                to1 = smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,1));
                to2 = smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,2));
                
                energySum1 = sum(sludgeLoadsCurrent.energy(to1));
                energySum2 = sum(sludgeLoadsCurrent.energy(to2));
            
                if energySum1 >= energyMinimum && energySum2 >= energyMinimum
                    gridPointCombsOK(i,:) = gridPointCombs(i,:);
                end
            end

        elseif distLimit == 1
            % if there is distance limit of 300 km, we can take it into
            % account here

            for i = 1:size(gridPointCombs,1)
                
                smallestValues = min(distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,1)),distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,2)));
                to1 = ( smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,1)) ) & ( smallestValues <= kmlimit );
                to2 = ( smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,2)) ) & ( smallestValues <= kmlimit );
                
                energySum1 = sum(sludgeLoadsCurrent.energy(to1));
                energySum2 = sum(sludgeLoadsCurrent.energy(to2));
               
                if energySum1 >= energyMinimum && energySum2 >= energyMinimum && (energySum1+energySum2) >= energyTotalMinimum
                    gridPointCombsOK(i,:) = gridPointCombs(i,:);
                end
            end

        end

    elseif numberOfSTF ==4

        if distLimit == 0
            for i = 1:size(gridPointCombs,1)
                
                smallestValues = min(distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,1)),min(distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,2)),min(distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,3)),distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,4)))));
                to1 = smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,1));
                to2 = smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,2));
                to3 = smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,3));
                to4 = smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,4));
                
                energySum1 = sum(sludgeLoadsCurrent.energy(to1));
                energySum2 = sum(sludgeLoadsCurrent.energy(to2));
                energySum3 = sum(sludgeLoadsCurrent.energy(to3));
                energySum4 = sum(sludgeLoadsCurrent.energy(to4));
            
                if energySum1 >= energyMinimum && energySum2 >= energyMinimum && energySum3 >= energyMinimum && energySum4 >= energyMinimum
                    gridPointCombsOK(i,:) = gridPointCombs(i,:);
                end
            end

        elseif distLimit == 1
            % if there is distance limit of 300 km, we can take it into
            % account here

            for i = 1:size(gridPointCombs,1)
                
                smallestValues = min(distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,1)),min(distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,2)),min(distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,3)),distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,4)))));
                to1 = ( smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,1)) ) & ( smallestValues <= kmlimit );
                to2 = ( smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,2)) ) & ( smallestValues <= kmlimit );
                to3 = ( smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,3)) ) & ( smallestValues <= kmlimit );
                to4 = ( smallestValues == distancesCurrent(sludgeLoadsCurrent.indWWTP,gridPointCombs(i,4)) ) & ( smallestValues <= kmlimit );
                
                energySum1 = sum(sludgeLoadsCurrent.energy(to1));
                energySum2 = sum(sludgeLoadsCurrent.energy(to2));
                energySum3 = sum(sludgeLoadsCurrent.energy(to3));
                energySum4 = sum(sludgeLoadsCurrent.energy(to4));
            
                if energySum1 >= energyMinimum && energySum2 >= energyMinimum && energySum3 >= energyMinimum && energySum4 >= energyMinimum
                    gridPointCombsOK(i,:) = gridPointCombs(i,:);
                end
            end

        end
    end
end

% let's remove the extra rows
gridPointCombsOK = rmmissing(gridPointCombsOK);


% gridPointCombsOK2NYK300opt = gridPointCombsOK;
% save('data','gridPointCombsOK2NYK300opt','-append')

%%
%---- if we already have gridPointCombsOK for this scenario, we can continue here ----%

% choose the correct one for current scenario
gridPointCombsOK = gridPointCombsOK4KUI;

% then we can simulate the transportation for the combinations that passed the condition
% one grid point combination at a time

% initializing table for the transport info
currentGroupDist = zeros(size(gridPointCombsOK));
currentMassRaw = zeros(size(gridPointCombsOK));
currentMassDigested = zeros(size(gridPointCombsOK));
currentMassRavita = zeros(size(gridPointCombsOK));
currentEnergyPotential = zeros(size(gridPointCombsOK));


for i = 1:size(gridPointCombsOK,1)

    % one load at a time
    for j = 1:size(sludgeLoadsCurrent,1)
    
    % find the transport distance from WWTP that produced the load to gridPointCombs
    transportToPoints = distancesCurrent(sludgeLoadsCurrent.indWWTP(j),gridPointCombsOK(i,:));
        
        % find to which grid point (=potential STF location) the distance is the smallest
        [distClosest, stfClosest] = min(transportToPoints);
        
        %---- do not transport loads that are coming from too far away ---%
        if distLimit == 1
            % if the distance is below our limit, it will be added
            % otherwise we save it to the list of 'tooFar' and proceed to the next load
            if distClosest > kmlimit
                continue
            end
        end
        
        % add it to the sum of distancesCurrent
        currentGroupDist(i,stfClosest) = currentGroupDist(i,stfClosest) + distClosest;

        % add kms and tons of the load
        % sludge type separation might be removed later
        if sludgeLoadsCurrent.type(j) == "Raw"
            currentMassRaw(i,stfClosest) = currentMassRaw(i,stfClosest) + sludgeLoadsCurrent.mass(j);
        elseif sludgeLoadsCurrent.type(j) == "Digested"
            currentMassDigested(i,stfClosest) = currentMassDigested(i,stfClosest) + sludgeLoadsCurrent.mass(j);                    
        elseif sludgeLoadsCurrent.type(j) == "Ravita"
            currentMassRavita(i,stfClosest) = currentMassRavita(i,stfClosest) + sludgeLoadsCurrent.mass(j);
        end

        currentEnergyPotential(i,stfClosest) = currentEnergyPotential(i,stfClosest) + sludgeLoadsCurrent.energy(j);
        
    end

end

    % save all into one table
    if isRavita == 1
        transportInfo = table(gridPointCombsOK,currentGroupDist,currentMassRaw,currentMassRavita,currentEnergyPotential);
    else
        transportInfo = table(gridPointCombsOK,currentGroupDist,currentMassRaw,currentMassDigested,currentEnergyPotential);
    end

% naming a variable in a table
transportInfo.Properties.VariableNames{1} = 'gridPointCombs';

% transportInfo2RAV = transportInfo;
% save('data','transportInfo2RAV','-append')

                
%% results

% first, let's pick the best option of the chosen scenario

% which scenario?
transportInfo = transportInfo4RAV300;

% best locations = smallest transport distance in total
[minDist, minInd] = mink(sum(transportInfo.currentGroupDist,2),5);
best = transportInfo(minInd,:);

if any(contains(transportInfo.Properties.VariableNames,'Ravita'))
    best.currentMassTotal = best.currentMassRaw+best.currentMassRavita;
else
    best.currentMassTotal = best.currentMassRaw+best.currentMassDigested;
end

%% sludge qualities of the best
% let's take a closer look at the sludge qualities of the best option

isRaw = 0;
betterTS = 0;
isFuture = 0;
isRavita = 1;

% if there is a km limit (optimized OR cut) use this
isDistLimit = 1;
kmlimit = 300;

%-----------%

% STF locations of the best option
STFind = best.gridPointCombs(1,:);

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
        transportToPoints = distancesTUL(sludgeLoadsCurrent.indWWTP(i),STFind);
    elseif isRavita == 1
        transportToPoints = distancesRAV(sludgeLoadsCurrent.indWWTP(i),STFind);
    else
        transportToPoints = distancesNYK(sludgeLoadsCurrent.indWWTP(i),STFind);
    end

    % find to which grid point (=potential STF location) the distance is the smallest
    [distClosest, STFclosest] = min(transportToPoints);

    % if there is a dist limit, it's considered here
    if isDistLimit == 1
        if distClosest <= kmlimit
            sludgeLoadsCurrent.toSTF(i) = STFind(STFclosest);
        end
    else
        sludgeLoadsCurrent.toSTF(i) = STFind(STFclosest);
    end

end

% information of which we want to take a closer look
% variables in Finnish, as we use these in result excel
laitos = STFind';
laitoksia = numel(STFind);
if isRavita == 1
    tyyppi = ["raaka";"ravita"];
else
    tyyppi = ["raaka";"madate"];
end
massa = zeros(laitoksia,1);
kuivaainepro = zeros(laitoksia,1);
energia = zeros(laitoksia,1);
metaani = zeros(laitoksia,1);
fosfori = zeros(laitoksia,1);
typpi = zeros(laitoksia,1);

ind = 1;

% one STF at a time
for i = 1:laitoksia
    
    % first the raw sludge
    massa(ind,1) = sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Raw"));
    kuivaainepro(ind,1) = sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Raw").*sludgeLoadsCurrent.percentageTS(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Raw"))./sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Raw"));
    energia(ind,1) = sum(sludgeLoadsCurrent.energy(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Raw"));
    metaani(ind,1) = sum(sludgeLoadsCurrent.methane(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Raw"));
    fosfori(ind,1) = sum(sludgeLoadsCurrent.P(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Raw"));
    typpi(ind,1) = sum(sludgeLoadsCurrent.N(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Raw"));
    
    % two rows for each STF, so we use this index
    ind = ind+1;    

    if isRavita == 1
        % ravita sludge
        massa(ind,1) = sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Ravita"));
        kuivaainepro(ind,1) = sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Ravita").*sludgeLoadsCurrent.percentageTS(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Ravita"))./sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Ravita"));
        energia(ind,1) = sum(sludgeLoadsCurrent.energy(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Ravita"));
        metaani(ind,1) = sum(sludgeLoadsCurrent.methane(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Ravita"));
        fosfori(ind,1) = sum(sludgeLoadsCurrent.P(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Ravita"));
        typpi(ind,1) = sum(sludgeLoadsCurrent.N(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Ravita"));
    else
        % digested sludge
        massa(ind,1) = sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Digested"));
        kuivaainepro(ind,1) = sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Digested").*sludgeLoadsCurrent.percentageTS(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Digested"))./sum(sludgeLoadsCurrent.mass(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Digested"));
        energia(ind,1) = sum(sludgeLoadsCurrent.energy(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Digested"));
        metaani(ind,1) = sum(sludgeLoadsCurrent.methane(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Digested"));
        fosfori(ind,1) = sum(sludgeLoadsCurrent.P(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Digested"));
        typpi(ind,1) = sum(sludgeLoadsCurrent.N(sludgeLoadsCurrent.toSTF == STFind(i) & sludgeLoadsCurrent.type == "Digested"));
    end

    ind = ind+1;
end

laitostable = zeros(2*laitoksia,1);
for j = 1:laitoksia
    laitostable(j*2-1) = laitos(j);
    laitostable(j*2) = laitos(j);
end
tyyppitable = repmat(tyyppi,laitoksia,1);

% here are the results
tuloksia = table(laitostable,tyyppitable,massa,kuivaainepro,energia,metaani,fosfori,typpi);

% we write the results to the excel as well
% they are easy to copy from there if needed
% first we delete the old file so there are no old results confusing us
!del results.xls
% then write the results there
writetable(tuloksia,'results.xls')


%% general information about the best
% distance, masses, energy separately for all the STFs

laitos = zeros(laitoksia,1);
kuljetusmatka = zeros(laitoksia,1);
massaraaka = zeros(laitoksia,1);
massamadate = zeros(laitoksia,1);
massaravita = zeros(laitoksia,1);
massayht = zeros(laitoksia,1);
energiapotentiaali = zeros(laitoksia,1);

for i = 1:laitoksia

    laitos(i,1) = best.gridPointCombs(1,i);
    kuljetusmatka(i,1) = best.currentGroupDist(1,i);
    massaraaka(i,1) = best.currentMassRaw(1,i);
    if isRavita == 1
        massaravita(i,1) = best.currentMassRavita(1,i);
    else
        massamadate(i,1) = best.currentMassDigested(1,i);
    end
    massayht(i,1) = best.currentMassTotal(1,i);
    energiapotentiaali(i,1) = best.currentEnergyPotential(1,i);

end

% results are here
if isRavita == 1
    tulokset = table(laitos,kuljetusmatka,massaraaka,massaravita,massayht,energiapotentiaali);
else
    tulokset = table(laitos,kuljetusmatka,massaraaka,massamadate,massayht,energiapotentiaali);
end

% first we delete the old file so there are no old results confusing us
!del results.xls
% then write the results there
writetable(tulokset,'results.xls')

%% visualization
% show the locations on map
% if there is a distance limit, use the one in the end of this script

% choose the scenario
transportInfo = transportInfo4RAV;

webmap

% show the wwtps
p = geopoint([wwtpNYK.KoordWGSP_piste],[wwtpNYK.KoordiWGSI_piste]);
wmmarker(p,'Description','WWTP','Icon','point_magenta.png','IconScale',0.25)

% let's pick the five best options of the scenario
[~, minInd] = mink(sum(transportInfo.currentGroupDist,2),5);
bestInd = transportInfo.gridPointCombs(minInd,:);

% which option do you want to see? (1 = best = shortest total distance)
opt = 1;

bestPoint = gridPoints(bestInd(opt,:),:);
bestGeopoint{1} = geopoint(bestPoint(1,1),bestPoint(1,2));
bestGeopoint{2} = geopoint(bestPoint(2,1),bestPoint(2,2));
wmmarker(bestGeopoint{1},'Icon','star_blue.png','Description','STF best','IconScale',0.85)
wmmarker(bestGeopoint{2},'Icon','star_blue.png','Description','STF best','IconScale',0.85)

if size(bestPoint,1) == 4
    bestGeopoint{3} = geopoint(bestPoint(3,1),bestPoint(3,2));
    bestGeopoint{4} = geopoint(bestPoint(4,1),bestPoint(4,2));
    wmmarker(bestGeopoint{3},'Icon','star_blue.png','Description','STF best','IconScale',0.85)
    wmmarker(bestGeopoint{4},'Icon','star_blue.png','Description','STF best','IconScale',0.85)
end


%% removing >300 km
% here we make scenarios with the dist limit (without optimization,
% cutting out the ones that are too far away)

% choose the scenario
transportInfo = transportInfo4KUI;

% choose the correct gridPointCombsOK
gridPointCombsOK = gridPointCombsOK4KUI;

isRaw = 0;
betterTS = 1;
isFuture = 0;
isRavita = 0;

%------------%

distLimit = 1;
% how many kms?
kmlimit = 300;

% our best grid point combination
[~, minInd] = min(sum(transportInfo.currentGroupDist,2));

i = minInd;

numberOfSTF = size(gridPointCombsOK,2);

% initializing variables
currentGroupDist = zeros(1,numberOfSTF);
currentMassRaw = zeros(1,numberOfSTF);
currentMassDigested = zeros(1,numberOfSTF);
currentMassRavita = zeros(1,numberOfSTF);
currentEnergyPotential = zeros(1,numberOfSTF);
    
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
    
% one load at a time
for j = 1:size(sludgeLoadsCurrent,1)

    % find the transport distance from WWTP that produced the load to gridPointCombs
    if isFuture == 1
        transportToPoints = distancesTUL(sludgeLoadsCurrent.indWWTP(j),gridPointCombsOK(i,:));
    elseif isRavita == 1
        transportToPoints = distancesRAV(sludgeLoadsCurrent.indWWTP(j),gridPointCombsOK(i,:));
    else
        transportToPoints = distancesNYK(sludgeLoadsCurrent.indWWTP(j),gridPointCombsOK(i,:));
    end    

    % find to which grid point (=potential STF location) the distance is the smallest
    [distClosest, stfClosest] = min(transportToPoints);
    
    %---- do not transport loads that are coming from too far away ---%
    if distLimit == 1
        % if the distance is below our limit, it will be added
        % otherwise we proceed to the next load
        if distClosest > kmlimit
            continue
        end
    end
    
    % add it to the sum of distances
    currentGroupDist(stfClosest) = currentGroupDist(stfClosest) + distClosest;

    % add kms and tons of the load
    if sludgeLoadsCurrent.type(j) == "Raw"
        currentMassRaw(stfClosest) = currentMassRaw(stfClosest) + sludgeLoadsCurrent.mass(j);
    elseif sludgeLoadsCurrent.type(j) == "Digested"
        currentMassDigested(stfClosest) = currentMassDigested(stfClosest) + sludgeLoadsCurrent.mass(j);                    
    elseif sludgeLoadsCurrent.type(j) == "Ravita"
        currentMassRavita(stfClosest) = currentMassRavita(stfClosest) + sludgeLoadsCurrent.mass(j);
    end
    currentEnergyPotential(stfClosest) = currentEnergyPotential(stfClosest) + sludgeLoadsCurrent.energy(j);
    
end

% save all the info into one table
if isRavita == 1
    transportInfo = table(gridPointCombsOK(i,:),currentGroupDist,currentMassRaw,currentMassRavita,currentEnergyPotential);
else
    transportInfo = table(gridPointCombsOK(i,:),currentGroupDist,currentMassRaw,currentMassDigested,currentEnergyPotential);
end

% naming a variable in a table
transportInfo.Properties.VariableNames{1} = 'gridPointCombs';

% transportInfo4KUI300 = transportInfo;
% save('data.mat','transportInfo4KUI300','-append')

%% visualization with dist limit

% choose the scenario
transportInfo = transportInfo4KUI300;

isFuture = 0;
isRavita = 0;

%---------%

[~, minInd] = mink(sum(transportInfo.currentGroupDist,2),1);
bestInd = transportInfo.gridPointCombs(minInd,:);
best = transportInfo(minInd,:);

kmlimit = 300;

numOfSTF = size(transportInfo.gridPointCombs,2);

if isFuture == 1
    distancesCurrent = distancesTUL;
    wwtpCurrent = wwtpTUL;
elseif isRavita == 1
    distancesCurrent = distancesRAV;
    wwtpCurrent = wwtpRAV;
else
    distancesCurrent = distancesNYK;
    wwtpCurrent = wwtpNYK;
end

if numOfSTF == 2
    etaisyys1 = distancesCurrent(:,best.gridPointCombs(1,1));
    etaisyys2 = distancesCurrent(:,best.gridPointCombs(1,2));
    wwtpPoints1 = geopoint((wwtpCurrent.KoordWGSP_piste(etaisyys1<=kmlimit | etaisyys2<=kmlimit)),(wwtpCurrent.KoordiWGSI_piste(etaisyys1<=kmlimit | etaisyys2<=kmlimit)));
    tooFarWWTP1 = geopoint((wwtpCurrent.KoordWGSP_piste(etaisyys1>kmlimit & etaisyys2>kmlimit)),(wwtpCurrent.KoordiWGSI_piste(etaisyys1>kmlimit & etaisyys2>kmlimit))); 
else
    etaisyys1 = distancesCurrent(:,best.gridPointCombs(1,1));
    etaisyys2 = distancesCurrent(:,best.gridPointCombs(1,2));
    etaisyys3 = distancesCurrent(:,best.gridPointCombs(1,3));
    etaisyys4 = distancesCurrent(:,best.gridPointCombs(1,4));
    wwtpPoints1 = geopoint((wwtpCurrent.KoordWGSP_piste(etaisyys1<=kmlimit | etaisyys2<=kmlimit | etaisyys3<=kmlimit | etaisyys4<=kmlimit)),(wwtpCurrent.KoordiWGSI_piste(etaisyys1<=kmlimit | etaisyys2<=kmlimit | etaisyys3<=kmlimit | etaisyys4<=kmlimit)));
    tooFarWWTP1 = geopoint((wwtpCurrent.KoordWGSP_piste(etaisyys1>kmlimit & etaisyys2>kmlimit & etaisyys3>kmlimit & etaisyys4>kmlimit)),(wwtpCurrent.KoordiWGSI_piste(etaisyys1>kmlimit & etaisyys2>kmlimit & etaisyys3>kmlimit & etaisyys4>kmlimit))); 
end

% WWTPs that are too far away from STFs
wmmarker(tooFarWWTP1,'Icon','triangle-purple.png','IconScale',0.3,'Description','>300 km')
% WWTPs wihtin the 300 km range from WWTPs
wmmarker(wwtpPoints1,'Description','<300 km','Icon','point_magenta.png','IconScale',0.25)

bestLoc = zeros(numOfSTF,2);
bestGeopoint = cell(1,numOfSTF);

% STFs
for i = 1:numOfSTF
    bestLoc(i,:) = gridPoints(bestInd(1,i),:);
    bestGeopoint{i} = geopoint(bestLoc(i,1),bestLoc(i,2));
    wmmarker(bestGeopoint{i},'Icon','star_blue.png','Description','STF best','IconScale',0.85)   
end

