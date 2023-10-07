--[ Variables ]--
local ESP = Instance.new(
    "Folder",
    workspace
) ESP.Name = "ESP"
local ESPPC = Instance.new(
    "Folder",
    workspace
) ESPPC.Name = "ESPComputer"
function GetSizeOfObject(Obj)
    if Obj:IsA("BasePart") then
        return Obj.Size
    elseif Obj:IsA("Model") then
        return Obj:GetExtentsSize()
    end
end
function CreateESPPart(BodyPart,r,g,b)
    local ESPPartparent = BodyPart
    local Box = Instance.new("BoxHandleAdornment")
    Box.Size = GetSizeOfObject(ESPPartparent) + Vector3.new(0.1, 0.1, 0.1)
    Box.Name = "ESPPart"
    Box.Adornee = ESPPartparent
    Box.Color3 = Color3.fromRGB(r,g,b)
    Box.AlwaysOnTop = true
    Box.ZIndex = 5
    Box.Transparency = 0.4
    Box.Parent = ESP
    if BodyPart.Parent.Name == game.Players.LocalPlayer.Name then
        Box:remove()
        spawn (function()
            while true do
                wait(0.1)
                if BodyPart ~= nil then
                    Box:remove()
                end
            end
        end)
    end
end
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(...)
    local Args = {...}
    local Self = Args[1]
    if getnamecallmethod() == "FireServer" and tostring(Self) == "RemoteEvent" and Args[1] == "ReportPhysicsFPS" then
        return wait(math.huge)
    end
    return OldNameCall(...)
end)
local function WalkSpeedBypass()
  local gmt = getrawmetatable(game)
  setreadonly(gmt, false)
  local oldIndex = gmt.__Index
  gmt.__Index = newcclosure(function(self, b)
    if b == 'WalkSpeed' then
      return 16
    end
    return oldIndex(self, b)
  end)
end
local function JumpPowerBypass()
  local gmt = getrawmetatable(game)
  setreadonly(gmt, false)
  local oldIndex = gmt.__Index
  gmt.__Index = newcclosure(function(self, b)
    if b == 'JumpPower' then
      return 50
    end
    return oldIndex(self, b)
  end)
end
local BeastColor = Color3.new(255, 0, 0)
local InoccentColor = Color3.new(255, 255, 255)
local CreateEsp = function()
  for _, v in pairs(game:GetService('Players'):GetChildren()) do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
      local Esp = Instance.new('Highlight', v.Character)
      Esp.Name = 'EspPlayer'
      Esp.FillTransparency = 0.5
    end
  end
end
local UpdateEsp = function()
  for _, v in pairs(game:GetService('Players'):GetChildren()) do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
      if v.Character:findFirstChild('BeastPowers') then
        v.Character.EspPlayer.FillColor = BeastColor
      else
        v.Character.EspPlayer.FillColor = InoccentColor
      end
    end
  end
end
local KeyPress = function(v)
    return game:GetService("VirtualInputManager"):SendKeyEvent(true, v, false, game)
end
local Map = workspace:FindFirstChild(tostring(game.ReplicatedStorage.CurrentMap.Value))
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()



--[ Library ]--
local DevTools = loadstring(game:HttpGet("https://raw.githubusercontent.com/05-4/DevTools/main/index.lua"))()
local Window = DevTools:Init({
    Name = "Infinity Hub | Main Hub",
    Title = "Infinity Hub",
    Subtitle = "by Infinity Mercury",
    Icon = "rbxassetid://10723415766",
    LoadingBackgroundImage = "rbxassetid://14980847307",
    Options = {
        KillYourself = false,
        FOVAnimations = false,
    }
})



--[ Tabs ]--
local farmingTab = Window:CreateTab({
    Name = "Farming",
    Icon = ""
})
local playerTab = Window:CreateTab({
    Name = "Player",
    Icon = ""
})
local espTab = Window:CreateTab({
    Name = "Esp",
    Icon = ""
})



--[ Code ]--
local Section = farmingTab:CreateSection("[ Farming Options ]")
farmingTab:CreateToggle({
    Name = "Auto Hack",
    Callback = function(bool)
        autoHack = bool
        while autoHack do task.wait()
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("SetPlayerMinigameResult",true)
        end
    end,
})
farmingTab:CreateButton({
    Name = "Check Beast",
    Callback = function()
        for _, v in pairs(game:GetService('Players'):GetChildren()) do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then
              if v.Character:findFirstChild('BeastPowers') then
                Notification:Notify(
                    {Title = "Infinity Hub | Check Beast", Description = "Beast is "..v.Name},
                    {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=10709775560", ImageColor = Color3.fromRGB(255, 255, 255), Callback = function(State) print(tostring(State)) end}
                )
              end
            end
        end
    end,
})
farmingTab:CreateButton({
    Name = "Teleport to exit door",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if (v:IsA('Model') and v.Name == 'ExitDoor') then
                game:GetService('Players').LocalPlayer.Character:PivotTo(v:GetPivot())
            end
        end
    end,
})
farmingTab:CreateButton({
    Name = "Save captured players",
    Callback = function()
        local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local TeleportOldPos = '';
        TeleportOldPos = oldPos
        for _, v in pairs(game:GetService('Players'):GetChildren()) do
            if (v.Name ~= game.Players.LocalPlayer.Name) then
                if (v.TempPlayerStatsModule.Captured.Value == true) then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2.35)
                    wait(.2)
                    KeyPress('E')
                    wait(.25)
                end
            end
        end
        wait(.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TeleportOldPos)
    end,
})


