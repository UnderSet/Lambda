if SERVER then
    AddCSLuaFile()
end

local MAPSCRIPT = {}
MAPSCRIPT.DefaultLoadout = {
    Weapons = {"weapon_lambda_medkit", "weapon_physcannon", "weapon_pistol", "weapon_smg1", "weapon_shotgun"},
    Ammo = {
        ["Pistol"] = 18,
        ["SMG1"] = 45,
        ["Buckshot"] = 12
    },
    Armor = 0,
    HEV = true
}

MAPSCRIPT.InputFilters = {}
MAPSCRIPT.EntityFilterByClass = {
    ["weapon_pistol"] = true -- The weapon is not a part of any spawner template so we have to remove it here
}
MAPSCRIPT.EntityFilterByName = {
    ["global_newgame_spawner_suit"] = true,
    ["global_newgame_spawner_physcannon"] = true,
    ["global_newgame_spawner_shotgun"] = true,
    ["global_newgame_spawner_smg"] = true,
    ["global_newgame_template_ammo"] = true,
    ["global_newgame_spawner_ammo"] = true
}

MAPSCRIPT.GlobalStates = {
    ["super_phys_gun"] = GLOBAL_OFF
}

MAPSCRIPT.Checkpoints = {
    {
        Pos = Vector(698, 38, 150),
        Ang = Angle(0, 90, 0),
        Trigger = {
            Pos = Vector(698, 38, 200),
            Mins = Vector(-62, -86, -56),
            Maxs = Vector(62, 86, 56)
        }
    },
    {
        Pos = Vector(-1803, 2079, -119),
        Ang = Angle(0, 90, 0),
        Trigger = {
            Pos = Vector(-1788, 2068, -86),
            Mins = Vector(-180, -150, -50),
            Maxs = Vector(180, 150, 50)
        }
    }
}

function MAPSCRIPT:PostInit()
    -- Add ar2 and frags to player loadout when entering the ambush room
    local loadoutTrigger = ents.Create("trigger_once")
    loadoutTrigger:SetupTrigger(Vector(1276, -428, 71), Angle(0, 90, 0), Vector(-27, -8, -55), Vector(27, 8, 55))
    loadoutTrigger.OnTrigger = function()
        DbgPrint("Adding AR2 and frags to player loadout")
        local loadout = GAMEMODE:GetMapScript().DefaultLoadout
        table.insert(loadout.Weapons, "weapon_ar2")
        table.insert(loadout.Weapons, "weapon_frag")
    end
end

function MAPSCRIPT:PostPlayerSpawn(ply)
end

return MAPSCRIPT