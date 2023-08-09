--|| - Variables - ||--
local ChestsName = {}
local FPS = 60 --FPS
local clock = tick()
local Chests = workspace.ChestSpawns:GetChildren()



--|| - Script - ||--
game:GetService("StarterGui"):SetCore("SendNotification", {
  Title  = 'AutoChest';
  Text   = 'AutoChest Start';
  Icon   = 'http://www.roblox.com/asset/?id=13501251846';
})
for i,v in pairs(getgc(true)) do
   if (type(v)=='table' and rawget(v,'Remote')) then
       v.Remote.Name = v.Name
   end
end
for i,v in pairs(Chests) do
  if (v:IsA('Part')) then
    local ChestsModel = v
    table.insert(ChestsName,v.Name)
    for i,x in pairs(workspace:GetChildren()) do
      if (x:IsA('Model') and x.Name == tostring(ChestsModel)) then
        game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = x.Base.CFrame * CFrame.new(0,5,0)
        wait(.5)
        if getgenv().Settings.Methods.FireServer then
          local A_1 = ""
          local A_2 = x.Name
          local Event = game:GetService("ReplicatedStorage").Communication.Functions.OpenWorldChest
        end
        if getgenv().Settings.Methods.FirePromt then
          fireproximitpromt(x.Inside.ProximitPromt)
        end
        Event:FireServer(A_1,A_2)
        wait(getgenv().Settings.Time)
      end
    end
  end
end
while wait() and getgenv().Settings.AntiLag do
  while clock + 1 / FPS > tick() do end
  clock = tick()
end
