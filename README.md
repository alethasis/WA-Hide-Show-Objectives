# Hide/Collapse Objectives and Quests

https://wago.io/WHMWWJawe

Hide/Collapse Objectives and Quests Tracker while in Dungeons, Raid, PvP, and/or Torghast.

Under "Custom Options", configure what to do for each location setting -- Dungeons, Raid, PvP, Torghast, and "Everywhere Else":

• Hide
• Collapse All
• Show & Expand
• Collapse All But Instance (will constinue to show M+ info, Torghast info, etc.)

**Note:**
With the recent update to add "Collapse All But Instance", I moved the bulk of the code out of the trigger and into the `actions_oninit` function. This should work (and be more performant), however, when I first made this WA it seemed like that was causing issues for some people. Eventually, I put everything into the trigger to ensure all of the data would be available when needed.

Please, let me know if you start encountering issues again, and I can move stuff back into the trigger.

Also, the recent changes to "Collapse All But Instance" have not been tested with "Kaliel's Tracker". If you use Kaliel's and have issues, let me know and I'll look into it. If I have to make a choice, I'm not going to support Kaliel's Tracker. But in theory I should be able to make my WA compatible with it.