playerTab:CreateSection("[ Player Options ]")
playerTab:CreateToggle({
    Name = "Anti Ragdoll (Beta)",
    Callback = function(bool)
        antiRagdoll = bool
        if antiRagdoll then
            while antiRagdoll do task.wait()
                for _, v in pairs(game:GetService("Players").LocalPlayer.TempPlayerStatsModule:GetChildren()) do
                    if (v:IsA('BoolValue') and v.Name == 'Ragdoll') then
                        v.Value = false
                        wait(.2) v.Value = true
                    end
                end
            end
        else
            wait(.5)
            for _, v in pairs(game:GetService("Players").LocalPlayer.TempPlayerStatsModule:GetChildren()) do
                if (v:IsA('BoolValue') and v.Name == 'Ragdoll') then
                    if (v.Value == true) then
                        v.Value = false
                    end
                end
            end
        end
    end,
})
playerTab:CreateToggle({
    Name = "No Slow (Rework)",
    Callback = function(bool)
        NoSlow = bool
        if NoSlow then
            if hookmetamethod then
                local oldnc
                oldnc = hookmetamethod(game, "__namecall", newcclosure(function(name, ...)
                       local Args = {...}
                       if not checkcaller() and tostring(name) == "PowersEvent" and Args[1] == "Jumped" then
                           return wait(9e9)
                       end
                       return oldnc(name, unpack(Args))
                end))
            else
                WalkSpeedBypass()
                while NoSlow do task.wait()
                    while NoSlow do task.wait()
                        if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed < 16 then
                            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                        end
                    end
                end
            end
        end
    end,
})
playerTab:CreateToggle({
    Name = "Active Crawling (Beast)",
    Callback = function(bool)
        antiveCrawling = bool
        while antiveCrawling do task.wait()
            for _, v in pairs(game:GetService("Players").LocalPlayer.TempPlayerStatsModule:GetChildren()) do
                if (v:IsA('BoolValue') and v.Name == 'DisableCrawl') then
                    v.Value = false
                end
            end
        end
    end,
})
playerTab:CreateSection("[ Normal Options ]")
playerTab:CreateSlider({
	Name = "WalkSpeed",
	Suffix = "Speed",
	Range = {16, 500},
	Interval = 1,
	Default = 16,
	Callback = function(Value)
		getgenv().Speed = Value
	end,
})
playerTab:CreateSlider({
	Name = "JumpPower",
	Suffix = "Jump",
	Range = {50, 500},
	Interval = 1,
	Default = 50,
	Callback = function(Value)
		getgenv().Jump = Value
	end,
})
playerTab:CreateToggle({
    Name = "Active Speed and Jump",
    Callback = function(bool)
        activeValues = bool
        while activeValues do task.wait()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Speed
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().Jump
        end
    end,
})


espTab:CreateToggle({
    Name = "Esp Player",
    Callback = function(bool)
        PlayersEsp = bool
        if PlayersEsp then
            CreateEsp()
            while PlayersEsp do task.wait()
                UpdateEsp()
            end
        else
            for _, x in pairs(workspace:GetDescendants()) do
                if x:IsA('Highlight') and x.Name == 'EspPlayer' then
                  x:Destroy()
                end
            end
        end
    end,
})
espTab:CreateToggle({
    Name = "Esp Computer",
    Callback = function(bool)
        CumputersEsp = bool
        if CumputersEsp then
            local map = workspace:findFirstChild(tostring(game.ReplicatedStorage.CurrentMap.Value))
            local children = map:GetChildren()
                for i =1, #children do
                if children[i].Name == "ComputerTable" then
                    local Box = Instance.new("BoxHandleAdornment")
                    Box.Size = GetSizeOfObject(children[i].Screen) + Vector3.new(-0.5, -0.5, -0.5)
                    Box.Name = "ESPPart"
                    Box.Adornee = children[i].Screen
                    spawn (function()
                        while true do
                            wait(0.1)
                            Box.Color3 = children[i].Screen.Color
                        end
                    end)
                    Box.AlwaysOnTop = true
                    Box.ZIndex = 5
                    Box.Transparency = 0.4
                    Box.Parent = ESPPC
                end
            end
        else
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA('BoxHandleAdornment') then
                    v:Destroy()
                end
            end
        end
    end,
})
