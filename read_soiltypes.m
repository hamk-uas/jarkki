function soiltypes = read_soiltypes(filePath)

%READ_SOILTYPES Reads soiltypes info for municipalities from a file

%   Inputs
%       - filePath: a string of path including the name of the excel file where the info is found

%   Outputs
%       - soiltypes: a table containing info about the soiltypes in municipalities

% -------- soiltypes ------- %

[~,sheet_name]=xlsfinfo(filePath);
soiltypes = [];
for k=1:numel(sheet_name)
    new = readtable(filePath,'Sheet',sheet_name{k});
    soiltypes = [soiltypes;new];
end

coarseCols = 3:12;
clayCols = 13:17;
organicCols = 18:26;

for col = 3:26
    soiltypes.(col) = regexprep(soiltypes.(col),',','.');
    soiltypes.(col) = str2double(soiltypes.(col));
end

municipality = table2array(soiltypes(:,1));
samples = table2array(soiltypes(:,2));

coarseTypes = table2array(soiltypes(:,coarseCols));
coarse = sum(coarseTypes,2,'omitnan');
clayTypes = table2array(soiltypes(:,clayCols));
clay = sum(clayTypes,2,'omitnan');
organicTypes = table2array(soiltypes(:,organicCols));
organic = sum(organicTypes,2,'omitnan');

soiltypesSummary = table(municipality,samples,coarse,clay,organic);

soiltypes = soiltypesSummary;

end

