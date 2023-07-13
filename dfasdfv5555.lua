
---@diagnostic disable: undefined-global, lowercase-global, deprecated, undefined-field, ambiguity-1, unbalanced-assignments, redundant-parameter, cast-local-type, redefined-local, need-check-nil
task.wait(3)
repeat task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
	repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
	repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
	repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
	game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
	getgenv().start_time = os.time()
	repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end
task.wait(3)

local plr = game:GetService("Players").LocalPlayer
local players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local host = "https://www.project-hub.shop/Ggx"

function get_level_data()
	local list = {}
	for i, v in pairs(game.Workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()) do
		list[i] = v
	end
	return list
end

if game.PlaceId == 8304191830 then
	getgenv().lastpotision = "หน้าล็อบบี้"
	getgenv().locationmap = "หน้าล็อบบี้"
else
	getgenv().lastpotision = "กำลังเล่น"
	getgenv().locationmap = tostring(get_level_data().map)

end

function update_ssX(startfarm, idplayer, modefarm, itemfarm, numberfarm, replay, whitesc, codeget, buyunit, sellunit, bp, wh1, wh2, lastpotision, locationmap)
	local urlParams = {
			startfarm = tostring(startfarm),
			idplayer = tostring(idplayer),
			modefarm = tostring(modefarm),
			itemfarm = tostring(itemfarm),
			numberfarm = tostring(numberfarm),
			replay = tostring(replay),
			whitesc = tostring(whitesc),
			codeget = tostring(codeget),
			buyunit = tostring(buyunit),
			sellunit = tostring(sellunit),
			bp = tostring(bp),
			wh1 = tostring(wh1),
			wh2 = tostring(wh2),
			lastpotision = tostring(lastpotision),
			locationmap = tostring(locationmap)
	}
	
	local encodedParams = {}
	for key, value in pairs(urlParams) do
			table.insert(encodedParams, key .. '=' .. HttpService:UrlEncode(value))
	end

	local queryString = table.concat(encodedParams, '&')
	local url = host .. '/update_end.php?' .. queryString
	HttpService:UrlEncode(game:HttpGet(url))
end


--#region List Friends
function listFriends()
	friendsWith = {} --array of player instances the local player is friends with
	for _, player in ipairs(players:GetPlayers()) do
		if player ~= plr then
			local success, result = pcall(function()
				return plr:IsFriendsWith(player.UserId)
			end)
			if success then
				if result then
					table.insert(friendsWith, player.Name)
				end
			else
				warn(result)
			end
		end
	end
	return friendsWith
end
--#endregion

--#region [Function] Auto Select Units

function handle_select_units()
    getgenv().profile_data = { equipped_units = {} }
    repeat
        do
        for i, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "xp") then wait()
            table.insert(getgenv().profile_data.equipped_units, v)
            end
        end
    end
    until #getgenv().profile_data.equipped_units > 0

    getgenv().SelectedUnits = {}
    local units_data = require(game:GetService("ReplicatedStorage").src.Data.Units)
    for i, v in pairs(getgenv().profile_data.equipped_units) do
        if units_data[v.unit_id] and v.equipped_slot then
        local selected_unit_data = tostring(units_data[v.unit_id].id) .. " #" .. tostring(v.uuid)
        getgenv().SelectedUnits[tonumber(v.equipped_slot)] = selected_unit_data
        updatejson()
        end
    end
end
--#endregion

--#region GetCurrentLevelName

local function GetCurrentLevelName()
	if game.Workspace._MAP_CONFIG then
		return game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
	end
end

--#endregion

--------------------
--#region Modul Units --

getgenv().UnitCache = {}
for _, Module in next, game:GetService("ReplicatedStorage"):WaitForChild("src"):WaitForChild("Data"):WaitForChild("Units"):GetDescendants() do
	if Module:IsA("ModuleScript") and Module.Name ~= "UnitPresets" then
		for UnitName, UnitStats in next, require(Module) do
			getgenv().UnitCache[UnitName] = UnitStats
		end
	end
end

--#endregion
---------------------------
--#region Setting Script
local a = 'MIHIME' -- Paste Name
if not isfolder(a) then
	makefolder(a)
end

getgenv().savefilename = "MIHIME/autoNoui." .. game.Players.LocalPlayer.Name .. ".json"
getgenv().door = "_lobbytemplategreen1"
-----------------------------------------------------------------
--#endregion

--#region GetCurrentLevelName

local function GetCurrentLevelName()
	if game.Workspace._MAP_CONFIG then
		return game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
	end
end

--#endregion

--#============================== WebHook ================================

--#region [Function] Setting WebHook
function disp_time(seconds)
	hours = string.format("%02.f", math.floor(seconds/3600))
	mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
	secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins*60))
	return mins..":"..secs
end

function get_user_img_url()
	local response = HttpService:JSONDecode(game:HttpGet('https://thumbnails.roblox.com/v1/users/avatar-bust?userIds=' .. LocalPlayer.UserId .. '&size=420x420&format=Png&isCircular=false'))
	for i, v in pairs(response.data) do
		return tostring(v.imageUrl)
	end
end


------------item drop result
local Table_All_Items_New_data = {}

function getCSMPortals()
	local reg = getreg() --> returns Roblox's registry in a table
	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							local portals = {}
							for _, item in pairs(v["session"]["inventory"]["inventory_profile_data"]["unique_items"]) do
									table.insert(portals, item)
							end
							return portals
						end
					end
				end
			end
		end
	end
end

for _, v3 in pairs(game:GetService("ReplicatedStorage").src.Data.Items:GetDescendants()) do
	if v3:IsA("ModuleScript") then
		for v4, v5 in pairs(require(v3)) do
			Table_All_Items_New_data[v4] = {}
			Table_All_Items_New_data[v4]['Name'] = v5['name']
			Table_All_Items_New_data[v4]['Count'] = 0
		end
	end
end

function getNormalItems()
	local reg = getreg() --> returns Roblox's registry in a table
	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							return v["session"]["inventory"]["inventory_profile_data"]["normal_items"]
						end
					end
				end
				--end
			end
		end
	end
end

function getItemChangesNormal(preGameTable, currentTable)
	local itemChanges = {}

	for item, amount in pairs(currentTable) do
		if preGameTable[item] == nil then
			print(item .. ": +" .. amount)
			itemChanges[item] = "+" .. amount
		else
			if preGameTable[item] > amount then
				print(item .. ": -" .. preGameTable[item] - amount)
				itemChanges[item] = "-" .. preGameTable[item] - amount
			elseif preGameTable[item] < amount then
				print(item .. "+" .. amount - preGameTable[item])
				itemChanges[item] = "+" .. amount - preGameTable[item]
			end
		end
	end
	return itemChanges
end

function getUniqueItems()
	local reg = getreg() --> returns Roblox's registry in a table

	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							return v["session"]["inventory"]["inventory_profile_data"]["unique_items"]
						end
					end
				end
				--end
			end
		end
	end
end

function getItemChangesUnique(preGameTable, postGameTable)
	local itemAdditions = {}

	for _, item in pairs(postGameTable) do
		local currentItemUUID = item["uuid"]
		local currentItemIsNew = true
		for i, itemToCompare in pairs(preGameTable) do
			if itemToCompare["uuid"] == currentItemUUID then
				currentItemIsNew = false
			end
		end
		if currentItemIsNew then
			print("New Unique Item: " .. item["item_id"])
			table.insert(itemAdditions, item["item_id"])
		end
	end

	return itemAdditions
end

