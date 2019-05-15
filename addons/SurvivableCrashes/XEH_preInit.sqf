r0ed_SurvivableCrashes_OnVehicleCrash = compileFinal preprocessFileLineNumbers "\r0ed_SurvivableCrashes\functions\fn_onVehicleCrash.sqf";
r0ed_SurvivableCrashes_VehicleInit = compileFinal preprocessFileLineNumbers "\r0ed_SurvivableCrashes\functions\fn_vehicleInit.sqf";
r0ed_SurvivableCrashes_PlaySfx = compileFinal preprocessFileLineNumbers "\r0ed_SurvivableCrashes\functions\fn_playSfx.sqf";

if (isClass (configfile >> "CfgPatches" >> "cba_settings")) then {
	private _settings = [
		[
			"r0ed_SurvivableCrashes_modEnable",
			"CHECKBOX",
			["Enable Survivable Crashes", "Allow crashes to be survivable!"],
			"Survivable Crashes",
			true, // Default Value
			true
		],
		[
			"r0ed_SurvivableCrashes_vfxEnable",
			"CHECKBOX",
			["Enable Visual Effects", "Enable visual effects to affect your view"],
			"Survivable Crashes",
			true, // Default Value
			true
		],
		[
			"r0ed_SurvivableCrashes_sfxEnable",
			"CHECKBOX",
			["Enable Sound Effects", "Enable additional sound effects to play whilst crashing"],
			"Survivable Crashes",
			true, // Default Value
			true
		],
		[
			"r0ed_SurvivableCrashes_efxEnable",
			"CHECKBOX",
			["Enable Exaggerated Effects", "Enable exaggerated 3D effects during and after a crash"],
			"Survivable Crashes",
			true, // Default Value
			true
		],
		[
			"r0ed_SurvivableCrashes_medicalSystem",
			"LIST",
			["Medical System", "What medical system shall be used to damage victims"],
			"Survivable Crashes",
			[
				["ACE", "VANILLA", "AUTO", "LIMIT_DAMAGE", "NONE"],
				["Force ACE3", "Force Vanilla", "Auto Detect (ACE3 or Vanilla)", "Limited Damage Only", "Do not prevent damage (Game Default damage)"],
				2 // Default Value
			],
			true
		],
		[
			"r0ed_SurvivableCrashes_damageMultiplier",
			"SLIDER",
			["Damage multiplier", "The amount of damage to apply to crashed player (Recommended ~0.2 with ACE3)"],
			"Survivable Crashes",
			[0, 1, 0.3 /* Default Value */, 1],
			true
		],
		[
			"r0ed_SurvivableCrashes_vehicleWhitelist",
			"EDITBOX",
			["Vehicle classes", "Vehicle classes to whitelist,<br>in square brackets, with quotation marks seperated by ,"],
			["Survivable Crashes", "Advanced"],
			"[""Air""]", // Default Value
			true
		],
		[
			"r0ed_SurvivableCrashes_onCrashCode",
			"EDITBOX",
			["On Crash Code", "Code called vehicle local:<br>_this = [vehicle, EventHandlerEvent_HandleDamage]"],
			["Survivable Crashes", "Advanced"],
			"params[""_vehicle"", ""_event""];", // Default Value
			true
		],
		[
			"r0ed_SurvivableCrashes_onPostCrashCode",
			"EDITBOX",
			["Crew Post-Crash Code", "Code called locally by each crew member after they are ejected:<br>_this = [unit]"],
			["Survivable Crashes", "Advanced"],
			"params[""_unit""];", // Default Value
			true
		],
		[
			"r0ed_SurvivableCrashes_vehicleRestCode",
			"EDITBOX",
			["Vehicle Rest Code", "Code called after vehicle stops moving:<br>_this = [vehicle, impact speed]"],
			["Survivable Crashes", "Advanced"],
			"params[""_veh""];sleep (40 + random 40);_veh allowDamage true;_veh setDamage 1;", // Default Value
			true
		],
		[
			"r0ed_SurvivableCrashes_debugEnable",
			"CHECKBOX",
			["Enable Debug", "Tick enable debug messages to appear in RPT and systemChat"],
			["Survivable Crashes", "Advanced"],
			false
		]
	];
	{_x call CBA_Settings_fnc_init;} forEach _settings;

	[
		r0ed_SurvivableCrashes_modEnable,
		r0ed_SurvivableCrashes_vfxEnable,
		r0ed_SurvivableCrashes_sfxEnable,
		r0ed_SurvivableCrashes_efxEnable,
		r0ed_SurvivableCrashes_medicalSystem,
		r0ed_SurvivableCrashes_damageMultiplier,
		call compile r0ed_SurvivableCrashes_vehicleWhitelist,
		compile r0ed_SurvivableCrashes_onCrashCode,
		compile r0ed_SurvivableCrashes_onPostCrashCode,
		compile r0ed_SurvivableCrashes_vehicleRestCode
	] call compile preprocessFileLineNumbers "\r0ed_SurvivableCrashes\functions\init\init_survivableCrashes.sqf";

	// Log the details
	[format ["CBA Settings: %1", [
		r0ed_SurvivableCrashes_modEnable,
		r0ed_SurvivableCrashes_vfxEnable,
		r0ed_SurvivableCrashes_sfxEnable,
		r0ed_SurvivableCrashes_efxEnable,
		r0ed_SurvivableCrashes_medicalSystem,
		r0ed_SurvivableCrashes_damageMultiplier,
		call compile r0ed_SurvivableCrashes_vehicleWhitelist,
		compile r0ed_SurvivableCrashes_onCrashCode,
		compile r0ed_SurvivableCrashes_onPostCrashCode,
		compile r0ed_SurvivableCrashes_vehicleRestCode
	]], "SurvivableCrashes\XEH_preInit.sqf"] call r0ed_fnc_log;

	missionNamespace setVariable["r0ed_SurvivableCrashes_Initialized", true];
};
