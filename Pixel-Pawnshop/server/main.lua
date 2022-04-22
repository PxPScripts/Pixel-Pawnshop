ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--------------------- PAWNSHOP

RegisterServerEvent('pixel-pawnshop:sellPawnshop')
AddEventHandler('pixel-pawnshop:sellPawnshop', function(itemName, itemAmount)
	local pixel = source
	local xPlayer = ESX.GetPlayerFromId(pixel)
	local priceMultiplier = Config.PawnItems[itemName].price * itemAmount
	
	if xPlayer.getInventoryItem(itemName).count >= itemAmount then
		if Config.PawnBlackMoney then
			xPlayer.addAccountMoney('black_money', priceMultiplier)
		else
			xPlayer.addMoney(priceMultiplier)
		end
		xPlayer.removeInventoryItem(itemName, itemAmount)
		TriggerClientEvent('t-notify:client:Custom', ServerID, { style  =  'success', duration  =  3000, title  =  'Pawnshop Funktioner', message  =  'Du solgte '..Config.PawnItems[itemName].label..' for DKK '..priceMultiplier..'.', sound  =  true})
	else
			TriggerClientEvent('t-notify:client:Custom', ServerID, { style  =  'error', duration  =  3000, title  =  'Pawnshop Funktioner', message  =  'Du har ikke flere af disse genstande', sound  =  true})
	end
end)

print(
	"^0======================================================================^7\n" ..
	"^0[^4TGPX.Store^0]^7 :^0 ^0https://discord.gg/e3S4Svrewg^7\n" ..
	"^0[^4TGPX.Development^0]^7 :^0 ^0https://discord.gg/fJekXq5jUP^7\n" ..
	"^0======================================================================^7"
)