import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DelvingHelper.Data";

-- ============================================================================
-- DelvingHelper v1.5.8
-- Dedicated Delving Writs Farm, Mission Pools & Burglar Speedrun Tracker
-- Developed by Antigravity & Andy
-- Strict 7-bit ASCII text only to avoid '??' glyph rendering issues in LOTRO.
-- ============================================================================

DelvingHelper = DelvingHelper or {};
local DH = DelvingHelper;
local D = DelvingHelper.Data;

local PLUGIN_VERSION = "1.5.16";

-- ----------------------------------------------------------------------------
-- Safe Callback Registration
-- ----------------------------------------------------------------------------
local function AddCallback(object, event, callback)
    if not object or not callback then return callback end
    local prev = object[event];
    if prev == nil then
        object[event] = callback;
    else
        object[event] = function(sender, args)
            pcall(prev, sender, args);
            pcall(callback, sender, args);
        end
    end
    return callback;
end

-- ----------------------------------------------------------------------------
-- Colors Palette
-- ----------------------------------------------------------------------------
local Colors = {
    Gold        = Turbine.UI.Color(1.00, 0.82, 0.25),
    BrightGold  = Turbine.UI.Color(1.00, 0.92, 0.45),
    White       = Turbine.UI.Color(0.95, 0.95, 0.95),
    Gray        = Turbine.UI.Color(0.65, 0.65, 0.65),
    LightGray   = Turbine.UI.Color(0.80, 0.80, 0.80),
    DarkGray    = Turbine.UI.Color(0.25, 0.25, 0.28),
    Green       = Turbine.UI.Color(0.35, 0.90, 0.35),
    BrightGreen = Turbine.UI.Color(0.25, 1.00, 0.35),
    Cyan        = Turbine.UI.Color(0.35, 0.85, 1.00),
    Orange      = Turbine.UI.Color(1.00, 0.55, 0.15),
    Red         = Turbine.UI.Color(0.95, 0.30, 0.25),
    CardBg      = Turbine.UI.Color(0.90, 0.08, 0.09, 0.11),
    CardDoneBg  = Turbine.UI.Color(0.90, 0.05, 0.10, 0.07),
    Border      = Turbine.UI.Color(0.40, 0.38, 0.28),
    BorderGreen = Turbine.UI.Color(0.85, 0.18, 0.55, 0.24),
    BorderGold  = Turbine.UI.Color(0.80, 0.65, 0.20),
    BarBg       = Turbine.UI.Color(0.12, 0.12, 0.15),
    EmeraldText = Turbine.UI.Color(0.20, 0.95, 0.60),
    EmeraldBorder = Turbine.UI.Color(0.12, 0.72, 0.45),
    EmeraldBg   = Turbine.UI.Color(0.85, 0.05, 0.16, 0.10),
    PurpleText  = Turbine.UI.Color(0.92, 0.78, 1.00),
    PurpleBorder= Turbine.UI.Color(0.68, 0.38, 0.98),
    PurpleBg    = Turbine.UI.Color(0.88, 0.14, 0.06, 0.22),
};

local function ApplyBorder(parent, color, thickness)
    if not parent then return end
    thickness = thickness or 1;
    color = color or Colors.BorderGold;
    local w = parent:GetWidth();
    local h = parent:GetHeight();
    local function MakeLine(x, y, lw, lh)
        local line = Turbine.UI.Control();
        line:SetParent(parent);
        line:SetPosition(x, y);
        line:SetSize(lw, lh);
        line:SetBackColor(color);
        line:SetMouseVisible(false);
        return line;
    end
    MakeLine(0, 0, w, thickness);
    MakeLine(0, h - thickness, w, thickness);
    MakeLine(0, 0, thickness, h);
    MakeLine(w - thickness, 0, thickness, h);
end

local function ApplySmoothedBorder(parent, borderColor, radius, innerColor)
    if not parent then return end
    radius = radius or 2;
    local w = parent:GetWidth();
    local h = parent:GetHeight();
    if w <= radius * 2 or h <= radius * 2 then return end

    local top = Turbine.UI.Control();
    top:SetParent(parent);
    top:SetPosition(radius, 0);
    top:SetSize(w - radius * 2, 1);
    top:SetBackColor(borderColor);
    top:SetMouseVisible(false);

    local bot = Turbine.UI.Control();
    bot:SetParent(parent);
    bot:SetPosition(radius, h - 1);
    bot:SetSize(w - radius * 2, 1);
    bot:SetBackColor(borderColor);
    bot:SetMouseVisible(false);

    local left = Turbine.UI.Control();
    left:SetParent(parent);
    left:SetPosition(0, radius);
    left:SetSize(1, h - radius * 2);
    left:SetBackColor(borderColor);
    left:SetMouseVisible(false);

    local right = Turbine.UI.Control();
    right:SetParent(parent);
    right:SetPosition(w - 1, radius);
    right:SetSize(1, h - radius * 2);
    right:SetBackColor(borderColor);
    right:SetMouseVisible(false);

    local function MakeCornerDot(x, y)
        local d = Turbine.UI.Control();
        d:SetParent(parent);
        d:SetPosition(x, y);
        d:SetSize(1, 1);
        d:SetBackColor(borderColor);
        d:SetMouseVisible(false);
        return d;
    end
    MakeCornerDot(1, 1);
    MakeCornerDot(w - 2, 1);
    MakeCornerDot(1, h - 2);
    MakeCornerDot(w - 2, h - 2);

    if innerColor then
        local inTop = Turbine.UI.Control();
        inTop:SetParent(parent);
        inTop:SetPosition(radius + 1, 1);
        inTop:SetSize(w - (radius + 1) * 2, 1);
        inTop:SetBackColor(innerColor);
        inTop:SetMouseVisible(false);

        local inBot = Turbine.UI.Control();
        inBot:SetParent(parent);
        inBot:SetPosition(radius + 1, h - 2);
        inBot:SetSize(w - (radius + 1) * 2, 1);
        inBot:SetBackColor(innerColor);
        inBot:SetMouseVisible(false);

        local inLeft = Turbine.UI.Control();
        inLeft:SetParent(parent);
        inLeft:SetPosition(1, radius + 1);
        inLeft:SetSize(1, h - (radius + 1) * 2);
        inLeft:SetBackColor(innerColor);
        inLeft:SetMouseVisible(false);

        local inRight = Turbine.UI.Control();
        inRight:SetParent(parent);
        inRight:SetPosition(w - 2, radius + 1);
        inRight:SetSize(1, h - (radius + 1) * 2);
        inRight:SetBackColor(innerColor);
        inRight:SetMouseVisible(false);
    end
end

-- ----------------------------------------------------------------------------
-- Character & Class State
-- ----------------------------------------------------------------------------
DH.isBurglar = false;
DH.playerClass = "Unknown";
DH.playerName = "Player";

local function DetectPlayer()
    local player = Turbine.Gameplay.LocalPlayer.GetInstance();
    if player then
        DH.playerName = player:GetName() or "Player";
        local pClass = player:GetClass();
        for className, classId in pairs(Turbine.Gameplay.Class) do
            if pClass == classId then
                DH.playerClass = className;
                break;
            end
        end
        if DH.playerClass == "Burglar" or pClass == Turbine.Gameplay.Class.Burglar then
            DH.isBurglar = true;
        end
    end
end

-- ----------------------------------------------------------------------------
-- Default Settings & Data Structure
-- ----------------------------------------------------------------------------
local defaultSettings = {
    winX = 180,
    winY = 100,
    winW = 660,
    winH = 680,
    winVisible = false,

    iconX = 220,
    iconY = 60,
    showIcon = true,
    lockIcon = false,

    filterHub = "all",
    favorites = {},
    speedrunOnly = false,
    searchText = "",
    filterIncomplete = false,
    viewMode = "missions", -- "missions", "malice", "writs"
    profileMode = "auto",  -- "auto", "burglar", "standard"
    autoBurglar = true,    -- automatically select Burglar route on Burglar character

    selectedDayOverride = 0, -- 0 = auto today, 1..7 = specific day, -1 = all runs
    serverResetHour = 3,     -- 03:00 Server Time
    clientUtcOffset = 3,     -- Client UTC offset (default 3 for MSK / Moscow Time)
    
    autoTrack = true,        -- auto-detect mission completions from chat
    announceChat = true,     -- print chat notice on mission completion
    warnUnknown = true,      -- warn when taking a mission not in DelvingHelper database

    completedMissions = {},  -- [shortName] = true
    dateKey = "",            -- "YYYY-MM-DD" (Server date)
    weekKey = "",            -- "YYYY-MM-DD" (LOTRO Thursday week date)
    weekly10Done = false,    -- true if weekly 10 delvings wrapper is done for the week
    dailyGoal = 10,
    weeklyGoal = 15,
    weekly45Goal = 45,
    countDaily = 0,          -- High tier delvings (tier 6 and higher) (0/10)
    countWeekly = 0,         -- On A Mission (Weekly) (0/15)
    countWeekly45 = 0,       -- On A Continuing Mission (Weekly) (0/45)
    manualOffset = 0,
    manualOffsetDaily = 0,
    manualOffsetWeekly = 0,
    manualOffsetWeekly45 = 0,
    showTravelTray = true,   -- Collapsible Fast Travel & Return Maps tray (Option 3)
    customTravelSlots = {},  -- [slotId] = { type = shortcutType, data = shortcutData }
};

DH.settings = {};

local function GetEffectiveProfile()
    return "burglar";
end

-- ----------------------------------------------------------------------------
-- Screen Boundaries Helper
-- ----------------------------------------------------------------------------
local function ClampToScreen(x, y, w, h)
    local screenW = Turbine.UI.Display:GetWidth();
    local screenH = Turbine.UI.Display:GetHeight();
    if x < 0 then x = 0; end
    if y < 0 then y = 0; end
    if x + w > screenW then x = math.max(0, screenW - w); end
    if y + h > screenH then y = math.max(0, screenH - h); end
    return x, y;
end

-- ----------------------------------------------------------------------------
-- Persistence (Save & Load)
-- ----------------------------------------------------------------------------
local function SaveSettings()
    local ok = pcall(function()
        Turbine.PluginData.Save(Turbine.DataScope.Character, "DelvingHelperSettings", DH.settings);
    end);
    if not ok then
        pcall(function()
            Turbine.PluginData.Save(Turbine.DataScope.Account, "DelvingHelperSettings", DH.settings);
        end);
    end
end

local function LoadSettings()
    local loaded = nil;
    pcall(function()
        loaded = Turbine.PluginData.Load(Turbine.DataScope.Character, "DelvingHelperSettings");
    end);
    if not loaded then
        pcall(function()
            loaded = Turbine.PluginData.Load(Turbine.DataScope.Account, "DelvingHelperSettings");
        end);
    end

    DH.settings = {};
    for k, v in pairs(defaultSettings) do
        if loaded and loaded[k] ~= nil then
            DH.settings[k] = loaded[k];
        else
            DH.settings[k] = v;
        end
    end

    DH.settings.winW = 660;
    DH.settings.winH = 680;

    if type(DH.settings.favorites) ~= "table" then
        DH.settings.favorites = {};
    end

    if type(DH.settings.customTravelSlots) ~= "table" then
        DH.settings.customTravelSlots = {};
    end

    if type(DH.settings.completedMissions) ~= "table" then
        DH.settings.completedMissions = {};
    else
        local timeTable = Turbine.Engine.GetDate();
        local autoDay = D.GetActiveRotationDay(timeTable, DH.settings.serverResetHour);
        local curDayPrefix = tostring(autoDay) .. ":";
        local migrated = {};
        for k, v in pairs(DH.settings.completedMissions) do
            if not string.find(tostring(k), ":") then
                migrated[curDayPrefix .. tostring(k)] = v;
            else
                migrated[k] = v;
            end
        end
        DH.settings.completedMissions = migrated;
    end

    if DH.settings.filterHub == "clegur" or DH.settings.filterHub == "mattugard" or DH.settings.filterHub == "gundabad" then
        DH.settings.filterHub = "all";
    end

    if DH.settings.filterHub == "favorites" then
        DH.settings.selectedDayOverride = -1;
    end

    DH.settings.speedrunOnly = false;

    local checked = 0;
    for _, done in pairs(DH.settings.completedMissions) do
        if done == true then checked = checked + 1; end
    end

    if DH.settings.countDaily == nil then
        if DH.settings.manualOffsetDaily ~= nil then
            DH.settings.countDaily = checked + (DH.settings.manualOffsetDaily or 0);
        else
            DH.settings.countDaily = 0;
        end
    end

    if DH.settings.countWeekly == nil then
        if DH.settings.manualOffsetWeekly ~= nil then
            DH.settings.countWeekly = checked + (DH.settings.manualOffsetWeekly or 0);
        else
            DH.settings.countWeekly = 0;
        end
    end

    if DH.settings.countWeekly45 == nil then
        if DH.settings.manualOffsetWeekly45 ~= nil then
            DH.settings.countWeekly45 = checked + (DH.settings.manualOffsetWeekly45 or 0);
        else
            DH.settings.countWeekly45 = 0;
        end
    end

    if DH.settings.manualOffsetDaily == nil then
        DH.settings.manualOffsetDaily = DH.settings.countDaily;
    end

    if DH.settings.manualOffsetWeekly == nil then
        DH.settings.manualOffsetWeekly = DH.settings.countWeekly;
    end

    if DH.settings.manualOffsetWeekly45 == nil then
        DH.settings.manualOffsetWeekly45 = DH.settings.countWeekly45;
    end

    if DH.settings.weekly45Goal == nil then
        DH.settings.weekly45Goal = 45;
    end

    DetectPlayer();
end

-- ----------------------------------------------------------------------------
-- Date & Daily Reset Logic
-- ----------------------------------------------------------------------------
local function GetCurrentTimeTable()
    local localTime = Turbine.Engine.GetDate();
    local offset = (DH.settings and DH.settings.clientUtcOffset) or 3;
    return D.GetServerTimeTable(localTime, offset);
end

local function GetDateKey(timeTable)
    return string.format("%04d-%02d-%02d", timeTable.Year, timeTable.Month, timeTable.Day);
end

local function CountCompletedCheckboxes()
    local count = 0;
    if DH.settings and DH.settings.completedMissions then
        for _, done in pairs(DH.settings.completedMissions) do
            if done == true then
                count = count + 1;
            end
        end
    end
    return count;
end

local function CountCompletedDaily()
    local maxGoal = (DH.settings and DH.settings.dailyGoal) or 10;
    local total = (DH.settings and DH.settings.countDaily) or 0;
    if total < 0 then total = 0; end
    if total > maxGoal then total = maxGoal; end
    return total;
end

local function CountCompletedWeekly()
    local maxGoal = (DH.settings and DH.settings.weeklyGoal) or 15;
    local total = (DH.settings and DH.settings.countWeekly) or 0;
    if total < 0 then total = 0; end
    if total > maxGoal then total = maxGoal; end
    return total;
end

local function CountCompletedWeekly45()
    local maxGoal = (DH.settings and DH.settings.weekly45Goal) or 45;
    local total = (DH.settings and DH.settings.countWeekly45) or 0;
    if total < 0 then total = 0; end
    if total > maxGoal then total = maxGoal; end
    return total;
end

local function CountCompletedToday()
    return CountCompletedDaily();
end

local function CheckDailyReset(timeTable)
    -- 1. Daily Rotation Day Transition (every day at 03:00 Server Time = 10:00 MSK summer / 11:00 MSK winter)
    -- Advances the rotation day tab and Malice variant. Delving counters (10/10 & 15/15) are weekly and NOT reset here.
    local curKey = GetDateKey(timeTable);
    if DH.settings.dateKey ~= curKey then
        DH.settings.dateKey = curKey;

        -- Daily mission checkboxes cleanup:
        -- When a new day arrives, clear stale checkboxes for today's active day
        -- so today's rotation cards always start fresh and unchecked.
        local autoDay = D.GetActiveRotationDay(timeTable, DH.settings.serverResetHour);
        if DH.settings.completedMissions then
            local dayPrefix = tostring(autoDay) .. ":";
            for key, _ in pairs(DH.settings.completedMissions) do
                if key:sub(1, #dayPrefix) == dayPrefix then
                    DH.settings.completedMissions[key] = nil;
                end
            end
        end

        SaveSettings();
        if RefreshMainWindow then RefreshMainWindow(); end
        if RefreshIconBadge then RefreshIconBadge(); end
    end

    -- 2. Weekly Reset (every Thursday at 03:00 Server Time = 10:00 MSK summer / 11:00 MSK winter)
    -- Both Delvings (10/10) and Delvings on any difficulty (15/15) are WEEKLY wrapper quests.
    -- In LOTRO, a weekly wrapper quest ONLY resets on Thursday IF IT WAS COMPLETED (10/10 or 15/15, green).
    -- Incomplete progress (e.g. 6/10 or 14/15) is NEVER wiped; it carries over into the next week!
    local curWeekKey = D.GetLotroWeekKey(timeTable);
    if DH.settings.weekKey ~= curWeekKey then
        local isFirstRun = (DH.settings.weekKey == "" or DH.settings.weekKey == nil);
        if not isFirstRun then
            local curDaily = CountCompletedDaily();
            local curWeekly = CountCompletedWeekly();
            local curWeekly45 = CountCompletedWeekly45();
            local dailyGoal = DH.settings.dailyGoal or 10;
            local weeklyGoal = DH.settings.weeklyGoal or 15;
            local weekly45Goal = DH.settings.weekly45Goal or 45;
            local dailyDone = (curDaily >= dailyGoal);
            local weeklyDone = (curWeekly >= weeklyGoal);
            local weekly45Done = (curWeekly45 >= weekly45Goal);

            -- Reset individual mission checkboxes for the new week's rotation pool
            DH.settings.completedMissions = {};

            -- 10 Delvings wrapper (Delve into the Darkness)
            if dailyDone then
                DH.settings.countDaily = 0;
                DH.settings.manualOffsetDaily = 0;
                DH.settings.weekly10Done = false;
            else
                -- Incomplete (e.g. 6/10): preserve exact progress!
                DH.settings.countDaily = curDaily;
                DH.settings.manualOffsetDaily = curDaily;
            end

            -- 15 Missions wrapper (On a Mission)
            if weeklyDone then
                DH.settings.countWeekly = 0;
                DH.settings.manualOffsetWeekly = 0;
            else
                -- Incomplete (e.g. 14/15): preserve exact progress!
                DH.settings.countWeekly = curWeekly;
                DH.settings.manualOffsetWeekly = curWeekly;
            end

            -- 45 Missions wrapper (On a Continuing Mission)
            if weekly45Done then
                DH.settings.countWeekly45 = 0;
                DH.settings.manualOffsetWeekly45 = 0;
            else
                -- Incomplete (e.g. 30/45): preserve exact progress!
                DH.settings.countWeekly45 = curWeekly45;
                DH.settings.manualOffsetWeekly45 = curWeekly45;
            end

            DH.settings.weekKey = curWeekKey;
            SaveSettings();
            if RefreshMainWindow then RefreshMainWindow(); end
            if RefreshIconBadge then RefreshIconBadge(); end

            if DH.settings.announceChat then
                Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Weekly Reset: Delvings (%d/%d), Missions (%d/%d), Continuing (%d/%d) progress updated.</rgb>",
                    curDaily, dailyGoal, curWeekly, weeklyGoal, curWeekly45, weekly45Goal));
            end
        else
            DH.settings.weekKey = curWeekKey;
            SaveSettings();
        end
    end
