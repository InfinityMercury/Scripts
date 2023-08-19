local BikeNames = {}
for _, v in pairs(game:GetService("ReplicatedStorage").AVehicles:GetChildren()) do
    table.insert(BikeNames, v.Name)
end



local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()
library.rank = "Script User"
local Wm = library:Watermark("Infinity Hub | v" .. library.version ..  " | " .. library:GetUsername() .. " | rank: " .. library.rank)
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
    while wait(.75) do
        FpsWm:Text("fps: " .. library.fps)
    end
end)()
local Notif = library:InitNotifications()
local LoadingXSX = Notif:Notify("Loading Inifnity Hub", 5, "information") 
library.title = "Infinity Hub - "..game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name
library:Introduction()
wait(1)
local Init = library:Init()
local Tab1 = Init:NewTab("Main")
local Label1 = Tab1:NewLabel("------------------ Spawn Any Bike ------------------", "center")
local Selector1 = Tab1:NewSelector("Select Bike:", "Not selected", BikeNames, function(d)
    getgenv().BikesNameSelect = d
end)
local Button1 = Tab1:NewButton("Spawn", function()
    local ohString1 = getgenv().BikesNameSelect
    local ohVector32 = Vector3.new(0, 0, 0)
    game:GetService("ReplicatedStorage").SpawnVeh:FireServer(ohString1, ohVector32)
end)

local Tab2 = Init:NewTab("Settings")
local Label2 = Tab2:NewLabel("Settings", "center")
local Keybind1 = Tab2:NewKeybind("Hub KeyBind", Enum.KeyCode.J, function(key)
    Init:UpdateKeybind(Enum.KeyCode[key])
end)
