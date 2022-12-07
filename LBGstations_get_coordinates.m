function LBGstations2 = LBGstations_get_coordinates(LBGstations,token)
%LBGSTATIONS_GET_COORDINATES Finds lat,lon coordinates for addresses

    % Urlin kiinteät osat
    urlAlku = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
    urlLoppu = ".json?types=address&country=fi&limit=1&access_token=";
    
    osoitedata = {};
    %
    for i = 1:size(LBGstations,1)
    
        % käsiteltävä rivi
        rivi = LBGstations(i,:);
        % katu & nro oikeaan muotoon
        osoite = regexprep(rivi.Osoite,'\s','%20');
        osoite = strrep(osoite,'Ä','A');
        osoite = strrep(osoite,'Ö','O');
        osoite = strrep(osoite,'ä','a');
        osoite = strrep(osoite,'ö','o');
        osoite = strrep(osoite,'Å','A');
        osoite = strrep(osoite,'å','a');
        % kaupunki
        city = rivi.Kunta;
        city = strrep(city,'Ä','A');
        city = strrep(city,'Ö','O');
        city = strrep(city,'ä','a');
        city = strrep(city,'ö','o');
        city = strrep(city,'Å','A');
        city = strrep(city,'å','a');
        % muodostetaan url
        url = strcat(urlAlku,osoite,"%20",city,urlLoppu,token);    
        
        % haetaan tiedot mapboxista
        try
            osoitedata{i} = webread(url);
        catch
            continue
        end
        % tarkistetaan että koordinaatit löytyivät
        if ~isempty(osoitedata{i}.features)
    
            % lisätään koordinaatit LBGstations-tableen
            LBGstations.Lon(i) = osoitedata{i}.features.center(1);
            LBGstations.Lat(i) = osoitedata{i}.features.center(2);
            
        end
        
    end

    LBGstations2 = LBGstations;

end