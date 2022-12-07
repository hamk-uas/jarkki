% draw maps

load data.mat

%% wwtps on map
% based on their sludge amount (in total solids)

totalSolids = wwtpNYK.LaskeutetunLietteenKuiva_aine_tTS_a_IlmanM_d_tyst_;
% <200, 200-500, 500-1000, 1000-2000, 2000-4000, 4000-8000, >8000

wwtpPoints1 = geopoint((wwtpNYK.KoordWGSP_piste(totalSolids<200)),(wwtpNYK.KoordiWGSI_piste(totalSolids<200)));
wwtpPoints2 = geopoint((wwtpNYK.KoordWGSP_piste(totalSolids>=200&totalSolids<2000)),(wwtpNYK.KoordiWGSI_piste(totalSolids>=200&totalSolids<2000)));
wwtpPoints3 = geopoint((wwtpNYK.KoordWGSP_piste(totalSolids>=2000&totalSolids<20000)),(wwtpNYK.KoordiWGSI_piste(totalSolids>=2000&totalSolids<20000)));
wwtpPoints4 = geopoint((wwtpNYK.KoordWGSP_piste(totalSolids>20000)),(wwtpNYK.KoordiWGSI_piste(totalSolids>20000)));
wmmarker(wwtpPoints4,'Icon','point_red.png','IconScale',0.6)
wmmarker(wwtpPoints3,'Icon','pallo4.png','IconScale',0.45)
wmmarker(wwtpPoints2,'Icon','pallo3.png','IconScale',0.3)
wmmarker(wwtpPoints1,'Icon','point_magenta.png','IconScale',0.2)

%% phosphorus in wwtps
% wwtps on map based on their phosphorus amount in sludge

indDigested = ~cellfun(@isempty,wwtpNYK.LieteOnM_d_tett_);

phosphorus = wwtpNYK.Kok_P_tP_a_RaakalietteenKuiva_aineessa;
phosphorus(indDigested) = wwtpNYK.Kok_P_tP_a_M_d_tteenKuiva_aineessa(indDigested);
% <2, 2-20, 20-200, >200

wwtpPoints1 = geopoint((wwtpNYK.KoordWGSP_piste(phosphorus<2)),(wwtpNYK.KoordiWGSI_piste(phosphorus<2)));
wwtpPoints2 = geopoint((wwtpNYK.KoordWGSP_piste(phosphorus>=2&phosphorus<20)),(wwtpNYK.KoordiWGSI_piste(phosphorus>=2&phosphorus<20)));
wwtpPoints3 = geopoint((wwtpNYK.KoordWGSP_piste(phosphorus>=20&phosphorus<200)),(wwtpNYK.KoordiWGSI_piste(phosphorus>=20&phosphorus<200)));
wwtpPoints4 = geopoint((wwtpNYK.KoordWGSP_piste(phosphorus>200)),(wwtpNYK.KoordiWGSI_piste(phosphorus>200)));
wmmarker(wwtpPoints4,'Icon','point_red.png','IconScale',0.6)
wmmarker(wwtpPoints3,'Icon','pallo4.png','IconScale',0.45)
wmmarker(wwtpPoints2,'Icon','pallo3.png','IconScale',0.3)
wmmarker(wwtpPoints1,'Icon','point_magenta.png','IconScale',0.2)

%% all wwtps on map
wwtpPoints1 = geopoint(wwtpNYK.KoordWGSP_piste,wwtpNYK.KoordiWGSI_piste);
wmmarker(wwtpPoints1,'Icon','point_magenta.png','IconScale',0.3)

%% current plants on map
plantPoints = geopoint(plants.WGSP,plants.WGSI);
wmmarker(plantPoints,'Icon','square-blue3.png','IconScale',0.3)

%% digested and raw
% show which wwtps digest their sludge and which don't

indDigested = ~cellfun(@isempty,wwtpNYK.LieteOnM_d_tett_);

wwtpRaw = geopoint((wwtpNYK.KoordWGSP_piste(~indDigested)),(wwtpNYK.KoordiWGSI_piste(~indDigested)));
wwtpDigested = geopoint((wwtpNYK.KoordWGSP_piste(indDigested)),(wwtpNYK.KoordiWGSI_piste(indDigested)));

wmmarker(wwtpRaw,'Icon','point_magenta.png','IconScale',0.3)
wmmarker(wwtpDigested,'Icon','square-blue3.png','IconScale',0.3)

%% gridpoints
% show all the gridpoints on map

