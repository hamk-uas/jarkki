function [muniWithFieldArea, fieldAreas, averageAreas] = read_fieldarea(muni,filePath,range)

%READ_NUTRIENTS Add/update fieldarea info to the municipalities struct

%   Inputs
%       - muni: a struct containing municipalities info
%       - filePath: a string of path including the name of the excel file where the updated info about farming areas is found
%       - range: a string that tells the range of info in the file

%   Outputs
%       - muniWithFieldArea: a struct where average field areas are added to the input struct 'muni'
%       - fieldAreas: a struct that contains all field area info for each municipality (every year, different species)
    
% ------------- farming area info ------------------- %

% let's read the field area info from the file
areaTable = readtable(filePath,'Range',range);
% in some reason 'Sodankylä' is 'Sodankylän kunta' in the file, let's
% change it. First all the names from char to string
areaTable.Var2 = string(areaTable.Var2);
areaTable.Var2(contains(areaTable.Var2,'Sodankylän kunta')) = 'Sodankylä';

% what years do we have data from?
idxYear = find(~cellfun(@isempty,areaTable.Var1));
years = cellfun(@str2num,areaTable.Var1(idxYear));

% areas for each year
fieldAreas = ([]);

% some municipality mergers have effects, let's use only 3 latest years
for i = length(years)-2:length(years)
    
    name = append('year',num2str(years(i)));
    if i < length(years)
        table = areaTable(idxYear(i):(idxYear(i+1)-1),2:end);
    else
        table = areaTable(idxYear(i):end,2:end);
    end
    fieldAreas.(name) = table;
end

% average values, total
fields = string(fieldnames(fieldAreas));
% all the years, one at a time
for j = 1:numel(fields)
    % farming areas of that year
    yearInfo = fieldAreas.(fields{j});   
    % if first year, create the table
    if j == 1
        averageAreas.Municipalities = string(yearInfo.Var2);
        averageAreas.TotalArea = yearInfo.K_YT_SS_OLEVAMAATALOUSMAAYHTEENS_;
        averageAreas.Years = ones(size(yearInfo,1),1);
        averageAreas = struct2table(averageAreas);
        averageAreas.Years(isnan(averageAreas.TotalArea)) = 0;
    else    % otherwise add info about one municipality at a time        
        for k = 1:size(yearInfo,1)            
            currentMuni = yearInfo.Var2{k};
            % let's find its total area this year
            currentTotal = yearInfo.K_YT_SS_OLEVAMAATALOUSMAAYHTEENS_(string(yearInfo.Var2) == currentMuni);
            % and lets add it to our table
            if (~isnan(currentTotal))
                currentIdx = find(averageAreas.Municipalities == currentMuni);
                % if there was nan, but now there is a number, it excludes the nan
                averageAreas.TotalArea(currentIdx) = sum([averageAreas.TotalArea(currentIdx), currentTotal],'omitnan');
                averageAreas.Years(currentIdx) = averageAreas.Years(currentIdx) + 1;
            end
        end
    end
end

% After all the years have been gone through, let's calculate average
averageAreas.Average = averageAreas.TotalArea./averageAreas.Years;
% no need for total anymore
averageAreas.TotalArea = [];

% Next let's add this info to 'muni'
muniWithFieldArea = muni;
for l = 1:length(muni)
    [~,idx] = ismember(muni(l).NAMEFIN,averageAreas.Municipalities);
    % check swedish name if it's not found by finnish name
    if idx == 0
        [~,idx] = ismember(muni(l).NAMESWE,averageAreas.Municipalities);
    end
    % if it's found, save the field area info to 'muni'
    if idx ~= 0
        muniWithFieldArea(l).FieldArea = averageAreas.Average(idx);
    end
end

end