end

local function GetSecondsUntilReset(timeTable, resetHour)
    resetHour = resetHour or 3;
    local currentSec = timeTable.Hour * 3600 + timeTable.Minute * 60 + timeTable.Second;
    local resetSec = resetHour * 3600;
    local diff = resetSec - currentSec;
    if diff <= 0 then
        diff = diff + 86400;
    end
    return diff;
end

local function FormatDuration(seconds)
    local h = math.floor(seconds / 3600);
    local m = math.floor((seconds % 3600) / 60);
    local s = seconds % 60;
    return string.format("%02dh %02dm %02ds", h, m, s);
end

local function FormatDurationShort(seconds)
    local h = math.floor(seconds / 3600);
    local m = math.floor((seconds % 3600) / 60);
    return string.format("%dh %02dm", h, m);
end

-- ----------------------------------------------------------------------------
-- Forward Declarations
-- ----------------------------------------------------------------------------
local mainWindow = nil;
local iconWindow = nil;
local quickSettingsWindow = nil;
local optionsPanel = nil;
local updateTimer = nil;
local RefreshMainWindow = nil;
local RefreshIconBadge = nil;
local UpdateOptionsUI = nil;
local TriggerReloadPlugin = nil;
local updatingLockUI = false;

-- ----------------------------------------------------------------------------
-- Quick Chat Commands
-- ----------------------------------------------------------------------------
local function PrintTodaySpeedruns()
    local timeTable = GetCurrentTimeTable();
    local autoDay = D.GetActiveRotationDay(timeTable, DH.settings.serverResetHour);
    local activeDay = (DH.settings.selectedDayOverride > 0) and DH.settings.selectedDayOverride or autoDay;
    local dayInfo = D.Days[activeDay] or D.Days[1];
    local profile = GetEffectiveProfile();

    Turbine.Shell.WriteLine(string.format("<rgb=#FFD700>=== [DelvingHelper v%s] Today's Writs Farm (%s - %s) ===</rgb>", 
        PLUGIN_VERSION, (profile == "burglar" and "Burglar Route" or "Standard Pools"), dayInfo.name));

    local missions = {};
    if profile == "burglar" then
        missions = D.GetBurglarMissions(activeDay, "all", false);
    else
        missions = D.DailyMissions[activeDay] or {};
    end

    local count = 0;
    for _, m in ipairs(missions) do
        count = count + 1;
        Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>  [%d] %s</rgb> at [%s] (%s)", 
            count, m.name, m.coords, m.hubName));
    end
end

local function PrintTodayMalice()
    local timeTable = GetCurrentTimeTable();
    local malice = D.GetMaliceVariant(timeTable, DH.settings.serverResetHour);
    Turbine.Shell.WriteLine(string.format("<rgb=#FF8800>=== [DelvingHelper] Today's Delving Malice: %s ===</rgb>", malice.title));
    Turbine.Shell.WriteLine(string.format("<rgb=#FFFF55>  Hazard:</rgb> %s", malice.tagline));
    Turbine.Shell.WriteLine(string.format("<rgb=#55FFFF>  Potions:</rgb> %s", malice.recommendedPotions));
    Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>  Tactics:</rgb> %s", malice.tactics));
end

local function PrintNPCCoordinates()
    Turbine.Shell.WriteLine("<rgb=#FFD700>=== [DelvingHelper] Delving Bestower & Barter NPCs ===</rgb>");
    for _, npc in ipairs(D.NPCLocations) do
        Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>  * %s</rgb> at <rgb=#FFFF55>[%s]</rgb> in %s", npc.name, npc.coords, npc.area));
    end
end

local function ResetProgressToday()
    DH.settings.completedMissions = {};
    DH.settings.manualOffset = 0;
    DH.settings.manualOffsetDaily = 0;
    DH.settings.manualOffsetWeekly = 0;
    DH.settings.manualOffsetWeekly45 = 0;
    DH.settings.countDaily = 0;
    DH.settings.countWeekly = 0;
    DH.settings.countWeekly45 = 0;
    SaveSettings();
    if RefreshMainWindow then RefreshMainWindow(); end
    if RefreshIconBadge then RefreshIconBadge(); end
    Turbine.Shell.WriteLine("<rgb=#55FF55>[DelvingHelper] Completed missions counters have been reset to 0.</rgb>");
end

local confirmResetWindow = nil;

local function ShowConfirmResetDialog()
    if not confirmResetWindow then
        local dlgW, dlgH = 340, 140;
        confirmResetWindow = Turbine.UI.Lotro.Window();
        confirmResetWindow:SetSize(dlgW, dlgH);
        confirmResetWindow:SetText("Reset Confirmation");

        local lblPrompt = Turbine.UI.Label();
        lblPrompt:SetParent(confirmResetWindow);
        lblPrompt:SetPosition(16, 40);
        lblPrompt:SetSize(dlgW - 32, 44);
        lblPrompt:SetFont(Turbine.UI.Lotro.Font.Verdana12);
        lblPrompt:SetForeColor(Colors.White);
        lblPrompt:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        lblPrompt:SetText("Are you sure you want to reset all completed Delving mission counters to 0?");

        local btnW = 100;
        local btnH = 26;
        local btnY = 94;

        local btnYes = Turbine.UI.Lotro.Button();
        btnYes:SetParent(confirmResetWindow);
        btnYes:SetPosition(55, btnY);
        btnYes:SetSize(btnW, btnH);
        btnYes:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
        btnYes:SetText("Reset");
        btnYes.Click = function()
            confirmResetWindow:SetVisible(false);
            ResetProgressToday();
        end

        local btnCancel = Turbine.UI.Lotro.Button();
        btnCancel:SetParent(confirmResetWindow);
        btnCancel:SetPosition(185, btnY);
        btnCancel:SetSize(btnW, btnH);
        btnCancel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
        btnCancel:SetText("Cancel");
        btnCancel.Click = function()
            confirmResetWindow:SetVisible(false);
        end

        confirmResetWindow.Closing = function()
            confirmResetWindow:SetVisible(false);
        end

        confirmResetWindow:SetWantsKeyEvents(true);
        confirmResetWindow.KeyDown = function(sender, args)
            if args.Action == Turbine.UI.Lotro.Action.Escape or args.Action == 145 then
                confirmResetWindow:SetVisible(false);
            end
        end
    end

    if mainWindow and mainWindow:IsVisible() then
        local mx, my = mainWindow:GetPosition();
        local mw, mh = mainWindow:GetSize();
        local dw, dh = confirmResetWindow:GetSize();
        local cx = mx + math.floor((mw - dw) / 2);
        local cy = my + math.floor((mh - dh) / 2);
        cx, cy = ClampToScreen(cx, cy, dw, dh);
        confirmResetWindow:SetPosition(cx, cy);
    else
        local screenW = Turbine.UI.Display:GetWidth();
        local screenH = Turbine.UI.Display:GetHeight();
        local dw, dh = confirmResetWindow:GetSize();
        confirmResetWindow:SetPosition(math.floor((screenW - dw) / 2), math.floor((screenH - dh) / 2));
    end

    confirmResetWindow:SetVisible(true);
    confirmResetWindow:Activate();
end

local colorLegendWindow = nil;

local function ShowColorLegendDialog()
    if not colorLegendWindow then
        local dlgW, dlgH = 540, 440;
        colorLegendWindow = Turbine.UI.Lotro.Window();
        colorLegendWindow:SetSize(dlgW, dlgH);
        colorLegendWindow:SetText("Mission Color Guide");

        local lblTitle = Turbine.UI.Label();
        lblTitle:SetParent(colorLegendWindow);
        lblTitle:SetPosition(16, 36);
        lblTitle:SetSize(dlgW - 32, 22);
        lblTitle:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
        lblTitle:SetForeColor(Colors.BrightGold);
        lblTitle:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        lblTitle:SetText("Delving Mission Visual Color Codes");

        local lblSub = Turbine.UI.Label();
        lblSub:SetParent(colorLegendWindow);
        lblSub:SetPosition(16, 58);
        lblSub:SetSize(dlgW - 32, 18);
        lblSub:SetFont(Turbine.UI.Lotro.Font.Verdana12);
        lblSub:SetForeColor(Colors.LightGray);
        lblSub:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        lblSub:SetText("Card borders and titles highlight specific mechanics and speedrun routes:");

        local entries = {
            {
                title = "RED: Danger Alert / Difficult Mission",
                color = Colors.Red,
                desc = "Missions with high enemy density, heavy incoming damage, or tedious objectives. E.g. 'Reclaiming the Torrent-spires' (clearing dense hostile mob packs to plant banners under fire), 'The Matron of the Hatchery' (boss stands inside dense adds)."
            },
            {
                title = "BLUE / CYAN: Tactical Alerts & Crucial Mechanics",
                color = Colors.Cyan,
                desc = "Crucial combat mechanics or special conditions! Cleanse Damage Reflect immediately or burst boss before escape ('Down on the Farm', 'Caranost Command Post'). Also marks Duo Recommended missions."
            },
            {
                title = "GOLD: Speedrun Farming Routes",
                color = Colors.BrightGold,
                desc = "Fastest delving runs (~1.5 - 2 min), optimal for stealth Burglar routes and rapid 10/10 and 15/15 weekly wrapper completions."
            },
            {
                title = "GREEN: Completed Missions & Goals",
                color = Colors.BrightGreen,
                desc = "Missions currently completed / checked off, or weekly wrapper goals that have reached 10/10 or 15/15."
            },
            {
                title = "WHITE / GREY: Standard Rotation Missions",
                color = Colors.White,
                desc = "Standard daily rotation pool delving missions with standard difficulty."
            }
        };

        local curY = 82;
        for _, item in ipairs(entries) do
            local swatch = Turbine.UI.Control();
            swatch:SetParent(colorLegendWindow);
            swatch:SetPosition(20, curY + 2);
            swatch:SetSize(12, 12);
            swatch:SetBackColor(item.color);

            local lblHeader = Turbine.UI.Label();
            lblHeader:SetParent(colorLegendWindow);
            lblHeader:SetPosition(38, curY);
            lblHeader:SetSize(dlgW - 56, 18);
            lblHeader:SetFont(Turbine.UI.Lotro.Font.TrajanProBold14);
            lblHeader:SetForeColor(item.color);
            lblHeader:SetText(item.title);

            local lblBody = Turbine.UI.Label();
            lblBody:SetParent(colorLegendWindow);
            lblBody:SetPosition(38, curY + 18);
            lblBody:SetSize(dlgW - 56, 42);
            lblBody:SetFont(Turbine.UI.Lotro.Font.Verdana12);
            lblBody:SetForeColor(Colors.White);
            lblBody:SetText(item.desc);

            curY = curY + 62;
        end

        local btnClose = Turbine.UI.Lotro.Button();
        btnClose:SetParent(colorLegendWindow);
        btnClose:SetPosition(math.floor((dlgW - 120) / 2), dlgH - 42);
        btnClose:SetSize(120, 26);
        btnClose:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
        btnClose:SetText("Close");
        btnClose.Click = function()
            colorLegendWindow:SetVisible(false);
        end

        colorLegendWindow.Closing = function()
            colorLegendWindow:SetVisible(false);
        end

        colorLegendWindow:SetWantsKeyEvents(true);
        colorLegendWindow.KeyDown = function(sender, args)
            if args.Action == Turbine.UI.Lotro.Action.Escape or args.Action == 145 then
                colorLegendWindow:SetVisible(false);
            end
        end
    end

    if mainWindow and mainWindow:IsVisible() then
        local mx, my = mainWindow:GetPosition();
        local mw, mh = mainWindow:GetSize();
        local dw, dh = colorLegendWindow:GetSize();
        local cx = mx + math.floor((mw - dw) / 2);
        local cy = my + math.floor((mh - dh) / 2);
        cx, cy = ClampToScreen(cx, cy, dw, dh);
        colorLegendWindow:SetPosition(cx, cy);
    else
        local screenW = Turbine.UI.Display:GetWidth();
        local screenH = Turbine.UI.Display:GetHeight();
        local dw, dh = colorLegendWindow:GetSize();
        colorLegendWindow:SetPosition(math.floor((screenW - dw) / 2), math.floor((screenH - dh) / 2));
    end

    colorLegendWindow:SetVisible(true);
    colorLegendWindow:Activate();
end

-- ----------------------------------------------------------------------------
-- On-Screen Mission Alert Banner (Center screen warning for wrong/unknown missions)
-- ----------------------------------------------------------------------------
local alertWindow = nil;
local alertHideTime = 0;
local alertTimer = nil;

local function ShowMissionWarningBanner(titleText, msgText, isDangerous)
    local alertW, alertH = 560, 96;
    if not alertWindow then
        alertWindow = Turbine.UI.Window();
        alertWindow:SetSize(alertW, alertH);
        alertWindow:SetZOrder(9999);
        alertWindow:SetMouseVisible(false);

        local bg = Turbine.UI.Control();
        bg:SetParent(alertWindow);
        bg:SetPosition(0, 0);
        bg:SetSize(alertW, alertH);
        bg:SetMouseVisible(false);
        alertWindow.bg = bg;

        alertWindow.lblIcon = Turbine.UI.Label();
        alertWindow.lblIcon:SetParent(alertWindow);
        alertWindow.lblIcon:SetPosition(12, 10);
        alertWindow.lblIcon:SetSize(alertW - 24, 24);
        alertWindow.lblIcon:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
        alertWindow.lblIcon:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        alertWindow.lblIcon:SetMouseVisible(false);

        alertWindow.lblMsg = Turbine.UI.Label();
        alertWindow.lblMsg:SetParent(alertWindow);
        alertWindow.lblMsg:SetPosition(14, 36);
        alertWindow.lblMsg:SetSize(alertW - 28, 52);
        alertWindow.lblMsg:SetFont(Turbine.UI.Lotro.Font.Verdana14);
        alertWindow.lblMsg:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        alertWindow.lblMsg:SetMultiline(true);
        alertWindow.lblMsg:SetMouseVisible(false);

        alertTimer = Turbine.UI.Control();
        alertTimer.Update = function()
            if alertWindow and alertWindow:IsVisible() then
                if Turbine.Engine.GetGameTime() >= alertHideTime then
                    alertWindow:SetVisible(false);
                    alertTimer:SetWantsUpdates(false);
                end
            end
        end
    end

    local screenW = Turbine.UI.Display:GetWidth();
    local screenH = Turbine.UI.Display:GetHeight();
    local posX = math.floor((screenW - alertW) / 2);
    local posY = math.floor(screenH * 0.22); -- Displayed prominently in upper-center of screen
    alertWindow:SetPosition(posX, posY);

    if isDangerous then
        alertWindow.bg:SetBackColor(Turbine.UI.Color(0.92, 0.28, 0.02, 0.02));
        ApplyBorder(alertWindow.bg, Colors.Red, 2);
        alertWindow.lblIcon:SetForeColor(Colors.Red);
    else
        alertWindow.bg:SetBackColor(Turbine.UI.Color(0.92, 0.25, 0.18, 0.02));
        ApplyBorder(alertWindow.bg, Colors.BrightGold, 2);
        alertWindow.lblIcon:SetForeColor(Colors.BrightGold);
    end

    alertWindow.lblIcon:SetText(titleText);
    alertWindow.lblMsg:SetText(msgText);
    alertWindow:SetVisible(true);

    alertHideTime = Turbine.Engine.GetGameTime() + 5.0; -- Show for 5 seconds
    alertTimer:SetWantsUpdates(true);
end

local function CenterAllWindowPositions()
    local screenW = Turbine.UI.Display:GetWidth();
    local screenH = Turbine.UI.Display:GetHeight();
    DH.settings.winX = math.floor((screenW - DH.settings.winW) / 2);
    DH.settings.winY = math.floor((screenH - DH.settings.winH) / 2);
    DH.settings.iconX = 200;
    DH.settings.iconY = 60;
    if mainWindow then
        mainWindow:SetPosition(DH.settings.winX, DH.settings.winY);
    end
    if iconWindow then
        iconWindow:SetPosition(DH.settings.iconX, DH.settings.iconY);
    end
    SaveSettings();
    Turbine.Shell.WriteLine("<rgb=#55FF55>[DelvingHelper] Windows centered on screen.</rgb>");
end

-- ----------------------------------------------------------------------------
-- Plugin Reload Mechanism (Gibberish3 / EquipmentPlugin style companion reloader)
-- ----------------------------------------------------------------------------
TriggerReloadPlugin = function()
    Turbine.Shell.WriteLine("<rgb=#EEDD82>[DelvingHelper] Reloading plugin...</rgb>");
    SaveSettings();
    if Turbine.PluginManager then
        -- Force unload companion reloader first in case it is still in memory from a prior session/reload
        if type(Turbine.PluginManager.UnloadScriptState) == "function" then
            pcall(Turbine.PluginManager.UnloadScriptState, "DelvingHelperReloader");
        end
        if type(Turbine.PluginManager.RefreshAvailablePlugins) == "function" then
            pcall(Turbine.PluginManager.RefreshAvailablePlugins);
        end
        local ok, res = pcall(Turbine.PluginManager.LoadPlugin, "DelvingHelperReloader");
        if not ok or res == false then
            Turbine.Shell.WriteLine("<rgb=#FF5555>[DelvingHelper] Could not load DelvingHelperReloader. Try: /plugins load DelvingHelper</rgb>");
        end
    end
end

