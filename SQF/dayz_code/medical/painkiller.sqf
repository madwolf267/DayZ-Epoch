// bleed.sqf

private ["_id","_unit","_num_removed"];

disableserialization;

_unit = (_this select 3) select 0;

call fnc_usec_medic_removeActions;
r_action = false;

_num_removed = ([player,"ItemPainkiller"] call BIS_fnc_invRemove);
if(_num_removed == 1) then {

	if (vehicle player != player) then {
		_display = findDisplay 106;
		_display closeDisplay 0;
	};	

	_unit setVariable ["USEC_inPain", false, true];

	if (vehicle player == player) then {
		//not in a vehicle
		player playActionNow "Gear";
	};

	if ((_unit == player) or (vehicle player != player)) then {
		//Self Healing
		_id = [player,player] execVM "\z\addons\dayz_code\medical\publicEH\medPainkiller.sqf";
	} else {
		//PVDZE_plr_HumanityChange = [player,20];
		[player,20] call player_humanityChange;
	};

	sleep 1;
	//clear the healed player's vision
	//["usecPainK",[_unit,player]] call broadcastRpcCallAll;
	usecPainK = [_unit,player];
	publicVariable "usecPainK";
};
