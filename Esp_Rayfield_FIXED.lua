-- ✅ Unnamed ESP (Rayfield UI Edition - Fixed 2025)
-- Original by ic3w0lf | Rayfield Integration & Offline Patch by ChatGPT

-- ✅ Safe Rayfield Import
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)

if not success or not Rayfield then
    warn("⚠️ Failed to load Rayfield UI library. Check your executor or internet.")
    return
end

-- ✅ Built-in Simple ESP (Fallback if no external ESP is loaded)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESP = {}
ESP.Enabled = true
ESP.ShowBoxes = true
ESP.ShowNames = true
ESP.ShowTracers = true
ESP.ShowHealth = true
ESP.ShowDistance = true
ESP.MaxDistance = 2500
ESP.TextSize = 18
ESP.TeamColor = Color3.new(0, 1, 0)
ESP.EnemyColor = Color3.new(1, 0, 0)

local function createBillboard(player)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local root = char.HumanoidRootPart
    if root:FindFirstChild("ESP_Billboard") then return end

    local billboard = Instance.new("BillboardGui", root)
    billboard.Name = "ESP_Billboard"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.5
    label.TextSize = ESP.TextSize
    label.Font = Enum.Font.SourceSansBold
    label.Text = player.Name

    return billboard, label
end

RunService.RenderStepped:Connect(function()
    if not ESP.Enabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local root = p.Character.HumanoidRootPart
                local bb = root:FindFirstChild("ESP_Billboard")
                if bb then bb.Enabled = false end
            end
        end
        return
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local root = p.Character.HumanoidRootPart
            local bb = root:FindFirstChild("ESP_Billboard")
            local label
            if not bb then bb, label = createBillboard(p) else label = bb:FindFirstChildOfClass("TextLabel") end

            if bb and label then
                bb.Enabled = true
                local dist = (root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist <= ESP.MaxDistance then
                    label.TextSize = ESP.TextSize
                    label.Text = ""
                    if ESP.ShowNames then label.Text = label.Text .. p.Name .. " " end
                    if ESP.ShowDistance then label.Text = label.Text .. string.format("[%d]", dist) end
                    if ESP.ShowHealth and p.Character:FindFirstChild("Humanoid") then
                        label.Text = label.Text .. string.format(" ❤️%d", p.Character.Humanoid.Health)
                    end
                    label.TextColor3 = (p.Team == LocalPlayer.Team) and ESP.TeamColor or ESP.EnemyColor
                else
                    bb.Enabled = false
                end
            end
        end
    end
end)

-- ✅ Rayfield UI Setup
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

-- ✅ Toggles
ESPTab:CreateToggle({
    Name = "ESP Enabled",
    CurrentValue = true,
    Flag = "ESPEnabled",
    Callback = function(Value) ESP.Enabled = Value end
})

ESPTab:CreateToggle({
    Name = "Show Boxes",
    CurrentValue = true,
    Flag = "ShowBoxes",
    Callback = function(Value) ESP.ShowBoxes = Value end
})

ESPTab:CreateToggle({
    Name = "Show Names",
    CurrentValue = true,
    Flag = "ShowNames",
    Callback = function(Value) ESP.ShowNames = Value end
})

ESPTab:CreateToggle({
    Name = "Show Tracers",
    CurrentValue = true,
    Flag = "ShowTracers",
    Callback = function(Value) ESP.ShowTracers = Value end
})

ESPTab:CreateToggle({
    Name = "Show Health",
    CurrentValue = true,
    Flag = "ShowHealth",
    Callback = function(Value) ESP.ShowHealth = Value end
})

ESPTab:CreateToggle({
    Name = "Show Distance",
    CurrentValue = true,
    Flag = "ShowDistance",
    Callback = function(Value) ESP.ShowDistance = Value end
})

-- ✅ Sliders
ESPTab:CreateSlider({
    Name = "Max Distance",
    Range = {100, 25000},
    Increment = 100,
    CurrentValue = ESP.MaxDistance,
    Flag = "MaxDistance",
    Callback = function(Value) ESP.MaxDistance = Value end
})

ESPTab:CreateSlider({
    Name = "Text Size",
    Range = {10, 24},
    Increment = 1,
    CurrentValue = ESP.TextSize,
    Flag = "TextSize",
    Callback = function(Value) ESP.TextSize = Value end
})

-- ✅ Color Pickers
ESPTab:CreateColorPicker({
    Name = "Team Color",
    Color = ESP.TeamColor,
    Flag = "TeamColor",
    Callback = function(Color) ESP.TeamColor = Color end
})

ESPTab:CreateColorPicker({
    Name = "Enemy Color",
    Color = ESP.EnemyColor,
    Flag = "EnemyColor",
    Callback = function(Color) ESP.EnemyColor = Color end
})

-- ✅ Save Button
ESPTab:CreateButton({
    Name = "Save Settings",
    Callback = function()
        Rayfield:SaveConfiguration()
        Rayfield:Notify({Title = "Saved", Content = "ESP settings saved successfully!"})
    end
})

print("[✅] Rayfield UI loaded successfully. ESP active.")