-- ----------------------------------------------------------------------------
-- Delving Floating Jewel Icon Window (42x42)
-- ----------------------------------------------------------------------------
local function CreateDelvingIcon()
    iconWindow = Turbine.UI.Window();
    iconWindow:SetSize(42, 42);
    iconWindow:SetPosition(DH.settings.iconX, DH.settings.iconY);
    iconWindow:SetVisible(DH.settings.showIcon);

    local iconBg = Turbine.UI.Control();
    iconBg:SetParent(iconWindow);
    iconBg:SetPosition(0, 0);
    iconBg:SetSize(42, 42);
    iconBg:SetBackground("DelvingHelper/icon.tga");
    iconBg:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);

    RefreshIconBadge = function()
        -- Icon counter disabled for clean icon artwork display
    end

    local tooltip = Turbine.UI.Window();
    tooltip:SetSize(280, 92);
    tooltip:SetBackColor(Turbine.UI.Color(0.92, 0.05, 0.06, 0.08));
    tooltip:SetVisible(false);
    tooltip:SetMouseVisible(false);
    tooltip:SetZOrder(9999);

    local function AddTooltipBorder(x, y, w, h)
        local b = Turbine.UI.Control();
        b:SetParent(tooltip);
        b:SetPosition(x, y);
        b:SetSize(w, h);
        b:SetBackColor(Colors.BorderGold);
    end
    AddTooltipBorder(0, 0, 280, 1);
    AddTooltipBorder(0, 91, 280, 1);
    AddTooltipBorder(0, 0, 1, 92);
    AddTooltipBorder(279, 0, 1, 92);

    local lblTooltip = Turbine.UI.Label();
    lblTooltip:SetParent(tooltip);
    lblTooltip:SetPosition(6, 4);
    lblTooltip:SetSize(268, 84);
    lblTooltip:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    lblTooltip:SetForeColor(Colors.BrightGold);
    lblTooltip:SetText("");

    local function UpdateTooltipText()
        local timeTable = GetCurrentTimeTable();
        local autoDay = D.GetActiveRotationDay(timeTable, DH.settings.serverResetHour);
        local activeDay = (DH.settings.selectedDayOverride > 0) and DH.settings.selectedDayOverride or autoDay;
        local dayInfo = D.Days[activeDay] or D.Days[1];
        local dailyCount = CountCompletedDaily();
        local weeklyCount = CountCompletedWeekly();
        local weekly45Count = CountCompletedWeekly45();
        local profile = GetEffectiveProfile();

        lblTooltip:SetText(string.format(
            "Delving Helper v%s\n" ..
            "Profile: %s | %s\n" ..
            "Delvings: %d/%d\n" ..
            "Missions: %d/%d\n" ..
            "Continuing: %d/%d",
            PLUGIN_VERSION,
            (profile == "burglar" and "Burglar Route" or "Standard"),
            dayInfo.short,
            dailyCount,
            DH.settings.dailyGoal or 10,
            weeklyCount,
            DH.settings.weeklyGoal or 15,
            weekly45Count,
            DH.settings.weekly45Goal or 45
        ));
    end

    local dragging = false;
    local dragMoved = false;
    local dragStartX = 0;
    local dragStartY = 0;

    iconBg.MouseDown = function(sender, args)
        if args.Button == Turbine.UI.MouseButton.Left and not DH.settings.lockIcon then
            dragging = true;
            dragMoved = false;
            dragStartX = args.X;
            dragStartY = args.Y;
        end
    end

    iconBg.MouseMove = function(sender, args)
        if dragging then
            local diffX = args.X - dragStartX;
            local diffY = args.Y - dragStartY;
            if math.abs(diffX) > 2 or math.abs(diffY) > 2 then
                dragMoved = true;
            end
            local curX, curY = iconWindow:GetPosition();
            local newX = curX + diffX;
            local newY = curY + diffY;
            newX, newY = ClampToScreen(newX, newY, iconWindow:GetWidth(), iconWindow:GetHeight());
            iconWindow:SetPosition(newX, newY);
            DH.settings.iconX = newX;
            DH.settings.iconY = newY;
        end
    end

    iconBg.MouseUp = function(sender, args)
        if args.Button == Turbine.UI.MouseButton.Left and dragging then
            dragging = false;
            if dragMoved then
                SaveSettings();
            end
        end
    end

    local iconContextMenu = nil;

    local function ShowIconContextMenu()
        iconContextMenu = Turbine.UI.ContextMenu();
        local items = iconContextMenu:GetItems();

        local titleItem = Turbine.UI.MenuItem(string.format("Delving Helper v%s", PLUGIN_VERSION), false);
        items:Add(titleItem);

        local reloadItem = Turbine.UI.MenuItem("Reload Plugin");
        reloadItem.Click = function(s, a)
            TriggerReloadPlugin();
        end
        items:Add(reloadItem);

        local winText = (mainWindow and mainWindow:IsVisible()) and "Close Window" or "Open Window";
        local winItem = Turbine.UI.MenuItem(winText);
        winItem.Click = function(s, a)
            if mainWindow then
                local vis = not mainWindow:IsVisible();
                mainWindow:SetVisible(vis);
                DH.settings.winVisible = vis;
                SaveSettings();
                if vis then
                    RefreshMainWindow();
                    if mainWindow.Activate then mainWindow:Activate(); end
                end
            end
        end
        items:Add(winItem);

        local lockText = DH.settings.lockIcon and "Unlock Icon Position" or "Lock Icon Position";
        local lockItem = Turbine.UI.MenuItem(lockText);
        lockItem.Click = function(s, a)
            DH.settings.lockIcon = not DH.settings.lockIcon;
            SaveSettings();
            if UpdateOptionsUI then UpdateOptionsUI(); end
            if DH.settings.announceChat then
                Turbine.Shell.WriteLine(string.format("<rgb=#EEDD82>[DelvingHelper] Icon position is now %s.</rgb>", DH.settings.lockIcon and "locked" or "unlocked"));
            end
        end
        items:Add(lockItem);

        local settingsItem = Turbine.UI.MenuItem("Quick Settings...");
        settingsItem.Click = function(s, a)
            if quickSettingsWindow then
                local x, y = iconWindow:GetPosition();
                local winW = quickSettingsWindow:GetWidth();
                local posX = math.max(10, x - winW + 42);
                local posY = y + 46;
                posX, posY = ClampToScreen(posX, posY, quickSettingsWindow:GetWidth(), quickSettingsWindow:GetHeight());
                quickSettingsWindow:SetPosition(posX, posY);
                quickSettingsWindow:SetVisible(not quickSettingsWindow:IsVisible());
            end
        end
        items:Add(settingsItem);

        iconContextMenu:ShowMenu();
    end

    iconBg.MouseClick = function(sender, args)
        if dragMoved then
            dragMoved = false;
            return;
        end

        local isRight = (args.Button == Turbine.UI.MouseButton.Right) or (args.Button == 2);
        local isLeft = (args.Button == Turbine.UI.MouseButton.Left) or (args.Button == 1);

        if isRight then
            ShowIconContextMenu();
        elseif isLeft then
            if mainWindow then
                local vis = not mainWindow:IsVisible();
                mainWindow:SetVisible(vis);
                DH.settings.winVisible = vis;
                SaveSettings();
                if vis then
                    RefreshMainWindow();
                    if mainWindow.Activate then mainWindow:Activate(); end
                end
            end
        end
    end

    iconWindow.MouseClick = iconBg.MouseClick;

    iconBg.MouseEnter = function(sender, args)
        UpdateTooltipText();
        local x, y = iconWindow:GetPosition();
        local tipX = x - 280;
        if tipX < 10 then tipX = x + 46; end
        local tipY = y;
        tipX, tipY = ClampToScreen(tipX, tipY, tooltip:GetWidth(), tooltip:GetHeight());
        tooltip:SetPosition(tipX, tipY);
        tooltip:SetVisible(true);
    end

    iconBg.MouseLeave = function(sender, args)
        tooltip:SetVisible(false);
    end

    RefreshIconBadge();
end

-- ----------------------------------------------------------------------------
-- Quick Settings Window (Right-click pop-up)
-- ----------------------------------------------------------------------------
local function CreateQuickSettingsWindow()
    quickSettingsWindow = Turbine.UI.Lotro.Window();
    quickSettingsWindow:SetSize(290, 260);
    quickSettingsWindow:SetText("Delving Helper Options");
    quickSettingsWindow:SetVisible(false);

    quickSettingsWindow.Closing = function()
        quickSettingsWindow:SetVisible(false);
    end

    quickSettingsWindow:SetWantsKeyEvents(true);
    quickSettingsWindow.KeyDown = function(sender, args)
        if args.Action == Turbine.UI.Lotro.Action.Escape or args.Action == 145 then
            quickSettingsWindow:SetVisible(false);
        end
    end

    local yPos = 40;

    -- Character & Class Display
    local lblChar = Turbine.UI.Label();
    lblChar:SetParent(quickSettingsWindow);
    lblChar:SetPosition(16, yPos);
    lblChar:SetSize(258, 20);
    lblChar:SetFont(Turbine.UI.Lotro.Font.TrajanProBold14);
    lblChar:SetForeColor(Colors.BrightGold);
    lblChar:SetText(string.format("Player: %s (%s)", DH.playerName, DH.playerClass));
    yPos = yPos + 26;

    local lblRoute = Turbine.UI.Label();
    lblRoute:SetParent(quickSettingsWindow);
    lblRoute:SetPosition(16, yPos);
    lblRoute:SetSize(258, 22);
    lblRoute:SetFont(Turbine.UI.Lotro.Font.TrajanProBold14);
    lblRoute:SetForeColor(Colors.BrightGold);
    lblRoute:SetText("Route: Burglar Stealth Speedruns");
    yPos = yPos + 28;

    -- Lock Floating Icon CheckBox
    local cbLock = Turbine.UI.Lotro.CheckBox();
    cbLock:SetParent(quickSettingsWindow);
    cbLock:SetPosition(16, yPos);
    cbLock:SetSize(258, 22);
    cbLock:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    cbLock:SetForeColor(Colors.White);
    cbLock:SetText("Lock Floating Icon Position");
    cbLock:SetChecked(DH.settings.lockIcon);
    cbLock.CheckedChanged = function()
        if updatingLockUI then return; end
        DH.settings.lockIcon = cbLock:IsChecked();
        SaveSettings();
        UpdateOptionsUI();
        Turbine.Shell.WriteLine(string.format("<rgb=#00FF88>[DelvingHelper]</rgb> Jewel icon %s.", 
            DH.settings.lockIcon and "locked" or "unlocked. Drag the icon to any desired position."));
    end
    quickSettingsWindow.cbLock = cbLock;
    yPos = yPos + 24;

    -- Warn on Unknown Missions CheckBox
    local cbWarn = Turbine.UI.Lotro.CheckBox();
    cbWarn:SetParent(quickSettingsWindow);
    cbWarn:SetPosition(16, yPos);
    cbWarn:SetSize(258, 22);
    cbWarn:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    cbWarn:SetForeColor(Colors.White);
    cbWarn:SetText("Warn on Unknown Missions");
    cbWarn:SetChecked(DH.settings.warnUnknown);
    cbWarn.CheckedChanged = function()
        if updatingLockUI then return; end
        DH.settings.warnUnknown = cbWarn:IsChecked();
        SaveSettings();
        UpdateOptionsUI();
    end
    quickSettingsWindow.cbWarn = cbWarn;
    yPos = yPos + 26;

    -- Reset Daily Counter Button
    local btnReset = Turbine.UI.Lotro.Button();
    btnReset:SetParent(quickSettingsWindow);
    btnReset:SetPosition(16, yPos);
    btnReset:SetSize(258, 24);
    btnReset:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    btnReset:SetText("Reset Completed Delvings");
    btnReset.Click = function()
        ShowConfirmResetDialog();
    end
    yPos = yPos + 28;

    -- Print Coordinates Button
    local btnCoords = Turbine.UI.Lotro.Button();
    btnCoords:SetParent(quickSettingsWindow);
    btnCoords:SetPosition(16, yPos);
    btnCoords:SetSize(258, 24);
    btnCoords:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    btnCoords:SetText("Print NPC Coords in Chat");
    btnCoords.Click = function()
        PrintNPCCoordinates();
    end
    yPos = yPos + 28;

    -- Center Windows Button
    local btnCenter = Turbine.UI.Lotro.Button();
    btnCenter:SetParent(quickSettingsWindow);
    btnCenter:SetPosition(16, yPos);
    btnCenter:SetSize(258, 24);
    btnCenter:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    btnCenter:SetText("Center Window on Screen");
    btnCenter.Click = function()
        CenterAllWindowPositions();
    end
end

-- ----------------------------------------------------------------------------
-- LOTRO Plugin Manager Options Panel
-- ----------------------------------------------------------------------------
local function CreatePluginManagerOptions()
    optionsPanel = Turbine.UI.Control();
    optionsPanel:SetSize(460, 520);

    local yPos = 14;

    local lblTitle = Turbine.UI.Label();
    lblTitle:SetParent(optionsPanel);
    lblTitle:SetPosition(14, yPos);
    lblTitle:SetSize(430, 24);
    lblTitle:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
    lblTitle:SetForeColor(Colors.BrightGold);
    lblTitle:SetText("DelvingHelper v" .. PLUGIN_VERSION .. " Settings");
    yPos = yPos + 26;

    local lblDesc = Turbine.UI.Label();
    lblDesc:SetParent(optionsPanel);
    lblDesc:SetPosition(14, yPos);
    lblDesc:SetSize(430, 36);
    lblDesc:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    lblDesc:SetForeColor(Colors.LightGray);
    lblDesc:SetText("Delving Writs speedrun rotation tracker & Malice manager.\nSupports dedicated Burglar stealth speedrun routes.");
    yPos = yPos + 44;

    -- Status label
    local lblStatus = Turbine.UI.Label();
    lblStatus:SetParent(optionsPanel);
    lblStatus:SetPosition(14, yPos);
    lblStatus:SetSize(430, 20);
    lblStatus:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    lblStatus:SetForeColor(Colors.BrightGold);
    lblStatus:SetText(string.format("Current Character: %s (%s)", DH.playerName, DH.playerClass));
    yPos = yPos + 28;

    local lblRoute = Turbine.UI.Label();
    lblRoute:SetParent(optionsPanel);
    lblRoute:SetPosition(14, yPos);
    lblRoute:SetSize(400, 22);
    lblRoute:SetFont(Turbine.UI.Lotro.Font.TrajanProBold14);
    lblRoute:SetForeColor(Colors.BrightGold);
    lblRoute:SetText("Active Route: Burglar Stealth Speedruns");
    yPos = yPos + 28;

    local cbShowIcon = Turbine.UI.Lotro.CheckBox();
    cbShowIcon:SetParent(optionsPanel);
    cbShowIcon:SetPosition(14, yPos);
    cbShowIcon:SetSize(400, 22);
    cbShowIcon:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    cbShowIcon:SetForeColor(Colors.White);
    cbShowIcon:SetText("Show floating jewel icon on screen");
    cbShowIcon:SetChecked(DH.settings.showIcon);
    cbShowIcon.CheckedChanged = function()
        DH.settings.showIcon = cbShowIcon:IsChecked();
        if iconWindow then iconWindow:SetVisible(DH.settings.showIcon); end
        SaveSettings();
    end
    yPos = yPos + 26;

    local cbLockIcon = Turbine.UI.Lotro.CheckBox();
    cbLockIcon:SetParent(optionsPanel);
    cbLockIcon:SetPosition(14, yPos);
    cbLockIcon:SetSize(400, 22);
    cbLockIcon:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    cbLockIcon:SetForeColor(Colors.White);
    cbLockIcon:SetText("Lock floating jewel icon position");
    cbLockIcon:SetChecked(DH.settings.lockIcon);
    cbLockIcon.CheckedChanged = function()
        if updatingLockUI then return; end
        DH.settings.lockIcon = cbLockIcon:IsChecked();
        SaveSettings();
        UpdateOptionsUI();
        Turbine.Shell.WriteLine(string.format("<rgb=#00FF88>[DelvingHelper]</rgb> Jewel icon %s.", 
            DH.settings.lockIcon and "locked" or "unlocked. Drag the icon to any desired position."));
    end
    yPos = yPos + 26;

    local cbAutoTrack = Turbine.UI.Lotro.CheckBox();
    cbAutoTrack:SetParent(optionsPanel);
    cbAutoTrack:SetPosition(14, yPos);
    cbAutoTrack:SetSize(400, 22);
    cbAutoTrack:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    cbAutoTrack:SetForeColor(Colors.White);
    cbAutoTrack:SetText("Auto-track completed delving missions from game chat");
    cbAutoTrack:SetChecked(DH.settings.autoTrack);
    cbAutoTrack.CheckedChanged = function()
        DH.settings.autoTrack = cbAutoTrack:IsChecked();
        SaveSettings();
    end
    yPos = yPos + 26;

    local cbAnnounce = Turbine.UI.Lotro.CheckBox();
    cbAnnounce:SetParent(optionsPanel);
    cbAnnounce:SetPosition(14, yPos);
    cbAnnounce:SetSize(400, 22);
    cbAnnounce:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    cbAnnounce:SetForeColor(Colors.White);
    cbAnnounce:SetText("Print chat confirmation on mission completion");
    cbAnnounce:SetChecked(DH.settings.announceChat);
    cbAnnounce.CheckedChanged = function()
        DH.settings.announceChat = cbAnnounce:IsChecked();
        SaveSettings();
    end
    yPos = yPos + 26;

    local cbWarnMissions = Turbine.UI.Lotro.CheckBox();
    cbWarnMissions:SetParent(optionsPanel);
    cbWarnMissions:SetPosition(14, yPos);
    cbWarnMissions:SetSize(400, 22);
    cbWarnMissions:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    cbWarnMissions:SetForeColor(Colors.White);
    cbWarnMissions:SetText("Warn on screen when accepting unknown missions");
    cbWarnMissions:SetChecked(DH.settings.warnUnknown);
    cbWarnMissions.CheckedChanged = function()
        DH.settings.warnUnknown = cbWarnMissions:IsChecked();
        SaveSettings();
        UpdateOptionsUI();
    end
    yPos = yPos + 32;

    local btnResetCounter = Turbine.UI.Lotro.Button();
    btnResetCounter:SetParent(optionsPanel);
    btnResetCounter:SetPosition(14, yPos);
    btnResetCounter:SetSize(220, 26);
    btnResetCounter:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    btnResetCounter:SetText("Reset Completed Delvings");
    btnResetCounter.Click = function()
        ShowConfirmResetDialog();
    end

    local btnPrintNPCs = Turbine.UI.Lotro.Button();
    btnPrintNPCs:SetParent(optionsPanel);
    btnPrintNPCs:SetPosition(244, yPos);
    btnPrintNPCs:SetSize(200, 26);
    btnPrintNPCs:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    btnPrintNPCs:SetText("Print NPC Coordinates");
    btnPrintNPCs.Click = function()
        PrintNPCCoordinates();
    end
    yPos = yPos + 34;

    local btnCenterWins = Turbine.UI.Lotro.Button();
    btnCenterWins:SetParent(optionsPanel);
    btnCenterWins:SetPosition(14, yPos);
    btnCenterWins:SetSize(220, 26);
    btnCenterWins:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    btnCenterWins:SetText("Center Window on Screen");
    btnCenterWins.Click = function()
        CenterAllWindowPositions();
    end

    local btnColorGuide = Turbine.UI.Lotro.Button();
    btnColorGuide:SetParent(optionsPanel);
    btnColorGuide:SetPosition(244, yPos);
    btnColorGuide:SetSize(200, 26);
    btnColorGuide:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    btnColorGuide:SetText("Mission Color Guide");
    btnColorGuide.Click = function()
        ShowColorLegendDialog();
    end
    yPos = yPos + 34;

    local lblTz = Turbine.UI.Label();
    lblTz:SetParent(optionsPanel);
    lblTz:SetPosition(14, yPos);
    lblTz:SetSize(430, 42);
    lblTz:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    lblTz:SetForeColor(Colors.BrightGold);
    lblTz:SetMarkupEnabled(true);

    UpdateOptionsUI = function()
        updatingLockUI = true;
        if cbShowIcon then cbShowIcon:SetChecked(DH.settings.showIcon); end
        if cbLockIcon then cbLockIcon:SetChecked(DH.settings.lockIcon); end
        if cbWarnMissions then cbWarnMissions:SetChecked(DH.settings.warnUnknown); end
        if quickSettingsWindow and quickSettingsWindow.cbLock then
            quickSettingsWindow.cbLock:SetChecked(DH.settings.lockIcon);
        end
        if quickSettingsWindow and quickSettingsWindow.cbWarn then
            quickSettingsWindow.cbWarn:SetChecked(DH.settings.warnUnknown);
        end
        if mainWindow and mainWindow.cbLockIcon then
            mainWindow.cbLockIcon:SetChecked(DH.settings.lockIcon);
        end
        updatingLockUI = false;
        if lblTz then
            local timeTable = GetCurrentTimeTable();
            local tz = timeTable.tzName or "EST";
            local localReset = string.format("%02d:00", timeTable.localResetHour or 10);
            local offset = DH.settings.clientUtcOffset or 3;
            lblTz:SetText(string.format("Timezone: UTC%+d | Server Time: %02d:%02d %s | Reset: 03:00 Server (%s Local)\nAdjust timezone offset via command: <rgb=#55FFFF>/delving tz <hours></rgb>", 
                offset, timeTable.Hour, timeTable.Minute, tz, localReset));
        end
    end
