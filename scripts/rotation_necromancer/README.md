# Necromancer Rotation - Enhanced Edition

## Version 2.0 - Build Profiles + Equipped Skills

This enhanced version of the Necromancer rotation plugin adds two major features inspired by the Sorcerer build structure:

### New Features

#### 1. Build Profiles
Select from pre-configured build profiles that enable only relevant spells for specific playstyles:

- **Default**: All skills enabled based on individual menu settings (backward compatible)
- **Bone Spear**: Bone Spear focused build with supporting skills
- **Blood**: Blood magic focused build (Blood Lance, Blood Surge, Blood Wave, etc.)
- **Minion**: Minion master build focused on summoning and supporting minions

**How to use:**
1. Open the plugin menu
2. Select your desired build from the "Build Profile" dropdown
3. The rotation will automatically filter spells based on the selected profile

#### 2. Equipped Skills Detection
Enable automatic detection of skills on your skill bar to only cast spells you have equipped.

**How to use:**
1. Check "Only Use Equipped Skills" in the plugin menu
2. The plugin will automatically detect your equipped spells
3. Only spells on your skill bar will be cast during rotation

### Features Combined
Both features work together:
- Select a build profile to focus on a specific playstyle
- Enable "Only Use Equipped Skills" to ensure only your equipped abilities are used
- Individual spell settings in the menu still apply for fine-tuning

### Backward Compatibility
- Uses the "Default" profile by default, maintaining original behavior
- All existing spell configurations are preserved
- No changes required to existing spell modules

### Technical Implementation
Following the Sorcerer rotation structure:

1. **equipped_skills.lua**: Module for detecting and managing equipped skills
   - Auto-detects spells on skill bar using `get_equipped_spell_ids()`
   - Maps spell IDs to module names
   - Provides filtering functions

2. **build_profiles.lua**: Module for managing build profiles
   - Defines multiple build configurations
   - Provides profile selection and filtering
   - Menu integration for profile selection

3. **main.lua**: Enhanced with filtering logic
   - `should_use_spell()` helper function checks both filters
   - All spell calls updated to respect filters
   - Cleaner structure inspired by Sorcerer rotation

### Spell ID Reference
The plugin tracks all Necromancer skills:
- Blood Mist (493422)
- Bone Spear (432879)
- Bone Splinters (500962)
- Corpse Explosion (432897)
- Corpse Tendrils (463349)
- Decrepify (915150)
- Hemorrhage (484661)
- Reap (432896)
- Blood Lance (501629)
- Blood Surge (592163)
- Blight (481293)
- Sever (481785)
- Bone Prison (493453)
- Iron Maiden (915152)
- Bone Spirit (469641)
- Blood Wave (658216)
- Army of the Dead (497193)
- Bone Storm (499281)
- Raise Skeleton (1059157)
- Golem Control (440463)

### Usage Examples

**Example 1: Bone Spear Build with Equipped Skills Only**
1. Equip Bone Spear build on your skill bar
2. Select "Bone Spear" profile
3. Enable "Only Use Equipped Skills"
4. Result: Only Bone Spear and supporting skills that are equipped will cast

**Example 2: Custom Build**
1. Select "Default" profile
2. Enable "Only Use Equipped Skills"
3. Configure individual spell settings in menu
4. Result: Full customization based on your equipped skills

**Example 3: Profile-Based (Classic)**
1. Select any build profile
2. Keep "Only Use Equipped Skills" disabled
3. Result: Profile determines which spells are used, regardless of equipment
