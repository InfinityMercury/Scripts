-- Variables
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



-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/InfinityMercury/UiLibray/main/CFA%20Hub/source.lua",true))()
local Windown = Library:CreateWindow(
    "Infinity Hub",
    game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name,
    true
);



-- Tabs
local farmingTab = Windown:CreatePage("Farming")
local playerTab = Windown:CreatePage("Player")
local espTab = Windown:CreatePage("Esp")
local creditsTab = Windown:CreatePage("Credits")



-- Code
local farmingSection = farmingTab:CreateSection("[ Farming Options ]")
farmingSection:CreateToggle("Auto Hack", {Toggled = false , Description = false}, function(bool)
    autoHack = bool
    while autoHack do task.wait()
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("SetPlayerMinigameResult",true)
    end
end)
farmingSection:CreateButton("Check Beast", function ()
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
end)
farmingSection:CreateButton("Teleport To Exit Door", function ()
    for _, v in pairs(workspace:GetDescendants()) do
        if (v:IsA('Model') and v.Name == 'ExitDoor') then
            game:GetService('Players').LocalPlayer.Character:PivotTo(v:GetPivot())
        end
    end
end)
farmingSection:CreateButton("Save Captured Players", function ()
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
end)
local unfinishedSection = farmingTab:CreateSection("[ Unfinished Options ]")
unfinishedSection:CreateButton("Teleport Computers (Beta Test)", function ()
    for _, v in pairs(Map:GetChildren()) do
        if (v:IsA('Model') and v.Name == 'ComputerTable') then
            for _, x in pairs(v:GetChildren()) do
                if (x:IsA('Part') and x.Name == 'Screen') then
                    if (x.Color == Color3.fromRGB(13, 105, 172) or Color3.new(196, 40, 28)) then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = x.Parent.ComputerTrigger1.CFrame
                        wait(.1) KeyPress('E') return
                    end
                end
            end
        end
    end
end)


local playerSection = playerTab:CreateSection("[ Player Options ]")
playerSection:CreateToggle("Anti Ragdoll (Beta Test)", {Toggled = false , Description = false}, function(bool)
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
end)
playerSection:CreateToggle("No Slow", {Toggled = false , Description = false}, function(bool)
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
end)
playerSection:CreateToggle("Active Crawling (Beast)", {Toggled = false , Description = false}, function(bool)
    antiveCrawling = bool
    while antiveCrawling do task.wait()
        for _, v in pairs(game:GetService("Players").LocalPlayer.TempPlayerStatsModule:GetChildren()) do
            if (v:IsA('BoolValue') and v.Name == 'DisableCrawl') then
                v.Value = false
            end
        end
    end
end)
local miscSections = playerTab:CreateSection("[ Misc ]")
miscSections:CreateSlider("WalkSpeed", {Min = 16, Max = 500, DefaultValue = 16}, function(speed)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=speed
end)
miscSections:CreateSlider("JumpPower", {Min = 50, Max = 500, DefaultValue = 36}, function(jump)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower=jump
end)


local espSection = espTab:CreateSection("[ Esp Options ]")
espSection:CreateToggle("Esp Player", {Toggled = false , Description = false}, function(bool)
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
end)
espSection:CreateToggle("Esp Computer", {Toggled = false , Description = false}, function(bool)
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
end)


local creaditsSection = creditsTab:CreateSection('[ Credits ]')
creaditsSection:CreateButton("Click Here", function ()
    Notification:Notify(
        {Title = "Infinity Hub | Credits", Description = "Made by InfintyMercury"},
        {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 8, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=10709775560", ImageColor = Color3.fromRGB(255, 255, 255), Callback = function(State) print(tostring(State)) end}
    )
end)



-- KeyBind
wait(.5)
local MainHub = game:GetService('CoreGui').CFAHubPremium2022
local hub = MainHub.Container
local keyBind = 'J'
game:GetService("UserInputService").InputBegan:Connect(function(Key, IsChat)
    if IsChat then return end
    if Key.KeyCode == Enum.KeyCode[keyBind] then
        if hub.Visible == true then
            hub.Visible = false
        elseif hub.Visible == false then
            hub.Visible = true
        end
    end
end)
warn('KeyBind: J')
Notification:Notify(
    {Title = "Infinity Hub | KeyBind", Description = "Keybind: "..keyBind},
    {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 8, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=10709775560", ImageColor = Color3.fromRGB(255, 255, 255), Callback = function(State) print(tostring(State)) end}
)