gridP = geopoint(gridPoints(:,1),gridPoints(:,2));
wmmarker(gridP,'Icon','yellow-dot.png','IconScale',0.4)

%% municipalities
% show the municipalities in Finland

g = geoshape(muni);

% in random colors
% colors = parula(length(muni));
% wmpolygon(g,'Facecolor',colors);

% or just the outlines
wmpolygon(g,'FaceAlpha',0,'EdgeColor','k');


%% phosphorus in municipalities' soil

% this works without any shapefiles or functions
% worldmap([59 71],[18 33])
% setm(gca,'MapProjection','mercator')
% faceColors = makesymbolspec('Polygon',{'Phosphorus',[floor(min(nonzeros([muni.Phosphorus]))) 25],'FaceColor',cool},{'Phosphorus',[25 ceil(max(nonzeros([muni.Phosphorus])))],'FaceColor',[1,0,0]});
% geoshow(muni,'DisplayType','Polygon','SymbolSpec',faceColors)
% caxis([5 25])
% colormap(cool)
% h = colorbar;
% h.Label.String = 'Phosphorus rate in soil (mg/l)';

% here we use shapefiles and functions to make it prettier

% Matlab shapefile
coast = shaperead('landareas.shp','UseGeoCoords',true,'RecordNumbers',2);
% Files downloaded from Maanmittauslaitos
valtio = shaperead('C:\Users\marianne210\Hämeen ammattikorkeakoulu\YM Järkki - General\TP1\TP1 Data\Ravinteisuus\TietoaKuntajaosta_ESRI_2021_4500k\SuomenValtakunta_2021_4500k.shp');
valtio_info = shapeinfo('C:\Users\marianne210\Hämeen ammattikorkeakoulu\YM Järkki - General\TP1\TP1 Data\Ravinteisuus\TietoaKuntajaosta_ESRI_2021_4500k\SuomenValtakunta_2021_4500k.shp');
valtio_proj = valtio_info.CoordinateReferenceSystem;
[valtio.lat,valtio.lon] = projinv(valtio_proj,valtio.X,valtio.Y);

% Setting up the map base    
worldmap([59 71],[18 33])
setm(gca,'MapProjection','mercator')

% Create coastlines and choose colors for land and sea
geoshow(coast,'FaceColor',[224/256, 224/256, 224/256]) % light grey
setm(gca,'ffacecolor',[189/256,228/256,234/256]) % lighter blue

% And the line for Finland's borders
geoshow(valtio.lat,valtio.lon)

% Let's make our own colormap, function 'customcolormap' needed here
mycolormap = customcolormap([0 .33 .67 1], {'#f66e45','#ffffbb','#65c0ae','#5e4f9f'});

% we dont want the range to be from min to max (5-95) but specify it so it
% serves us better
range = [floor(min(nonzeros([muni.Phosphorus]))) 25];
underRange = [0 floor(min(nonzeros([muni.Phosphorus])))];
overRange = [25 ceil(max(nonzeros([muni.Phosphorus])))];

% then choose colors or colormap for each range
myRed = [208/256,90/256,55/256];
faceColors = makesymbolspec('Polygon',{'Phosphorus',range,'FaceColor',mycolormap},{'Phosphorus',overRange,'FaceColor',myRed},{'Phosphorus',underRange,'FaceColor','w'});
% if we don't have info, it's below 5 (actually 0) and it is shown in white
% our colormap is set between the smallest non-zero value and 25
% everything over 25 are red

% then we display it
geoshow(muni,'DisplayType','Polygon','SymbolSpec',faceColors)

% let's set colorbar: axis, our colors and text what it means
caxis([floor(min(nonzeros([muni.Phosphorus]))) 25])
colormap(mycolormap)
h = colorbar;
h.Label.String = 'Phosphorus rate in soil (mg/l)';

% for clarification, let's plot the coast line as the municipalities continue to the sea
plotm(coast.Lat,coast.Lon,'Color','k','LineWidth',1)

% then just some positioning
width = 1000;
height = 1800;
set(gcf,'position',[0,0,width,height])

% saveas(gcf,'nutrientmap.png')

%% city centers
% show city centers on map

% if you want to have municipalities' outlines shown, use this
g = geoshape(muni);
wmpolygon(g,'FaceAlpha',0,'EdgeColor','k');

% then the city centers
centerPoints = geopoint([muni.CenterLat],[muni.CenterLon]);
wmmarker(centerPoints,'Icon','pallo3.png','IconScale',0.2)

%% field areas

