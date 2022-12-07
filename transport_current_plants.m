function currentTransportInfoSum = transport_current_plants(plants,currentDistances,sludgeLoadsNYK)
%TRANSPORT_CURRENT_PLANTS simulates transportation from WWTPs to current plants
  
    % initializing variables
    currentGroupDist = zeros(1,size(plants,1));
    currentMassRaw = zeros(1,size(plants,1));
    currentMassDigested = zeros(1,size(plants,1));
    currentEnergyPotential = zeros(1,size(plants,1));
        
    % one load at a time
    for j = 1:size(sludgeLoadsNYK,1)
        
        % find the transport distance from WWTP that produced the load to
        % current plants
        transportToPoints = currentDistances(sludgeLoadsNYK.indWWTP(j),:);
            
        % find to which grid point (=potential STF location) the distance is the smallest
        [distClosest, plantClosest] = min(transportToPoints);
        
        % add it to the sum of distances
        currentGroupDist(plantClosest) = currentGroupDist(plantClosest) + distClosest;
    
        % add kms and tons of the load
        if sludgeLoadsNYK.type(j) == "Raw"
            currentMassRaw(plantClosest) = currentMassRaw(plantClosest) + sludgeLoadsNYK.mass(j);
            currentEnergyPotential(plantClosest) = currentEnergyPotential(plantClosest) + sludgeLoadsNYK.energy(j);
        else
            % if digested, no energy is received
            currentMassDigested(plantClosest) = currentMassDigested(plantClosest) + sludgeLoadsNYK.mass(j);                    
        end        
    end
        
    transportInfo = table(1:size(plants,1),currentGroupDist,currentMassRaw,currentMassDigested,currentEnergyPotential);
    
    % naming a variable in a table
    transportInfo.Properties.VariableNames{1} = 'plants';
    
    currentTransportInfo = transportInfo;
    currentTransportInfoSum = table();
    currentTransportInfoSum.dist = sum(currentTransportInfo.currentGroupDist);
    currentTransportInfoSum.energy = sum(currentTransportInfo.currentEnergyPotential);
    currentTransportInfoSum.massRaw = sum(transportInfo.currentMassRaw);
    currentTransportInfoSum.massDigested = sum(transportInfo.currentMassDigested);
    currentTransportInfoSum.massTotal = currentTransportInfoSum.massRaw + currentTransportInfoSum.massDigested;

end