-- DelvingHelperReloader.lua
-- Dedicated separate-apartment reloader for DelvingHelper.
import "Turbine";
import "Turbine.UI";

DelvingHelperReloaderControl = Turbine.UI.Control();

local phase = "unload";
local deadline = nil;

local function now()
    if Turbine.Engine and Turbine.Engine.GetGameTime then
        return Turbine.Engine.GetGameTime();
    end
    return 0;
end

local function isPluginLoaded(name)
    if not (Turbine.PluginManager and Turbine.PluginManager.GetLoadedPlugins) then
        return false;
    end
    local ok, list = pcall(Turbine.PluginManager.GetLoadedPlugins);
    if not ok or type(list) ~= "table" then
        return false;
    end
    for _, entry in pairs(list) do
        if entry.Name == name then
            return true;
        end
    end
    return false;
end

function DelvingHelperReloaderControl:Update()
    local t = now();

    if phase == "unload" then
        local present = isPluginLoaded("DelvingHelper");
        if present then
            pcall(Turbine.PluginManager.UnloadScriptState, "DelvingHelper");
        end
        phase = "waitUnload";
        deadline = t + 3;

    elseif phase == "waitUnload" then
        local present = isPluginLoaded("DelvingHelper");
        if present then
            if t >= deadline then
                phase = "load";
            end
            return;
        end
        phase = "load";

    elseif phase == "load" then
        if type(Turbine.PluginManager.RefreshAvailablePlugins) == "function" then
            pcall(Turbine.PluginManager.RefreshAvailablePlugins);
        end
        local ok, res = pcall(Turbine.PluginManager.LoadPlugin, "DelvingHelper");
        if not ok or res == false then
            Turbine.Shell.WriteLine("<rgb=#FF5555>[DelvingHelperReloader] LoadPlugin failed. Try: /plugins load DelvingHelper</rgb>");
            self:SetWantsUpdates(false);
            DelvingHelperReloaderControl = nil;
            return;
        end
        phase = "waitLoad";
        deadline = t + 3;

    elseif phase == "waitLoad" then
        local present = isPluginLoaded("DelvingHelper");
        if present or (t >= deadline) then
            self:SetWantsUpdates(false);
            DelvingHelperReloaderControl = nil;
            phase = "done";
        end
    end
end

DelvingHelperReloaderControl:SetWantsUpdates(true);