end

-- ----------------------------------------------------------------------------
-- Main Window Creation
-- ----------------------------------------------------------------------------
local resetTooltip = nil;

local function CreateMainWindow()
    mainWindow = Turbine.UI.Lotro.Window();
    mainWindow:SetSize(DH.settings.winW, DH.settings.winH);
    mainWindow:SetPosition(DH.settings.winX, DH.settings.winY);
    mainWindow:SetText("Delving Helper v" .. PLUGIN_VERSION .. " - Delving Writs Farm");
    mainWindow:SetVisible(DH.settings.winVisible);

    mainWindow.PositionChanged = function(sender, args)
        local x, y = mainWindow:GetPosition();
        DH.settings.winX = x;
        DH.settings.winY = y;
        SaveSettings();
    end

    mainWindow.Closing = function(sender, args)
        if resetTooltip then resetTooltip:SetVisible(false); end
        DH.settings.winVisible = false;
        SaveSettings();
    end

    mainWindow:SetWantsKeyEvents(true);
    mainWindow.KeyDown = function(sender, args)
        if args.Action == Turbine.UI.Lotro.Action.Escape or args.Action == 145 then
            if confirmResetWindow and confirmResetWindow:IsVisible() then
                confirmResetWindow:SetVisible(false);
                return;
            end
            if colorLegendWindow and colorLegendWindow:IsVisible() then
                colorLegendWindow:SetVisible(false);
                return;
            end
            if quickSettingsWindow and quickSettingsWindow:IsVisible() then
                quickSettingsWindow:SetVisible(false);
                return;
            end
            if mainWindow:IsVisible() then
                if resetTooltip then resetTooltip:SetVisible(false); end
                mainWindow:SetVisible(false);
                DH.settings.winVisible = false;
                SaveSettings();
            end
        end
    end

    -- Top Banner: Reset Countdown & Server Clock
    local headerBg = Turbine.UI.Control();
    headerBg:SetParent(mainWindow);
    headerBg:SetPosition(18, 40);
    headerBg:SetSize(DH.settings.winW - 36, 32);
    headerBg:SetBackColor(Turbine.UI.Color(0.85, 0.06, 0.07, 0.08));
    ApplySmoothedBorder(headerBg, Turbine.UI.Color(0.40, 0.32, 0.28, 0.22), 2);

    mainWindow.lblCountdown = Turbine.UI.Label();
    mainWindow.lblCountdown:SetParent(headerBg);
    mainWindow.lblCountdown:SetPosition(4, 6);
    mainWindow.lblCountdown:SetSize(headerBg:GetWidth() - 96, 20);
    mainWindow.lblCountdown:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.lblCountdown:SetMultiline(false);
    mainWindow.lblCountdown:SetForeColor(Colors.BrightGold);
    mainWindow.lblCountdown:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    mainWindow.lblCountdown:SetText("Loading server rotation...");

    mainWindow.cbLockIcon = Turbine.UI.Lotro.CheckBox();
    mainWindow.cbLockIcon:SetParent(headerBg);
    mainWindow.cbLockIcon:SetPosition(headerBg:GetWidth() - 88, 6);
    mainWindow.cbLockIcon:SetSize(84, 20);
    mainWindow.cbLockIcon:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    mainWindow.cbLockIcon:SetForeColor(Colors.White);
    mainWindow.cbLockIcon:SetText("Lock Icon");
    mainWindow.cbLockIcon:SetChecked(DH.settings.lockIcon);
    mainWindow.cbLockIcon.CheckedChanged = function(sender, args)
        if updatingLockUI then return; end
        DH.settings.lockIcon = sender:IsChecked();
        SaveSettings();
        UpdateOptionsUI();
        Turbine.Shell.WriteLine(string.format("<rgb=#00FF88>[DelvingHelper]</rgb> Jewel icon %s.", 
            DH.settings.lockIcon and "locked" or "unlocked. Drag the icon to any desired position."));
    end

    resetTooltip = Turbine.UI.Control();
    resetTooltip:SetParent(mainWindow);
    resetTooltip:SetSize(580, 140);
    resetTooltip:SetPosition(40, 74);
    resetTooltip:SetZOrder(9999);
    resetTooltip:SetBackColor(Turbine.UI.Color(0.96, 0.05, 0.06, 0.09));
    resetTooltip:SetVisible(false);
    resetTooltip:SetMouseVisible(false);
    ApplyBorder(resetTooltip, Colors.BorderGold, 1);

    local lblResetTip = Turbine.UI.Label();
    lblResetTip:SetParent(resetTooltip);
    lblResetTip:SetPosition(14, 10);
    lblResetTip:SetSize(552, 120);
    lblResetTip:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    lblResetTip:SetForeColor(Colors.White);
    lblResetTip:SetMarkupEnabled(true);
    lblResetTip:SetMouseVisible(false);

    local function ShowResetTooltip()
        local timeTable = GetCurrentTimeTable();
        local localT = timeTable.localTime or timeTable;
        local tz = timeTable.tzName or "EST";
        local localReset = string.format("%02d:00", timeTable.localResetHour or 10);
        local secThu = D.GetSecondsUntilWeeklyReset(timeTable);
        local durThu = D.FormatWeeklyDuration(secThu);
        lblResetTip:SetText(string.format(
            "<rgb=#FFD700><b>LOTRO Server Reset & Timezone Info:</b></rgb>\n" ..
            "* Daily Reset: 03:00 AM Server Time (US Eastern) | Next in: %s\n" ..
            "* Weekly Reset: Thursday 03:00 AM Server Time (%s Local) | In: %s\n" ..
            "* Current Server Time: %02d:%02d %s  |  Your Local Time: %02d:%02d\n" ..
            "* Daily 10/10 limit is tracked independently per character.\n" ..
            "* Weekly 10/10 Delvings wrapper quest resets every Thursday morning.",
            FormatDuration(GetSecondsUntilReset(timeTable, 3)),
            localReset, durThu,
            timeTable.Hour, timeTable.Minute, tz, localT.Hour, localT.Minute
        ));
        resetTooltip:SetVisible(true);
    end

    local function HideResetTooltip()
        resetTooltip:SetVisible(false);
    end

    mainWindow.lblCountdown.MouseEnter = ShowResetTooltip;
    mainWindow.lblCountdown.MouseLeave = HideResetTooltip;
    headerBg.MouseEnter = ShowResetTooltip;
    headerBg.MouseLeave = HideResetTooltip;

    -- Rotation Pool Navigator Row: All + 7 Day Boxes (Mon..Sun)
    local navY = 76;
    local navH = 28;

    mainWindow.dayButtons = {};
    local dayConfigs = {
        { id = -1, name = "All Days",  short = "All", x = 18,  w = 71 },
        { id = 1,  name = "Monday",    short = "Mon", x = 95,  w = 73 },
        { id = 2,  name = "Tuesday",   short = "Tue", x = 174, w = 73 },
        { id = 3,  name = "Wednesday", short = "Wed", x = 253, w = 73 },
        { id = 4,  name = "Thursday",  short = "Thu", x = 332, w = 73 },
        { id = 5,  name = "Friday",    short = "Fri", x = 411, w = 73 },
        { id = 6,  name = "Saturday",  short = "Sat", x = 490, w = 73 },
        { id = 7,  name = "Sunday",    short = "Sun", x = 569, w = 73 },
    };

    for _, cfg in ipairs(dayConfigs) do
        local btn = Turbine.UI.Control();
        btn:SetParent(mainWindow);
        btn:SetPosition(cfg.x, navY);
        btn:SetSize(cfg.w, navH);

        local border = Turbine.UI.Control();
        border:SetParent(btn);
        border:SetPosition(0, 0);
        border:SetSize(cfg.w, navH);
        border:SetBackColor(Turbine.UI.Color(0.40, 0.42, 0.46));
        border:SetMouseVisible(false);

        local inner = Turbine.UI.Control();
        inner:SetParent(btn);
        inner:SetPosition(1, 1);
        inner:SetSize(cfg.w - 2, navH - 2);
        inner:SetBackColor(Turbine.UI.Color(0.90, 0.12, 0.13, 0.16));
        inner:SetMouseVisible(false);

        local todayBar = Turbine.UI.Control();
        todayBar:SetParent(btn);
        todayBar:SetPosition(3, navH - 3);
        todayBar:SetSize(cfg.w - 6, 2);
        todayBar:SetBackColor(Colors.BrightGreen);
        todayBar:SetVisible(false);
        todayBar:SetMouseVisible(false);

        local lbl = Turbine.UI.Label();
        lbl:SetParent(btn);
        lbl:SetPosition(0, 0);
        lbl:SetSize(cfg.w, navH);
        lbl:SetFont(Turbine.UI.Lotro.Font.TrajanProBold14);
        lbl:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        lbl:SetForeColor(Turbine.UI.Color(0.80, 0.75, 0.65));
        lbl:SetText(cfg.short);
        lbl:SetMouseVisible(false);

        btn.cfg = cfg;
        btn.border = border;
        btn.inner = inner;
        btn.todayBar = todayBar;
        btn.lbl = lbl;

        btn.MouseEnter = function()
            if not btn.isSelected then
                border:SetBackColor(Colors.White);
                inner:SetBackColor(Turbine.UI.Color(0.90, 0.22, 0.24, 0.30));
                lbl:SetForeColor(Colors.White);
            end
        end

        btn.MouseLeave = function()
            if btn.UpdateVisualState then btn.UpdateVisualState(); end
        end

        btn.MouseDown = function()
            inner:SetBackColor(Turbine.UI.Color(0.95, 0.06, 0.07, 0.09));
        end

        btn.MouseUp = function()
            if btn.UpdateVisualState then btn.UpdateVisualState(); end
        end

        btn.MouseClick = function()
            local timeTable = GetCurrentTimeTable();
            local autoDay = D.GetActiveRotationDay(timeTable, DH.settings.serverResetHour);
            if cfg.id == -1 then
                DH.settings.selectedDayOverride = -1;
            elseif cfg.id == autoDay then
                DH.settings.selectedDayOverride = 0;
            else
                DH.settings.selectedDayOverride = cfg.id;
            end
            SaveSettings();
            RefreshMainWindow();
        end

        mainWindow.dayButtons[cfg.id] = btn;
    end

    -- View Mode Tabs: [Writ Missions] | [Malice Guide] | [Writ Yields Guide]
    local tabY = 110;
    local tabW = 204;

    mainWindow.btnTabMissions = Turbine.UI.Lotro.Button();
    mainWindow.btnTabMissions:SetParent(mainWindow);
    mainWindow.btnTabMissions:SetPosition(18, tabY);
    mainWindow.btnTabMissions:SetSize(tabW, 28);
    mainWindow.btnTabMissions:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.btnTabMissions:SetText("Writ Missions");

    mainWindow.btnTabMalice = Turbine.UI.Lotro.Button();
    mainWindow.btnTabMalice:SetParent(mainWindow);
    mainWindow.btnTabMalice:SetPosition(228, tabY);
    mainWindow.btnTabMalice:SetSize(tabW, 28);
    mainWindow.btnTabMalice:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.btnTabMalice:SetText("Malice Guide");

    mainWindow.btnTabWrits = Turbine.UI.Lotro.Button();
    mainWindow.btnTabWrits:SetParent(mainWindow);
    mainWindow.btnTabWrits:SetPosition(438, tabY);
    mainWindow.btnTabWrits:SetSize(tabW, 28);
    mainWindow.btnTabWrits:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.btnTabWrits:SetText("Writ Yields Guide");

    mainWindow.btnTabMissions.Click = function()
        DH.settings.viewMode = "missions";
        SaveSettings();
        RefreshMainWindow();
    end

    mainWindow.btnTabMalice.Click = function()
        DH.settings.viewMode = "malice";
        SaveSettings();
        RefreshMainWindow();
    end

    mainWindow.btnTabWrits.Click = function()
        DH.settings.viewMode = "writs";
        SaveSettings();
        RefreshMainWindow();
    end

    -- Container for Missions View
    mainWindow.panelMissions = Turbine.UI.Control();
    mainWindow.panelMissions:SetParent(mainWindow);
    mainWindow.panelMissions:SetPosition(18, 144);
    mainWindow.panelMissions:SetSize(DH.settings.winW - 36, DH.settings.winH - 156);

    -- Hub Filter Buttons Row (Across All Delving Hubs & Favorites)
    local hubNames = {
        { id = "all",          label = "All Hubs",          width = 80 },
        { id = "bloody_eagle", label = "The Bloody Eagle",  width = 128 },
        { id = "cardolan",     label = "Cardolan",          width = 86 },
        { id = "urmakh",       label = "Umbar",             width = 78 },
        { id = "warroom",      label = "War Room",          width = 94 },
        { id = "favorites",    label = "   Favorites",      width = 128, hasStar = true },
    };
    mainWindow.hubButtons = {};
    local curX = 0;
    for idx, hub in ipairs(hubNames) do
        local btn = Turbine.UI.Lotro.Button();
        btn:SetParent(mainWindow.panelMissions);
        btn:SetPosition(curX, 0);
        btn:SetSize(hub.width, 24);
        btn:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
        btn:SetText(hub.label);

        if hub.hasStar then
            local btnStar = Turbine.UI.Control();
            btnStar:SetParent(btn);
            btnStar:SetPosition(12, 6);
            btnStar:SetSize(12, 12);
            btnStar:SetBlendMode(Turbine.UI.BlendMode.Overlay);
            btnStar:SetBackground("DelvingHelper/star_on.tga");
            btnStar:SetMouseVisible(false);
            btn.starIcon = btnStar;
        end

        btn.Click = function()
            if hub.id == "favorites" then
                DH.settings.filterHub = "favorites";
                DH.settings.selectedDayOverride = -1;
            else
                if DH.settings.filterHub == "favorites" and DH.settings.selectedDayOverride == -1 then
                    DH.settings.selectedDayOverride = 0;
                end
                DH.settings.filterHub = hub.id;
            end
            SaveSettings();
            RefreshMainWindow();
        end
        mainWindow.hubButtons[hub.id] = btn;
        curX = curX + hub.width + 6;
    end

    -- Sub-bar: Progress Counter Rows & Independent Stepper Buttons
    local row1Y = 26;
    local row2Y = 46;
    local row3Y = 66;

    -- Color Guide Button (Left side of sub-bar)
    mainWindow.btnColorLegend = Turbine.UI.Lotro.Button();
    mainWindow.btnColorLegend:SetParent(mainWindow.panelMissions);
    mainWindow.btnColorLegend:SetPosition(0, row1Y);
    mainWindow.btnColorLegend:SetSize(95, 58);
    mainWindow.btnColorLegend:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.btnColorLegend:SetText("Color Guide");
    mainWindow.btnColorLegend.Click = function()
        ShowColorLegendDialog();
    end

    mainWindow.lblProgress = Turbine.UI.Label();
    mainWindow.lblProgress:SetParent(mainWindow.panelMissions);
    mainWindow.lblProgress:SetPosition(98, row1Y);
    mainWindow.lblProgress:SetSize(378, 18);
    mainWindow.lblProgress:SetFont(Turbine.UI.Lotro.Font.TrajanProBold14);
    mainWindow.lblProgress:SetForeColor(Colors.BrightGold);
    mainWindow.lblProgress:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
    mainWindow.lblProgress:SetText("High tier delvings (tier 6 and higher): 0/10");

    mainWindow.lblProgressWeekly = Turbine.UI.Label();
    mainWindow.lblProgressWeekly:SetParent(mainWindow.panelMissions);
    mainWindow.lblProgressWeekly:SetPosition(98, row2Y);
    mainWindow.lblProgressWeekly:SetSize(378, 18);
    mainWindow.lblProgressWeekly:SetFont(Turbine.UI.Lotro.Font.TrajanProBold14);
    mainWindow.lblProgressWeekly:SetForeColor(Colors.BrightGold);
    mainWindow.lblProgressWeekly:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
    mainWindow.lblProgressWeekly:SetText("On A Mission (Weekly): 0/15");

    mainWindow.lblProgressWeekly45 = Turbine.UI.Label();
    mainWindow.lblProgressWeekly45:SetParent(mainWindow.panelMissions);
    mainWindow.lblProgressWeekly45:SetPosition(98, row3Y);
    mainWindow.lblProgressWeekly45:SetSize(378, 18);
    mainWindow.lblProgressWeekly45:SetFont(Turbine.UI.Lotro.Font.TrajanProBold14);
    mainWindow.lblProgressWeekly45:SetForeColor(Colors.BrightGold);
    mainWindow.lblProgressWeekly45:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
    mainWindow.lblProgressWeekly45:SetText("On A Continuing Mission (Weekly): 0/45");

    local function CreateMiniStepperButton(parent, x, y, w, h, text)
        local btn = Turbine.UI.Control();
        btn:SetParent(parent);
        btn:SetPosition(x, y);
        btn:SetSize(w, h);
        btn:SetBackColor(Turbine.UI.Color(0.85, 0.14, 0.15, 0.18));

        local border = Turbine.UI.Control();
        border:SetParent(btn);
        border:SetPosition(0, 0);
        border:SetSize(w, h);
        border:SetBackColor(Turbine.UI.Color(0.40, 0.42, 0.46));
        border:SetMouseVisible(false);

        local inner = Turbine.UI.Control();
        inner:SetParent(btn);
        inner:SetPosition(1, 1);
        inner:SetSize(w - 2, h - 2);
        inner:SetBackColor(Turbine.UI.Color(0.90, 0.12, 0.13, 0.16));
        inner:SetMouseVisible(false);

        local lbl = Turbine.UI.Label();
        lbl:SetParent(btn);
        lbl:SetPosition(0, 0);
        lbl:SetSize(w, h);
        lbl:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
        lbl:SetForeColor(Colors.BrightGold);
        lbl:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        lbl:SetText(text);
        lbl:SetMouseVisible(false);

        btn.MouseEnter = function()
            border:SetBackColor(Colors.BrightGold);
            inner:SetBackColor(Turbine.UI.Color(0.90, 0.22, 0.24, 0.30));
            lbl:SetForeColor(Colors.White);
        end
        btn.MouseLeave = function()
            border:SetBackColor(Turbine.UI.Color(0.40, 0.42, 0.46));
            inner:SetBackColor(Turbine.UI.Color(0.90, 0.12, 0.13, 0.16));
            lbl:SetForeColor(Colors.BrightGold);
        end
        btn.MouseDown = function()
            inner:SetBackColor(Turbine.UI.Color(0.95, 0.06, 0.07, 0.09));
        end
        btn.MouseUp = function()
            inner:SetBackColor(Turbine.UI.Color(0.90, 0.22, 0.24, 0.30));
        end
        btn.MouseClick = function()
            if btn.Action then btn.Action(); end
        end

        return btn;
    end

    -- Daily Steppers (Delvings: 0/10)
    mainWindow.btnDailyMinus = CreateMiniStepperButton(mainWindow.panelMissions, 480, row1Y, 20, 18, "-");
    mainWindow.btnDailyMinus.Action = function()
        local cur = CountCompletedDaily();
        if cur > 0 then
            DH.settings.countDaily = cur - 1;
            DH.settings.manualOffsetDaily = DH.settings.countDaily;
            SaveSettings();
            RefreshMainWindow();
            RefreshIconBadge();
        end
    end

    mainWindow.btnDailyPlus = CreateMiniStepperButton(mainWindow.panelMissions, 504, row1Y, 20, 18, "+");
    mainWindow.btnDailyPlus.Action = function()
        local cur = CountCompletedDaily();
        local maxGoal = DH.settings.dailyGoal or 10;
        if cur < maxGoal then
            DH.settings.countDaily = cur + 1;
            DH.settings.manualOffsetDaily = DH.settings.countDaily;
            SaveSettings();
            RefreshMainWindow();
            RefreshIconBadge();
        end
    end

    -- Weekly Steppers (On a Mission: 0/15)
    mainWindow.btnWeeklyMinus = CreateMiniStepperButton(mainWindow.panelMissions, 480, row2Y, 20, 18, "-");
    mainWindow.btnWeeklyMinus.Action = function()
        local cur = CountCompletedWeekly();
        if cur > 0 then
            DH.settings.countWeekly = cur - 1;
            DH.settings.manualOffsetWeekly = DH.settings.countWeekly;
            SaveSettings();
            RefreshMainWindow();
            RefreshIconBadge();
        end
    end

    mainWindow.btnWeeklyPlus = CreateMiniStepperButton(mainWindow.panelMissions, 504, row2Y, 20, 18, "+");
    mainWindow.btnWeeklyPlus.Action = function()
        local cur = CountCompletedWeekly();
        local maxGoal = DH.settings.weeklyGoal or 15;
        if cur < maxGoal then
            DH.settings.countWeekly = cur + 1;
            DH.settings.manualOffsetWeekly = DH.settings.countWeekly;
            SaveSettings();
            RefreshMainWindow();
            RefreshIconBadge();
        end
    end

    -- Weekly 45 Steppers (On a Continuing Mission: 0/45)
    mainWindow.btnWeekly45Minus = CreateMiniStepperButton(mainWindow.panelMissions, 480, row3Y, 20, 18, "-");
    mainWindow.btnWeekly45Minus.Action = function()
        local cur = CountCompletedWeekly45();
        if cur > 0 then
            DH.settings.countWeekly45 = cur - 1;
            DH.settings.manualOffsetWeekly45 = DH.settings.countWeekly45;
            SaveSettings();
            RefreshMainWindow();
            RefreshIconBadge();
        end
    end

    mainWindow.btnWeekly45Plus = CreateMiniStepperButton(mainWindow.panelMissions, 504, row3Y, 20, 18, "+");
    mainWindow.btnWeekly45Plus.Action = function()
        local cur = CountCompletedWeekly45();
        local maxGoal = DH.settings.weekly45Goal or 45;
        if cur < maxGoal then
            DH.settings.countWeekly45 = cur + 1;
            DH.settings.manualOffsetWeekly45 = DH.settings.countWeekly45;
            SaveSettings();
            RefreshMainWindow();
            RefreshIconBadge();
        end
    end

    -- Reset Button (Right of both stepper rows)
    local btnReset = Turbine.UI.Lotro.Button();
    btnReset:SetParent(mainWindow.panelMissions);
    btnReset:SetPosition(529, row1Y);
    btnReset:SetSize(95, 58);
    btnReset:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    btnReset:SetText("Reset Count");
    btnReset.Click = function()
        ShowConfirmResetDialog();
    end

    -- ------------------------------------------------------------------------
    -- Collapsible Travel Tray (Option 3: Fast Travel & Return Maps)
    -- ------------------------------------------------------------------------
    local trayToggleY = 88;
    local trayToggleH = 24;
    local trayW = mainWindow.panelMissions:GetWidth() - 14;

    -- Variant 2: Standard LOTRO Button (Left side, 210px width matching UI style)
    mainWindow.btnTravelToggle = Turbine.UI.Lotro.Button();
    mainWindow.btnTravelToggle:SetParent(mainWindow.panelMissions);
    mainWindow.btnTravelToggle:SetPosition(0, trayToggleY);
    mainWindow.btnTravelToggle:SetSize(210, trayToggleH);
    mainWindow.btnTravelToggle:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);

    -- Center Hint Label (Subtle text explaining click action)
    mainWindow.lblTravelHint = Turbine.UI.Label();
    mainWindow.lblTravelHint:SetParent(mainWindow.panelMissions);
    mainWindow.lblTravelHint:SetPosition(216, trayToggleY + 3);
    mainWindow.lblTravelHint:SetSize(trayW - 216 - 104, 20);
    mainWindow.lblTravelHint:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    mainWindow.lblTravelHint:SetForeColor(Turbine.UI.Color(0.65, 0.60, 0.50));
    mainWindow.lblTravelHint:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    mainWindow.lblTravelHint:SetText("(Click to toggle ports & maps)");
    mainWindow.lblTravelHint:SetMouseVisible(false);

    -- Reset Slots Button (Right side, 100px width)
    mainWindow.btnResetTravel = Turbine.UI.Lotro.Button();
    mainWindow.btnResetTravel:SetParent(mainWindow.panelMissions);
    mainWindow.btnResetTravel:SetPosition(trayW - 100, trayToggleY);
    mainWindow.btnResetTravel:SetSize(100, trayToggleH);
    mainWindow.btnResetTravel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.btnResetTravel:SetText("Reset Slots");

    -- Travel Tray Panel (Contains 6 Quickslots)
    local trayContentY = trayToggleY + trayToggleH + 4;
    local trayContentH = 68;

    mainWindow.travelTray = Turbine.UI.Control();
    mainWindow.travelTray:SetParent(mainWindow.panelMissions);
    mainWindow.travelTray:SetPosition(0, trayContentY);
    mainWindow.travelTray:SetSize(trayW, trayContentH);
    mainWindow.travelTray:SetBackColor(Turbine.UI.Color(0.88, 0.08, 0.09, 0.10));
    ApplySmoothedBorder(mainWindow.travelTray, Turbine.UI.Color(0.35, 0.38, 0.32, 0.22), 2);

    -- Baruk-style Quickslot Creator (Equendil Architecture)
    -- Overrides VisibleChanged so empty quickslots never get hidden by LOTRO engine,
    -- enabling flawless drag & drop of any skills, map items, or milestones!
    local function CreateBarukQuickslot(parent, x, y, sz)
        local qs = Turbine.UI.Lotro.Quickslot();
        qs:SetParent(parent);
        qs:SetPosition(x, y);
        qs:SetSize(sz, sz);
        qs:SetZOrder(10);
        qs:SetAllowDrop(true);

        qs.pressed = false;
        qs.dragging = false;

        qs.MouseDown = function(sender, args)
            if args.Button == Turbine.UI.MouseButton.Left then
                qs.pressed = true;
            end
        end

        qs.MouseLeave = function(sender, args)
            if qs.pressed then
                qs.dragging = true;
            end
        end

        qs.MouseUp = function(sender, args)
            if args.Button == Turbine.UI.MouseButton.Left then
                if qs.dragging then
                    pcall(function() qs:SetShortcut(nil); end);
                end
            end
            qs.pressed = false;
            qs.dragging = false;
        end

        -- Keep Quickslot visible even when blank/undefined
        local function KeepVisible()
            qs.VisibleChanged = nil;
            qs:SetVisible(true);
            qs.VisibleChanged = KeepVisible;
        end
        qs.VisibleChanged = KeepVisible;
        KeepVisible();

        return qs;
    end

    local function SafeSetShortcut(qs, stype, sdata)
        if not qs or not stype or not sdata then return end
        pcall(function()
            local sc = Turbine.UI.Lotro.Shortcut(stype, sdata);
            if sc then
                qs:SetShortcut(sc);
            end
        end);
    end

    mainWindow.travelSlots = {};
    local travelList = D.DefaultTravelSkills or {};
    local numSlots = #travelList;
    local slotColW = math.floor(trayW / math.max(1, numSlots));

    local function ApplyTravelSlotShortcuts()
        for idx, cfg in ipairs(travelList) do
            local item = mainWindow.travelSlots[cfg.id];
            if item and item.qs then
                local saved = DH.settings.customTravelSlots and DH.settings.customTravelSlots[cfg.id];
                if saved and saved.type and saved.data then
                    SafeSetShortcut(item.qs, saved.type, saved.data);
                elseif cfg.skillId then
                    SafeSetShortcut(item.qs, Turbine.UI.Lotro.ShortcutType.Skill, cfg.skillId);
                else
                    pcall(function() item.qs:SetShortcut(nil); end);
                end
            end
        end
    end

    for idx, cfg in ipairs(travelList) do
        local colX = (idx - 1) * slotColW;
        local qsX = colX + math.floor((slotColW - 36) / 2);

        -- Slot Frame & Border (direct child of travelTray)
        local slotFrame = Turbine.UI.Control();
        slotFrame:SetParent(mainWindow.travelTray);
        slotFrame:SetPosition(qsX - 1, 3);
        slotFrame:SetSize(38, 38);
        slotFrame:SetBackColor(Turbine.UI.Color(0.28, 0.25, 0.18));
        slotFrame:SetZOrder(1);
        slotFrame:SetMouseVisible(false);

        local slotInner = Turbine.UI.Control();
        slotInner:SetParent(slotFrame);
        slotInner:SetPosition(1, 1);
        slotInner:SetSize(36, 36);
        slotInner:SetBackColor(Turbine.UI.Color(0.85, 0.05, 0.05, 0.06));
        slotInner:SetMouseVisible(false);

        local lblSlotPlus = Turbine.UI.Label();
        lblSlotPlus:SetParent(slotInner);
        lblSlotPlus:SetPosition(0, 0);
        lblSlotPlus:SetSize(36, 36);
        lblSlotPlus:SetFont(Turbine.UI.Lotro.Font.TrajanPro16);
        lblSlotPlus:SetForeColor(Turbine.UI.Color(0.40, 0.36, 0.28));
        lblSlotPlus:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        lblSlotPlus:SetText("+");
        lblSlotPlus:SetMouseVisible(false);

        -- Centered 36x36 Quickslot with Baruk architecture
        local qs = CreateBarukQuickslot(mainWindow.travelTray, qsX, 4, 36);

        -- Quickslot Drag & Drop Re-bind / Assignment
        qs.ShortcutChanged = function(sender, args)
            local sc = sender:GetShortcut();
            if sc and sc:GetType() ~= Turbine.UI.Lotro.ShortcutType.Undefined then
                DH.settings.customTravelSlots = DH.settings.customTravelSlots or {};
                DH.settings.customTravelSlots[cfg.id] = {
                    type = sc:GetType(),
                    data = sc:GetData()
                };
                SaveSettings();
                Turbine.Shell.WriteLine("<rgb=#00FF66>[DelvingHelper] Saved custom travel port for " .. cfg.name .. ": " .. tostring(sc:GetData()) .. "</rgb>");
            else
                if DH.settings.customTravelSlots then
                    DH.settings.customTravelSlots[cfg.id] = nil;
                    SaveSettings();
                end
                if cfg.skillId then
                    SafeSetShortcut(sender, Turbine.UI.Lotro.ShortcutType.Skill, cfg.skillId);
                end
            end
        end

        local lblName = Turbine.UI.Label();
        lblName:SetParent(mainWindow.travelTray);
        lblName:SetPosition(colX, 42);
        lblName:SetSize(slotColW, 12);
        lblName:SetFont(Turbine.UI.Lotro.Font.Verdana12);
        lblName:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        lblName:SetForeColor(Colors.BrightGold);
        lblName:SetText(cfg.name);
        lblName:SetMouseVisible(false);

        local lblSub = Turbine.UI.Label();
        lblSub:SetParent(mainWindow.travelTray);
        lblSub:SetPosition(colX, 54);
        lblSub:SetSize(slotColW, 11);
        lblSub:SetFont(Turbine.UI.Lotro.Font.Verdana10);
        lblSub:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        lblSub:SetForeColor(Turbine.UI.Color(0.60, 0.58, 0.52));
        lblSub:SetText(cfg.subName);
        lblSub:SetMouseVisible(false);

        mainWindow.travelSlots[cfg.id] = {
            qs = qs,
            cfg = cfg
        };
    end

    ApplyTravelSlotShortcuts();

    mainWindow.btnResetTravel.Click = function()
        DH.settings.customTravelSlots = {};
        SaveSettings();
        ApplyTravelSlotShortcuts();
        Turbine.Shell.WriteLine("<rgb=#00FF66>[DelvingHelper] Fast Travel slots reset to default Return skills.</rgb>");
    end

    -- ------------------------------------------------------------------------
    -- Search & Smart Filters Bar
    -- ------------------------------------------------------------------------
    local searchBarH = 26;
    mainWindow.searchBar = Turbine.UI.Control();
    mainWindow.searchBar:SetParent(mainWindow.panelMissions);
    mainWindow.searchBar:SetSize(mainWindow.panelMissions:GetWidth() - 14, searchBarH);
    mainWindow.searchBar:SetBackColor(Turbine.UI.Color(0.85, 0.08, 0.09, 0.11));
    ApplySmoothedBorder(mainWindow.searchBar, Turbine.UI.Color(0.35, 0.38, 0.32, 0.22), 1);

    local lblSearch = Turbine.UI.Label();
    lblSearch:SetParent(mainWindow.searchBar);
    lblSearch:SetPosition(8, 4);
    lblSearch:SetSize(50, 18);
    lblSearch:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    lblSearch:SetForeColor(Colors.BrightGold);
    lblSearch:SetText("Search:");
    lblSearch:SetMouseVisible(false);

    mainWindow.txtSearch = Turbine.UI.Lotro.TextBox();
    mainWindow.txtSearch:SetParent(mainWindow.searchBar);
    mainWindow.txtSearch:SetPosition(60, 2);
    mainWindow.txtSearch:SetSize(195, 22);
    mainWindow.txtSearch:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    mainWindow.txtSearch:SetForeColor(Colors.White);
    mainWindow.txtSearch:SetMultiline(false);
    mainWindow.txtSearch:SetText(DH.settings.searchText or "");

    local updatingSearch = false;
    mainWindow.txtSearch.TextChanged = function()
        if updatingSearch then return; end
        DH.settings.searchText = mainWindow.txtSearch:GetText();
        RefreshMainWindow();
    end

    mainWindow.btnClearSearch = Turbine.UI.Lotro.Button();
    mainWindow.btnClearSearch:SetParent(mainWindow.searchBar);
    mainWindow.btnClearSearch:SetPosition(260, 2);
    mainWindow.btnClearSearch:SetSize(52, 22);
    mainWindow.btnClearSearch:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.btnClearSearch:SetText("Clear");
    mainWindow.btnClearSearch.Click = function()
        updatingSearch = true;
        mainWindow.txtSearch:SetText("");
        DH.settings.searchText = "";
        updatingSearch = false;
        SaveSettings();
        RefreshMainWindow();
    end

    local function UpdateFilterButtonStates()
        if mainWindow.btnFilterIncomplete then
            if DH.settings.filterIncomplete then
                mainWindow.btnFilterIncomplete:SetText("Incomplete (ON)");
            else
                mainWindow.btnFilterIncomplete:SetText("Incomplete");
            end
        end
    end

    mainWindow.btnFilterIncomplete = Turbine.UI.Lotro.Button();
    mainWindow.btnFilterIncomplete:SetParent(mainWindow.searchBar);
    mainWindow.btnFilterIncomplete:SetPosition(360, 2);
    mainWindow.btnFilterIncomplete:SetSize(130, 22);
    mainWindow.btnFilterIncomplete:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.btnFilterIncomplete.Click = function()
        DH.settings.filterIncomplete = not DH.settings.filterIncomplete;
        SaveSettings();
        UpdateFilterButtonStates();
        RefreshMainWindow();
    end

    mainWindow.btnFilterReset = Turbine.UI.Lotro.Button();
    mainWindow.btnFilterReset:SetParent(mainWindow.searchBar);
    mainWindow.btnFilterReset:SetPosition(496, 2);
    mainWindow.btnFilterReset:SetSize(108, 22);
    mainWindow.btnFilterReset:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    mainWindow.btnFilterReset:SetText("Reset");
    mainWindow.btnFilterReset.Click = function()
        updatingSearch = true;
        mainWindow.txtSearch:SetText("");
        DH.settings.searchText = "";
        updatingSearch = false;
        DH.settings.filterIncomplete = false;
        DH.settings.filterHub = "all";
        SaveSettings();
        UpdateFilterButtonStates();
        RefreshMainWindow();
    end

    UpdateFilterButtonStates();

    local function UpdateTravelTrayLayout()
        local baseListY = trayToggleY + trayToggleH + 4;
        local searchY = baseListY;
        if DH.settings.showTravelTray then
            mainWindow.travelTray:SetVisible(true);
            mainWindow.btnTravelToggle:SetText("[ - ] Travel & Return Maps");
            searchY = baseListY + trayContentH + 4;
        else
            mainWindow.travelTray:SetVisible(false);
            mainWindow.btnTravelToggle:SetText("[ + ] Travel & Return Maps");
        end

        mainWindow.searchBar:SetPosition(0, searchY);
        local listY = searchY + searchBarH + 4;
        local listH = mainWindow.panelMissions:GetHeight() - listY - 8;
        mainWindow.listBox:SetPosition(0, listY);
        mainWindow.listBox:SetSize(mainWindow.panelMissions:GetWidth() - 14, listH);
        mainWindow.scrollBar:SetPosition(mainWindow.panelMissions:GetWidth() - 12, listY);
        mainWindow.scrollBar:SetSize(12, listH);
    end

    mainWindow.btnTravelToggle.Click = function()
        DH.settings.showTravelTray = not DH.settings.showTravelTray;
        SaveSettings();
        UpdateTravelTrayLayout();
    end

    -- Scrollable ListBox for Missions
    local listY = trayToggleY + trayToggleH + 4;
    local listH = mainWindow.panelMissions:GetHeight() - listY - 8;
    mainWindow.listBox = Turbine.UI.ListBox();
    mainWindow.listBox:SetParent(mainWindow.panelMissions);
    mainWindow.listBox:SetPosition(0, listY);
    mainWindow.listBox:SetSize(mainWindow.panelMissions:GetWidth() - 14, listH);
    mainWindow.listBox:SetOrientation(Turbine.UI.Orientation.Horizontal);
    mainWindow.listBox:SetMaxItemsPerLine(1);

    mainWindow.scrollBar = Turbine.UI.Lotro.ScrollBar();
    mainWindow.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    mainWindow.scrollBar:SetParent(mainWindow.panelMissions);
    mainWindow.scrollBar:SetPosition(mainWindow.panelMissions:GetWidth() - 12, listY);
    mainWindow.scrollBar:SetSize(12, listH);
    mainWindow.listBox:SetVerticalScrollBar(mainWindow.scrollBar);

    UpdateTravelTrayLayout();

    -- Container for Delving Malice Panel
    mainWindow.panelMalice = Turbine.UI.Control();
    mainWindow.panelMalice:SetParent(mainWindow);
    mainWindow.panelMalice:SetPosition(18, 144);
    mainWindow.panelMalice:SetSize(DH.settings.winW - 36, DH.settings.winH - 156);
    mainWindow.panelMalice:SetVisible(false);

    -- Container for Writ Yields Guide Panel
    mainWindow.panelWrits = Turbine.UI.Control();
    mainWindow.panelWrits:SetParent(mainWindow);
    mainWindow.panelWrits:SetPosition(18, 144);
    mainWindow.panelWrits:SetSize(DH.settings.winW - 36, DH.settings.winH - 156);
    mainWindow.panelWrits:SetVisible(false);

    RefreshMainWindow();
