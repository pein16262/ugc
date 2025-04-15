-- Fly GUI + Script with Basic Anti-Cheat Bypass
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Anti-Cheat Bypass: Disconnect basic state detectors
for _, conn in ipairs(getconnections(Character.Humanoid.StateChanged)) do
    conn:Disable()
end

-- GUI
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "FlyBypassGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 160, 0, 100)
frame.Position = UDim2.new(0, 10, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.8, 0, 0.4, 0)
toggle.Position = UDim2.new(0.1, 0, 0.1, 0)
toggle.Text = "Fly: OFF"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true

local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0.35, 0, 0.3, 0)
plus.Position = UDim2.new(0.55, 0, 0.6, 0)
plus.Text = "+"
plus.TextColor3 = Color3.new(1, 1, 1)
plus.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
plus.Font = Enum.Font.GothamBold
plus.TextScaled = true

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0.35, 0, 0.3, 0)
minus.Position = UDim2.new(0.1, 0, 0.6, 0)
minus.Text = "-"
minus.TextColor3 = Color3.new(1, 1, 1)
minus.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minus.Font = Enum.Font.GothamBold
minus.TextScaled = true

-- Flying logic
local flying = false
local velocity
local gyro

local function startFly()
    velocity = Instance.new("BodyVelocity")
    velocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    velocity.Velocity = Vector3.zero
    velocity.P = 1250
    velocity.Parent = HumanoidRootPart

    gyro = Instance.new("BodyGyro")
    gyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    gyro.CFrame = HumanoidRootPart.CFrame
    gyro.P = 3000
    gyro.Parent = HumanoidRootPart

    task.spawn(function()
        while flying and Character and Character.Parent do
            local cam = workspace.CurrentCamera
            local direction = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then direction += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then direction -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then direction -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then direction += cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0, 1, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then direction -= Vector3.new(0, 1, 0) end

            velocity.Velocity = direction.Unit * 60
            gyro.CFrame = cam.CFrame
            task.wait()
        end
    end)
end

local function stopFly()
    if velocity then velocity:Destroy() end
    if gyro then gyro:Destroy() end
end

toggle.MouseButton1Click:Connect(function()
    flying = not flying
    toggle.Text = "Fly: " .. (flying and "ON" or "OFF")
    if flying then
        startFly()
    else
        stopFly()
    end
end)

plus.MouseButton1Click:Connect(function()
    frame.Size = frame.Size + UDim2.new(0, 20, 0, 20)
end)

minus.MouseButton1Click:Connect(function()
    frame.Size = frame.Size - UDim2.new(0, 20, 0, 20)
end)
