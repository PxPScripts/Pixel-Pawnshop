ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pawnItem')
AddEventHandler('pawnItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.PawnShopPrices[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('Pixel-Pawnshop%s attempted to sell an invalid item!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		xPlayer.showNotification("~r~Du har ikke nok af denne genstand.")
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveDirty then
		xPlayer.addAccountMoney('black_money', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)
	xPlayer.showNotification('Du solgte ~b~'..amount..'x~s~ ~y~'..xItem.name..'~s~ for ~g~DKK'..price..'~s~', amount, xItem.label, ESX.Math.GroupDigits(price))
end)

print(
	"^0======================================================================^7\n" ..
	"^0[^4TGPX.Store^0]^7 :^0 ^0https://discord.gg/e3S4Svrewg^7\n" ..
	"^0[^4TGPX.Development^0]^7 :^0 ^0https://discord.gg/fJekXq5jUP^7\n" ..
	"^0======================================================================^7"
)