end

-- ----------------------------------------------------------------------------
-- Refresh Main Window Content
-- ----------------------------------------------------------------------------
RefreshMainWindow = function()
    if not mainWindow then return end

    local timeTable = GetCurrentTimeTable();
    CheckDailyReset(timeTable);

    local autoDay = D.GetActiveRotationDay(timeTable, DH.settings.serverResetHour);
    local selectedDay = autoDay;
    if DH.settings.selectedDayOverride == -1 then
        selectedDay = -1;
    elseif DH.settings.selectedDayOverride and DH.settings.selectedDayOverride > 0 then
        selectedDay = DH.settings.selectedDayOverride;
    else
        selectedDay = autoDay;
    end

    local dayInfo = (selectedDay > 0 and D.Days[selectedDay]) or D.Days[1];
    local isToday = (selectedDay == autoDay or DH.settings.selectedDayOverride == 0);

    if mainWindow.dayButtons then
        for id, btn in pairs(mainWindow.dayButtons) do
            local isDayToday = (id == autoDay);
            local isDaySelected = false;
            if id == -1 then
                isDaySelected = (DH.settings.selectedDayOverride == -1);
            elseif id == autoDay then
                isDaySelected = (DH.settings.selectedDayOverride == 0 or DH.settings.selectedDayOverride == autoDay);
            else
                isDaySelected = (DH.settings.selectedDayOverride == id);
            end

            btn.isToday = isDayToday;
            btn.isSelected = isDaySelected;

            btn.UpdateVisualState = function()
                if btn.isSelected then
                    btn.border:SetBackColor(Colors.BrightGold);
                    btn.inner:SetBackColor(Turbine.UI.Color(0.92, 0.20, 0.16, 0.08));
                    btn.lbl:SetForeColor(Colors.BrightGold);
                    btn.todayBar:SetVisible(btn.isToday);
                elseif btn.isToday then
                    btn.border:SetBackColor(Colors.BrightGreen);
                    btn.inner:SetBackColor(Turbine.UI.Color(0.90, 0.08, 0.16, 0.08));
                    btn.lbl:SetForeColor(Colors.BrightGreen);
                    btn.todayBar:SetVisible(true);
                else
                    btn.border:SetBackColor(Turbine.UI.Color(0.40, 0.42, 0.46));
                    btn.inner:SetBackColor(Turbine.UI.Color(0.90, 0.12, 0.13, 0.16));
                    btn.lbl:SetForeColor(Turbine.UI.Color(0.80, 0.75, 0.65));
                    btn.todayBar:SetVisible(false);
                end
            end
            btn.UpdateVisualState();
        end
    end

    local resetSec = GetSecondsUntilReset(timeTable, 3);
    local secThu = D.GetSecondsUntilWeeklyReset(timeTable);
    local durDaily = FormatDuration(resetSec);
    local durWeekly = D.FormatWeeklyDuration(secThu);
    local tz = timeTable.tzName or "EST";
    local localT = timeTable.localTime or timeTable;

    mainWindow.lblCountdown:SetText(string.format(
        "Daily: %s  |  Weekly: %s  |  Server: %02d:%02d %s  |  Local: %02d:%02d",
        durDaily, durWeekly, timeTable.Hour, timeTable.Minute, tz, localT.Hour, localT.Minute
    ));

    local isMissionsView = (DH.settings.viewMode == "missions");
    local isMaliceView = (DH.settings.viewMode == "malice");
    local isWritsView = (DH.settings.viewMode == "writs");

    mainWindow.panelMissions:SetVisible(isMissionsView);
    mainWindow.panelMalice:SetVisible(isMaliceView);
    mainWindow.panelWrits:SetVisible(isWritsView);

    mainWindow.btnTabMissions:SetEnabled(not isMissionsView);
    mainWindow.btnTabMissions:SetText("Burglar Writs");
    mainWindow.btnTabMalice:SetEnabled(not isMaliceView);
    mainWindow.btnTabWrits:SetEnabled(not isWritsView);

    if isMissionsView then
        for hubId, btn in pairs(mainWindow.hubButtons) do
            local isSelected = (hubId == DH.settings.filterHub) or (hubId == "warroom" and DH.settings.filterHub == "annak_khurfu");
            btn:SetEnabled(not isSelected);
        end

        local completedDaily = CountCompletedDaily();
        local completedWeekly = CountCompletedWeekly();
        local completedWeekly45 = CountCompletedWeekly45();
        local dailyGoal = DH.settings.dailyGoal or 10;
        local weeklyGoal = DH.settings.weeklyGoal or 15;
        local weekly45Goal = DH.settings.weekly45Goal or 45;

        mainWindow.lblProgress:SetText(string.format("High tier delvings (tier 6 and higher): %d/%d", completedDaily, dailyGoal));
        mainWindow.lblProgress:SetForeColor(completedDaily >= dailyGoal and Colors.BrightGreen or Colors.BrightGold);

        if mainWindow.lblProgressWeekly then
            mainWindow.lblProgressWeekly:SetText(string.format("On A Mission (Weekly): %d/%d", completedWeekly, weeklyGoal));
            mainWindow.lblProgressWeekly:SetForeColor(completedWeekly >= weeklyGoal and Colors.BrightGreen or Colors.BrightGold);
        end

        if mainWindow.lblProgressWeekly45 then
            mainWindow.lblProgressWeekly45:SetText(string.format("On A Continuing Mission (Weekly): %d/%d", completedWeekly45, weekly45Goal));
            mainWindow.lblProgressWeekly45:SetForeColor(completedWeekly45 >= weekly45Goal and Colors.BrightGreen or Colors.BrightGold);
        end

        mainWindow.listBox:ClearItems();

        local missionList = D.GetBurglarMissions(selectedDay, DH.settings.filterHub, false, DH.settings.favorites);

        local searchPattern = string.lower(string.gsub(DH.settings.searchText or "", "^%s*(.-)%s*$", "%1"));
        local filteredList = {};
        for _, mission in ipairs(missionList) do
            local activeDay = (selectedDay > 0) and selectedDay or ((mission.dayId and mission.dayId > 0) and mission.dayId or autoDay);
            local missionKey = tostring(activeDay) .. ":" .. mission.shortName;
            local isDone = (DH.settings.completedMissions[missionKey] == true);

            local keep = true;

            -- 1. Incomplete Filter
            if DH.settings.filterIncomplete and isDone then
                keep = false;
            end

            -- 2. Search text query
            if keep and #searchPattern > 0 then
                local fullTitle = string.lower(mission.name or "");
                local shortTitle = string.lower(mission.shortName or "");
                local npcName = string.lower(mission.npc or "");
                local hubName = string.lower(mission.hub or "");
                local areaName = string.lower(mission.area or "");
                local locName = string.lower(mission.location or "");

                local match = string.find(fullTitle, searchPattern, 1, true)
                    or string.find(shortTitle, searchPattern, 1, true)
                    or string.find(npcName, searchPattern, 1, true)
                    or string.find(hubName, searchPattern, 1, true)
                    or string.find(areaName, searchPattern, 1, true)
                    or string.find(locName, searchPattern, 1, true);

                if not match then
                    keep = false;
                end
            end

            if keep then
                table.insert(filteredList, mission);
            end
        end

        local cardW = mainWindow.listBox:GetWidth();
        local cardH = 88;

        if #filteredList == 0 then
            local emptyCard = Turbine.UI.Control();
            emptyCard:SetSize(cardW, 90);
            emptyCard:SetBackColor(Turbine.UI.Color(0.85, 0.08, 0.09, 0.12));

            local lblEmpty = Turbine.UI.Label();
            lblEmpty:SetParent(emptyCard);
            lblEmpty:SetPosition(20, 20);
            lblEmpty:SetSize(cardW - 40, 50);
            lblEmpty:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
            lblEmpty:SetForeColor(Colors.BrightGold);
            lblEmpty:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
            if #searchPattern > 0 then
                lblEmpty:SetText(string.format("No missions found matching '%s'.\nClick 'Clear' to clear search.", DH.settings.searchText));
            elseif DH.settings.filterIncomplete then
                lblEmpty:SetText("All missions in this selection are COMPLETED!\nToggle 'Incomplete' or choose another day/hub.");
            elseif DH.settings.filterHub == "favorites" then
                lblEmpty:SetText("No favorite missions found for this day selection.\nClick the star button on any mission to add it to Favorites!");
            else
                lblEmpty:SetText("No missions found matching the selected filters.");
            end
            mainWindow.listBox:AddItem(emptyCard);
        end

        local dayShortNames = {
            [1] = "Mon",
            [2] = "Tue",
            [3] = "Wed",
            [4] = "Thu",
            [5] = "Fri",
            [6] = "Sat",
            [7] = "Sun",
        };

        for _, mission in ipairs(filteredList) do
            local activeDay = (selectedDay > 0) and selectedDay or ((mission.dayId and mission.dayId > 0) and mission.dayId or autoDay);
            local missionKey = tostring(activeDay) .. ":" .. mission.shortName;
            local isDone = (DH.settings.completedMissions[missionKey] == true);
            local favDayKey = tostring(activeDay) .. ":" .. mission.shortName;
            local isFav = false;
            if DH.settings.favorites then
                if DH.settings.favorites[favDayKey] ~= nil then
                    isFav = (DH.settings.favorites[favDayKey] == true);
                else
                    isFav = (DH.settings.favorites[mission.shortName] == true);
                end
            end

            local card = Turbine.UI.Control();
            card:SetSize(cardW, cardH);
            local defaultCardBg = (mission.highlightColor == "yellow") and Turbine.UI.Color(0.90, 0.15, 0.13, 0.06) or (
                (mission.highlightColor == "blue") and Turbine.UI.Color(0.90, 0.05, 0.09, 0.16) or (
                    (mission.highlightColor == "red") and Turbine.UI.Color(0.90, 0.16, 0.05, 0.06) or Colors.CardBg
                )
            );
            card:SetBackColor(isDone and Colors.CardDoneBg or defaultCardBg);

            local bColor = isDone and Colors.BorderGreen or (
                (mission.highlightColor == "red") and Colors.Red or (
                    (mission.highlightColor == "blue") and Colors.Cyan or (
                        (mission.highlightColor == "yellow" or mission.isSpeedrun) and Colors.BorderGold or Colors.Border
                    )
                )
            );
            local innerHighlight = isDone and Turbine.UI.Color(0.35, 0.30, 0.85, 0.37) or (
                (mission.highlightColor == "red") and Turbine.UI.Color(0.40, 0.90, 0.30, 0.25) or (
                    (mission.highlightColor == "blue") and Turbine.UI.Color(0.40, 0.35, 0.85, 1.00) or (
                        (mission.highlightColor == "yellow" or mission.isSpeedrun) and Turbine.UI.Color(0.40, 1.00, 0.85, 0.35) or Turbine.UI.Color(0.20, 0.55, 0.50, 0.40)
                    )
                )
            );
            ApplySmoothedBorder(card, bColor, 3, innerHighlight);

            -- Checkbox (Completion)
            local cb = Turbine.UI.Lotro.CheckBox();
            cb:SetParent(card);
            cb:SetPosition(8, 8);
            cb:SetSize(20, 20);
            cb:SetChecked(isDone);
            cb.CheckedChanged = function()
                local checked = cb:IsChecked();
                DH.settings.completedMissions[missionKey] = checked;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
            end

            -- Favorite Star Button
            local btnFav = Turbine.UI.Control();
            btnFav:SetParent(card);
            btnFav:SetPosition(32, 7);
            btnFav:SetSize(22, 22);

            local favBorder = Turbine.UI.Control();
            favBorder:SetParent(btnFav);
            favBorder:SetPosition(0, 0);
            favBorder:SetSize(22, 22);
            favBorder:SetBackColor(isFav and Colors.BorderGold or Turbine.UI.Color(0.35, 0.35, 0.38));
            favBorder:SetMouseVisible(false);

            local favInner = Turbine.UI.Control();
            favInner:SetParent(btnFav);
            favInner:SetPosition(1, 1);
            favInner:SetSize(20, 20);
            favInner:SetBackColor(isFav and Turbine.UI.Color(0.92, 0.22, 0.18, 0.08) or Turbine.UI.Color(0.90, 0.10, 0.10, 0.12));
            favInner:SetMouseVisible(false);

            local favStar = Turbine.UI.Control();
            favStar:SetParent(btnFav);
            favStar:SetPosition(5, 5);
            favStar:SetSize(12, 12);
            favStar:SetBlendMode(Turbine.UI.BlendMode.Overlay);
            favStar:SetBackground(isFav and "DelvingHelper/star_on.tga" or "DelvingHelper/star_off.tga");
            favStar:SetMouseVisible(false);

            btnFav.MouseEnter = function()
                favBorder:SetBackColor(Colors.BrightGold);
                favInner:SetBackColor(Turbine.UI.Color(0.92, 0.26, 0.22, 0.10));
            end

            btnFav.MouseLeave = function()
                local curFav = false;
                if DH.settings.favorites then
                    if DH.settings.favorites[favDayKey] ~= nil then
                        curFav = (DH.settings.favorites[favDayKey] == true);
                    else
                        curFav = (DH.settings.favorites[mission.shortName] == true);
                    end
                end
                favBorder:SetBackColor(curFav and Colors.BorderGold or Turbine.UI.Color(0.35, 0.35, 0.38));
                favInner:SetBackColor(curFav and Turbine.UI.Color(0.92, 0.22, 0.18, 0.08) or Turbine.UI.Color(0.90, 0.10, 0.10, 0.12));
                favStar:SetBackground(curFav and "DelvingHelper/star_on.tga" or "DelvingHelper/star_off.tga");
            end

            btnFav.MouseClick = function()
                DH.settings.favorites = DH.settings.favorites or {};
                local curFav = false;
                if DH.settings.favorites[favDayKey] ~= nil then
                    curFav = (DH.settings.favorites[favDayKey] == true);
                else
                    curFav = (DH.settings.favorites[mission.shortName] == true);
                end
                local newFav = not curFav;
                local dayLabel = dayShortNames[activeDay] or ("Day " .. tostring(activeDay));
                if newFav then
                    DH.settings.favorites[favDayKey] = true;
                    Turbine.Shell.WriteLine("<rgb=#FFD700>[DelvingHelper] Added to Favorites (" .. dayLabel .. "): " .. (mission.shortName or mission.name) .. "</rgb>");
                else
                    DH.settings.favorites[favDayKey] = false;
                    DH.settings.favorites[mission.shortName] = nil;
                    Turbine.Shell.WriteLine("<rgb=#888888>[DelvingHelper] Removed from Favorites (" .. dayLabel .. "): " .. (mission.shortName or mission.name) .. "</rgb>");
                end
                SaveSettings();
                RefreshMainWindow();
            end

            -- Mission Name (clean short name without redundant prefix)
            local lblTitle = Turbine.UI.Label();
            lblTitle:SetParent(card);
            lblTitle:SetPosition(58, 6);
            lblTitle:SetSize(cardW - 280, 20);
            lblTitle:SetMultiline(false);
            lblTitle:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
            local titleColor = isDone and Colors.Green or (
                (mission.highlightColor == "red") and Colors.Red or (
                    (mission.highlightColor == "yellow") and Colors.BrightGold or (
                        (mission.highlightColor == "blue") and Colors.Cyan or Colors.White
                    )
                )
            );
            lblTitle:SetForeColor(titleColor);
            lblTitle:SetText(mission.shortName or mission.name);

            -- Hub & Day Badge (Single line, ample width, never wraps)
            local lblHub = Turbine.UI.Label();
            lblHub:SetParent(card);
            lblHub:SetPosition(cardW - 220, 6);
            lblHub:SetSize(212, 20);
            lblHub:SetMultiline(false);
            lblHub:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
            lblHub:SetForeColor(Colors.Cyan);
            lblHub:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
            local hubBadge = "Hub";
            if mission.hub == "warroom" or mission.hub == "annak_khurfu" then
                hubBadge = "War Room";
            elseif mission.hub == "bloody_eagle" or mission.hub == "the_bloody_eagle" then
                hubBadge = "Bloody Eagle";
            elseif mission.hubName then
                hubBadge = mission.hubName:match("^%a+") or mission.hubName;
            end

            local dayText = "";
            if selectedDay == -1 or DH.settings.filterHub == "favorites" then
                local badgeDay = (mission.dayId and mission.dayId > 0) and mission.dayId or activeDay;
                if dayShortNames[badgeDay] then
                    dayText = " [" .. dayShortNames[badgeDay] .. "]";
                elseif mission.days and mission.days ~= "" then
                    local dShort = mission.days:gsub("Monday", "Mon"):gsub("Tuesday", "Tue"):gsub("Wednesday", "Wed"):gsub("Thursday", "Thu"):gsub("Friday", "Fri"):gsub("Saturday", "Sat"):gsub("Sunday", "Sun");
                    dayText = " [" .. dShort .. "]";
                end
            end
            lblHub:SetText(hubBadge .. dayText);

            -- Line 2: Purple / Amethyst NPC Tag & Location
            local npcName = mission.npc or "Mission Giver";
            local tagText = "NPC: " .. npcName;
            local tagW = 14 + string.len(tagText) * 7;

            local tagNpc = Turbine.UI.Control();
            tagNpc:SetParent(card);
            tagNpc:SetPosition(58, 27);
            tagNpc:SetSize(tagW, 19);
            tagNpc:SetBackColor(Colors.PurpleBg);
            tagNpc:SetMouseVisible(false);
            ApplySmoothedBorder(tagNpc, Colors.PurpleBorder, 2);

            local lblTag = Turbine.UI.Label();
            lblTag:SetParent(tagNpc);
            lblTag:SetPosition(0, 0);
            lblTag:SetSize(tagW, 19);
            lblTag:SetFont(Turbine.UI.Lotro.Font.VerdanaBold12);
            lblTag:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
            lblTag:SetForeColor(Colors.PurpleText);
            lblTag:SetMouseVisible(false);
            lblTag:SetText(tagText);

            local locX = 58 + tagW + 8;
            local locW = math.max(80, (cardW - 92) - locX);
            local lblLoc = Turbine.UI.Label();
            lblLoc:SetParent(card);
            lblLoc:SetPosition(locX, 28);
            lblLoc:SetSize(locW, 18);
            lblLoc:SetMultiline(false);
            lblLoc:SetFont(Turbine.UI.Lotro.Font.Verdana12);
            lblLoc:SetForeColor(Colors.LightGray);
            lblLoc:SetMouseVisible(false);

            local place = mission.location or mission.hubName or "War Room";
            local locText = "";
            if mission.coords and mission.coords ~= "" then
                locText = string.format("[%s] - %s", mission.coords, place);
            else
                locText = place;
            end
            lblLoc:SetText(locText);

            -- Button to print run tip to chat
            local btnTip = Turbine.UI.Lotro.Button();
            btnTip:SetParent(card);
            btnTip:SetPosition(cardW - 88, 26);
            btnTip:SetSize(80, 22);
            btnTip:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
            btnTip:SetText("Run Tip");
            btnTip.Click = function()
                Turbine.Shell.WriteLine(string.format("<rgb=#55FFFF>[DelvingHelper] %s:</rgb>", mission.name));
                Turbine.Shell.WriteLine(string.format("<rgb=#FFFF55>  Bestower: %s at [%s] in %s</rgb>", mission.npc, mission.coords, mission.location or mission.hubName));
                Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>  Strategy: %s</rgb>", mission.tip or mission.objective));
            end

            -- Line 3: Delving Rush Strategy
            local lblObj = Turbine.UI.Label();
            lblObj:SetParent(card);
            lblObj:SetPosition(58, 52);
            lblObj:SetSize(cardW - 68, 28);
            lblObj:SetFont(Turbine.UI.Lotro.Font.Verdana12);
            lblObj:SetMultiline(true);
            lblObj:SetForeColor(mission.isSpeedrun and Colors.LightGray or Colors.Gray);
            lblObj:SetText(mission.tip or mission.objective);

            local itemWrapper = Turbine.UI.Control();
            itemWrapper:SetSize(cardW, cardH + 6);
            card:SetParent(itemWrapper);
            card:SetPosition(0, 0);
            mainWindow.listBox:AddItem(itemWrapper);
        end
    elseif isMaliceView then
        mainWindow.panelMalice:GetControls():Clear();

        local malice = D.GetMaliceVariant(timeTable, DH.settings.serverResetHour);
        local cardW = mainWindow.panelMalice:GetWidth();

        local lblMaliceTitle = Turbine.UI.Label();
        lblMaliceTitle:SetParent(mainWindow.panelMalice);
        lblMaliceTitle:SetPosition(0, 0);
        lblMaliceTitle:SetSize(cardW, 26);
        lblMaliceTitle:SetFont(Turbine.UI.Lotro.Font.TrajanProBold24);
        lblMaliceTitle:SetForeColor(Colors.Orange);
        lblMaliceTitle:SetText(malice.title);

        local lblTagline = Turbine.UI.Label();
        lblTagline:SetParent(mainWindow.panelMalice);
        lblTagline:SetPosition(0, 28);
        lblTagline:SetSize(cardW, 20);
        lblTagline:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
        lblTagline:SetForeColor(Colors.BrightGold);
        lblTagline:SetText(malice.tagline);

        local lblPots = Turbine.UI.Label();
        lblPots:SetParent(mainWindow.panelMalice);
        lblPots:SetPosition(0, 52);
        lblPots:SetSize(cardW, 20);
        lblPots:SetFont(Turbine.UI.Lotro.Font.Verdana12);
        lblPots:SetForeColor(Colors.Cyan);
        lblPots:SetText("Recommended Potions: " .. malice.recommendedPotions);

        local lblTactics = Turbine.UI.Label();
        lblTactics:SetParent(mainWindow.panelMalice);
        lblTactics:SetPosition(0, 74);
        lblTactics:SetSize(cardW, 36);
        lblTactics:SetFont(Turbine.UI.Lotro.Font.Verdana12);
        lblTactics:SetForeColor(Colors.White);
        lblTactics:SetText("Tactics: " .. malice.tactics);

        -- Malice Tiers breakdown
        local yOffset = 114;
        for _, t in ipairs(malice.tiers) do
            local tierBox = Turbine.UI.Control();
            tierBox:SetParent(mainWindow.panelMalice);
            tierBox:SetPosition(0, yOffset);
            tierBox:SetSize(cardW, 58);
            tierBox:SetBackColor(Colors.CardBg);
            ApplySmoothedBorder(tierBox, Colors.Border, 2);

            local lblTierRange = Turbine.UI.Label();
            lblTierRange:SetParent(tierBox);
            lblTierRange:SetPosition(12, 6);
            lblTierRange:SetSize(180, 20);
            lblTierRange:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
            lblTierRange:SetForeColor(Colors.Gold);
            lblTierRange:SetText(t.range);

            local lblHazard = Turbine.UI.Label();
            lblHazard:SetParent(tierBox);
            lblHazard:SetPosition(12, 28);
            lblHazard:SetSize(cardW - 24, 26);
            lblHazard:SetFont(Turbine.UI.Lotro.Font.Verdana12);
            lblHazard:SetForeColor(Colors.LightGray);
            lblHazard:SetText(t.hazard);

            yOffset = yOffset + 64;
        end
    elseif isWritsView then
        mainWindow.panelWrits:GetControls():Clear();
        local cardW = mainWindow.panelWrits:GetWidth();

        local lblWritsTitle = Turbine.UI.Label();
        lblWritsTitle:SetParent(mainWindow.panelWrits);
        lblWritsTitle:SetPosition(0, 0);
        lblWritsTitle:SetSize(cardW, 26);
        lblWritsTitle:SetFont(Turbine.UI.Lotro.Font.TrajanProBold24);
        lblWritsTitle:SetForeColor(Colors.BrightGold);
        lblWritsTitle:SetText("Delving Writs Yields & Rewards Guide");

        local lblWritsDesc = Turbine.UI.Label();
        lblWritsDesc:SetParent(mainWindow.panelWrits);
        lblWritsDesc:SetPosition(0, 28);
        lblWritsDesc:SetSize(cardW, 34);
        lblWritsDesc:SetFont(Turbine.UI.Lotro.Font.Verdana12);
        lblWritsDesc:SetForeColor(Colors.LightGray);
        lblWritsDesc:SetText("Delving Writs are awarded upon mission completion from the delving chest.\nHigher tiers grant greater writ yields and qualify for weekly quests.");

        local yOffset = 68;
        for _, y in ipairs(D.WritYields) do
            local box = Turbine.UI.Control();
            box:SetParent(mainWindow.panelWrits);
            box:SetPosition(0, yOffset);
            box:SetSize(cardW, 64);
            box:SetBackColor(Colors.CardBg);
            ApplySmoothedBorder(box, Colors.Border, 2);

            local lblTier = Turbine.UI.Label();
            lblTier:SetParent(box);
            lblTier:SetPosition(12, 8);
            lblTier:SetSize(200, 20);
            lblTier:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
            lblTier:SetForeColor(Colors.Gold);
            lblTier:SetText(y.tier);

            local lblYield = Turbine.UI.Label();
            lblYield:SetParent(box);
            lblYield:SetPosition(cardW - 210, 8);
            lblYield:SetSize(196, 20);
            lblYield:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
            lblYield:SetForeColor(Colors.BrightGreen);
            lblYield:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
            lblYield:SetText(y.writsPerRun);

            local lblRec = Turbine.UI.Label();
            lblRec:SetParent(box);
            lblRec:SetPosition(12, 32);
            lblRec:SetSize(cardW - 24, 24);
            lblRec:SetFont(Turbine.UI.Lotro.Font.Verdana12);
            lblRec:SetForeColor(Colors.LightGray);
            lblRec:SetText(string.format("Difficulty: %s  |  Recommendation: %s", y.difficulty, y.recommended));

            yOffset = yOffset + 70;
        end

        -- Weekly Quest Wrappers Info
        local boxWeekly = Turbine.UI.Control();
        boxWeekly:SetParent(mainWindow.panelWrits);
        boxWeekly:SetPosition(0, yOffset);
        boxWeekly:SetSize(cardW, 110);
        boxWeekly:SetBackColor(Turbine.UI.Color(0.88, 0.06, 0.12, 0.08));

        local lblWkTitle = Turbine.UI.Label();
        lblWkTitle:SetParent(boxWeekly);
        lblWkTitle:SetPosition(12, 8);
        lblWkTitle:SetSize(cardW - 24, 20);
        lblWkTitle:SetFont(Turbine.UI.Lotro.Font.TrajanProBold16);
        lblWkTitle:SetForeColor(Colors.BrightGold);
        lblWkTitle:SetText("Weekly Delving Wrapper Quests (Massive Writs)");

        local lblWkText = Turbine.UI.Label();
        lblWkText:SetParent(boxWeekly);
        lblWkText:SetPosition(12, 32);
        lblWkText:SetSize(cardW - 24, 70);
        lblWkText:SetFont(Turbine.UI.Lotro.Font.Verdana12);
        lblWkText:SetForeColor(Colors.White);
        lblWkText:SetText(
            "* Delve Into the Darkness (Weekly): Complete 10 Delvings at Tier 7+ -> +500 Delving Writs.\n" ..
            "* Delve Deeply (Weekly): Complete 15 Delvings at Tier 10+ -> +1000 Delving Writs & Gold Tracery.\n" ..
            "Pick up weekly wrapper quests from the Delving Mission Quartermaster before running!"
        );
    end