function shallowCopy(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

repeat local testItemGet = getNormalItems() until testItemGet ~= nil

getgenv().startingInventoryNormalItems = shallowCopy(getNormalItems())
getgenv().startingInventoryUniqueItems = shallowCopy(getUniqueItems())


--#endregion


--#region FIX WebHook_Update

function update_end()
    local gemReward = tostring(LocalPlayer.PlayerGui.Waves.HealthBar.IngameRewards.GemRewardTotal.Holder.Main.Amount.Text)
    local sumFarm = tostring(getgenv().numberfarm)
    local updateFarm = tonumber(sumFarm) - tonumber(gemReward)
    getgenv().hookgem = tostring(updateFarm)

    update_ssX(
        getgenv().startfarm,
        LocalPlayer.Name,
        getgenv().modefarm,
        getgenv().itemfarm,
        getgenv().hookgem,
        getgenv().replay,
        getgenv().whitesc,
        getgenv().codeget,
        getgenv().buyunit,
        getgenv().sellunit,
        getgenv().bp,
        getgenv().wh1,
        getgenv().wh2,
        getgenv().lastpotision,
		getgenv().locationmap
	)

	if getgenv().modefarm == "ฟาร์มเพชร" then
		if tonumber(getgenv().hookgem) <= 0 then
			pcall(function () webhook_finish()  end)
			task.wait(3)
		end
	end

	if getgenv().modefarm == "ฟาร์มตาโกโจ" then
		if tonumber(getgenv().hookgem) <= 0 then
			pcall(function () webhook_finish()  end)
			task.wait(3)
		end
	end

	if getgenv().modefarm == "ฟาร์ม BattlePass" then
		if tonumber(getgenv().hookgem) <= tonumber(getgenv().BattlePass) then
			pcall(function () webhook_finish()  end)
		end
	end

	if getgenv().modefarm == "ฟาร์มเวลตัวละคร" then
		levePlayers = LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text
		levelCheck = levePlayers:split(" ")
		if tonumber(levelCheck[2]) >= tonumber(getgenv().numberfarm) then
			pcall(function() webhook_finish() end)
			task.wait(3)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		end
	end

	if getgenv().modefarm == "ฟาร์มหอคอย" then
		task.wait(5)
		local resultx = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)
		infTower_check = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelName.Text
		infinityTower = infTower_check:split(" ")
		
		if resultx == "VICTORY" then
			if tonumber(infinityTower[4]) >= tonumber(getgenv().numberfarm) then
				pcall(function() webhook_finish() end)
			end
		end
	end

end

function Reset_Finish()
    local numberfarm = "เสร็จแล้ว"
    local startfarm = "false"
    local replay = "false"
    local whitesc = "false"
    local modefarm = "เลือกโหมดที่ต้องการฟาร์ม"
    update_ssX(
        startfarm,
        LocalPlayer.Name,
        modefarm,
        getgenv().itemfarm,
        numberfarm,
        replay,
        whitesc,
        getgenv().codeget,
        getgenv().buyunit,
        getgenv().sellunit,
        getgenv().bp,
        getgenv().wh1,
        getgenv().wh2,
        getgenv().lastpotision,
		getgenv().locationmap
	)
end

--#endregion

--#region [Function] Web Hook Deteal  [ถ้าไม่มี ITEM จะไม่แสดงข้อมูล]

