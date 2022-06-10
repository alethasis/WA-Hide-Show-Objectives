function (event, ...)
    aura_env.OBJECTIVE_TRACKER = (IsAddOnLoaded("!KalielsTracker") and
                                     _G["!KalielsTrackerFrame"]) or
                                     ObjectiveTrackerFrame

    local _, instanceType, difficultyIndex, _, maxPlayers = GetInstanceInfo()

    local settings = aura_env.getInstanceSettings(instanceType, maxPlayers)

    local instanceSetting = settings[difficultyIndex]

    local visibilitySetting = instanceSetting or
                                  aura_env.config.settingsEverywhereElse

    return aura_env.handleVisibilitySetting(visibilitySetting)
end