end

-- ----------------------------------------------------------------------------
-- Chat Listener for Automatic Quest Progress Tracking
-- ----------------------------------------------------------------------------
local function InitChatListener()
    if not Turbine.Chat then return end

    AddCallback(Turbine.Chat, "Received", function(sender, args)
        if not DH.settings.autoTrack then return end
        if not args or not args.Message then return end

        local text = args.Message;
        local lowerText = string.lower(text);

        -- 1. Check for Daily Delvings Goal (10/10) or wrapper quest progress
        -- Handles e.g. "Completed high tier delvings (tier 6 and higher) (10/10)"
        local progressDone = nil;
        if (string.find(lowerText, "delving", 1, true) or string.find(lowerText, "delvings", 1, true)) 
           and string.find(lowerText, "completed", 1, true) then
            if string.find(lowerText, "10/10", 1, true) or string.find(lowerText, "10 / 10", 1, true) then
                progressDone = 10;
            else
                local nStr = lowerText:match("%((%d+)%s*/%s*10%)");
                if nStr then
                    progressDone = tonumber(nStr);
                end
            end
        end
        if not progressDone and (string.find(lowerText, "tier 6", 1, true) or string.find(lowerText, "delve into the darkness", 1, true)) and (string.find(lowerText, "completed", 1, true) or string.find(lowerText, "finished", 1, true)) then
            progressDone = 10;
        end

        if progressDone then
            local goal = DH.settings.dailyGoal or 10;
            local currentTotal = CountCompletedDaily();
            if currentTotal ~= progressDone then
                DH.settings.countDaily = progressDone;
                DH.settings.manualOffsetDaily = progressDone;
                if progressDone >= 10 then
                    DH.settings.weekly10Done = true;
                end
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                if DH.settings.announceChat then
                    if progressDone >= goal then
                        local timeTable = GetCurrentTimeTable();
                        local secUntilThu = D.GetSecondsUntilWeeklyReset(timeTable);
                        local durStr = D.FormatWeeklyDuration(secUntilThu);
                        Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Weekly 10 High Tier Delvings Goal reached (%d/%d)! Next weekly reset in %s (Thursday 03:00 Server Time / 10:00 MSK).</rgb>", 
                            goal, goal, durStr));
                    else
                        Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] High tier delvings quest progress tracked: %d/%d delvings.</rgb>", 
                            progressDone, goal));
                    end
                end
            end
        end

        -- 1b. Check for 15 Missions Weekly Goal (15/15) ("On a Mission (Weekly)")
        local progressDone15 = nil;
        if string.find(lowerText, "15", 1, true) and (string.find(lowerText, "mission", 1, true) or string.find(lowerText, "missions", 1, true)) then
            if string.find(lowerText, "15/15", 1, true) or string.find(lowerText, "15 / 15", 1, true) then
                progressDone15 = 15;
            else
                local nStr15 = lowerText:match("%((%d+)%s*/%s*15%)");
                if nStr15 then
                    progressDone15 = tonumber(nStr15);
                end
            end
        end
        if not progressDone15 and string.find(lowerText, "on a mission", 1, true) and (string.find(lowerText, "completed", 1, true) or string.find(lowerText, "finished", 1, true)) then
            progressDone15 = 15;
        end

        if progressDone15 then
            local goal15 = DH.settings.weeklyGoal or 15;
            local currentTotal15 = CountCompletedWeekly();
            if currentTotal15 ~= progressDone15 then
                DH.settings.countWeekly = progressDone15;
                DH.settings.manualOffsetWeekly = progressDone15;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                if DH.settings.announceChat then
                    if progressDone15 >= goal15 then
                        Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Weekly 15 Missions Goal reached (%d/%d)!</rgb>", goal15, goal15));
                    else
                        Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] 15 Missions quest progress tracked: %d/%d missions.</rgb>", progressDone15, goal15));
                    end
                end
            end
        end

        -- 1c. Check for 45 Missions Weekly Goal (45/45) ("On a Continuing Mission (Weekly)")
        local progressDone45 = nil;
        if string.find(lowerText, "45", 1, true) and (string.find(lowerText, "continuing", 1, true) or string.find(lowerText, "mission", 1, true) or string.find(lowerText, "missions", 1, true)) then
            if string.find(lowerText, "45/45", 1, true) or string.find(lowerText, "45 / 45", 1, true) then
                progressDone45 = 45;
            else
                local nStr45 = lowerText:match("%((%d+)%s*/%s*45%)");
                if nStr45 then
                    progressDone45 = tonumber(nStr45);
                end
            end
        end
        if not progressDone45 and string.find(lowerText, "continuing", 1, true) and (string.find(lowerText, "completed", 1, true) or string.find(lowerText, "finished", 1, true)) then
            progressDone45 = 45;
        end

        if progressDone45 then
            local goal45 = DH.settings.weekly45Goal or 45;
            local currentTotal45 = CountCompletedWeekly45();
            if currentTotal45 ~= progressDone45 then
                DH.settings.countWeekly45 = progressDone45;
                DH.settings.manualOffsetWeekly45 = progressDone45;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                if DH.settings.announceChat then
                    if progressDone45 >= goal45 then
                        Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Weekly 45 Continuing Missions Goal reached (%d/%d)!</rgb>", goal45, goal45));
                    else
                        Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Continuing Missions quest progress tracked: %d/%d missions.</rgb>", progressDone45, goal45));
                    end
                end
            end
        end

        -- 2. Check channel for individual mission completions or new quest acceptance
        local cType = args.ChatType;
        local isAllowedType = (cType == Turbine.ChatType.Standard) or 
                              (cType == Turbine.ChatType.Quest) or 
                              (Turbine.ChatType.Advancement and cType == Turbine.ChatType.Advancement);
        if not isAllowedType then
            return;
        end

        local function NormalizeName(s)
            if not s then return "" end
            s = string.lower(s);
            s = string.gsub(s, string.char(195, 169), "e");
            s = string.gsub(s, string.char(195, 170), "e");
            s = string.gsub(s, string.char(195, 168), "e");
            s = string.gsub(s, string.char(195, 162), "a");
            s = string.gsub(s, string.char(195, 161), "a");
            s = string.gsub(s, string.char(195, 174), "i");
            s = string.gsub(s, string.char(195, 173), "i");
            s = string.gsub(s, string.char(195, 180), "o");
            s = string.gsub(s, string.char(195, 179), "o");
            s = string.gsub(s, string.char(195, 187), "u");
            s = string.gsub(s, string.char(195, 186), "u");
            s = string.gsub(s, string.char(195, 187), "u"); -- u circumflex (Nurz)
            s = string.gsub(s, string.char(195, 162), "a"); -- a circumflex (Ghashu)
            s = string.gsub(s, string.char(226, 128, 153), "");
            s = string.gsub(s, "['`]", "");
            return s;
        end

        -- 2a. Check if player accepted a new Mission: "New Quest: Mission: ..."
        local acceptedName = text:match("New Quest:%s*Mission:%s*([^%.%c]+)");
        if not acceptedName then
            acceptedName = text:match("new quest:%s*mission:%s*([^%.%c]+)");
        end
        if not acceptedName then
            acceptedName = text:match("Accepted:%s*Mission:%s*([^%.%c]+)");
        end

        if acceptedName and DH.settings.warnUnknown then
            acceptedName = string.gsub(acceptedName, "^%s*(.-)%s*$", "%1");
            acceptedName = string.gsub(acceptedName, "%.$", "");
            local normAccepted = NormalizeName(acceptedName);

            local timeTable = GetCurrentTimeTable();
            local autoDay = D.GetActiveRotationDay(timeTable, DH.settings.serverResetHour);
            local foundMission = D.FindMissionInDatabase(normAccepted, NormalizeName, autoDay);

            if not foundMission then
                -- Mission NOT FOUND anywhere in DelvingHelper database!
                Turbine.Shell.WriteLine(string.format("<rgb=#FF2222>==================================================</rgb>"));
                Turbine.Shell.WriteLine(string.format("<rgb=#FF3333><b>[DelvingHelper WARNING]</b> Unknown or Unsupported Mission taken: <b>'%s'</b>!</rgb>", acceptedName));
                Turbine.Shell.WriteLine(string.format("<rgb=#FF8888>This mission is NOT in the DelvingHelper database for any day of the week!</rgb>"));
                Turbine.Shell.WriteLine(string.format("<rgb=#FFFF55>Recommendation: Cancel this quest and pick an approved speedrun mission!</rgb>"));
                Turbine.Shell.WriteLine(string.format("<rgb=#FF2222>==================================================</rgb>"));

                ShowMissionWarningBanner(
                    "WARNING: UNKNOWN MISSION!",
                    string.format("Mission: '%s'\nis NOT in DelvingHelper database! Consider cancelling.", acceptedName),
                    true
                );
            else
                -- Mission exists in database. Check if it matches today's active rotation day
                local matchesToday = false;
                if D.MatchesDay and D.MatchesDay(foundMission, autoDay) then
                    matchesToday = true;
                elseif foundMission.dayId == autoDay or foundMission.dayId == 0 then
                    matchesToday = true;
                else
                    if D.DailyMissions and D.DailyMissions[autoDay] then
                        for _, dm in ipairs(D.DailyMissions[autoDay]) do
                            if NormalizeName(dm.shortName) == normAccepted or NormalizeName(dm.name) == normAccepted then
                                matchesToday = true;
                                foundMission = dm;
                                break;
                            end
                        end
                    end
                    if not matchesToday and D.BurglarMissions then
                        for _, bm in ipairs(D.BurglarMissions) do
                            if (NormalizeName(bm.shortName) == normAccepted or NormalizeName(bm.name) == normAccepted) and
                               (D.MatchesDay(bm, autoDay) or bm.dayId == autoDay or bm.dayId == 0) then
                                matchesToday = true;
                                foundMission = bm;
                                break;
                            end
                        end
                    end
                end

                if not matchesToday then
                    local dayName = (foundMission.days or (foundMission.dayId and D.Days[foundMission.dayId] and D.Days[foundMission.dayId].name) or "another day");
                    Turbine.Shell.WriteLine(string.format("<rgb=#FFAA00>[DelvingHelper Notice] '%s' is an approved mission, but scheduled for %s (Today: %s).</rgb>", 
                        foundMission.shortName, dayName, (D.Days[autoDay] and D.Days[autoDay].name or "Today")));
                    ShowMissionWarningBanner(
                        "NOTICE: ROTATION DAY MISMATCH",
                        string.format("'%s' is normally scheduled for %s.", foundMission.shortName, dayName),
                        false
                    );
                end
            end
        end

        -- 2b. Check channel for individual mission completions
        local completedName = text:match("Completed:%s*Mission:%s*([^%.%c]+)");
        if not completedName then
            completedName = text:match("completed%s+Mission:%s*([^%.%c]+)");
        end

        if completedName then
            completedName = string.gsub(completedName, "^%s*(.-)%s*$", "%1");
            completedName = string.gsub(completedName, "%.$", "");

            local timeTable = GetCurrentTimeTable();
            local autoDay = D.GetActiveRotationDay(timeTable, DH.settings.serverResetHour);
            local targetDay = autoDay; -- Always track completion for current active server day, regardless of UI tab viewed
            local normCompleted = NormalizeName(completedName);
            local matched = false;

            -- 1. First priority: match Burglar missions for target day (today)
            for _, m in ipairs(D.BurglarMissions) do
                if ((D.MatchesDay and D.MatchesDay(m, targetDay)) or (m.dayId == targetDay or m.dayId == 0)) and NormalizeName(m.shortName) == normCompleted then
                    local key = tostring(targetDay) .. ":" .. m.shortName;
                    DH.settings.completedMissions[key] = true;
                    matched = true;
                    break;
                end
            end

            -- 2. Fallback: match any Burglar mission and assign to target day
            if not matched then
                for _, m in ipairs(D.BurglarMissions) do
                    if NormalizeName(m.shortName) == normCompleted then
                        local key = tostring(targetDay) .. ":" .. m.shortName;
                        DH.settings.completedMissions[key] = true;
                        matched = true;
                        break;
                    end
                end
            end

            -- 3. Fallback: check all Daily Rotation Pools
            if not matched then
                for poolId = 1, 7 do
                    for _, m in ipairs(D.DailyMissions[poolId]) do
                        if NormalizeName(m.shortName) == normCompleted then
                            local key = tostring(targetDay) .. ":" .. m.shortName;
                            DH.settings.completedMissions[key] = true;
                            matched = true;
                            break;
                        end
                    end
                    if matched then break end
                end
            end

            if matched then
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                if DH.settings.announceChat then
                    Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Rotation checklist: %s completed!</rgb>", 
                        completedName));
                end
            end
        end
    end);
