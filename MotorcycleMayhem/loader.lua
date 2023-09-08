--// Variables
local GetBikes = function()
    local bikesNames = {}
    for _, v in pairs(game:GetService("ReplicatedStorage").AVehicles:GetChildren()) do
        table.insert(bikesNames, v.Name)
    end
    return bikesNames
end



--// Libray
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Window = Fluent:CreateWindow({
    Title = 'Infinity Hub | 1.5 | '..game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name,
    SubTitle = "by InfinityMercury",
    TabWidth = 100,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.J
})
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://10723424505" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local Options = Fluent.Options



--// Code
Tabs.Main:AddSection('- Spawn Any Motorcycles')
local Dropdown = Tabs.Main:AddDropdown("BikeDropdown", {
    Title = "Select Bike: ",
    Values = GetBikes(),
    Multi = false,
    Default = 1,
})
Tabs.Main:AddButton({
    Title = "Spawn",
    Description = "Click to spawn bike selected",
    Callback = function()
        local ohString1 = Options.BikeDropdown.Value
        local ohVector32 = Vector3.new(0, 0, 0)
        game:GetService("ReplicatedStorage").SpawnVeh:FireServer(ohString1, ohVector32)
    end
})
Tabs.Main:AddSection('')
Tabs.Main:AddSection('- Get Any Motorcycles')
local Dropdown = Tabs.Main:AddDropdown("BikeDropdownGet", {
    Title = "Select Bike: ",
    Values = GetBikes(),
    Multi = false,
    Default = 1,
})
Tabs.Main:AddButton({
    Title = "Get (beta)",
    Description = "Click to Get bike selected",
    Callback = function()
        local bikesNames = Instance.new('Weld')
        local bikesNamesClone = Instance.new('Weld')
        bikesNames.Parent = game.Players.LocalPlayer.Vehicle_Spawner
        bikesNames.Name = Options.BikeDropdownGet.Value
        wait(1)
        bikesNamesClone.Parent = game.Players.LocalPlayer.Vehicle_Spawner
        bikesNamesClone.Name = Options.BikeDropdownGet.Value
        bikesNames:Destroy()
    end
})
Tabs.Main:AddSection('')
Tabs.Main:AddSection('- Misc')
Tabs.Main:AddButton({
    Title = "Redeem all codes",
    Description = "",
    Callback = function()
        local Codes = {'80K','wehit70k','60kwow','cactus','omg50k','TURBINEBIKE'}
        local args = {[1] = '80K'}
        game:GetService("ReplicatedStorage").Code:InvokeServer(unpack(args))
        local args2 = {[1] = 'wehit70k'}
        game:GetService("ReplicatedStorage").Code:InvokeServer(unpack(args2))
        local args3 = {[1] = '60kwow'}
        game:GetService("ReplicatedStorage").Code:InvokeServer(unpack(args3))
        local args4 = {[1] = 'cactus'}
        game:GetService("ReplicatedStorage").Code:InvokeServer(unpack(args4))
        local args5 = {[1] = 'omg50k'}
        game:GetService("ReplicatedStorage").Code:InvokeServer(unpack(args5))
        local args6 = {[1] = 'TURBINEBIKE'}
        game:GetService("ReplicatedStorage").Code:InvokeServer(unpack(args6))
    end
})
local FarmWheelieToggle = Tabs.Main:AddToggle("MyToggle", {Title = "Farm Wheelie (unfinished)", Default = false })
FarmWheelieToggle:OnChanged(function(bool)
    AutoWheelie = bool
    if AutoWheelie then
        for i,v in pairs(getgc()) do
            if type(v) == 'function' and debug.getinfo(v).name == 'WheelieToggle' then
                debug.setupvalue(v, 1, true)
            end
        end

        local KeyPress = function(v)
            return game:GetService("VirtualInputManager"):SendKeyEvent(true, v, false, game)
        end
        KeyPress("LeftControl")
        for _ = 1, 90000 do
            game:GetService("ReplicatedStorage").WheelieBadge:FireServer(_)
            wait(0.1)
        end
    end
end)
