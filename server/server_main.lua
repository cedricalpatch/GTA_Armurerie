--||@SuperCoolNinja.||--
--||@cedricAlpatch.||--

--> Version de la Resource : 1.0


RegisterServerEvent("GTAArme:RecevoirItem")
AddEventHandler("GTAArme:RecevoirItem", function(quantityItems, nameItem, prixItem)
	local source = source
	local prixTotal = prixItem * tonumber(quantityItems)

	TriggerEvent('GTA_Inventaire:GetItemQty', source, "cash", function(qtyItem, itemid)
		local cash = qtyItem
		if (tonumber(cash) >= prixTotal) then
			TriggerClientEvent("GTAArme:Achat", source, quantityItems, nameItem)
			TriggerClientEvent("GTA_Inventaire:RetirerItem", source, "cash", quantityItems)
			TriggerClientEvent('nMenuNotif:showNotification', source, " + "..quantityItems .. " ".. nameItem)
		else
			TriggerClientEvent('GTAArme:AchatFail', source)
			TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
		end
	end)
end)