end

-- ----------------------------------------------------------------------------
-- Periodic 1-Second Timer for Countdown & Icon Badge
-- ----------------------------------------------------------------------------
local function InitTimer()
    updateTimer = Turbine.UI.Control();
    updateTimer:SetWantsUpdates(true);
    local lastTick = 0;

    updateTimer.Update = function(sender, args)
        local cur = Turbine.Engine.GetGameTime();
        if cur - lastTick >= 1.0 then
            lastTick = cur;
            local timeTable = GetCurrentTimeTable();
            CheckDailyReset(timeTable);
            if mainWindow and mainWindow:IsVisible() then
                local resetSec = GetSecondsUntilReset(timeTable, 3);
                local secThu = D.GetSecondsUntilWeeklyReset(timeTable);
                local durDaily = FormatDuration(resetSec);
                local durWeekly = D.FormatWeeklyDuration(secThu);
                local tz = timeTable.tzName or "EST";
                local localT = timeTable.localTime or timeTable;

                mainWindow.lblCountdown:SetText(string.format(
                    "Daily: %s  |  Weekly: %s  |  Server: %02d:%02d %s  |  Local: %02d:%02d",
                    durDaily, durWeekly, timeTable.Hour, timeTable.Minute, tz, localT.Hour, localT.Minute
                ));
            end
            RefreshIconBadge();
        end
    end
