-- build_profiles.lua
-- Module for managing different Necromancer build profiles

local my_utility = require("my_utility/my_utility")

-- Build profile configurations
local build_profiles = {
    Default = {
        name = "Default",
        description = "All skills enabled based on menu settings",
        enabled_spells = "all", -- special value indicating all spells
    },
    BoneSpear = {
        name = "Bone Spear",
        description = "Bone Spear focused build",
        enabled_spells = {
            "bone_spear",
            "bone_splinters",
            "corpse_explosion",
            "corpse_tendrils",
            "blood_mist",
            "raise_skeleton",
            "golem_control",
        },
    },
    Blood = {
        name = "Blood",
        description = "Blood magic focused build",
        enabled_spells = {
            "blood_lance",
            "blood_surge",
            "blood_wave",
            "blood_mist",
            "hemorrhage",
            "corpse_explosion",
            "raise_skeleton",
            "golem_control",
        },
    },
    Minion = {
        name = "Minion",
        description = "Minion focused build",
        enabled_spells = {
            "raise_skeleton",
            "golem_control",
            "corpse_explosion",
            "corpse_tendrils",
            "bone_spear",
            "blood_mist",
            "decrepify",
            "army_of_the_dead",
        },
    },
}

-- Get available profile names for menu
local function get_profile_names()
    local names = {}
    for profile_name, _ in pairs(build_profiles) do
        table.insert(names, profile_name)
    end
    table.sort(names)
    return names
end

-- Get profile by name
local function get_profile(profile_name)
    return build_profiles[profile_name]
end

-- Check if a spell is enabled in the current profile
local function is_spell_enabled_in_profile(spell_module_name, profile_name)
    local profile = get_profile(profile_name)
    
    if not profile then
        return true -- If profile not found, enable all
    end
    
    if profile.enabled_spells == "all" then
        return true -- All spells enabled
    end
    
    -- Check if spell is in the profile's enabled list
    for _, enabled_spell in ipairs(profile.enabled_spells) do
        if enabled_spell == spell_module_name then
            return true
        end
    end
    
    return false
end

-- Build profile menu state
local menu_elements = {
    profile_combo = combo_box:new(0, get_hash(my_utility.plugin_label .. "build_profile_combo")),
}

-- Get current selected profile name
local function get_current_profile()
    local profile_names = get_profile_names()
    local selected_index = menu_elements.profile_combo:get()
    
    -- Ensure Default is first in the list
    local ordered_names = {"Default"}
    for _, name in ipairs(profile_names) do
        if name ~= "Default" then
            table.insert(ordered_names, name)
        end
    end
    
    -- Convert 0-based combo box index to 1-based Lua array index
    if selected_index >= 0 and selected_index < #ordered_names then
        local lua_index = selected_index + 1
        return ordered_names[lua_index]
    end
    
    return "Default"
end

-- Render build profile menu
local function render_menu()
    -- Build profile names list for combo box
    local profile_names = get_profile_names()
    
    -- Ensure Default is first
    local ordered_names = {"Default"}
    for _, name in ipairs(profile_names) do
        if name ~= "Default" then
            table.insert(ordered_names, name)
        end
    end
    
    menu_elements.profile_combo:render("Build Profile", ordered_names, "Select which build profile to use")
end

return {
    build_profiles = build_profiles,
    get_profile_names = get_profile_names,
    get_profile = get_profile,
    is_spell_enabled_in_profile = is_spell_enabled_in_profile,
    get_current_profile = get_current_profile,
    render_menu = render_menu,
    menu_elements = menu_elements,
}
