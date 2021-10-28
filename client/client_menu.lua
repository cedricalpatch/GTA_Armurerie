mainMenu = RageUI.CreateMenu("Armurerie",  "George pour vous servir !")
local subFood =  RageUI.CreateSubMenu(mainMenu, "Poing", "Arme legère !")
local subBoissons =  RageUI.CreateSubMenu(mainMenu, "Lourde", "Arme Lourde !")
local subMutlimedia =  RageUI.CreateSubMenu(mainMenu, "Sniper", "Fusil de sniper")
local prix1 = nil
local prix2 = nil
local prix3 = nil
local itemName = " "
local Duree = 0

Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button('Poing', "Arme blanche, tazer et autre arme legère", {}, true, {}, subFood);
            RageUI.Button('Lourde', "Arme lourde, automatique de guerre et autre carabine", {}, true, {}, subBoissons);
            RageUI.Button('Sniper', "Arme de precision, fusil a lunette longue distence", {}, true, {}, subMutlimedia);
        end, function()end)

        --> SubMenu Snack : 
        RageUI.IsVisible(subFood, function()
            for shop = 1, #Config.Locations do
                local item = Config.Locations[shop]["arme"]
                local sPed = Config.Locations[shop]["sPed"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    for _, v in pairs(item.itemNameArmeP) do
                        itemName = v
                        for _, j in pairs(item.prix1) do 
                            prix1 = j
                        end

                        RageUI.Button(v, "", {RightLabel = prix1 .. "~g~$"}, true, { 
                        onSelected = function()
                            local quantityItems =  InputNombre("Montant : ")
                            if tonumber(quantityItems) == nil then
                                exports.nCoreGTA:ShowNotification("Veuillez inserer un nombre correct !")
                                return nil
                            end
                
                            TriggerServerEvent("GTASuperette:RecevoirItem", quantityItems, itemName, prix1)
                        end});
                    end
                end
            end
        end, function() end)

        --> SubMenu Boissons : 
        RageUI.IsVisible(subBoissons, function()
            for shop = 1, #Config.Locations do
                local item = Config.Locations[shop]["arme"]
                local sPed = Config.Locations[shop]["sPed"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)

                if dist <= 5.0 then
                    for _, w in pairs(item.itemNameArmeM) do
                        itemName = w
                        for _, k in pairs(item.prix2) do 
                            prix2 = k
                        end

                        RageUI.Button(w, "", {RightLabel = prix2 .. "~g~$"}, true, { 
                        onSelected = function()
                            local quantityItems =  InputNombre("Montant : ")
                            if tonumber(quantityItems) == nil then
                                exports.nCoreGTA:ShowNotification("Veuillez inserer un nombre correct !")
                                return nil
                            end
                
                            TriggerServerEvent("GTASuperette:RecevoirItem", quantityItems, itemName, prix2)
                        end});
                    end
                end
            end
        end, function() end)

        --> SubMenu Mutlimédia : 
        RageUI.IsVisible(subMutlimedia, function()
            for shop = 1, #Config.Locations do
                local item = Config.Locations[shop]["arme"]
                local sPed = Config.Locations[shop]["sPed"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)

                if dist <= 5.0 then
                    for _, x in pairs(item.itemNameArmeG) do
                        itemName = x
                        for _, l in pairs(item.prix3) do 
                            prix3 = l
                        end

                        RageUI.Button(x, "", {RightLabel = prix3 .. "~g~$"}, true, { 
                        onSelected = function()
                            local quantityItems =  InputNombre("Montant : ")
                            if tonumber(quantityItems) == nil then
                                exports.nCoreGTA:ShowNotification("Veuillez inserer un nombre correct !")
                                return nil
                            end
                
                            TriggerServerEvent("GTASuperette:RecevoirItem", quantityItems, itemName, prix3)
                        end});
                    end
                end
            end
        end, function()end)
    Citizen.Wait(Duree)
    end
end)

Citizen.CreateThread(function()
    while true do
        Duree = 250
        for shop = 1, #Config.Locations do
           local sPed = Config.Locations[shop]["sPed"]
           local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)

            if dist <= 2.0 then
                Duree = 0
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
                end
           
               if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then 
                    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
               end
            end
        end

        if RageUI.Visible(mainMenu) or RageUI.Visible(subFood) or RageUI.Visible(subBoissons) or RageUI.Visible(subMutlimedia) == true then 
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT  
        end
       Citizen.Wait(Duree)
   end
end)