local function getexploit()
  local exploit =
      (syn and not is_sirhurt_closure and not pebc_execute and "Synapse") or
      (secure_load and "Sentinel") or
      (is_sirhurt_closure and "Sirhurt") or
      (pebc_execute and "ProtoSmasher") or
      (KRNL_LOADED and "Krnl" and 'Krnl UWP') or
      (WrapGlobal and "WeAreDevs") or
      (isvm and "Proxo") or
      (shadow_env and "Shadow") or
      (jit and "EasyExploits") or
      (getscriptenvs and "Calamari") or
      (unit and not syn and "Unit") or
      (OXYGEN_LOADED and "Oxygen U") or
      (IsElectron and "Electron") or
      ("Unsupported")

  return exploit
end


if game.PlaceId == 5610197459 then
    if getexploit() == 'Krnl UWP' then
        rconsolename('Infinity Hub')
        rconsoleprint('@@WHITE@@')
        rconsoleprint('Hello '..game.Players.LocalPlayer.Name..' Welcome to infinity Hub\n')
        wait(2)
        rconsoleprint('Check Game...\n')
        wait(4)
        rconsoleprint('Game Supported! Game: '..game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name..'\n\n')
        wait(1)
        rconsoleinfo('Version Hub: 1.0')
        rconsoleinfo('Hub Status: Beta')
        rconsoleinfo('Script Executed: '..os.date("%I:%M:%S")..' | '..os.date("%B %d, %Y"))
        rconsoleinfo('Credits: InfinityMercury')
        wait(1)
        rconsoleprint('@@GREEN@@')
        rconsoleprint('Script Executed!') wait(.5)
        loadstring(game:HttpGet("https://gist.githubusercontent.com/InfinityMercury/bcec4f5d1417f97700faa998784994fc/raw/440e39e9731751d3ec72207f2c7b21bb4b6eb730/GangUpSimulator.lua",true))()
    else
        warn('Exploit is not Krnl, is: '..identifyexecutor())
        wait(1)
        loadstring(game:HttpGet("https://gist.githubusercontent.com/InfinityMercury/bcec4f5d1417f97700faa998784994fc/raw/440e39e9731751d3ec72207f2c7b21bb4b6eb730/GangUpSimulator.lua",true))()
        warn('Script Executed, Welcome '..game.Players.LocalPlayer.Name)
    end

else
    game.Players.LocalPlayer:Kick('game not supported :(')
end