% the same story here as with the phosphotus

% % without any functions and shapefiles
% worldmap([59 71],[18 33])
% setm(gca,'MapProjection','mercator')
% 
% % range either from min to max or from min to 40000
% faceColors = makesymbolspec('Polygon',{'FieldArea',[floor(min(nonzeros([muni.FieldArea]))) 40000],'FaceColor',flipud(summer)},{'FieldArea',[40000 ceil(max(nonzeros([muni.FieldArea])))],'FaceColor',summer(1)}); 
% %     faceColors = makesymbolspec('Polygon',{'FieldArea',[floor(min(nonzeros([muni.FieldArea]))) ceil(max(nonzeros([muni.FieldArea])))],'FaceColor',flipud(summer)});
% 
% geoshow(muni,'DisplayType','Polygon','SymbolSpec',faceColors)    
% 
% caxis([floor(min(nonzeros([muni.FieldArea]))) 40000]);
% %     caxis([floor(min(nonzeros([muni.FieldArea]))) ceil(max(nonzeros([muni.FieldArea])))]);
% 
% colormap(flipud(summer))
% h = colorbar;
% h.Label.String = 'Field area in a municipality (ha)';


% here we manipulate it a bit to make it better

% Matlab shapefile
coast = shaperead('landareas.shp','UseGeoCoords',true,'RecordNumbers',2);
% Files downloaded from Maanmittauslaitos
valtio = shaperead('C:\Users\marianne210\Hämeen ammattikorkeakoulu\YM Järkki - General\TP1\TP1 Data\Ravinteisuus\TietoaKuntajaosta_ESRI_2021_4500k\SuomenValtakunta_2021_4500k.shp');
valtio_info = shapeinfo('C:\Users\marianne210\Hämeen ammattikorkeakoulu\YM Järkki - General\TP1\TP1 Data\Ravinteisuus\TietoaKuntajaosta_ESRI_2021_4500k\SuomenValtakunta_2021_4500k.shp');
valtio_proj = valtio_info.CoordinateReferenceSystem;
[valtio.lat,valtio.lon] = projinv(valtio_proj,valtio.X,valtio.Y);

worldmap([59 71],[18 33])
setm(gca,'MapProjection','mercator')

% Create coastlines and choose colors for land and sea
geoshow(coast,'FaceColor',[224/256, 224/256, 224/256]) % light grey
setm(gca,'ffacecolor',[189/256,228/256,234/256]) % lighter blue

% let's use summer colors but not linearly
colors = flipud(summer);
myColorMap = customcolormap([0 0.5 0.75 1],[colors(256,:); colors(171,:); colors(85,:); colors(1,:)]);

faceColors = makesymbolspec('Polygon',{'FieldArea',[floor(min(nonzeros([muni.FieldArea]))) ceil(max(nonzeros([muni.FieldArea])))],'FaceColor',myColorMap});
geoshow(muni,'DisplayType','Polygon','SymbolSpec',faceColors)
caxis([floor(min(nonzeros([muni.FieldArea]))) ceil(max(nonzeros([muni.FieldArea])))]);
colormap(myColorMap)
h = colorbar;
h.Label.String = 'Field area in a municipality (ha)';

% for clarification, let's plot the coast line as the municipalities continue to the sea
plotm(coast.Lat,coast.Lon,'Color','k','LineWidth',1)

% positioning
width = 1000;
height = 1800;
set(gcf,'position',[0,0,width,height])

% saveas(gcf,'fieldmap2.png')

%%
% out of curiosity: how much there is field area compared to the
% municipality total area
    
for i = 1: numel(muni)   
    muni(i).tiheys = muni(i).FieldArea/muni(i).LANDAREA;    
end

    worldmap([59 71],[18 33])
    setm(gca,'MapProjection','mercator')
    
 faceColors = makesymbolspec('Polygon',{'tiheys',[floor(min(nonzeros([muni.tiheys]))) ceil(max(nonzeros([muni.tiheys])))],'FaceColor',flipud(summer)});
    geoshow(muni,'DisplayType','Polygon','SymbolSpec',faceColors)
    caxis([floor(min(nonzeros([muni.tiheys]))) ceil(max(nonzeros([muni.tiheys])))]);
    colormap(flipud(summer))
    h = colorbar;

%% soiltypes

% let's split municipalities into categories based on their most common
% soiltype

coarseMuni = [];
clayMuni = [];
organicMuni = [];

