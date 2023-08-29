local Players = game:GetService("Players")
local IsGroup = game.CreatorType == Enum.CreatorType.Group
local CreatorId = game.CreatorId

local ModerationRanks = {
	'Noob',
	'Nooblet',
	'Developer',
	'Builder',
	'Community Supervisor',
	'Head Admin',
	'Admin',
	'Head Tester',
	'Noobility'
}

local function CheckPlayer(player)
	if not player then return end

	-- Ownership detection
	local success, result = pcall(function()
	return
	IsGroup and CreatorId and player:GetRankInGroup(CreatorId) == 255
	or CreatorId == player.UserId
	end)
	if success and result then
	tpservice:Teleport(game.PlaceId, player)
end

-- Group Rank detection
local success, result = pcall(function()
	return IsGroup and CreatorId and player:GetRoleInGroup(CreatorId)
end)
	if success and result then
		if table.find(ModerationRanks, result) then
			tpservice:Teleport(game.PlaceId, player)
		end
	end
end

Players.PlayerAdded:Connect(CheckPlayer)
for index, player in pairs(Players:GetPlayers()) do
	task.spawn(CheckPlayer, player)
end
