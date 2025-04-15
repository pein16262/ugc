-- Initialize the GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "FlyAndNoclipGui"

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

local FlyButton = Instance.new("TextButton")
FlyButton.Parent = Frame
FlyButton.Size = UDim2.new(0, 180, 0, 40)
FlyButton.Position = UDim2.new(0, 10, 0, 10)
FlyButton.Text = "Enable Fly"
FlyButton.TextColor3 = Color3.new(1, 1, 1)
FlyButton.BackgroundColor3 = Color3.new(0, 0, 1)

local NoclipButton = Instance.new("TextButton")
NoclipButton.Parent = Frame
NoclipButton.Size = UDim2.new(0, 180, 0, 40)
NoclipButton.Position = UDim2.new(0, 10, 0, 60)
NoclipButton.Text = "Enable Noclip"
NoclipButton.TextColor3 = Color3.new(1, 1, 1)
NoclipButton.BackgroundColor3 = Color3.new(0, 1, 0)

local TeleportButton = Instance.new("TextButton")
TeleportButton.Parent = Frame
TeleportButton.Size = UDim2.new(0, 180, 0, 40)
TeleportButton.Position = UDim2.new(0, 10, 0, 110)
TeleportButton.Text = "Teleport to (-339.12, 10, 553.27)"
TeleportButton.TextColor3 = Color3.new(1, 1, 1)
TeleportButton.BackgroundColor3 = Color3.new(1, 0, 0)

-- Fly and Noclip Functions
local flying = false
local noclipping = false
local bodyVelocity = Instance.new("BodyVelocity")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
local humanoid = character:WaitForChild("Humanoid", 5)

if not humanoidRootPart or not humanoid then
    warn("Humanoid or HumanoidRootPart not found!")
    return
end

local function toggleFly()
    if flying then
        flying = false
        bodyVelocity:Destroy()
        humanoid.PlatformStand = false
        FlyButton.Text = "Enable Fly"
    else
        flying = true
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = humanoidRootPart
        FlyButton.Text = "Disable Fly"
    end
end

local function toggleNoclip()
    noclipping = not noclipping
    NoclipButton.Text = noclipping and "Disable Noclip" or "Enable Noclip"
end

local function teleportToTarget()
    humanoidRootPart.CFrame = CFrame.new(-339.12, 10, 553.27)
end

-- Button Connections
FlyButton.MouseButton1Click:Connect(toggleFly)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)
TeleportButton.MouseButton1Click:Connect(teleportToTarget)

-- Noclip Update
game:GetService("RunService").Heartbeat:Connect(function()
    if noclipping then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