for i = 1:size(soiltypes,1)
   
    if soiltypes.coarse(i) < soiltypes.clay(i) 
        if soiltypes.clay(i) < soiltypes.organic(i)
            organicMuni = [organicMuni; soiltypes.municipality(i)];
        else
            clayMuni = [clayMuni; soiltypes.municipality(i)];
        end
    else
        if soiltypes.coarse(i) < soiltypes.organic(i)
            organicMuni = [organicMuni; soiltypes.municipality(i)];
        else
            coarseMuni = [coarseMuni; soiltypes.municipality(i)];
        end        
    end
    
end

muniCoarse = struct();
coarseCounter = 1;
muniClay = struct();
clayCounter = 1;
muniOrganic = struct();
OrganicCounter = 1;
fieldsMuni = fieldnames(muni);

% let's split the variable 'muni' into three different variables based on
% the most common soiltype

for j = 1:size(muni,1)
   
    if ismember(muni(j).NAMEFIN,coarseMuni)
       % loop through all the fields and copy them to the new variable
       for k = fieldsMuni(:)'
           muniCoarse(coarseCounter).(k{:}) = getfield(muni(j),k{:});
       end
       coarseCounter = coarseCounter+1;
    
    elseif ismember(muni(j).NAMEFIN,clayMuni)
       % loop through all the fields and copy them to the new variable
       for k = fieldsMuni(:)'
           muniClay(clayCounter).(k{:}) = getfield(muni(j),k{:});
       end
       clayCounter = clayCounter+1;
    
    elseif ismember(muni(j).NAMEFIN,organicMuni)
       % loop through all the fields and copy them to the new variable
       for k = fieldsMuni(:)'
           muniOrganic(OrganicCounter).(k{:}) = getfield(muni(j),k{:});
       end
       OrganicCounter = OrganicCounter+1;
    end
    
end


%% soiltypes on map
% now we can viasualize it

coast = shaperead('landareas.shp','UseGeoCoords',true,'RecordNumbers',2);
% Files downloaded from Maanmittauslaitos
valtio = shaperead('C:\Users\marianne210\Hämeen ammattikorkeakoulu\YM Järkki - General\TP1\TP1 Data\Ravinteisuus\TietoaKuntajaosta_ESRI_2021_4500k\SuomenValtakunta_2021_4500k.shp');
valtio_info = shapeinfo('C:\Users\marianne210\Hämeen ammattikorkeakoulu\YM Järkki - General\TP1\TP1 Data\Ravinteisuus\TietoaKuntajaosta_ESRI_2021_4500k\SuomenValtakunta_2021_4500k.shp');
valtio_proj = valtio_info.CoordinateReferenceSystem;
[valtio.lat,valtio.lon] = projinv(valtio_proj,valtio.X,valtio.Y);

worldmap([59 71],[18 33])
setm(gca,'MapProjection','mercator')

% Create coastlines and choose colors for land and sea
geoshow(coast,'FaceColor',[224/256, 224/256, 224/256]) % light grey
setm(gca,'ffacecolor',[189/256,228/256,234/256]) % light blue

punaruseka = [154/256,104/256,85/256];
keltava = [209/256,174/256,87/256];
vihera = [108/256,156/256,140/256];

t1 = geoshow(muniCoarse,'Facecolor',keltava);
t2 = geoshow(muniClay,'Facecolor',punaruseka);
t3 = geoshow(muniOrganic,'Facecolor',vihera);

% for clarification, let's plot the coast line as the municipalities continue to the sea
plotm(coast.Lat,coast.Lon,'Color','k','LineWidth',1)

legend([t1,t2,t3],{'Coarse-textured','Clay','Organic'},Location="best")

title('Major soil types')

width = 600;
height = 900;

set(gcf,'position',[50,50,width,height])

% saveas(gcf,'soiltypes.png')

%% best STF locations on map

% choose the scenario here
transportInfo = transportInfo4RAA;

[minDist, minInd] = mink(sum(transportInfo.currentGroupDist,2),3);
bestInd = transportInfo.gridPointCombs(minInd,:);

webmap

% uncomment these if you want to show the wwtps
% p = geopoint([wwtp.KoordWGSP_piste],[wwtp.KoordiWGSI_piste]);
% wmmarker(p,'Description','WWTP','Icon','point_magenta.png','IconScale',0.25)

% choose here if you want to see the best, second best or third best option
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

% uncomment these if you want to show the mills
% millPoints = geopoint(mills.Lat,mills.Lon);
% wmmarker(millPoints,'Icon','pallo4.png','IconScale',0.3)