end

-- ----------------------------------------------------------------------------
-- Shell Chat Fallback (/delving)
-- ----------------------------------------------------------------------------
local function InitCommands()
    local cmd = Turbine.ShellCommand();
    
    cmd.Execute = function(sender, cmdName, args)
        args = string.lower(args or "");
        args = string.gsub(args, "^%s*(.-)%s*$", "%1");

        if args == "icon" or args == "showicon" then
            DH.settings.showIcon = true;
            if iconWindow then iconWindow:SetVisible(true); end
            SaveSettings();
            Turbine.Shell.WriteLine("<rgb=#55FF55>[DelvingHelper] Floating icon is now visible.</rgb>");
        elseif args:match("^count%s+(%d+)%s+(%d+)%s+(%d+)$") or args:match("^set%s+(%d+)%s+(%d+)%s+(%d+)$") then
            local dStr, wStr, cStr = args:match("^count%s+(%d+)%s+(%d+)%s+(%d+)$");
            if not dStr then dStr, wStr, cStr = args:match("^set%s+(%d+)%s+(%d+)%s+(%d+)$"); end
            local dTarget = tonumber(dStr);
            local wTarget = tonumber(wStr);
            local cTarget = tonumber(cStr);
            if dTarget and wTarget and cTarget then
                DH.settings.countDaily = dTarget;
                DH.settings.countWeekly = wTarget;
                DH.settings.countWeekly45 = cTarget;
                DH.settings.manualOffsetDaily = dTarget;
                DH.settings.manualOffsetWeekly = wTarget;
                DH.settings.manualOffsetWeekly45 = cTarget;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Counters set: Daily %d/%d, Weekly %d/%d, Continuing %d/%d.</rgb>", 
                    dTarget, DH.settings.dailyGoal, wTarget, DH.settings.weeklyGoal, cTarget, DH.settings.weekly45Goal or 45));
            end
        elseif args:match("^count%s+(%d+)%s+(%d+)$") or args:match("^set%s+(%d+)%s+(%d+)$") then
            local dStr, wStr = args:match("^count%s+(%d+)%s+(%d+)$");
            if not dStr then dStr, wStr = args:match("^set%s+(%d+)%s+(%d+)$"); end
            local dTarget = tonumber(dStr);
            local wTarget = tonumber(wStr);
            if dTarget and wTarget then
                DH.settings.countDaily = dTarget;
                DH.settings.countWeekly = wTarget;
                DH.settings.manualOffsetDaily = dTarget;
                DH.settings.manualOffsetWeekly = wTarget;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Counters set: Daily %d/%d, Weekly %d/%d.</rgb>", 
                    dTarget, DH.settings.dailyGoal, wTarget, DH.settings.weeklyGoal));
            end
        elseif args:match("^count45%s+(%d+)$") or args:match("^set45%s+(%d+)$") then
            local rawNum = args:match("^count45%s+(%d+)$") or args:match("^set45%s+(%d+)$");
            local target = tonumber(rawNum);
            if target then
                DH.settings.countWeekly45 = target;
                DH.settings.manualOffsetWeekly45 = target;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Continuing 45 counter manually set to %d missions.</rgb>", target));
            end
        elseif args:match("^count15%s+(%d+)$") or args:match("^set15%s+(%d+)$") or args:match("^countweekly%s+(%d+)$") or args:match("^setweekly%s+(%d+)$") then
            local rawNum = args:match("^count15%s+(%d+)$") or args:match("^set15%s+(%d+)$") or args:match("^countweekly%s+(%d+)$") or args:match("^setweekly%s+(%d+)$");
            local target = tonumber(rawNum);
            if target then
                DH.settings.countWeekly = target;
                DH.settings.manualOffsetWeekly = target;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Weekly 15 counter manually set to %d missions.</rgb>", target));
            end
        elseif args:match("^count%s+(%d+)$") or args:match("^set%s+(%d+)$") then
            local rawNum = args:match("^count%s+(%d+)$") or args:match("^set%s+(%d+)$");
            local target = tonumber(rawNum);
            if target then
                DH.settings.countDaily = target;
                DH.settings.manualOffsetDaily = target;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Daily counter manually set to %d delvings.</rgb>", target));
            end
        elseif args:match("^tz%s+([%+%-]?%d+)$") or args:match("^timezone%s+([%+%-]?%d+)$") then
            local raw = args:match("^tz%s+([%+%-]?%d+)$") or args:match("^timezone%s+([%+%-]?%d+)$");
            local val = tonumber(raw);
            if val and val >= -12 and val <= 14 then
                DH.settings.clientUtcOffset = val;
                SaveSettings();
                RefreshMainWindow();
                RefreshIconBadge();
                local timeTable = GetCurrentTimeTable();
                local tz = timeTable.tzName or "EST";
                local localReset = string.format("%02d:00", timeTable.localResetHour or 10);
                Turbine.Shell.WriteLine(string.format("<rgb=#55FF55>[DelvingHelper] Timezone UTC offset set to UTC%+d. Server Time: %02d:%02d %s (Daily Reset at %s Local).</rgb>", 
                    val, timeTable.Hour, timeTable.Minute, tz, localReset));
            else
                Turbine.Shell.WriteLine("<rgb=#FF5555>[DelvingHelper] Invalid UTC offset. Usage: /delving tz <hours> (e.g. /delving tz 3 for Moscow/MSK).</rgb>");
            end
        elseif args == "burglar" then
            DH.settings.profileMode = "burglar";
            SaveSettings();
            RefreshMainWindow();
            Turbine.Shell.WriteLine("<rgb=#FFD700>[DelvingHelper] Switched to Burglar Stealth Route!</rgb>");
        elseif args == "standard" then
            DH.settings.profileMode = "standard";
            SaveSettings();
            RefreshMainWindow();
            Turbine.Shell.WriteLine("<rgb=#55FFFF>[DelvingHelper] Switched to Standard Swanfleet/Cardolan Pools!</rgb>");
        elseif args == "colors" or args == "color" or args == "guide" then
            ShowColorLegendDialog();
        elseif args == "lock" then
            DH.settings.lockIcon = true;
            SaveSettings();
            UpdateOptionsUI();
            Turbine.Shell.WriteLine("<rgb=#00FF88>[DelvingHelper]</rgb> Jewel icon locked.");
        elseif args == "unlock" then
            DH.settings.lockIcon = false;
            SaveSettings();
            UpdateOptionsUI();
            Turbine.Shell.WriteLine("<rgb=#00FF88>[DelvingHelper]</rgb> Jewel icon unlocked. Drag the icon to any desired position.");
        elseif args == "warn" or args == "togglewarn" then
            DH.settings.warnUnknown = not DH.settings.warnUnknown;
            SaveSettings();
            UpdateOptionsUI();
            Turbine.Shell.WriteLine(string.format("<rgb=#00FF88>[DelvingHelper]</rgb> Warning on unknown missions %s.", 
                DH.settings.warnUnknown and "ENABLED" or "DISABLED"));
        elseif args == "resetweekly" or args == "weeklyreset" then
            local curDaily = CountCompletedDaily();
            local curWeekly = CountCompletedWeekly();
            local curWeekly45 = CountCompletedWeekly45();
            local dailyGoal = DH.settings.dailyGoal or 10;
            local weeklyGoal = DH.settings.weeklyGoal or 15;
            local weekly45Goal = DH.settings.weekly45Goal or 45;
            local dailyDone = (curDaily >= dailyGoal);
            local weeklyDone = (curWeekly >= weeklyGoal);
            local weekly45Done = (curWeekly45 >= weekly45Goal);

            DH.settings.completedMissions = {};
            if dailyDone then
                DH.settings.manualOffsetDaily = 0;
                DH.settings.weekly10Done = false;
            else
                DH.settings.manualOffsetDaily = curDaily;
            end
            if weeklyDone then
                DH.settings.manualOffsetWeekly = 0;
            else
                DH.settings.manualOffsetWeekly = curWeekly;
            end
            if weekly45Done then
                DH.settings.manualOffsetWeekly45 = 0;
            else
                DH.settings.manualOffsetWeekly45 = curWeekly45;
            end
            local timeTable = GetCurrentTimeTable();
            DH.settings.weekKey = D.GetLotroWeekKey(timeTable);
            SaveSettings();
            if RefreshMainWindow then RefreshMainWindow(); end
            if RefreshIconBadge then RefreshIconBadge(); end
            Turbine.Shell.WriteLine("<rgb=#55FF55>[DelvingHelper] Weekly reset applied successfully.</rgb>");
        elseif args == "reset" or args == "resetall" then
            ShowConfirmResetDialog();
        elseif args == "center" then
            CenterAllWindowPositions();
        elseif args == "reload" then
            TriggerReloadPlugin();
        elseif args:match("^search%s+(.+)$") or args:match("^find%s+(.+)$") then
            local q = args:match("^search%s+(.+)$") or args:match("^find%s+(.+)$");
            DH.settings.searchText = q;
            if mainWindow and mainWindow.txtSearch then
                mainWindow.txtSearch:SetText(q);
            end
            SaveSettings();
            if mainWindow and not mainWindow:IsVisible() then
                mainWindow:SetVisible(true);
            end
            RefreshMainWindow();
            Turbine.Shell.WriteLine("<rgb=#55FF55>[DelvingHelper] Search filter applied: '" .. q .. "'.</rgb>");
        elseif args == "clear" or args == "clearsearch" then
            DH.settings.searchText = "";
            DH.settings.filterIncomplete = false;
            if mainWindow and mainWindow.txtSearch then
                mainWindow.txtSearch:SetText("");
            end
            SaveSettings();
            RefreshMainWindow();
            Turbine.Shell.WriteLine("<rgb=#55FF55>[DelvingHelper] Search and filters cleared.</rgb>");
        else
            if mainWindow then
                local vis = not mainWindow:IsVisible();
                mainWindow:SetVisible(vis);
                DH.settings.winVisible = vis;
                SaveSettings();
                if vis then RefreshMainWindow(); end
            end
        end
    end

    cmd.GetHelp = function()
        return "DelvingHelper: Left-click icon to toggle window, Right-click for menu (Reload, Lock). Type /dh search <name> to filter missions or /dh reload to reload.";
    end

    Turbine.Shell.AddCommand("delving", cmd);
    Turbine.Shell.AddCommand("delvings", cmd);
    Turbine.Shell.AddCommand("dh", cmd);
end

-- ----------------------------------------------------------------------------
-- Plugin Initialization & Plugin Manager Hook
-- ----------------------------------------------------------------------------
local function Init()
    -- Asynchronously unload companion reloader once its call stack has unwound
    if Turbine.PluginManager and Turbine.PluginManager.UnloadScriptState then
        local reloaderCleaner = Turbine.UI.Control();
        local cleanTicks = 0;
        reloaderCleaner.Update = function(sender, args)
            cleanTicks = cleanTicks + 1;
            if cleanTicks >= 20 then
                reloaderCleaner:SetWantsUpdates(false);
                pcall(Turbine.PluginManager.UnloadScriptState, "DelvingHelperReloader");
                reloaderCleaner = nil;
            end
        end;
        reloaderCleaner:SetWantsUpdates(true);
    end

    LoadSettings();
    local timeTable = GetCurrentTimeTable();
    CheckDailyReset(timeTable);
    CreateDelvingIcon();
    CreateQuickSettingsWindow();
    CreatePluginManagerOptions();
    CreateMainWindow();
    InitChatListener();
    InitTimer();
    InitCommands();

    local profile = GetEffectiveProfile();
    if profile == "burglar" then
        Turbine.Shell.WriteLine("<rgb=#FFD700>DelvingHelper v" .. PLUGIN_VERSION .. " loaded! Detected Burglar ('" .. DH.playerName .. "'). Burglar Stealth Route ACTIVE.</rgb>");
    else
        Turbine.Shell.WriteLine("<rgb=#FFD700>DelvingHelper v" .. PLUGIN_VERSION .. " loaded! Character: " .. DH.playerName .. " (" .. DH.playerClass .. "). Left-click jewel icon to view missions.</rgb>");
    end
end

if plugin ~= nil then
    plugin.GetOptionsPanel = function(self)
        UpdateOptionsUI();
        return optionsPanel;
    end

    plugin.Unload = function(sender, args)
        pcall(function()
            SaveSettings();
            if updateTimer then
                updateTimer:SetWantsUpdates(false);
            end
            if alertTimer then
                alertTimer:SetWantsUpdates(false);
            end
            if iconWindow then
                iconWindow:SetVisible(false);
            end
            if mainWindow then
                mainWindow:SetVisible(false);
            end
            if quickSettingsWindow then
                quickSettingsWindow:SetVisible(false);
            end
            if alertWindow then
                alertWindow:SetVisible(false);
            end
            if colorLegendWindow then
                colorLegendWindow:SetVisible(false);
            end
            if optionsPanel then
                optionsPanel:SetParent(nil);
            end
        end);
    end
end

Init();
