-- Unnamed ESP (Rayfield UI Edition)
-- Original by ic3w0lf, UI integration by ChatGPT (2025)
-- This version hides the old menu and replaces it with Rayfield UI controls

-- ✅ Dependencies
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success then
    warn("⚠️ Failed to load Rayfield UI library. Please check your connection or try again later.")
    return
end

-- Load original ESP core
local EspCore = loadstring(game:HttpGet("https://pastebin.com/raw/TwKQpM3C"))() -- placeholder link for Unnamed ESP core
-- If you have the original ESP logic locally, replace the above with its actual content.

-- Hide original Unnamed ESP drawing-based menu
if shared.MenuDrawingData then
    for _, inst in pairs(shared.MenuDrawingData.Instances or {}) do
        pcall(function() inst.Visible = false end)
    end
end

-- ✅ Rayfield Window Setup
local Window = Rayfield:CreateWindow({
    Name = "Unnamed ESP Controller",
    LoadingTitle = "ESP Menu",
    LoadingSubtitle = "Rayfield Integration",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "UnnamedESP",
        FileName = "Settings"
    },
    KeySystem = false
})

local ESPTab = Window:CreateTab("ESP", 4483362458)

-- Dummy placeholder for Options (replace with your existing ESP options table)
Options = Options or {}

-- ✅ Main Toggles
ESPTab:CreateToggle({
    Name = "ESP Enabled",
    CurrentValue = Options.Enabled and Options.Enabled.Value or true,
    Flag = "ESPEnabled",
    Callback = function(Value)
        if Options.Enabled then Options.Enabled(Value) end
    end
})

ESPTab:CreateToggle({
    Name = "Show Boxes",
    CurrentValue = Options.ShowBoxes and Options.ShowBoxes.Value or true,
    Flag = "ShowBoxes",
    Callback = function(Value)
        if Options.ShowBoxes then Options.ShowBoxes(Value) end
    end
})

ESPTab:CreateToggle({
    Name = "Show Names",
    CurrentValue = Options.ShowName and Options.ShowName.Value or true,
    Flag = "ShowNames",
    Callback = function(Value)
        if Options.ShowName then Options.ShowName(Value) end
    end
})

ESPTab:CreateToggle({
    Name = "Show Tracers",
    CurrentValue = Options.ShowTracers and Options.ShowTracers.Value or false,
    Flag = "ShowTracers",
    Callback = function(Value)
        if Options.ShowTracers then Options.ShowTracers(Value) end
    end
})

ESPTab:CreateToggle({
    Name = "Show Health",
    CurrentValue = Options.ShowHealth and Options.ShowHealth.Value or false,
    Flag = "ShowHealth",
    Callback = function(Value)
        if Options.ShowHealth then Options.ShowHealth(Value) end
    end
})

ESPTab:CreateToggle({
    Name = "Show Distance",
    CurrentValue = Options.ShowDistance and Options.ShowDistance.Value or true,
    Flag = "ShowDistance",
    Callback = function(Value)
        if Options.ShowDistance then Options.ShowDistance(Value) end
    end
})

-- ✅ Sliders
ESPTab:CreateSlider({
    Name = "Max Distance",
    Range = {100, 25000},
    Increment = 100,
    CurrentValue = Options.MaxDistance and Options.MaxDistance.Value or 2500,
    Flag = "MaxDistance",
    Callback = function(Value)
        if Options.MaxDistance then Options.MaxDistance(Value) end
    end
})

ESPTab:CreateSlider({
    Name = "Text Size",
    Range = {10, 24},
    Increment = 1,
    CurrentValue = Options.TextSize and Options.TextSize.Value or 18,
    Flag = "TextSize",
    Callback = function(Value)
        if Options.TextSize then Options.TextSize(Value) end
    end
})

-- ✅ Color Pickers
local TeamColor = Color3.new(0, 1, 0)
local EnemyColor = Color3.new(1, 0, 0)

ESPTab:CreateColorPicker({
    Name = "Team Color",
    Color = TeamColor,
    Flag = "TeamColor",
    Callback = function(Color)
        TeamColor = Color
    end
})

ESPTab:CreateColorPicker({
    Name = "Enemy Color",
    Color = EnemyColor,
    Flag = "EnemyColor",
    Callback = function(Color)
        EnemyColor = Color
    end
})

-- ✅ Save Settings Button
ESPTab:CreateButton({
    Name = "Save Settings",
    Callback = function()
        Rayfield:SaveConfiguration()
        Rayfield:Notify({Title = "Saved", Content = "Your ESP settings have been saved successfully!"})
    end
})

print("[✅] Rayfield UI loaded successfully. Old menu hidden, ESP active.")
