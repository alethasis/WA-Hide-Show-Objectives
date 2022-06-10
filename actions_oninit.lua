-- CONSTANTS
aura_env.INSTANCE_CATEGORY = {
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
        24 -- Timewalking
        -- 150 -- Normal
    },
    ["pvp"] = {
        29, -- PvEvP Scenario
        34 -- PvP
        -- 45 -- PvP Scenario
    },
    ["torghast"] = 167
}

aura_env.HIDE_OBJECTIVES = 1
aura_env.COLLAPSE_ALL_OBJECTIVES = 2
aura_env.SHOW_AND_EXPAND_OBJECTIVES = 3
aura_env.COLLAPSE_ALL_BUT_INSTANCE = 4

--[[
  https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/AddOns/Blizzard_ObjectiveTracker/Blizzard_ObjectiveTracker.lua#L794
  
  ACHIEVEMENT_TRACKER_MODULE
  BONUS_OBJECTIVE_TRACKER_MODULE
  CAMPAIGN_QUEST_TRACKER_MODULE
  QUEST_TRACKER_MODULE
  SCENARIO_CONTENT_TRACKER_MODULE -- Show in Dungeons
  UI_WIDGET_TRACKER_MODULE
  WORLD_QUEST_TRACKER_MODULE

]]

-- UTIL
aura_env.hideObjectives = function() aura_env.OBJECTIVE_TRACKER:Hide() end

aura_env.setCollapsed = function(module, shouldCollapse)
    local isCollapsed = module:IsCollapsed() and true or false -- is `nil` onLoad

    if (shouldCollapse ~= isCollapsed) then
        module.Header.MinimizeButton:Click()
    end
end

aura_env.collapseAllObjectives = function()
    aura_env.OBJECTIVE_TRACKER:Show()
    ObjectiveTracker_Collapse()
end

aura_env.showAndExpandObjectives = function()
    aura_env.OBJECTIVE_TRACKER:Show()
    ObjectiveTracker_Expand()

    aura_env.setCollapsed(ACHIEVEMENT_TRACKER_MODULE, false)
    aura_env.setCollapsed(BONUS_OBJECTIVE_TRACKER_MODULE, false)
    aura_env.setCollapsed(CAMPAIGN_QUEST_TRACKER_MODULE, false)
    aura_env.setCollapsed(QUEST_TRACKER_MODULE, false)
    aura_env.setCollapsed(WORLD_QUEST_TRACKER_MODULE, false)
end

aura_env.collapseAllButInstance = function()
    aura_env.showAndExpandObjectives()

    aura_env.setCollapsed(ACHIEVEMENT_TRACKER_MODULE, true)
    aura_env.setCollapsed(BONUS_OBJECTIVE_TRACKER_MODULE, true)
    aura_env.setCollapsed(CAMPAIGN_QUEST_TRACKER_MODULE, true)
    aura_env.setCollapsed(QUEST_TRACKER_MODULE, true)
    aura_env.setCollapsed(WORLD_QUEST_TRACKER_MODULE, true)
end

aura_env.handleVisibilitySetting = function(setting)
    if (setting == aura_env.HIDE_OBJECTIVES) then
        aura_env.hideObjectives()
        return aura_env.config.shouldShowIconOnHide
    elseif (setting == aura_env.COLLAPSE_ALL_OBJECTIVES) then
        aura_env.collapseAllObjectives()
        return aura_env.config.shouldShowIconOnCollapse
    elseif (setting == aura_env.SHOW_AND_EXPAND_OBJECTIVES) then
        aura_env.showAndExpandObjectives()
        return false
    elseif (setting == aura_env.COLLAPSE_ALL_BUT_INSTANCE) then
        aura_env.collapseAllButInstance()
        return aura_env.config.shouldShowIconOnCollapse
    end
end

aura_env.getInstanceSettings = function(instanceType, maxPlayers)
    local instanceSettings = {}

    if (instanceType == "party" and maxPlayers > 1) then
        for _, v in pairs(aura_env.INSTANCE_CATEGORY.party) do
            instanceSettings[v] = aura_env.config.settingsDungeons
        end
    end

    if (instanceType == "raid") then
        for _, v in pairs(aura_env.INSTANCE_CATEGORY.raid) do
            instanceSettings[v] = aura_env.config.settingsRaid
        end
    end

    if (instanceType == "pvp" or instanceType == "arena") then
        for _, v in pairs(aura_env.INSTANCE_CATEGORY.pvp) do
            instanceSettings[v] = aura_env.config.settingsPvP
        end
    end

    instanceSettings[aura_env.INSTANCE_CATEGORY.torghast] = aura_env.config
                                                                .settingsTorghast

    return instanceSettings
end

-- INIT
aura_env.OBJECTIVE_TRACKER = (IsAddOnLoaded("!KalielsTracker") and
                                 _G["!KalielsTrackerFrame"]) or
                                 ObjectiveTrackerFrame
