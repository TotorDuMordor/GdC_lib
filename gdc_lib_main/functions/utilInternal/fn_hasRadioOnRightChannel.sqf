/*
	Author: Shinriel

	Description:
		Check if the unit has a radio with the asked type and the asked channel
		[_unit, _radioType, _channel] call GDC_fnc_hasRadioOnRightChannel

	Parameter(s):
		0 (optional): STRING - Unit to check
        1 (optional): STRING - Radio type to check
        2 (optional): NUMBER - Channel to check

	Returns:
		boolean: true if the unit has a radio with the right channel
*/

params[["_unit", player], ["_radioType", "ACRE_PRC117f"], ["_channel", 5]];

private ["_rightRadio"];

_rightRadio = false; 
{ 
	if(([_radioType, _x] call GDC_fnc_StringStartWith) && ([_x] call acre_api_fnc_getRadioChannel == _channel)) then { 
		_rightRadio = true; 
	};
} foreach ([_unit] call acre_api_fnc_getCurrentRadioList);

_rightRadio;
