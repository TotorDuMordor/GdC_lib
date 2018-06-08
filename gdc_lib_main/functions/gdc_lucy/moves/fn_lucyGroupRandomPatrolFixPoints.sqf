/*
	Author: Mystery

	Description:
	Create an infinite patrol between random defined points for a group.
    Points are defined at the beginning of the mission.

	Parameter(s):
		0 : GROUP - group
        1 : STRING - Marker name
        2 : NUMBER - Number of points to generate in the area
        3 (optional): ARRAY - Array of group move & combat parameters - Default : ["MOVE", "LIMITED", "SAFE", "RED", "COLUMN"]

	Returns:
	Nothing
*/

params ["_group", "_marker", "_nb_points", ["_grp_params", ["MOVE", "LIMITED", "SAFE", "RED", "COLUMN"]]];
private ["_i", "_wp", "_wp_timeout", "_cycle_pos"];

if (LUCY_RANDOM_PATROL_MAX_TIMEOUT < 1) then {
    _wp_timeout = 1;
} else {
    _wp_timeout = LUCY_RANDOM_PATROL_MAX_TIMEOUT;
};

// Create random points in the area
for [{_i=0}, {_i < _nb_points}, {_i = _i + 1}] do {
    _wp = [_group, _marker call BIS_fnc_randomPosTrigger, 5, 
        _grp_params select 0,
        _grp_params select 1, 
        _grp_params select 2, 
        _grp_params select 3,
        _grp_params select 4,
        15, [0, _wp_timeout/2, _wp_timeout]] call GDC_fnc_lucyAddWaypoint;
    // Save first position 
    if (_i == 0) then {_cycle_pos = waypointPosition _wp;};
    sleep 0.01;
};


_wp = [_group, [(_cycle_pos select 0) + 10, (_cycle_pos select 1) + 10, _cycle_pos select 2], 10, "CYCLE", 
        _grp_params select 1, 
        _grp_params select 2, 
        _grp_params select 3,
        _grp_params select 4,
        15, [0, _wp_timeout/2, _wp_timeout]] call GDC_fnc_lucyAddWaypoint;