-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NameCall
local OldNameCall = nil



-- Libray
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Window = Fluent:CreateWindow({
    Title = 'Infinity Hub | 1.0 | '..game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name,
    SubTitle = "by InfinityMercury",
    TabWidth = 100,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.J
})
local Tabs = {
    Farming = Window:AddTab({ Title = "Farming", Icon = "rbxassetid://7743866529" }),
    Player = Window:AddTab({ Title = "Player", Icon = "rbxassetid://14665259254" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local Options = Fluent.Options



-- Code
local AutoBatteriesToggle = Tabs.Farming:AddToggle("MyToggle", {Title = "Collect All Batteries", Default = false })
AutoBatteriesToggle:OnChanged(function(bool)
    AutoBatteries = bool
    while AutoBatteries do task.wait()
        for i,v in pairs(workspace.Batteries:GetChildren()) do
            if v:IsA('UnionOperation') then
                local Prompt = v.ProximityPrompt
                local Batteries = v

                Prompt.HoldDuration = 0
                game.Players.LocalPlayer.Character:PivotTo(v:GetPivot()) wait(.5) fireproximityprompt(Prompt)
            end
        end
    end
end)
local AutoCarToggle = Tabs.Farming:AddToggle("AutoCar", {Title = "Use Batteries In Car", Default = false })
AutoCarToggle:OnChanged(function(bool)
    AutoCar = bool
    while AutoCar do task.wait()
        for i,x in pairs(workspace.Cybertruck:GetDescendants()) do
            if x:IsA('ProximityPrompt') and x.Name == 'PlaceBattery' then
                local Prompt = x

                if Prompt.Enabled == false then
                    Fluent:Notify({
                        Title = "waring",
                        Content = "all the batteries are already in the car ",
                        SubContent = "enter in car",
                        Duration = 5
                    })
                    Options.AutoCar:SetValue(false)
                else
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-125, 3, -30)
                    fireproximityprompt(Prompt)
                end
            end
        end
    end
end)
local FastWinToggle = Tabs.Farming:AddToggle("", {Title = "Fast Win", Default = false })
FastWinToggle:OnChanged(function(bool)
    FastWin = bool
    while FastWin do task.wait()
        game:GetService("Players").LocalPlayer.leaderstats.Batteries.Value=27
        for i,x in pairs(workspace.Cybertruck:GetDescendants()) do
            if x:IsA('ProximityPrompt') and x.Name == 'EnterCar' then
                local Prompt = x
                Prompt.Enabled = true
                wait(.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-125, 3, -30)
                fireproximityprompt(Prompt)
            end
        end
    end
end)
local EspMonsterToggle = Tabs.Farming:AddToggle("", {Title = "Esp Monster", Default = false })
EspMonsterToggle:OnChanged(function(bool)
    local EspMonster = bool
    if EspMonster then
        local Esp = Instance.new('Highlight')
        Esp.Name = 'Esp'
        Esp.Parent = workspace.Black
    else
        for i,v in pairs(workspace.Black:GetChildren()) do
            if v:IsA('Highlight') then
                v:Destroy()
            end
        end
    end
end)
Tabs.Farming:AddSection('')
Tabs.Farming:AddSection('Others')
Tabs.Farming:AddButton({
    Title = "Block ChangeProperty",
    Description = "Imunity Monster",
    Callback = function()
        Window:Dialog({
            Title = "Waring",
            Content = "Are you sure?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local sbEvent = ReplicatedStorage.Remotes.ChangeProperty
                        local __namecall
                        __namecall = hookmetamethod(game, "__namecall", function(...)
                            local args = {...}
                            local self = args[1]
                            local method = getnamecallmethod()

                            if (self == sbEvent and method == "FireServer") then
                                return wait(9e9)
                            end

                            return __namecall(...)
                        end)
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})
Tabs.Farming:AddButton({
    Title = "Block AdImpressionEvent",
    Description = "Imunity Monster",
    Callback = function()
        Window:Dialog({
            Title = "Waring",
            Content = "Are you sure?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local sbEvent = workspace.Ads.AdsManager.Analytics.AdImpressionEvent
                        local __namecall
                        __namecall = hookmetamethod(game, "__namecall", function(...)
                            local args = {...}
                            local self = args[1]
                            local method = getnamecallmethod()

                            if (self == sbEvent and method == "FireServer") then
                                return wait(9e9)
                            end

                            return __namecall(...)
                        end)
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})
Tabs.Farming:AddButton({
    Title = "Big Safe Zone",
    Description = "Very important button",
    Callback = function()
        workspace.SafeZones:GetChildren()[98].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones.SafeZone.Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[49].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[2].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[96].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[95].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[94].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[92].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[90].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[91].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[89].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[88].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[87].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[86].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[84].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[85].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[83].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[82].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[81].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[80].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[79].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[78].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[77].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[76].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[75].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[74].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[73].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[71].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[70].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[69].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[68].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[67].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[66].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[65].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[64].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[63].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[62].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[61].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[60].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[59].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[58].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[57].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[56].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[55].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[54].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[53].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        workspace.SafeZones:GetChildren()[52].Size = Vector3.new(9e9,9e9,9e9)wait(.5)
        -- workspace.SafeZones.SafeZone.Size = Vector3.new(9e9,9e9,9e9)
    end
})
Tabs.Farming:AddButton({
    Title = "Play Again",
    Description = "Very important button",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.PlayAgain:InvokeServer()
    end
})


Tabs.Player:AddButton({
    Title = "Get all lives",
    Description = "Visual :(",
    Callback = function()
        game:GetService("Players").LocalPlayer.PlayerInfo.Lives.Value = 5
    end
})
local FlyToggle = Tabs.Player:AddToggle("", {Title = "Fly", Default = false })
FlyToggle:OnChanged(function(bool)
    Fly = bool
    if Fly then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
        local Head = game.Players.LocalPlayer.Character:WaitForChild("Head")
        Head.Anchored = true
        if CFloop then CFloop:Disconnect() end
        CFloop = game:GetService('RunService').Heartbeat:Connect(function(deltaTime)
            local moveDirection = game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').MoveDirection * (2 * 2)
            local headCFrame = Head.CFrame
            local cameraCFrame = workspace.CurrentCamera.CFrame
            local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
            cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
            local cameraPosition = cameraCFrame.Position
            local headPosition = headCFrame.Position

            local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
            Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
        end)
    else
        if CFloop then
            CFloop:Disconnect()
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
            local Head = game.Players.LocalPlayer.Character:WaitForChild("Head")
            Head.Anchored = false
        end
    end
end)
local GetShoesToggle = Tabs.Player:AddToggle("", {Title = "Get Shoes", Default = false })
GetShoesToggle:OnChanged(function(bool)
    Shoes = bool
    if Shoes then
        while Shoes do task.wait()
            game:GetService("Players").LocalPlayer.leaderstats.Wins.Value=10
        end
    else
        game:GetService("Players").LocalPlayer.leaderstats.Wins.Value=0
        wait(.5)
        game:GetService("Players").LocalPlayer.leaderstats.Wins.Value=0
    end
end)
local getTorchToggle = Tabs.Player:AddToggle("", {Title = "Get Torch", Default = false })
getTorchToggle:OnChanged(function(bool)
    Torch = bool
    if Torch then
        game:GetService("Players").LocalPlayer.PlayerInfo.IsCompassPurchased.Value=true
        game:GetService("Players").LocalPlayer.PlayerGui.MainUI.BatteryCompass.Visible=true
        game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Torch)

        wait(.5)
        local Fire = Instance.new('Fire')
        local Point = Instance.new('PointLight')
        Point.Name = 'Light'
        Point.Parent = game.Players.LocalPlayer.Character.Torch.Fuel
        Fire.Name = 'FakeFire'
        Fire.Parent = game.Players.LocalPlayer.Character.Torch.Fuel

        Fire.Size = 2
        Point.Color = Color3.fromRGB(219, 147, 38)
    else
        game:GetService("Players").LocalPlayer.PlayerInfo.IsCompassPurchased.Value=false
        game:GetService("Players").LocalPlayer.PlayerGui.MainUI.BatteryCompass.Visible=false
    end
end)


warn('Script Executed, Made by InfinityMercury')