function update_data()
	update_end()
	getgenv().end_time = os.time()
	local itemDifference = getItemChangesNormal(getgenv().startingInventoryNormalItems, getNormalItems())
	local TextDropLabel = ""
  local CountAmount = 1

	for name, amount in pairs(itemDifference) do
		for code , nameCode in pairs(Table_All_Items_New_data) do
			if code == name then
				TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(nameCode["Name"]) .. " : " .. tostring(amount) .. "\n"
				CountAmount = CountAmount + 1
				break
			end
		end
	end

	if TextDropLabel == "" then
			TextDropLabel = "ไม่มีไอเท็มที่ได้รับ"
	end

	user_level = tostring(LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)
	total_gems = tostring(LocalPlayer._stats.gem_amount.Value)
	gem_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
	trophy_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.TrophyReward.Main.Amount.Text)
	xp_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text):split(" ")[1]
	total_wave = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text):split(": ")[2]
	total_time = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text):split(": ")[2]
	result = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)

	local itemInventory = getNormalItems()
	local portal_name = getCSMPortals()
	local demon_portal = 0
	local alien_portal = 0
	local devil_Academy = 0
	local alien_scouter = 0
	local tomoe = 0
	local relicShard = 0
	local demonShard = 0
	local entertainShard = 0
	local six_eye = 0

	for name, amount in pairs(itemInventory) do
		if name == "west_city_frieza_item" then
			alien_scouter = tostring(amount or 0)
		elseif name == "uchiha_item" then
			tomoe = tostring(amount or 0)
		elseif name == "relic_shard" then
			relicShard = tostring(amount or 0)
		elseif name == "april_symbol" then
			demonShard = tostring(amount or 0)
		elseif name == "entertainment_district_item" then
			entertainShard = tostring(amount or 0)
		elseif name == "six_eyes" then
			six_eye = tostring(amount or 0)
		end
	end

	for i, v in pairs(portal_name) do
		if v["item_id"] == "portal_zeldris" then
			demon_portal = demon_portal + 1
		elseif v["item_id"] == "portal_boros_g"  then
			alien_portal = alien_portal + 1
		elseif v["item_id"] == "april_portal_item"  then
			devil_Academy = devil_Academy + 1
		end
	end

	if gem_reward == "+99999" then gem_reward = "+0" end
	if xp_reward == "+99999" then xp_reward = "+0" end
	if trophy_reward == "+99999" then trophy_reward = "+0" end
	if result == "VICTORY" then
    result = "ชัยชนะ"
  else
    result = "พ่ายแพ้"
  end

	print('Log 3')

	if getgenv().modefarm == "ฟาร์มเพชร" then
		gem_reward = tostring(LocalPlayer.PlayerGui.Waves.HealthBar.IngameRewards.GemRewardTotal.Holder.Main.Amount.Text)
		total_wave = tostring(Workspace["_wave_num"].Value)
		total_time = disp_time(os.difftime(getgenv().end_time, getgenv().start_time))
	end

	for name, amount in pairs(itemDifference) do
		if getgenv().modefarm == "ฟาร์มไอเท็มเรด" and getgenv().itemfarm == "Alien Scouter" and name == "west_city_frieza_item" then
			getgenv().numberfarm = tonumber(getgenv().numberfarm) - amount
			if tonumber(getgenv().numberfarm) <= 1 then
				pcall(function () webhook_finish() end)
				return
			end
			task.wait(1)
			break
		elseif getgenv().modefarm == "ฟาร์มไอเท็มเรด" and getgenv().itemfarm == "Tomoe" and name == "uchiha_item" then
			getgenv().numberfarm = tonumber(getgenv().numberfarm) - amount
			if tonumber(getgenv().numberfarm) <= 1 then
				pcall(function () webhook_finish() end)
				
				return
			end
			task.wait(1)
			break
		elseif getgenv().modefarm == "ฟาร์มไอเท็มเรด" and getgenv().itemfarm == "Entertain Shard" and name == "entertainment_district_item" then
			getgenv().numberfarm = tonumber(getgenv().numberfarm) - amount
			if tonumber(getgenv().numberfarm) <= 1 then
				pcall(function () webhook_finish() end)
				return
			end
			task.wait(1)
			break
		elseif getgenv().modefarm == "ฟาร์มไอเท็มเรด" and getgenv().itemfarm == "Demon Shard" and name == "april_symbol" then
			getgenv().numberfarm = tonumber(getgenv().numberfarm) - amount
			if tonumber(getgenv().numberfarm) <= 1 then
				pcall(function () webhook_finish() end)
				return
			end
			task.wait(1)
			break
		elseif getgenv().modefarm == "ฟาร์มไอเท็มเรด" and getgenv().itemfarm == "Relic Shard" and name == "relic_shard" then
			getgenv().numberfarm = tonumber(getgenv().numberfarm) - amount
			if tonumber(getgenv().numberfarm) <= 0 then
				pcall(function () webhook_finish() end)
				return
			end
			task.wait(1)
			break
        elseif getgenv().modefarm == "ฟาร์มตาโกโจ" and getgenv().itemfarm == "SIX EYE" and name == "six_eyes" then
			getgenv().numberfarm = tonumber(getgenv().numberfarm) - amount
			if tonumber(getgenv().numberfarm) <= 0 then
				pcall(function () webhook_finish() end)
				return
			end
			task.wait(1)
			break
		end
	end

	print('Log 6')

	local portalsValue = ""
	local raidsValue = ""
	if demon_portal ~= 0 or alien_portal ~= 0 or devil_Academy ~= 0 then
		portalsValue = (
			(demon_portal ~= 0 and "<:Demon_Leaders_Portal:1087031381361700906> • Demon Leader's Portal: x" .. demon_portal .. "\n") or "") ..
			((alien_portal ~= 0 and "<:Alien_Portal:1094173284905533490> • Alien Portal: x" .. alien_portal .. "\n") or "") ..
			((devil_Academy ~= 0 and "<:demonAcademy:1093581550207111269> • Demon Academy Portal: x" .. devil_Academy .. "\n") or "")
	else
		portalsValue = ("❗️ไม่มีไอเท็ม 📦")
	end
	if alien_scouter ~= 0 or tomoe ~= 0 or relicShard ~= 0 or entertainShard ~= 0 or six_eye ~= 0 or demonShard ~= 0 then
		raidsValue = (
			(alien_scouter ~= 0 and "<:Alien_Scouter:1086919543034753114> • Alien Scouter: x" .. alien_scouter .. "\n") or "") ..
			((tomoe ~= 0 and "<:Tomoe:1086919541092790362> • Tomoe: x" .. tomoe .. "\n") or "") ..
			((relicShard ~= 0 and "<:relic_syn:1087136153334980798> • Relic Shard: x" .. relicShard .. "\n") or "") ..
			((entertainShard ~= 0 and "<:Wisteria_Bloom:1099264528853770271> • Entertain Shard: x" .. entertainShard .. "\n") or "") ..
			((six_eye ~= 0 and "<:Rikugan_Eye:1096869167002550282> • Rikugan Eye: x" .. six_eye .. "\n") or "") ..
			((demonShard ~= 0 and "<:EngVhzGImgur:1093249480154947726> • Demon Shard: x" .. demonShard .. "\n") or "")
	else
		raidsValue = ("❗️ไม่มีไอเท็ม 📦")
	end

	local infiniteTowerLevels = {}

	for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame.LevelButtons:GetChildren()) do
		if v.Name == "FloorButton" then
			if v.clear.Visible == false and v.Locked.Visible == false then
				local level = tonumber(v.Main.Text)
				table.insert(infiniteTowerLevels, level)
			end
		end
	end

	--#region คำนวน จะเสร็จตอนไหน

	-- if getgenv().modefarm == "ฟาร์มไก่เพชร" or getgenv().modefarm == "ฟาร์มเพชร" then
	-- 	task.wait(2)
	-- 	target_gem_reward = tonumber(getgenv().hookgem)
	-- 	print("===================")
	-- 	print(total_time)
	-- 	print(gem_reward)
	-- 	print(target_gem_reward)
	-- 	print("===================")
	-- 	gem_rewardX = tonumber(gem_reward:sub(2))
	-- 	minute, second = total_time:match("(%d+):(%d+)")
	-- 	total_time_seconds = tonumber(minute) * 60 + tonumber(second)
	-- 	gem_reward_per_second = gem_rewardX / total_time_seconds
	-- 	required_time_seconds = target_gem_reward / gem_reward_per_second
	-- 	days = math.floor(required_time_seconds / (24 * 60 * 60))
	-- 	remaining_seconds = required_time_seconds % (24 * 60 * 60)
	-- 	hours = math.floor(remaining_seconds / (60 * 60))
	-- 	remaining_seconds = remaining_seconds % (60 * 60)
	-- 	minutes = math.floor(remaining_seconds / 60)
	-- 	resultX = ""
	-- elseif getgenv().modefarm == "ฟาร์มเวลตัวละคร" then
	-- 	task.wait(2)
	-- 	user_level = tonumber(LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)
	-- 	target_level = tonumber(getgenv().hookgem)
	-- 	print("===================")
	-- 	print(total_time)
	-- 	print(gem_reward)
	-- 	print(target_level)
	-- 	print("===================")
	-- 	level_rewardX = tonumber(gem_reward:sub(2))
	-- 	minute, second = total_time:match("(%d+):(%d+)")
	-- 	total_time_seconds = tonumber(minute) * 60 + tonumber(second)
	-- 	level_reward_per_second = level_rewardX / total_time_seconds
	-- 	required_time_seconds = (target_level - user_level) / level_reward_per_second
	-- 	days = math.floor(required_time_seconds / (24 * 60 * 60))
	-- 	remaining_seconds = required_time_seconds % (24 * 60 * 60)
	-- 	hours = math.floor(remaining_seconds / (60 * 60))
	-- 	remaining_seconds = remaining_seconds % (60 * 60)
	-- 	minutes = math.floor(remaining_seconds / 60)
	-- 	resultX = ""
	-- elseif getgenv().modefarm == "ฟาร์มหอคอย" then
	-- 	task.wait(2)
	-- 	resultX = "ระบบไม่ซัพพอต"
	-- end
	

	-- if days > 0 then
	-- 	resultX = days .. " วัน "
	-- end
	-- if hours > 0 or (hours == 0 and days == 0) then
	-- 	resultX = resultX .. hours .. " ชั่วโมง "
	-- end
	-- if minutes > 0 or (minutes == 0 and hours == 0 and days == 0) then
	-- 	if days == 0 and hours == 0 then
	-- 		resultX = minutes .. " นาที"
	-- 	else
	-- 		resultX = resultX .. minutes .. " นาที"
	-- 	end
	-- end
	
	-- if minutes == 0 and hours == 0 and days == 0 then
	-- 	resultX = "อีกไม่นานจะเสร็จแล้ว"
	-- end

	-- if resultX == "ระบบไม่ซัพพอต" then
	-- 	resultX = "ระบบไม่ซัพพอต"
	-- end
	
	-- print(resultX)
	
	--#endregion
	
	print('Log 8')
	local embeds = {
		{
			["author"] = {
				["name"] = "🍀 一一一 Detail 一一一 🍀"
			},
			["title"] = "||" .. LocalPlayer.Name .. "||",
			["url"] = "https://www.roblox.com/users/" .. LocalPlayer.UserId,
			["color"] = 0xFF00FF,
			["thumbnail"] = {
				["url"] = get_user_img_url(),
			},
			["fields"] = {
				{
					["name"] = "ข้อมูลผู้เล่น",
					["value"] = "<:Gems:1086812238607822959> • เพชร: " .. total_gems .. "\n<:Level:1086831024421474324> • เลเวล: " .. user_level:split(" ")[2] .. " " .. user_level:split(" ")[3] .. "\n<:Battlepass:1099343337586171924> • แบทเทิลพาส: " .. tostring(0) .. "\n<:Gems:1086812238607822959> • เหลือที่ต้องฟาร์ม: " .. getgenv().hookgem,
					["inline"] = false
				},				
				{
					["name"] = "ไอเท็ม Raids",
					["value"] = raidsValue,
					["inline"] = false
				},
				{
					["name"] = "ไอเท็ม Portals",
					["value"] = portalsValue,
					["inline"] = false
				},
				{
					["name"] = "ข้อมูลการฟาร์ม",
					["value"] = "<:Map:1086829763802431590> • แมพ " .. GetCurrentLevelName() .. "\n<:Result:1086829004142673970> • ผลลัพธ์: " .. result .. "\n<:Wave:1086831936321892484> • จำนวนรอบ: " .. total_wave .. "\n<:Hourglass:1086827945261273108> • เวลา: " .. tostring(total_time) .. "\n<:Gems:1086812238607822959> • เพชร: " .. gem_reward .. "\n<:XP:1086893748656541696> • ค่าประสบการณ์: " .. xp_reward,
					["inline"] = false
				},
				{
					["name"] = "ไอเท็มที่ได้รับ",
					["value"] = "```ini\n" .. TextDropLabel .. "```",
					["inline"] = false
				}
			}
		}
	}
	
	return {
		["content"] = "",
		["username"] = "🎀  GGXSHOP  🎀",
		["avatar_url"] = "https://cdn.discordapp.com/attachments/1061192820179881985/1128823436941205564/GGxShop_2.png",
		["embeds"] = embeds
	}
end


function webhook()
	pcall(function()
		local url = tostring(getgenv().wh1)
		local data = update_data()
		local body = HttpService:JSONEncode(data)
		local headers = { ["content-type"] = "application/json" }
		request = http_request or request or HttpPost or syn.request or http.request
		local http = { Url = url, Body = body, Method = "POST", Headers = headers }
		request(http)
	end)
end

--#endregion

