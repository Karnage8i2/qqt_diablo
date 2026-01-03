-- equipped_skills.lua
-- Module for detecting and managing equipped skills on the skill bar

local equipped_skills = {}

-- Get equipped spell IDs from the player's skill bar
local function get_equipped_spells()
    local spell_ids = get_equipped_spell_ids() -- Returns a table of 6 spell IDs
    if not spell_ids then
        return {}
    end
    
    -- Convert to a set for faster lookup
    local equipped_set = {}
    for _, id in ipairs(spell_ids) do
        equipped_set[id] = true
    end
    
    return equipped_set
end

-- Check if a spell is equipped
local function is_spell_equipped(spell_id)
    local equipped = get_equipped_spells()
    return equipped[spell_id] == true
end

-- Get list of equipped spell names (for debugging)
local function get_equipped_spell_names()
    local spell_ids = get_equipped_spell_ids()
    local names = {}
    
    if not spell_ids then
        return names
    end
    
    for _, spell_id in ipairs(spell_ids) do
        if spell_id > 1 then
            local spell_name = get_name_for_spell(spell_id)
            table.insert(names, {id = spell_id, name = spell_name})
        end
    end
    
    return names
end

-- Map spell IDs to their module names for Necromancer
local spell_id_map = {
    [493422] = "blood_mist",         -- Blood Mist
    [432879] = "bone_spear",         -- Bone Spear
    [500962] = "bone_splinters",     -- Bone Splinters
    [432897] = "corpse_explosion",   -- Corpse Explosion
    [463349] = "corpse_tendrils",    -- Corpse Tendrils
    [915150] = "decrepify",          -- Decrepify
    [484661] = "hemorrhage",         -- Hemorrhage
    [432896] = "reap",               -- Reap
    [501629] = "blood_lance",        -- Blood Lance
    [592163] = "blood_surge",        -- Blood Surge
    [481293] = "blight",             -- Blight
    [481785] = "sever",              -- Sever
    [493453] = "bone_prison",        -- Bone Prison
    [915152] = "iron_maiden",        -- Iron Maiden
    [469641] = "bone_spirit",        -- Bone Spirit
    [658216] = "blood_wave",         -- Blood Wave
    [497193] = "army_of_the_dead",   -- Army of the Dead
    [499281] = "bone_storm",         -- Bone Storm
    [1059157] = "raise_skeleton",    -- Raise Skeleton
    [440463] = "golem_control",      -- Golem Control
}

-- Get list of equipped spell modules for rotation
local function get_equipped_spell_modules(all_spells)
    local equipped = get_equipped_spells()
    local equipped_modules = {}
    
    for spell_id, module_name in pairs(spell_id_map) do
        if equipped[spell_id] and all_spells[module_name] then
            table.insert(equipped_modules, {
                module_name = module_name,
                spell_id = spell_id,
                spell_module = all_spells[module_name]
            })
        end
    end
    
    return equipped_modules
end

return {
    get_equipped_spells = get_equipped_spells,
    is_spell_equipped = is_spell_equipped,
    get_equipped_spell_names = get_equipped_spell_names,
    get_equipped_spell_modules = get_equipped_spell_modules,
    spell_id_map = spell_id_map,
}
