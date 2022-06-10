function (event, ...)
  -- CONSTANTS

  local OBJECTIVE_TRACKER = (IsAddOnLoaded("!KalielsTracker") and _G["!KalielsTrackerFrame"]) or ObjectiveTrackerFrame

  local INSTANCE_CATEGORY = {
    ["raid"] = {
        3, -- 10 Player
        4, -- 25 Player
        5, -- 10 Player (Heroic)
        6, -- 25 Player (Heroic)
        -- 7, -- LFR (Legacy)
        9, -- 40 Player
        14, -- Raid (Normal)
        15, -- Raid (Heroic)
        16, -- Raid (Mythic)
        17, -- LFR
        -- 18, -- Event
        33, -- Timewalking
        151 -- LFR Timewalking
    },
    ["party"] = {
        1, -- Normal
        2, -- Heroic
        8, -- Mythic Keystone
        -- 19, -- Event
        23, -- Mythic M0
        24, -- Timewalking
        -- 150 -- Normal
    },
    ["pvp"] = {
        29, -- PvEvP Scenario
        34, -- PvP
        -- 45 -- PvP Scenario
    },
    ["torghast"] = 167
  }

  local HIDE_OBJECTIVES = 1
  local COLLAPSE_OBJECTIVES = 2
  local SHOW_AND_EXPAND_OBJECTIVES = 3

  -- UTIL

  local hideObjectives = function()
    OBJECTIVE_TRACKER:Hide()
  end

  local collapseObjectives = function()
    OBJECTIVE_TRACKER:Show()
    ObjectiveTracker_Collapse()
  end

  local showAndExpandObjectives = function()
    OBJECTIVE_TRACKER:Show()
    ObjectiveTracker_Expand()
  end

  local handleVisibilitySetting = function(setting)
    if (setting == HIDE_OBJECTIVES) then
      hideObjectives()
      return aura_env.config.shouldShowIconOnHide
    elseif (setting == COLLAPSE_OBJECTIVES) then
      collapseObjectives()
      return aura_env.config.shouldShowIconOnCollapse
    elseif (setting == SHOW_AND_EXPAND_OBJECTIVES) then
      showAndExpandObjectives()
      return false
    end
  end

  local compileInstanceSettings = function(instanceType, maxPlayers)
    local instanceSettings = {}
  
    if (instanceType == "party" and maxPlayers > 1) then
      for _, v in pairs(INSTANCE_CATEGORY.party) do
          instanceSettings[v] = aura_env.config.settingsDungeons
      end
    end
  
    if (instanceType == "raid") then
      for _, v in pairs(INSTANCE_CATEGORY.raid) do
        instanceSettings[v] = aura_env.config.settingsRaid
      end
    end
  
    if (instanceType == "pvp" or instanceType == "arena") then
      for _, v in pairs(INSTANCE_CATEGORY.pvp) do
          instanceSettings[v] = aura_env.config.settingsPvP
      end
    end
  
    instanceSettings[INSTANCE_CATEGORY.torghast] = aura_env.config.settingsTorghast
  
    return instanceSettings
  end

  -- LOGIC

  local _, instanceType, difficultyIndex, _, maxPlayers = GetInstanceInfo()
  local settings = compileInstanceSettings(instanceType, maxPlayers)

  local instanceSetting = settings[difficultyIndex]

  local visibilitySetting = instanceSetting or aura_env.config.settingsEverywhereElse

  return handleVisibilitySetting(visibilitySetting)
end
