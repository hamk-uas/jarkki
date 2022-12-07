Järkki
2022
Marianne Honkasaari, HAMK Smart

Data:

- Järkki datafiles folder
Contains different datafiles. Some of them from the internet and not changing.
Some are created by ourselves and might get some updates. For example, Laitostiedot_Qgisiin_10.6.2021.xlsx is created and occassionally updated by Satu.

- data.mat
Contains saved Matlab variables.

Scripts:

- main.m
The main code. Updating data, running the sludge transportation simulations and inspecting results.

- transportation_statistics.m
Allows you to analyse sludge transportation.

- product_transportation.m
Products' transportation simulations.

- mapmaker.m
Collection of different map visualizations.

- graphmaker.m
Collection of different graphs.

Functions:

- calculate_phosphorus_need
Called by main.m when updating municipalities' phosphorus needs.

- create_gridpoints
Called by main.m when creating gridpoints.

- get_distances_universal
Called by main.m when updating distances between any two points.

- LBG_stations_get_coordinates
Called by main.m when updating LBG stations' coordinates based on their addresses in the datafile.

- read_fieldarea
Called by main.m when updating municipalities' field areas.

- read_soiltypes
Called by main.m when updating municipalities' soil types.

- transport_current_plants.m
Called by main.m when simulating transportation to current plants.

Additionally functions from Matlab file exchange:
- customcolormap
- plotBarStackGroups
---> used in some maps or graphs

