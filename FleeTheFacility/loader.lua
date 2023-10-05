--[ Variables ]--
function FixLabel()
    for _, v in pairs(game:GetService('CoreGui'):GetDescendants()) do
        if v:IsA('ScreenGui') and v.Name == 'Rayfield' then
            for _, x in pairs(v:GetDescendants()) do
                if x:IsA('Frame') and x.Name == 'Label' then
                    x.UIStroke.Color = Color3.fromRGB(6, 134, 138)
                end
            end
        end
    end
end
function FixTopBar()
    for _, v in pairs(game:GetService('CoreGui'):GetDescendants()) do
        if v:IsA('ScreenGui') and v.Name == 'Rayfield' then
            v.Main.Topbar.BackgroundColor3 = Color3.fromRGB(0, 63, 63)
            wait(.1)
            v.Main.Topbar.CornerRepair.BackgroundColor3 = Color3.fromRGB(0, 63, 63)
            wait(.1) v.Main.Topbar.Divider.BackgroundColor3 = Color3.fromRGB(4, 141, 149)
            wait(.25)
        end
    end
end
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
getgenv().SecureMode = true
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/InfinityMercury/UiLibray/main/Rayfield/Remake.lua'))()
local Window = Rayfield:CreateWindow({
   Name = "Infinity Hub | v2.5 | Flee The Facility",
   LoadingTitle = "Infinity Hub Loader",
   LoadingSubtitle = "by InfinityMercury",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = 'InfHub',
      FileName = "InfHub FTF"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = false
   },
   KeySystem = false,
   KeySettings = {
      Title = "",
      Subtitle = "",
      Note = "",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"cum"}
   }
})




--[ Tabs ]--
local Tab = Window:CreateTab("Farming", 7743866529)
local Section = Tab:CreateSection("[ Farming Options ]")
local Toggle = Tab:CreateToggle({
    Name = "Auto Hack",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(bool)
        autoHack = bool
        while autoHack do task.wait()
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("SetPlayerMinigameResult",true)
        end
    end,
})
local Button = Tab:CreateButton({
    Name = "Check Beast",
    Callback = function()
        for _, v in pairs(game:GetService('Players'):GetChildren()) do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then
              if v.Character:findFirstChild('BeastPowers') then
                Notification:Notify(
                    {Title = "Infinity Hub | Check Beast", Description = "Beast is "..v.Name},
                    {OutlineColor = Color3.fromRGB(255,255,255),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=7733964640", ImageColor = Color3.fromRGB(2, 255, 78), Callback = function(State) print(tostring(State)) end}
                )
              end
            end
        end
    end,
})
local Button = Tab:CreateButton({
    Name = "Teleport to exit door",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if (v:IsA('Model') and v.Name == 'ExitDoor') then
                game:GetService('Players').LocalPlayer.Character:PivotTo(v:GetPivot())
            end
        end
    end,
})
local Button = Tab:CreateButton({
    Name = "Save captured players",
    Callback = function()
        local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local TeleportOldPos = '';
        TeleportOldPos = oldPos
        for _, v in pairs(game:GetService('Players'):GetChildren()) do
            if (v.Name ~= game.Players.LocalPlayer.Name) then
                if (v.TempPlayerStatsModule.Captured.Value == true) then
                    game.Players.LocalPlayer.Character:PivotTo(v.Character:GetPivot())
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


local Tab = Window:CreateTab("Player", 10747373176)
local Section = Tab:CreateSection("[ Player Options ]")
local Toggle = Tab:CreateToggle({
    Name = "Anti Ragdoll (Beta)",
    CurrentValue = false,
    Flag = "Toggle1",
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
local Toggle = Tab:CreateToggle({
    Name = "No Slow",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(bool)
        NoSlow = bool
        while NoSlow do task.wait()
            if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed < 16 then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
    end,
})
local Toggle = Tab:CreateToggle({
    Name = "Active Crawling (Beast)",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(bool)
        antiRagdoll = bool
        while antiRagdoll do task.wait()
            for _, v in pairs(game:GetService("Players").LocalPlayer.TempPlayerStatsModule:GetChildren()) do
                if (v:IsA('BoolValue') and v.Name == 'DisableCrawl') then
                    v.Value = false
                end
            end
        end
    end,
})
local Slider = Tab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 500},
    Increment = 16,
    Suffix = "WalkSpeed",
    CurrentValue = 16,
    Flag = "Slider1",
    Callback = function(Value)
        WalkSpeedBypass()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})
local Slider = Tab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 500},
    Increment = 16,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Flag = "Slider1",
    Callback = function(Value)
        JumpPowerBypass()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})


local Tab = Window:CreateTab("Esp", 7733774602)
local Section = Tab:CreateSection("[ Esp Options ]")
local Toggle = Tab:CreateToggle({
    Name = "Esp Player",
    CurrentValue = false,
    Flag = "Toggle1",
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
local Toggle = Tab:CreateToggle({
    Name = "Esp Computer",
    CurrentValue = false,
    Flag = "Toggle1",
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



--[ Fix Options ]--
FixLabel()
FixTopBar()