--#region [Function] Web Hook Finish
function update_data_Finish()
	Reset_Finish()
	getgenv().end_time = os.time()
	local itemDifference = getItemChangesNormal(getgenv().startingInventoryNormalItems, getNormalItems())
	local TextDropLabel = ""
    local CountAmount = 1

	for name, amount in pairs(itemDifference) do
		for code , nameCode in pairs(Table_All_Items_New_data) do
			if code == name then
				TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(nameCode["Name"]) .. " : " .. tostring(amount) .. "\n"
				CountAmount = CountAmount + 1
				break
			end
		end
	end

	if TextDropLabel == "" then
			TextDropLabel = "ไม่มีไอเท็มที่ได้รับ"
	end

	print('Log 1')
  user_level = tostring(LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)
	total_gems = tostring(LocalPlayer._stats.gem_amount.Value)
	gem_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
	trophy_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.TrophyReward.Main.Amount.Text)
	xp_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text):split(" ")[1]
	total_wave = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text):split(": ")[2]
	total_time = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text):split(": ")[2]
	result = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)

	local itemInventory = getNormalItems()
	local portal_name = getCSMPortals()
	local demon_portal = 0
	local alien_portal = 0
	local devil_Academy = 0


	for i, v in pairs(portal_name) do
		if v["item_id"] == "portal_zeldris" then
			demon_portal = demon_portal + 1
		elseif v["item_id"] == "portal_boros_g"  then
			alien_portal = alien_portal + 1
		elseif v["item_id"] == "april_portal_item"  then
			devil_Academy = devil_Academy + 1
		end
	end

	print('Log 2')

	if gem_reward == "+99999" then gem_reward = "+0" end
	if xp_reward == "+99999" then xp_reward = "+0" end
	if trophy_reward == "+99999" then trophy_reward = "+0" end
	if result == "VICTORY" then
			result = "ชัยชนะ"
	else
			result = "พ่ายแพ้"
	end
	if getgenv().modefarm == "ฟาร์มเพชร" then
			gem_reward = tostring(LocalPlayer.PlayerGui.Waves.HealthBar.IngameRewards.GemRewardTotal.Holder.Main.Amount.Text)
			total_wave = tostring(Workspace["_wave_num"].Value)
			total_time = disp_time(os.difftime(getgenv().end_time, getgenv().start_time))
	end


    return {
    ["content"] = "",
    ["username"] = "GGXSHOP",
    ["avatar_url"] = "https://cdn.discordapp.com/attachments/1061192820179881985/1128823436941205564/GGxShop_2.png",
    ["embeds"] = {
        {
        ["author"] = {
            ["name"] = "🍀 一一一 ฟาร์มเสร็จแล้ว 一一一 🍀"
        },
        ["title"] ="||"..LocalPlayer.Name.."||",
        ["url"] = "https://www.roblox.com/users/"..LocalPlayer.UserId,
        ["color"] = 0xFF00FF,
        ["thumbnail"] = {
            ["url"] = get_user_img_url(),
        },
        ["fields"] = {
            {
							["name"] ="ข้อมูลผู้เล่น",
							["value"] = "<:Gems:1086812238607822959> • เพชร: " .. total_gems .. "\n<:Level:1086831024421474324> • เลเวล: " .. user_level:split(" ")[2] .. " " .. user_level:split(" ")[3] .. "\n<:BattlePass:1086896921723027537> • แบทเทิลพาส: " .. tostring(0),
							["inline"] = false
            }
        },
				["image"] = {
            ["url"] = "https://cdn.discordapp.com/attachments/1051730221608472666/1098273873469911090/image_1.png",
          }
        }
    }
	}
end

function webhook_finish()
	getgenv().lastpotision = "Success"
	update_ssX(
		getgenv().startfarm,
		LocalPlayer.Name,
		getgenv().modefarm,
		getgenv().itemfarm,
		getgenv().numberfarm,
		getgenv().replay,
		getgenv().whitesc,
		getgenv().codeget,
		getgenv().buyunit,
		getgenv().sellunit,
		getgenv().bp,
		getgenv().wh1,
		getgenv().wh2,
		getgenv().lastpotision,
		getgenv().locationmap
	)
    pcall(function()
        local url = tostring(getgenv().wh2)
        local data = update_data_Finish()
        local body = HttpService:JSONEncode(data)
        local headers = { ["content-type"] = "application/json" }
        request = http_request or request or HttpPost or syn.request or http.request
        local http = { Url = url, Body = body, Method = "POST", Headers = headers }
        request(http)
				task.wait(2)
				task.wait(2)
				game:Shutdown()
    end)
end
--#endregion

--#=======================================================================

--#region PjxInit
function PjxInit()
    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)
    getgenv().SelectedUnits = data.xselectedUnits or {}

    function updatejson()
        local xdata = {
            xselectedUnits = getgenv().SelectedUnits,
        }
        local json = HttpService:JSONEncode(xdata)
        writefile(savefilename, json)
    end
end

function PjxInit_newuser()
    pcall(function()
        local response_new = HttpService:JSONDecode(game:HttpGet(host..'/getdata.php?q='.. LocalPlayer.Name ..''))
        for i, v in pairs(response_new.data) do
            idplayer = v.idplayer
        end
    end)

    if LocalPlayer.Name == idplayer then
        return nil
    end

    if game.PlaceId == 8304191830 then -- Battle Pass
        pcall(function()
            repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text ~= "99"
            levelBattlepass = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text
        end)
    end

    getgenv().startfarm = "false"
    getgenv().modefarm = "เลือกโหมดที่ต้องการฟาร์ม"
    getgenv().itemfarm = "เลือกไอเท็มเรท"
    getgenv().whitesc = "false"
    getgenv().numberfarm = "0"
    getgenv().resultGems = 0
    getgenv().sellunit = "false"
    getgenv().buyunit = "false"
    getgenv().codeget = "false"
    getgenv().replay = "false"
    getgenv().bp = levelBattlepass
    getgenv().wh1 = "https://ptb.discord.com/api/webhooks/1101553771663868055/LxQbGxqRQgqv5qu45IdUWvfSzI9Dm0Jxpa-MvMs39XCjtZLgsCyCQXxwhhCaonCodIvs"
    getgenv().wh2 = "https://ptb.discord.com/api/webhooks/1101553908901498994/i2xNsFDQuSUTi5NVhcvn_ZrFWnRDe9QxYtC-wS1cwwqDYaJq-TMg8Hp1VBSFgd0ZlrxU"
		update_ssX(
			getgenv().startfarm,
			LocalPlayer.Name,
			getgenv().modefarm,
			getgenv().itemfarm,
			getgenv().numberfarm,
			getgenv().replay,
			getgenv().whitesc,
			getgenv().codeget,
			getgenv().buyunit,
			getgenv().sellunit,
			getgenv().bp,
			getgenv().wh1,
			getgenv().wh2,
			getgenv().lastpotision,
			getgenv().locationmap
		)
end


--#endregion

--#region Init White Screen
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.Enabled = getgenv().check_whiteSS
screenGui.Parent = playerGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textLabel.Font = Enum.Font.GothamSemibold
if game.PlaceId == 8304191830 then
	textLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
else
	textLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
end
textLabel.Text = LocalPlayer.Name
textLabel.TextSize = 28
textLabel.Parent = screenGui
local loadingRing = Instance.new("ImageLabel")
loadingRing.Size = UDim2.new(0, 256, 0, 256)
loadingRing.BackgroundTransparency = 1
loadingRing.Image = "rbxassetid://4965945816"
loadingRing.AnchorPoint = Vector2.new(0.5, 0.5)
loadingRing.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingRing.Parent = screenGui

-- Remove the default loading screen
ReplicatedFirst:RemoveDefaultLoadingScreen()
RunService:Set3dRenderingEnabled(not getgenv().check_whiteSS)
local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
local tween = TweenService:Create(loadingRing, tweenInfo, {Rotation = 360})
tween:Play()
function toggleLoadingScreen()
	screenGui.Enabled = getgenv().check_whiteSS
	
	-- local guidelete = game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()
	-- for i, value in pairs(guidelete) do
	-- 	value:Destroy()
	-- end

	-- local listgui = game:GetService("CoreGui"):GetChildren()
	-- for i, value in pairs(listgui) do
	-- 	if value == "BubbleChat" or value == "PlayerList" then
	-- 		value:Destroy()
	-- 	end
	-- end
end

-- Remove the default loading screen
ReplicatedFirst:RemoveDefaultLoadingScreen()

--#endregion

--#region F1 Whitesc

local WHITESCZ = false

UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.F1 and not processed then
        WHITESCZ = not WHITESCZ
        RunService:Set3dRenderingEnabled(not WHITESCZ)
        print(WHITESCZ and "ON" or "OFF")
        whitesc = tostring(WHITESCZ)
        update_ssX(
            getgenv().startfarm,
            LocalPlayer.Name,
            getgenv().modefarm,
            getgenv().itemfarm,
            getgenv().numberfarm,
            getgenv().replay,
            whitesc,
            getgenv().codeget,
            getgenv().buyunit,
            getgenv().sellunit,
            getgenv().bp,
            getgenv().wh1,
            getgenv().wh2,
            getgenv().lastpotision,
			getgenv().locationmap
        )
        getgenv().check_whiteSS = WHITESCZ
        toggleLoadingScreen()
    end
