globals
trigger gg_trg_Melee_Initialization= null


//JASSHelper struct globals:

endglobals


//===========================================================================
//*
//*  Global variables
//*
//===========================================================================

function InitGlobals takes nothing returns nothing
 local integer i= 0
endfunction

//===========================================================================
//*
//*  Map Item Tables
//*
//===========================================================================
//===========================================================================
//*
//*  Unit Item Tables
//*
//===========================================================================
//===========================================================================
//*
//*  Sounds
//*
//===========================================================================
function InitSounds takes nothing returns nothing
endfunction
//===========================================================================
//*
//*  Destructable Objects
//*
//===========================================================================
function CreateDestructables takes nothing returns nothing
 local destructable d
 local trigger t
 local real life
endfunction
//===========================================================================
//*
//*  Items
//*
//===========================================================================
function CreateItems takes nothing returns nothing
 local integer itemID
endfunction
//===========================================================================
//*
//*  Unit Creation
//*
//===========================================================================
function CreateUnits takes nothing returns nothing
 local unit u
 local integer unitID
 local trigger t
 local real life
	set u=BlzCreateUnitWithSkin(Player(0), 'hfoo', - 230.2307, - 301.4792, 255.9343, 'hfoo')
	set u=BlzCreateUnitWithSkin(Player(0), 'hpea', - 129.6125, - 283.6453, 233.3238, 'hpea')
	set u=BlzCreateUnitWithSkin(Player(0), 'nfrl', - 43.0085, - 2931.5239, 277.2452, 'nfrl')
	set u=BlzCreateUnitWithSkin(Player(0), 'nfrl', - 811.5940, - 3568.9565, 56.4535, 'nfrl')
	set u=BlzCreateUnitWithSkin(Player(0), 'nfrg', 160.0796, - 3502.9846, 129.5556, 'nfrg')
	set u=BlzCreateUnitWithSkin(Player(0), 'nfr1', - 999.6355, - 3479.5576, 325.7144, 'nfr1')
	set u=BlzCreateUnitWithSkin(Player(0), 'nfr2', 290.9966, - 3293.5903, 229.7782, 'nfr2')
	set u=BlzCreateUnitWithSkin(Player(0), 'nfrb', - 780.0398, - 3323.5308, 29.6704, 'nfrb')
endfunction
//===========================================================================
//*
//*  Regions
//*
//===========================================================================
function CreateRegions takes nothing returns nothing
 local weathereffect we

endfunction
//===========================================================================
//*
//*  Cameras
//*
//===========================================================================
function CreateCameras takes nothing returns nothing
endfunction
//===========================================================================
//*
//*  Custom Script Code
//*
//===========================================================================
//===========================================================================
//*
//*  Triggers
//*
//===========================================================================
//===========================================================================
// Trigger: Melee_Initialization
//===========================================================================
function Trig_Melee_Initialization_Actions takes nothing returns nothing
	call MeleeStartingVisibility()
	call MeleeStartingHeroLimit()
	call MeleeGrantHeroItems()
	call MeleeStartingResources()
	call MeleeClearExcessUnits()
	call MeleeStartingUnits()
	call MeleeStartingAI()
	call MeleeInitVictoryDefeat()
endfunction

//===========================================================================
function InitTrig_Melee_Initialization takes nothing returns nothing
	set gg_trg_Melee_Initialization=CreateTrigger()
	call TriggerAddAction(gg_trg_Melee_Initialization, function Trig_Melee_Initialization_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
	call InitTrig_Melee_Initialization()
endfunction
//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
	call ConditionalTriggerExecute(gg_trg_Melee_Initialization)
endfunction
//===========================================================================
//*
//*  Players
//*
//===========================================================================
function InitCustomPlayerSlots takes nothing returns nothing
	call SetPlayerStartLocation(Player(0), 0)
	call SetPlayerColor(Player(0), ConvertPlayerColor(0))
	call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
	call SetPlayerRaceSelectable(Player(0), true)
	call SetPlayerController(Player(0), MAP_CONTROL_USER)

endfunction

function InitCustomTeams takes nothing returns nothing

	// Force: TRIGSTR_002
	call SetPlayerTeam(Player(0), 0)

endfunction
function InitAllyPriorities takes nothing returns nothing
	call SetStartLocPrioCount(0, 0)
endfunction
//===========================================================================
//*
//*  Main Initialization
//*
//===========================================================================
function main takes nothing returns nothing
	call SetCameraBounds(- 3328.000000 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3584.000000 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.000000 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.000000 - GetCameraMargin(CAMERA_MARGIN_TOP), - 3328.000000 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.000000 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.000000 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3584.000000 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
	call SetDayNightModels("Environment/DNC/DNCLordaeron/DNCLordaeronTerrain/DNCLordaeronTerrain.mdl", "Environment/DNC/DNCLordaeron/DNCLordaeronTerrain/DNCLordaeronTerrain.mdl")
	call NewSoundEnvironment("Default")
	call SetAmbientDaySound("LordaeronSummerDay")
	call SetAmbientNightSound("LordaeronSummerNight")
	call SetMapMusic("Music", true, 0)
	call InitSounds()
	call CreateRegions()
	call CreateCameras()
	call CreateDestructables()
	call CreateItems()
	call CreateUnits()
	call InitBlizzard()


	call InitGlobals()
	call InitTrig_Melee_Initialization() // INLINED!!
	call ConditionalTriggerExecute(gg_trg_Melee_Initialization) // INLINED!!
endfunction
//===========================================================================
//*
//*  Map Configuration
//*
//===========================================================================
function config takes nothing returns nothing
	call SetMapName("Just another Warcraft III map ")
	call SetMapDescription("Nondescript ")
	call SetPlayers(1)
	call SetTeams(1)
	call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

	call DefineStartLocation(0, - 1856, - 768)

	call InitCustomPlayerSlots()
	call SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
	call InitGenericPlayerSlots()
	call SetStartLocPrioCount(0, 0) // INLINED!!
endfunction



//Struct method generated initializers/callers:

