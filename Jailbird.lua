-- // Target Aim Script (Toggle with Q)
-- // Made for educational/game feature purposes (e.g. aim assist or lock-on)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local aiming = false
local aimPart = "Head" -- Change to "UpperTorso" or any body part you like

-- Function to get the closest player to your mouse
local function getClosestPlayer()
    local closestDist = math.huge
    local target = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild(aimPart) then
            local part = player.Character[aimPart]
            local screenPoint, onScreen = camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local dist = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    target = part
                end
            end
        end
    end
    return target
end

-- Toggle aim with Q
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        aiming = not aiming
        if aiming then
            print("[Target Aim] ON")
        else
            print("[Target Aim] OFF")
        end
    end
end)

-- Main loop to update camera while aiming
RunService.RenderStepped:Connect(function()
    if aiming then
        local target = getClosestPlayer()
        if target then
            local targetPos = target.Position
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetPos)
        end
    end
end)