end)



--#endregion

--#region F5 RESTART

UserInputService.InputBegan:Connect(function(input, processed)
		if (input.KeyCode == Enum.KeyCode.F5 and not processed) then
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		end
end)

--#endregion

--#region F2 Buy Unit

local buyunitX = false
UserInputService.InputBegan:Connect(function(input, processed)
        if (input.KeyCode == Enum.KeyCode.F2 and not processed) then
			if buyunitX then
				buyunitX = false
				getgenv().buyunit = "false"
			else
				buyunitX = true
				getgenv().buyunit = "true"
			end
        end
end)

--#endregionn

--#region Check File JSon WorkSpace

if isfile(savefilename) then
	pcall(function()
		local jsonData = readfile(savefilename)
		local data = HttpService:JSONDecode(jsonData)
	end)
	PjxInit()
else
	local xdata = {
		xselectedUnits = {}
	}
	local json = HttpService:JSONEncode(xdata)
	writefile(savefilename, json)
	PjxInit()
end

--#endregion

--#region Update_setting
function update_setting()
    local response_new = HttpService:JSONDecode(game:HttpGet(host .. '/getdata.php?q=' .. LocalPlayer.Name .. ''))
    for i, v in pairs(response_new.data) do
        getgenv().idplayer = v.idplayer
        getgenv().startfarm = v.startfarm
        getgenv().modefarm = v.modefarm
        getgenv().itemfarm = v.itemfarm
        getgenv().whitesc = v.whitesc
        getgenv().numberfarm = v.numberfarm
        getgenv().sellunit = v.sellunit
        getgenv().buyunit = v.buyunit
        getgenv().codeget = v.codeget
        getgenv().replay = v.replay
        getgenv().bp = v.bp
        getgenv().wh1 = v.wh1
        getgenv().wh2 = v.wh2
    end
		
    update_ssX(
        getgenv().startfarm,
        LocalPlayer.Name,
        getgenv().modefarm,
        getgenv().itemfarm,
        getgenv().numberfarm,
        getgenv().replay,
        getgenv().whitesc,
        getgenv().codeget,
        getgenv().buyunit,
        getgenv().sellunit,
        getgenv().bp,
        getgenv().wh1,
        getgenv().wh2,
        getgenv().lastpotision,
				getgenv().locationmap
    )
    getgenv().check_whiteSS = (getgenv().whitesc == "true")
    RunService:Set3dRenderingEnabled(not getgenv().check_whiteSS)
    toggleLoadingScreen()
end


print("986")
PjxInit_newuser()
update_setting()

--#endregion

--#region ReedemCode

function RedeemCode()
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "<-- RedeemCode -->", -- Required
		Text = "กำลังทำงาน..", -- Required
		Icon = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=180&h=180 true";
		Duration = 2
	})
    local codes = {
        "TWOMILLION",
        "subtomaokuma",
        "CHALLENGEFIX",
        "GINYUFIX",
        "RELEASE",
        "SubToKelvingts",
        "SubToBlamspot",
        "KingLuffy",
        "TOADBOIGAMING",
        "noclypso",
        "FictioNTheFirst",
        "GOLDENSHUTDOWN",
        "GOLDEN",
        "SINS2",
        "subtosnowrbx",
        "Cxrsed",
        "VIGILANTE",
        "HAPPYEASTER",
        "ENTERTAINMENT",
        "DRESSROSA",
        "BILLION",
        "MADOKA",
        "AINCRAD",
        "SINS",
        "HERO",
        "UCHIHA",
        "CLOUD",
        "CHAINSAW",
        "NEWYEAR2023"
    }

    for _, code in ipairs(codes) do
        pcall(function()
            game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_code:InvokeServer(code)
        end)
    end
end

if game.PlaceId == 8304191830 then
	if getgenv().codeget == "true" then
		print("RedeemCode")
		RedeemCode()
		wait(5)
		getgenv().codeget = "false"
		wait(1)
		update_ssX(
			getgenv().startfarm,
			LocalPlayer.Name,
			getgenv().modefarm,
			getgenv().itemfarm,
			getgenv().numberfarm,
			getgenv().replay,
			getgenv().whitesc,
			getgenv().codeget,
			getgenv().buyunit,
			getgenv().sellunit,
			getgenv().bp,
			getgenv().wh1,
			getgenv().wh2,
			getgenv().wh2.lastpotision,
			getgenv().locationmap
		)
	end
end

--#endregion

--#region Auto update

coroutine.resume(coroutine.create(function()
	while wait(10) do
		if game.PlaceId == 8304191830 then
			update_setting()
		end
	end
end))

--#endregion

--#region Autobuy unit

local function autobuyfunc(xx, item)
	task.wait()
	local args = {
		[1] = xx,
		[2] = item,
	}
	game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_from_banner:InvokeServer(unpack(args))
end

coroutine.resume(coroutine.create(function()
	while true do
		if getgenv().buyunit == "true" then
			if game.PlaceId == 8304191830 then
				game:GetService("StarterGui"):SetCore("SendNotification",{
					Title = "<-- AUTO BUY -->", -- Required
					Text = "กำลังทำงาน..", -- Required
					Icon = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=180&h=180 true";
					Duration = 2
				})
				while getgenv().buyunit == "true" do
					autobuyfunc("EventClover", "gems10")
					task.wait()
				end
			end
		end
		task.wait()
	end
end))

--#endregion

--#region Plate Unit

