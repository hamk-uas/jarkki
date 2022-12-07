function distances = get_distances_universal(coordinates1,coordinates2,token)

%GET_DISTANCES searches distances from Mapbox from one point to another

%   Inputs
%       - coordinates1: a table containing starting point coordinates in columns Lat and Lon 
%       - coordinates2: a table containing end point coordinates in columns Lat and Lon
%       - token: a Mapbox token that is needed for distance searches

%   Outputs
%       - distances: a double array containing distances by road in kms from each WWTP to each gridpoint

% ------------------- %

% url for the search
url_part = "https://api.mapbox.com/directions/v5/mapbox/driving/";

% coordinates: first LON, then LAT!
coord1_string1 = string(coordinates1.Lon);
coord1_string2 = string(coordinates1.Lat);
coord1_string = strcat(coord1_string1,',',coord1_string2);
coord2_string1 = string(coordinates2.Lon);
coord2_string2 = string(coordinates2.Lat);
coord2_string = strcat(coord2_string1,',',coord2_string2);

% let's create the variable that stores the results
distances = zeros(length(coord1_string),length(coord2_string));

% one grid point at a time
for i=1:length(coord1_string)
   
    % urls for: grid point i, all the wwtps
    url_all = arrayfun(@(x) strcat(url_part,x,';',coord1_string(i,:),'?access_token=',token),coord2_string);
    % remove missing if there is some (= no coordinates, probably closed down wwtps)
    url_all = url_all(~ismissing(url_all));

    % search data from online for all
    dir_data = arrayfun(@(y) webread(y),url_all);
    
    % there might be a need to check here if there are no routes at all
    
    % let's store the distance in kms
    for j=1:length(dir_data)
       
        distances(i,j) = dir_data(j).routes.distance/1000;
        
    end    
    
end


end

