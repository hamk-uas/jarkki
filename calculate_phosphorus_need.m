function [muniWithPhosphorusNeed,needPhosphorus] = calculate_phosphorus_need(muni,nutrientClasses)

% CALCULATE_PHOSPHORUS_NEED calculates yearly phosphorus fertilizer need for each municipality

%   Inputs
%       - muni: a struct containing municipalities info
%       - nutrientClasses: a table that contains all nutrient info for each municipality

%   Outputs
%       - muniWithPhosphorusNeed: a struct where phosphorus needs are added to the input struct 'muni'
%       - needPhosphorus: a table that contains phosphorus need (kg/year) for each municipality

    
% ------------- phosphorus need ------------------- %

% field areas for each municipality (ha) is saved in 'muni.FieldArea'
% proportions of phosphorus classes (%, seven-step) in each municipality is saved in 'nutrientClasses'

% Finnish Food Authority, phosphorus fertilization rates for each class (kg/ha/a)
% huono, huononl. välttävä, tyydyttävä, hyvä, korkea, arv. korkea
fertilizationP = [34,26,16,10,5,0,0];

% let's initialize table for phosphorus needs in each municipality in one year (kg)
municipalities = string(nutrientClasses.Properties.RowNames);
PNeed = zeros(size(municipalities));
needPhosphorus = table(municipalities,PNeed);

muniWithPhosphorusNeed = muni;

% we need to loop through municipalities (not the same order in data structures)

% useful variables from muni-struct
muniVector = string({muniWithPhosphorusNeed.NAMEFIN})';
fieldVector = [muniWithPhosphorusNeed.FieldArea];
    
muniNames = string(nutrientClasses.Properties.RowNames);
    
% looping through the municipalities
for i = 1:size(needPhosphorus,1)
   
    % the municipality we are handling now
    theMuni = needPhosphorus.municipalities(i);
        
	% the field area of that municipality
    fieldArea = fieldVector(muniVector == theMuni);
    
    % if field area is not found, we go to the next municipality
    if isempty(fieldArea)
        continue
    end
    
    % then proportions of nutrient classes (percentages)
    indMuni = find(muniNames == theMuni);
    proHuono = nutrientClasses.Huono(indMuni)/100;
    proHuononl = nutrientClasses.Huononlainen(indMuni)/100;
    proValtt = nutrientClasses.V_ltt_v_(indMuni)/100;
    proTyy = nutrientClasses.Tyydytt_v_(indMuni)/100;
    proHyv = nutrientClasses.Hyv_(indMuni)/100;
    proKorkea = nutrientClasses.Korkea(indMuni)/100;
    proArvK = nutrientClasses.Arvel_Korkea(indMuni)/100;
    
    proClasses = [proHuono,proHuononl,proValtt,proTyy,proHyv,proKorkea,proArvK];
    
    % let's calculate the total need of phosphorus (kg) in one year
    result = proClasses*fertilizationP'*fieldArea;
    needPhosphorus.PNeed(i) = result;
    muniWithPhosphorusNeed(muniVector == theMuni).PhosphorusNeed = result;
end

% if there are empty cells, let's change them to NaN for visualization
indEmpty = find(cellfun(@isempty,{muniWithPhosphorusNeed.PhosphorusNeed}));

for j = indEmpty
    
    muniWithPhosphorusNeed(j).PhosphorusNeed = NaN;

end

end