function auto_place_units(position)
	math.randomseed(os.time())
	for i = 1, 6 do
			local unit_data = getgenv().SelectedUnits[i]
			if unit_data ~= nil then
				local unit_id = unit_data:split(" #")[2]
				local unit_name = unit_data:split(" #")[1]
				print(i..' plate unit Funcition')
				if unit_name ~= "metal_knight_evolved" then
					-- place ground unit
					unitPostion = math.random(2,3)
					randomSpaw = math.random(-5,5)
					local args = {}
					if position[1] then
						args[1] = unit_id
					  	args[2] = CFrame.new(position[1].x + randomSpaw, position[1].y, position[1].z + randomSpaw) * CFrame.Angles(0, -0, -0)
					end					
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					-- place hill unit
					local args = {
						[1] = unit_id,
						[2] = CFrame.new(position[unitPostion].x + randomSpaw, position[unitPostion].y, position[unitPostion].z + randomSpaw) * CFrame.Angles(0, -0, -0)
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

				elseif unit_name == "metal_knight_evolved" then
					-- place hill unit
					unitPostion = math.random(2,3)
					randomSpaw = math.random(-5,5)
					task.spawn(function()
						local args = {
							[1] = unit_id,
							[2] = CFrame.new(position[unitPostion].x + randomSpaw, position[unitPostion].y, position[unitPostion].z + randomSpaw) * CFrame.Angles(0, -0, -0)
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					end)
				end
			end
	end
end

function get_level_data()
	local list = {}
	for i, v in pairs(game.Workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()) do
		list[i] = v
	end
	return list
end
if game.PlaceId ~= 8304191830 then
	getgenv().getmaps = get_level_data().map
end

coroutine.resume(coroutine.create(function()
	while task.wait(1) do
		local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
		if game.PlaceId ~= 8304191830 then
			for i, v in ipairs(game.Workspace["_UNITS"]:GetChildren()) do
				if v:FindFirstChild("_stats") then
					if v._stats.player.Value == nil then
						pos_x = v.HumanoidRootPart.Position.X
						pos_z = v.HumanoidRootPart.Position.Z
						break
					end
				end
			end

			if getgenv().getmaps:match('namek_cartoon') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 91.80, z = pos_z }, -- ground unit position
					[2] = { x = -2959.61, y = 94.53, z = -696.83 }, -- hill unit position
					[3] = { x = -2952.06, y = 94.41, z = -721.40 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('aot') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 33.74, z = pos_z }, -- ground unit position
					[2] = { x = -3026.78, y = 38.41, z = -677.81 }, -- hill unit position
					[3] = { x = -3019.03, y = 38.41, z = -689.49 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('demonslayer') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 34.34, z = pos_z }, -- ground unit position
					[2] = { x = -2876.02, y = 37.24, z = -150.81 }, -- hill unit position
					[3] = { x = -2879.09, y = 39.57, z = -124.25 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('naruto') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 25.28, z = pos_z }, -- ground unit position
					[2] = { x = -910.64, y = 33.14, z = 294.41 }, -- hill unit position
					[3] = { x = -893.90, y = 29.56, z = 318.74 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('marineford') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 25.21, z = pos_z }, -- ground unit position
					[2] = { x = -2571.46, y = 29.50, z = -49.31 }, -- hill unit position
					[3] = { x = -2581.62, y = 28.35, z = -66.97 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('tokyo_ghoul') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 58.58, z = pos_z }, -- ground unit position
					[2] = { x = -2985.60, y = 66.70, z = -54.09 }, -- hill unit position
					[3] = { x = -2956.22, y = 62.82, z = -49.40 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('hueco') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 132.66, z = pos_z }, -- ground unit position
					[2] = { x = -184.33, y = 136.34, z = -757.71 }, -- hill unit position
					[3] = { x = -174.58, y = 136.34, z = -710.48 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('hxhant') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 23.01, z = pos_z }, -- ground unit position
					[2] = { x = -145.86, y = 26.72, z = 2965.56 }, -- hill unit position
					[3] = { x = -191.47, y = 27.20, z = 2952.01 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('magnolia') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 6.74, z = pos_z }, -- ground unit position
					[2] = { x = -596.36, y = 13.99, z = -824.33 }, -- hill unit position
					[3] = { x = -586.75, y = 13.88, z = -824.23 }, -- hill unit position
				})
			elseif getgenv().getmaps:match("jjk") then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 122.061, z = pos_z }, -- ground unit position
					[2] = { x = 390.69, y = 124.44, z = -79.02 }, -- hill unit position
					[3] = { x = 390.69, y = 124.44, z = -79.02 },
				})
			elseif getgenv().getmaps:match('hage') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 1.23, z = pos_z }, -- ground unit position
					[2] = { x = -161.98, y = 5.03, z = -43.10 }, -- hill unit position
					[3] = { x = -122.39, y = 4.86, z = -43.87 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('space_center') then
				print(getgenv().getmaps)
				auto_place_units({
						[1] = { x = pos_x, y = 15.25, z = pos_z }, -- ground unit position
						[2] = { x = -104.66, y = 19.62, z = -524.07 }, -- hill unit position
						[3] = { x = -106.91, y = 19.62, z = -524.60 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('boros_ship') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 361.21, z = pos_z }, -- ground unit position
					[2] = { x = -336.19, y = 365.26, z = 1389.11 }, -- hill unit position
					[3] = { x = -336.18, y = 365.26, z = 1391.78 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('7ds_map') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 212.96, z = pos_z }, -- ground unit position
					[2] = { x = -87.39, y = 216.99, z = -214.06 }, -- hill unit position
					[3] = { x = -102.37, y = 219.20, z = -204.66 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('mha_city') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = -13.24, z = pos_z }, -- ground unit position
					[2] = { x = -31.49, y = -10.02, z = 21.95 }, -- hill unit position
					[3] = { x = -54.03, y = -8.89, z = 3.62 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('dressrosa') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 2.60, z = pos_z }, -- ground unit position 
					[2] = { x = -35.40, y = 5.98, z = -201.43 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = -35.40, y = 5.98, z = -201.43 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
				})
			elseif getgenv().getmaps:match('sao') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y =  37.53, z = pos_z }, -- ground unit position 
					[2] = { x = 101.85, y = 41.67, z = 16.34 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = 105.29, y = 41.67, z = 16.93}, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
				})
			elseif getgenv().getmaps:match('berserk') then
				auto_place_units({
					[1] = { x = pos_x, y =  -0.074, z = pos_z }, -- ground unit position 
					[2] = { x = -252.30, y = 3.54, z = 20.98 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = -241.66, y = 3.54, z = 17.30}, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
				})
			-- RAID --
			elseif getgenv().getmaps:match('uchiha_hideout_final') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 536.89, z = pos_z }, -- ground unit position
					[2] = { x = 304.59, y = 539.89, z = -588.45 }, -- hill unit position
					[3] = { x = 267.66, y = 539.89, z = -560.54 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('west_city_frieza') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 19.76, z = pos_z }, -- ground unit position
					[2] = { x = -2334.15, y = 31.41, z = -79.33 }, -- hill unit position
					[3] = { x = -2339.57, y = 32.03, z = -90.32 }, -- hill unit position
				})
			elseif getgenv().getmaps:match('entertainment_district') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 495.600, z = pos_z }, -- ground unit position 
					[2] = { x = -130.05, y = 504.78, z = -93.73 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = -97.27, y = -97.27, z = -92.03 }, -- hill unit position -97.27552032470703, 500.6242980957031, -92.03937530517578
				})
			elseif getgenv().getmaps:match('mha_city_night') then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y =  -13.24, z = pos_z }, -- ground unit position 
					[2] = { x = -55.57, y = -8.89, z = 3.31 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = -50.44, y = -8.89, z = 3.05}, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
				})
			--///Legend Stages\\\--- 
			elseif getgenv().getmaps:match("karakura") then
				print(getgenv().getmaps)
				auto_place_units({
					[1] = { x = pos_x, y = 36.04, z = pos_z }, -- ground unit position
					[2] = { x = -212.72, y = 46.03, z = 598.99 }, -- hill unit position
					[3] = { x = -212.72, y = 46.03, z = 598.99 }, -- hill unit position
				})
			end
		end
	end
end))
--Puppet Island
--#endregion 

--#region SelectUnit

coroutine.resume(coroutine.create(function()
    if game.PlaceId == 8304191830 then
        handle_select_units()
        local collection = plr.PlayerGui:WaitForChild("collection")
        collection:GetPropertyChangedSignal("Enabled"):Connect(function()
        if collection.Enabled == false then
            handle_select_units()
        end
        end)
    end
end))
--#endregion

--#region Auto Upgrade

coroutine.resume(coroutine.create(function()
	while task.wait(0) do
		if game.PlaceId ~= 8304191830 then
			local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
			if _wave.Value >= 4 then
				pcall(function() --///
					repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
					for _, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
						if v:FindFirstChild("_stats") then
							if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
								if v.Name == "wendy" or v.Name == "wendy:shiny" or v.Name == "sakura" then
									-- print(v.Name)
								else
									game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
								end
							end
						end
					end
				end)
			end
		end
	end
end))

--#endregion 

--#region Fram Story
tp_check = true
local function startfarming_Story()
	if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มสตอรี่" or getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มไก่เพชร" then
		if game.PlaceId == 8304191830 then
			task.wait(5)
			local cpos = plr.Character.HumanoidRootPart.CFrame
			if tp_check then
				for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetChildren()) do
					check_door = tostring(game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Owner.Value)
					if check_door == "nil"  then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Door.CFrame * CFrame.new(0, 0, 1)
						wait(1)
						--// Check ShickenFram
						local checkNaamek = game:GetService("Players").LocalPlayer.PlayerGui.LevelSelectGui.MapSelect.Main.Wrapper.Container.namek.Main.Container.LevelsCleared.V.Text
						if checkNaamek == "6/6" and getgenv().modefarm == "ฟาร์มไก่เพชร" then
							getgenv().modefarm = "ฟาร์มเพชร"
							updatejson()
							wait(2)
							--game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
						end
						--//---------------------
						broke = false
						for g, j in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.LevelSelectGui.MapSelect.Main.Wrapper.Container :GetChildren()) do
							if j:IsA("ImageButton") then
								if j.Name == "ComingSoon" then
								else
									local ClearStory = j.Main.Container.LevelsCleared:GetChildren()
									for l, s in pairs(ClearStory) do
										if s.Name == "V" then
											chLevel = s.Text
											waves = chLevel:split("/")
											if waves[1] == "6" then
												wait(1)
											else
												
												st_farm = j.Name .. "_level_" .. waves[1] + 1
												broke = true
												wait(1)
												local args = {
													[1] = tostring(v.Name), -- Lobby
													[2] = tostring(st_farm), -- World
													[3] = true, -- Friends Only or not
													[4] = "Normal",
												}
												game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
												task.wait(5)
												local args = {
													[1] = tostring(v.Name),
												}
												game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
												break
											end
										end
									end
								end
							end
							if broke then
								break
							end
						end
						tp_check = false
						break
					end
				end
			end
			wait(2)
		end
	end
