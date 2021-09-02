ESX = nil
All_Data = {}
local starttick, tick = GetGameTimer(), GetGameTimer()	
local connectedPlayers, maxPlayers, All_Data = 0, GetConvarInt('sv_maxclients', 32), {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()		
	while true do
		Citizen.Wait(15000) -- check all 15 seconds
		tick = GetGameTimer()
		uptimeDay = math.floor((tick-starttick)/86400000)
        	uptimeHour = math.floor((tick-starttick)/3600000) % 24
		uptimeMinute = math.floor((tick-starttick)/60000) % 60
		uptimeSecond = math.floor((tick-starttick)/1000) % 60
		ExecuteCommand(string.format("sets Uptime \"%2d Days %2d Hours %2d Minutes %2d Seconds\"", uptimeDay, uptimeHour, uptimeMinute, uptimeSecond))
		
		uptime = string.format("%02dd %02dh %02dm",uptimeDay, uptimeHour, uptimeMinute)
		TriggerClientEvent('uptime:tick', -1, uptime)
		TriggerEvent('uptime:tick', uptime)
	end
end)

ESX.RegisterServerCallback('master_scoreboard:get_all_data', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	All_Data = {}
	
	-- Player Data
	All_Data.name = '-'
	All_Data.steamname = '-'
	All_Data.userID = _source
	All_Data.job = '-'
	All_Data.gang = '-'
	All_Data.money = '-'
	All_Data.bankmoney = '-'
	All_Data.mastercoin = '-' -- TODO
	
	-- Server Data
	All_Data.uptime = {}
	All_Data.uptime.secs = 0
	All_Data.uptime.minutes = 0
	All_Data.uptime.hours = 0
	All_Data.uptime.days = 0
	
	All_Data.onlines = 0 -- connectedPlayers
	All_Data.queue = 0 -- TODO
	
	secs = tick - starttick
	All_Data.uptime.days = math.floor((secs)/86400000)
	All_Data.uptime.hours = math.floor((secs)/3600000) % 24
	All_Data.uptime.minutes = math.floor((secs)/60000) % 60
	All_Data.uptime.secs = math.floor((secs)/1000) % 60

	xAll = ESX.GetPlayers()
	All_Data.onlines = #xAll
	
	All_Data.police = 0
	All_Data.ambulance = 0
	All_Data.sheriff = 0
	All_Data.mechanic = 0
	All_Data.taxi = 0
	All_Data.admins = 0
	for i=1, #xAll, 1 do
		local xTarget = ESX.GetPlayerFromId(xAll[i])
		if xTarget then
			if xTarget.job.name == "police" then
				All_Data.police = All_Data.police + 1
			elseif xTarget.job.name == "ambulance" then
				All_Data.ambulance = All_Data.ambulance + 1
			elseif xTarget.job.name == "sheriff" then
				All_Data.sheriff = All_Data.sheriff + 1
			elseif xTarget.job.name == "mechanic" then
				All_Data.mechanic = All_Data.mechanic + 1
			elseif xTarget.job.name == "taxi" then
				All_Data.taxi = All_Data.taxi + 1
			end
			
			if xPlayer.group ~= 'user' then
				All_Data.admins = All_Data.admins + 1
			end
		end
	end
	
	-- Player Data
	if xPlayer then
		if xPlayer.job.label ~= nil then
			All_Data.job = xPlayer.job.label
		end
		
		All_Data.steamname = GetPlayerName(_source)
		
		if xPlayer.job.grade_label ~= nil then
			All_Data.job = All_Data.job .. ' - ' .. xPlayer.job.grade_label
		end
		
		All_Data.money = xPlayer.getMoney()
		All_Data.bankmoney = xPlayer.getAccount('bank').money
		
	end
	
	cb(All_Data)
end)
