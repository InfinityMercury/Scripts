-- libray
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
    Player = Window:AddTab({ Title = "Player", Icon = "rbxassetid://14709912924" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local Options = Fluent.Options



-- code
local LBToggle = Tabs.Farming:AddToggle("MyToggle", {Title = "Auto Lucky Block", Default = false })
LBToggle:OnChanged(function(bool)
    LB = bool
    while LB do task.wait()
        game:GetService("ReplicatedStorage").SpawnLuckyBlock:FireServer()
    end
end)
local SLBToggle = Tabs.Farming:AddToggle("MyToggle", {Title = "Auto Super Lucky Block", Default = false })
SLBToggle:OnChanged(function(bool)
    SLB = bool
    while SLB do task.wait()
        game:GetService("ReplicatedStorage").SpawnSuperBlock:FireServer()
    end
end)
local DLBToggle = Tabs.Farming:AddToggle("MyToggle", {Title = "Auto Diamond Lucky Block", Default = false })
DLBToggle:OnChanged(function(bool)
    DLB = bool
    while DLB do task.wait()
        game:GetService("ReplicatedStorage").SpawnDiamondBlock:FireServer()
    end
end)
local RLBToggle = Tabs.Farming:AddToggle("MyToggle", {Title = "Auto Rainbow Lucky Block", Default = false })
RLBToggle:OnChanged(function(bool)
    RLB = bool
    while RLB do task.wait()
        game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer()
    end
end)
local GLBToggle = Tabs.Farming:AddToggle("MyToggle", {Title = "Auto Galaxy Lucky Block", Default = false })
GLBToggle:OnChanged(function(bool)
    GLB = bool
    while GLB do task.wait()
        game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
    end
end)
local AutoAllBlocksToggle = Tabs.Farming:AddToggle("MyToggle", {Title = "Auto All Lucky Block", Default = false })
AutoAllBlocksToggle:OnChanged(function(bool)
    AutoAll = bool
    while AutoAll do task.wait()
        game:GetService("ReplicatedStorage").SpawnLuckyBlock:FireServer()
        game:GetService("ReplicatedStorage").SpawnSuperBlock:FireServer()
        game:GetService("ReplicatedStorage").SpawnDiamondBlock:FireServer()
        game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer()
        game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
    end
end)
Tabs.Farming:AddSection('')
Tabs.Farming:AddSection('Multiple Open')
local Dropdown = Tabs.Farming:AddDropdown("LuckyBlockSelected", {
    Title = "Select Luck Block: ",
    Values = {'Normal Lucky Block', 'Super Lucky Block', 'Diamond Lucky Block', 'Rainbow Lucky Block', 'Galaxy Lucky Block'},
    Multi = false,
    Default = 1,
})
local Dropdown = Tabs.Farming:AddDropdown("MultipleDropdown", {
    Title = "Select Multiple: ",
    Values = {'10', '50', '100', '1000'},
    Multi = false,
    Default = 1,
})
Tabs.Farming:AddButton({
    Title = "Spawn",
    Description = "",
    Callback = function()
        for i = 1, Options.MultipleDropdown.Value  do
            if Options.LuckyBlockSelected.Value == 'Normal Lucky Block' then
                game:GetService("ReplicatedStorage").SpawnLuckyBlock:FireServer(i)
            elseif Options.LuckyBlockSelected.Value == 'Super Lucky Block' then
                game:GetService("ReplicatedStorage").SpawnSuperBlock:FireServer(i)
            elseif Options.LuckyBlockSelected.Value == 'Diamond Lucky Block' then
                game:GetService("ReplicatedStorage").SpawnDiamondBlock:FireServer(i)
            elseif Options.LuckyBlockSelected.Value == 'Rainbow Lucky Block' then
                game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer(i)
            elseif Options.LuckyBlockSelected.Value == 'Galaxy Lucky Block' then
                game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer(i)
            end
        end
    end
})


local Slider = Tabs.Player:AddSlider("Slider", {
    Title = "WalkSpeed",
    Description = "",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=Value
    end
})
local Slider = Tabs.Player:AddSlider("Slider", {
    Title = "JumpPower",
    Description = "",
    Default = 50,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower=Value
    end
})