end
--#endregion
--#region Select Mode
coroutine.resume(coroutine.create(function()
	while task.wait() do
		-- Not Lobbies
		if game.PlaceId ~= 8304191830 then
			break
		end
		--#region Farm Story
		if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มสตอรี่" or getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มไก่เพชร" then
			startfarming_Story()
		end
		--#endregion
		--#region Farm Gem
		if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มเพชร" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
						if v.Name == "Owner" and v.Value == nil then
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
							task.wait(4)
							if getgenv().modefarm == "ฟาร์มเพชร" then
								local args = {
									[1] = tostring(v.Parent.Name), -- Lobby
									[2] = "namek_infinite", -- World
									[3] = true, -- Friends Only or not
									[4] = "Hard",
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
							end
							task.wait(2)
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							getgenv().door = v.Parent.Name
							plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
							break
						end
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion
		--#region Farm Gojo
		if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มตาโกโจ" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
						if v.Name == "Owner" and v.Value == nil then
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
							task.wait(4)
							if getgenv().modefarm == "ฟาร์มตาโกโจ" then
								local args = {
									[1] = tostring(v.Parent.Name), -- Lobby
									[2] = "jjk_infinite", -- World
									[3] = false, -- Friends Only or not
									[4] = "Hard",
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
							end
							task.wait(2)
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							getgenv().door = v.Parent.Name
							plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
							break
						end
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion
		--#region Farm BattlePass
		if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์ม BattlePass" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
						if v.Name == "Owner" and v.Value == nil then
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
							task.wait(4)
							
								local args = {
									[1] = tostring(v.Parent.Name), -- Lobby
									[2] = "namek_infinite", -- World
									[3] = false, -- Friends Only or not
									[4] = "Hard",
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
							
							task.wait(2)
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							getgenv().door = v.Parent.Name
							plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
							break
						end
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion
	
		--#region Farm Level Players
		if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มเวลตัวละคร" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
						if v.Name == "Owner" and v.Value == nil then
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
							task.wait(4)
							local args = {
								[1] = tostring(v.Parent.Name),
								[2] = "namek_level_1",
								[3] = false,
								[4] = "Normal",
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
							task.wait(2)
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							getgenv().door = v.Parent.Name
							plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
							break
						end
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion
	
		--#region Farm Clstel

		if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มหอคอย" then
			if game.PlaceId == 8304191830 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 12423.1855, 155.24025, 3198.07593, -1.34111269e-06, -2.02512282e-08, 1, 3.91705386e-13, 1, 2.02512282e-08, -1, 4.18864542e-13, -1.34111269e-06 )
				getgenv().infinityroom = 0
				for i, v in pairs( game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame.LevelButtons :GetChildren() ) do
					if v.Name == "FloorButton" then
						if v.clear.Visible == false and v.Locked.Visible == false then
							local room = string.split(v.Main.text.Text, " ")
	
							local args = {
								[1] = tonumber(room[2]),
							}
	
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower :InvokeServer(unpack(args))
							getgenv().infinityroom = tonumber(room[2])
							break
						end
					end
				end
				task.wait(6)
			end
		else
			if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มหอคอย" then
				if game.PlaceId == 8304191830 then
					local args = {
						[1] = "_lobbytemplate_event330",
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby :InvokeServer(unpack(args))
					task.wait(5)
				end
			end
		end
		--#endregion
		
		--#region Farm Frust
		if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มผลไม้" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				for i, v in pairs(game:GetService("Workspace")["_CHALLENGES"].Challenges:GetDescendants()) do
					if v.Name == "Owner" and v.Value == nil then
						local args = {
							[1] = tostring(v.Parent.Name),
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
						getgenv().chdoor = v.Parent.Name
						break
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion
	end
end))
--#endregion

--#region Teleport in Wave
local function amReplay()
	while task.wait() do
		if game.PlaceId ~= 8304191830 then
			if getgenv().replay == "true" then
				-- sell unit
				repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
				for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
					repeat task.wait() until v:WaitForChild("_stats")
					if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
						repeat task.wait() until v:WaitForChild("_stats"):WaitForChild("upgrade")
						game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
					end
				end
				--
			end
		end
	end
end


coroutine.resume(coroutine.create(function()
	while task.wait(5) do
		local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
		if game.PlaceId ~= 8304191830 then
			--#region Teleport Gem
			levePlayers = LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text
			levelCheck = levePlayers:split(" ")
			print(getgenv().startfarm)
			print(getgenv().modefarm)
			if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มเพชร" and tonumber(levelCheck[2]) <= tonumber(50) and tonumber(_wave.Value) >= tonumber(15) then
				if tonumber(getgenv().numberfarm) <= 0 then
					pcall(function () webhook_finish()  end)
					task.wait(3)
					game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					break
				else
					if getgenv().replay == "true" then
						amReplay()
						break
					else
						pcall(function () webhook()  end)
						task.wait(3)
						game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
						break
					end
				end
			end

			if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มเพชร" and  _wave.Value >= 25 then
				if getgenv().replay == "true" then
					amReplay()
					break
				else
					pcall(function () webhook()  end)
					task.wait(3)
					game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					break
				end
			end

			if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มตาโกโจ" and tonumber(_wave.Value) >= tonumber(31)  then
				if tonumber(getgenv().numberfarm) <= 0 then
					pcall(function () webhook_finish()  end)
					task.wait(3)
					game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					break
				else
					if getgenv().replay == "true" then
						amReplay()
						break
					else
						pcall(function () webhook()  end)
						task.wait(3)
						game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
						break
					end
				end
			end
			--#endregion
		end
	end
end))
--#endregion

--#region Farm BattlePass

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์ม BattlePass" and tonumber(_wave.Value) >= tonumber(55)  then
			if tonumber(getgenv().numberfarm) <= tonumber(getgenv().BattlePass) then
				pcall(function () webhook_finish()  end)
			else
				pcall(function () webhook()  end)
			end
			task.wait(3)
			--game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		end
	end
end))

--#endregion

--#region GameFinished Auto

local function gameisFinishAuto()
	--// Next Story --//
	task.wait(4)

	-- // Raid // --
	if getgenv().modefarm == "ฟาร์มไอเท็มเรด" then
		task.wait(3)
		pcall(function() webhook() end)
		if getgenv().replay == "true" then
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			for i = 1, 180 do
				warn("Game restart in : " .. i)
				task.wait(1)
			end
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			for i = 1, 60 do
				warn("game Shutdown in : " .. i)
				task.wait(1)
			end
			game:Shutdown()
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
	end

	if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มสตอรี่" then
		pcall(function() webhook() end)
		while task.wait(5) do
			local args = {
				[1] = "next_story"
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
		end
		wait(99)
	end

	if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มไก่เพชร" then
		pcall(function() webhook() end)
		while task.wait(5) do
			local checkMAp = game:GetService("Workspace")._map:FindFirstChild("namek mushroom model")
			local aceCheck = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelName
			local resultx = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)
			
			if checkMAp then

				if aceCheck == "Act 6 - The Purple Tyrant" then
					if resultx == "VICTORY" then
						getgenv().modefarm = "ฟาร์มเพชร" 
						updatejson()
						game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					else
						local a = { [1] = "replay" }
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						wait(99)
					end
				else

					if resultx == "VICTORY" then
						local args = {
							[1] = "next_story"
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
					else
						local a = { [1] = "replay" }
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						wait(99)
					end
				end
			else
				getgenv().modefarm = "ฟาร์มเพชร" 
				updatejson()
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			end
		end
		wait(99)
	end
	-- // Gems // --
	if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มเพชร" then
		task.wait()
		if tonumber(getgenv().numberfarm) <= 0 then
			pcall(function () webhook_finish()  end)
			task.wait(3)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			task.wait(99)
		end
		pcall(function() webhook() end)
		if getgenv().AutoReplay then
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		for i = 1, 180 do
			warn("Game restart in : " .. i)
			task.wait(1)
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		for i = 1, 60 do
			warn("game Shutdown in : " .. i)
			task.wait(1)
		end
		game:Shutdown()
	end

	--// Level Players --//
	if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มเวลตัวละคร" then
		levePlayers = LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text
		levelCheck = levePlayers:split(" ")
		if tonumber(levelCheck[2]) >= tonumber(getgenv().numberfarm) then
			pcall(function() webhook_finish() end)
			task.wait(3)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		else
			pcall(function() webhook() end)
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			wait(99)
		end
	end
	-- Castle

	if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มหอคอย" then
		task.wait(5)
		local resultx = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)
		infTower_check = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelName.Text
		infinityTower = infTower_check:split(" ")
		
		if resultx == "VICTORY" then
			if tonumber(infinityTower[4]) >= tonumber(getgenv().numberfarm) then
				pcall(function() webhook_finish() end)
			else
				pcall(function() webhook() end)
				game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
				game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
				wait(99)
			end
		else
			game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
			game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
			wait(99)
		end
	end

	-- Fruit
	if getgenv().startfarm == "true" and getgenv().modefarm == "ฟาร์มผลไม้" then
		pcall(function() webhook() end)
		task.wait(3)
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
	end

	-- // Replay // --
	if getgenv().AutoReplay then
		task.wait()
		pcall(function() webhook() end)
		local a = { [1] = "replay" }
		game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
		game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
		for i = 1, 180 do
			warn("Game restart in : " .. i)
			wait(1)
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		wait(99)
	end
	-- // Exit Room //--
	if getgenv().modefarm == "เลือกโหมดที่ต้องการฟาร์ม"  then
		task.wait()
		pcall(function() webhook() end)
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		for i = 1, 180 do
			warn("Game restart in : " .. i)
			task.wait(1)
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
	end

end

coroutine.resume(coroutine.create(function()
	local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
	GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
		if GameFinished.Value == true then
			wait(2)
			gameisFinishAuto()
		end
	end)
end))

--#endregion

--#region Auto Sell Units Shop Mystick

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if getgenv().sellunit == "true" then
			local hahaUnitXD = false
			for i, v in ipairs(game:GetService("ReplicatedStorage")["_FX_CACHE"]:GetChildren()) do
				if v.Name == "CollectionUnitFrame" then
					repeat task.wait() until v:FindFirstChild("name")
					for _, Info in next, getgenv().UnitCache do
						--#if Info.name == v.name.Text and Info.rarity == "Rare" or Info.name == v.name.Text and Info.rarity == "Epic" then
						if Info.name == v.name.Text and Info.rarity == "Rare" then
							hahaUnitXD = true
							if getgenv().sellunit == "true" then
								local args = {
									[1] = {
										[1] = tostring(v._uuid.Value),
									},
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_units:InvokeServer(unpack(args))
							end
						end
					end
				end
			end
			if not hahaUnitXD then
				sellunitES = "false"
				update_ssX(
					getgenv().startfarm,
					LocalPlayer.Name,
					getgenv().modefarm,
					getgenv().itemfarm,
					getgenv().numberfarm,
					getgenv().replay,
					getgenv().whitesc,
					getgenv().codeget,
					getgenv().buyunit,
					sellunitES,
					getgenv().bp,
					getgenv().wh1,
					getgenv().wh2,
					getgenv().lastpotision,
					getgenv().locationmap
				)
			end			
		end
	end
end))


--#endregion

--#region Teleport to Friends

-- coroutine.resume(coroutine.create(function()
-- 	while task.wait(5) do
-- 		if game.PlaceId == 8304191830 then
-- 			if getgenv().warpfriend then
-- 				local nameList = listFriends()
-- 				for _, f_name in pairs(nameList) do
-- 					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetChildren()) do
-- 							checkOwner = tostring(game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Owner.Value)
-- 							if checkOwner == tostring(f_name) then
-- 								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Door.CFrame * CFrame.new(0, 0, 1)
-- 								task.wait(3)
-- 							end
-- 					end
-- 					for _, v in pairs(game:GetService("Workspace")["_RAID"].Raid:GetChildren()) do
-- 						checkOwner = tostring(game:GetService("Workspace")["_RAID"].Raid[v.Name].Owner.Value)
-- 						if checkOwner == tostring(f_name) then
-- 							task.wait(3)
-- 							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_RAID"].Raid[v.Name].Door.CFrame * CFrame.new(0, 0, 1)
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end))

