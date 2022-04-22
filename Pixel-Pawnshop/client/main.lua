ESX = nil

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

------------------------ PAWN SHOP

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(GetPlayerPed(-1))
        local isClose = false

		local pawn_dist = GetDistanceBetweenCoords(playerCoords, Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, 1)

		if pawn_dist <= 2.0 then
			isClose = true
			Draw3DText(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "[E] Åben Pantelånerbutik")
			if IsControlJustReleased(0, 38) then
				PawnshopMenu()
			end
		end        


        if not isClose then
            Citizen.Wait(1000)
        end


    end
end)


function PawnshopMenu()
	local elements = {}
	for k,v in pairs(Config.PawnItems) do
		table.insert(elements, {label = v.label .. ' | DKK' .. v.price, item = k, type = 'slider', value = v.min, min = v.min, max = v.max})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pawnshop', {
        title    = 'Pantelånerbutik',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()
		TriggerServerEvent('pixel-pawnshop:sellPawnshop', data.current.item, data.current.value)
    end, function(data, menu)
        menu.close()
    end) 
end


function CreateBlipCircle(coords, text, color, sprite)
	blip = AddBlipForCoord(coords)

	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	CreateBlipCircle(vector3(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z), 'Pantelånerbutik', 3, 272)
end)