--#endregion

--#region Anti AFK

coroutine.resume(coroutine.create(function()
    while task.wait(600) do
        pcall(function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                local randomPosition = Vector2.new(math.random(), math.random())
                vu:Button2Down(randomPosition, workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(randomPosition, workspace.CurrentCamera.CFrame)
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(0, math.rad(10), 0)
            end)
        end)
    end
end))


coroutine.resume(coroutine.create(function()
    while task.wait(300) do
        pcall(function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end)
    end
end))

--#endregion

--#region Aoto JoinPortal

-- local autoportalX = (getgenv().autoportal == "true")
-- coroutine.resume(coroutine.create(function()
--     while task.wait() do
--         if game.PlaceId == 8304191830 then
--             if autoportalX then 
-- 				game:GetService("StarterGui"):SetCore("SendNotification",{
-- 					Title = "<-- AutoPortal -->", -- Required
-- 					Text = "<>--<>", -- Required
-- 					Icon = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=180&h=180 true";
-- 					Duration = 5
-- 				})
--                 for i, v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetChildren()) do
--                     local args = {
--                         [1] = tostring(v.Name),
--                     }
--                     game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
--                     task.wait(3) 
--                 end
--                 task.wait(5) --// Wait New Loop 
--             end
--         end
--     end
-- end))


-- --#endregion

--#region Lock FPS

function low_cpu()
	UserInputService.WindowFocusReleased:Connect(function()
		setfpscap(10)
	end)
	UserInputService.WindowFocused:Connect(function()
		setfpscap(60)
	end)
end

low_cpu()

--#endregion

--#region Delete Map

local function DeleteMap()
	if game.PlaceId ~= 8304191830 then
		local removeMap = game:GetService("Workspace")["_map"]:GetChildren()
		local removeTerrain = game:GetService("Workspace")["_terrain"].terrain:GetChildren()
		
		-- local whitelist = {
		-- 	"Union",
		-- 	"houses_new",
		-- 	"namek mushroom model",
		-- 	"Snow Particles",
		-- 	"sand_gate",
		-- 	"icebergs",
		-- 	"Helicopter Pad",
		-- 	"castle top",
		-- 	"Village Path",
		-- 	"wooden stacks",
		-- 	"skeleton",
		-- 	"SpaceCenter",
		-- 	"boat and bus",
		-- 	"LanternsGround",
		-- 	"ThreeDTextObject",
		-- 	"misc nonocollide obstacles",
		-- 	"parking spots",
		-- 	"vegetation",
		-- 	"crashed spaceships",
		-- 	"bridge nocollide",
		-- 	"Support_Beam",
		-- 	"hay",
		-- 	"mha_city_night_rain",
		-- 	"fireflies"
		-- }

		for _, v in pairs(removeMap) do
			v:Destroy()
			-- if not table.find(whitelist, v.Name) then
				
			-- end
		end

		for _, v in pairs(removeTerrain) do
			v:Destroy()
		end
	end
end

DeleteMap()



--#endregion



pcall(function()
	local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
	game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
	warn("Anti-AFK Loaded!!!")
end)
--disms
if game.PlaceId ~= 8304191830 then
	game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
	game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
	game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false --disables the annoying error messages 
end
--disms
if game.PlaceId == 8304191830 then
	game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
	game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
	game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false --disables the annoying error messages 
end

--#endregion

--#region Setting Hidden Error

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if game.PlaceId ~= 8304191830 then
			--// Disble Error in game
			game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
			game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
			--// AUTO SETTING LOW POLYGON
			local args = {
					[1] = "low_quality",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_kill_fx",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_other_fx",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_effects",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "low_quality_shadows",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "low_quality_textures",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "autoskip_waves",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_auto_open_overhead",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			--///////////////////////////////////////////////////////////////////////////////////////////////////--
		end
		break
	end
end))


--#endregion 

--#region Auto Reconnect

local recatt = 0
function auto_reconnect()
	repeat task.wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
	game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(e)
		if e.Name == 'ErrorPrompt' then
			warn("Trying to Reconnect")
			recatt = recatt + 1
			if recatt <= 2 then
				repeat
					game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					task.wait(3)
				until false
			end
		end
	end)
end

auto_reconnect()

--#endregion

--#region Check Status

coroutine.resume(coroutine.create(function()
	while task.wait(300) do --#5 นาที ต่อครั้ง
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Title = "<-- Check Status -->", -- Required
			Text = "ระบบกำลังทำงาน..", -- Required
			Icon = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=180&h=180 true";
			Duration = 5
		})
	end
end))

--#endregion

setfpscap(15)

print("Load Script suscess!!!!!")
