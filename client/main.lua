--ESX = nil 
Citizen.CreateThread(function()
--    while ESX == nil do
--        ESX = exports['es_extended']:getSharedObject()
--        Citizen.Wait(1)
--    end
    while PlayerIdentifier == nil do
        PlayerIdentifier = ESX.GetPlayerData().identifier
        Citizen.Wait(1)
    end
end)

	local crate = GetHashKey("prop_ld_crate_01")
	local cratecreate = nil
	local cratecoord = vec3(908.48,-3243.04,-97.48)
	local wallhash = GetHashKey("xs_prop_arena_wall_02a_sf")
	local lamphash = GetHashKey("ch_prop_tunnel_tripod_lampa")
	local lamp1 = CreateObject(lamphash, 897.6,-3248.84,-99.16, false, false, false)
	local lamp2 = CreateObject(lamphash, 897.6,-3243.32,-99.08, false, false, false)
	local lamp3 = CreateObject(lamphash, 916.84,-3242.48,-97.8, false, false, false)
	local lamp4 = CreateObject(lamphash, 902.72,-3248.4,-98.76, false, false, false)
	local wallcoord = vec3(926.2,-3244.96,-97.24)
	local blipPickup = AddBlipForCoord(-1831.08,2088.28,136.88)
	local wine_npc_coords = vec3(813.96,-1644.92,30.88)
	local wine_npc = AddBlipForCoord(813.96,-1644.92,30.88)
--	local npcHash ="s_m_y_barman_01"
--	local ped =  CreatePed(4,npcHash, wine_npc_coords.x,wine_npc_coords.y,wine_npc_coords.z-1,257.0, false, true)
--	
--	         FreezeEntityPosition(ped, true)
--         SetEntityInvincible(ped, true)
--
--         SetBlockingOfNonTemporaryEvents(ped, true)
Cellars = {}
PlayerIdentifier = nil
PlayerInCellar = nil
Barrels = {}
Slots = {
    {coords = vec3(905.0,-3248.04,-97.68)},
    {coords = vec3(907.0,-3248.04,-97.68)},
    {coords = vec3(909.0,-3248.04,-97.68)},
    {coords = vec3(911.0,-3248.04,-97.68)},
}

npcs = {
    {pedmodel = GetHashKey(Config.Ped)},
}
Grapes = {
    {coords = vec3(-1850.72,2089.92,139.84), spawn = 100},
    {coords = vec3(-1844.96,2093.64,139.24), spawn = 100},
    {coords = vec3(-1839.08,2096.72,138.44), spawn = 100},
    {coords = vec3(-1831.88,2100.8,137.88), spawn = 100},
	--Line 2
    {coords = vec3(-1851.12,2084.48,139.72), spawn = 100},
    {coords = vec3(-1844.8,2087.96,139.12), spawn = 100},
    {coords = vec3(-1838.56,2091.84,138.2), spawn = 100},
    {coords = vec3(-1822.6,2101.0,137.12), spawn = 100},
    {coords = vec3(-1844.8,2082.8,139.0), spawn = 100},
    {coords = vec3(-1837.28,2087.44,137.92), spawn = 100},
    {coords = vec3(-1830.2,2091.24,137.0), spawn = 100},
    {coords = vec3(-1822.8,2096.0,136.4), spawn = 100},
    {coords = vec3(-1816.04,2099.84,135.88), spawn = 100},
    {coords = vec3(-1805.52,2105.8,134.24), spawn = 100},
    {coords = vec3(-1796.68,2111.08,133.16), spawn = 100},
    {coords = vec3(-1786.64,2116.92,130.76), spawn = 100},
    {coords = vec3(-1774.64,2124.0,127.48), spawn = 100},
    {coords = vec3(-1757.32,2133.76,123.88), spawn = 100},
    {coords = vec3(-1739.52,2144.44,121.24), spawn = 100},
	--Line 3
    {coords = vec3(-1724.0,2147.76,118.24), spawn = 100},
    {coords = vec3(-1734.16,2141.84,118.88), spawn = 100},
    {coords = vec3(-1743.04,2136.92,120.24), spawn = 100},
    {coords = vec3(-1752.12,2131.48,121.96), spawn = 100},
    {coords = vec3(-1764.32,2124.44,123.72), spawn = 100},
    {coords = vec3(-1779.6,2116.04,128.36), spawn = 100},
    {coords = vec3(-1795.84,2106.24,132.24), spawn = 100},
    {coords = vec3(-1804.48,2101.2,133.28), spawn = 100},
    {coords = vec3(-1816.0,2094.76,135.28), spawn = 100},
    {coords = vec3(-1830.0,2086.44,136.6), spawn = 100},
    {coords = vec3(-1843.52,2078.52,138.64), spawn = 100},
	--Line 4
    {coords = vec3(-1841.36,2075.0,138.16), spawn = 100},
    {coords = vec3(-1827.6,2083.0,136.04), spawn = 100},
    {coords = vec3(-1814.36,2090.72,134.48), spawn = 100},
    {coords = vec3(-1801.24,2098.2,132.2), spawn = 100},
    {coords = vec3(-1788.84,2105.6,129.96), spawn = 100},
    {coords = vec3(-1774.04,2114.28,126.28), spawn = 100},
    {coords = vec3(-1763.64,2120.48,122.96), spawn = 100},
    {coords = vec3(-1755.72,2124.88,121.44), spawn = 100},
    {coords = vec3(-1745.76,2130.44,119.84), spawn = 100},
    {coords = vec3(-1735.92,2136.28,118.04), spawn = 100},
    {coords = vec3(-1725.04,2143.16,116.92), spawn = 100},
    {coords = vec3(-1714.32,2149.28,114.84), spawn = 100},
    {coords = vec3(-1705.52,2153.8,113.16), spawn = 100},
	--Line 5
    {coords = vec3(-1689.68,2157.08,109.68), spawn = 100},
    {coords = vec3(-1706.8,2147.24,111.8), spawn = 100},
    {coords = vec3(-1723.52,2137.8,114.4), spawn = 100},
    {coords = vec3(-1740.04,2128.24,117.28), spawn = 100},
    {coords = vec3(-1757.32,2118.12,120.68), spawn = 100},
    {coords = vec3(-1769.56,2111.0,124.24), spawn = 100},
    {coords = vec3(-1787.2,2100.92,128.8), spawn = 100},
    {coords = vec3(-1805.28,2090.28,132.36), spawn = 100},
    {coords = vec3(-1818.72,2082.64,134.44), spawn = 100},
    {coords = vec3(-1829.2,2076.44,136.12), spawn = 100},
    {coords = vec3(-1840.44,2069.72,138.04), spawn = 100},
	--Line 6
    {coords = vec3(-1835.6,2067.48,137.16), spawn = 100},
    {coords = vec3(-1819.64,2076.64,134.4), spawn = 100},
    {coords = vec3(-1800.08,2088.08,130.6), spawn = 100},
    {coords = vec3(-1778.08,2100.8,125.84), spawn = 100},
    {coords = vec3(-1764.96,2108.52,122.32), spawn = 100},
    {coords = vec3(-1757.56,2112.56,120.04), spawn = 100},
    {coords = vec3(-1748.6,2117.88,118.04), spawn = 100},
    {coords = vec3(-1734.96,2126.0,114.92), spawn = 100},
	--Line 7
	

}
Citizen.CreateThread(function()
    while true do
		local waittime = (Config.WineProgressTime*1000)*0.6
		for k,v in pairs(Cellars) do
			for r,t in pairs(v.barrels) do
				if t.wine == 100 then
				elseif t.grape == 100 and t.wine < 100 then
				TriggerServerEvent("hyon_winecellar:make_wine",v.id,r, t.wine+1)
				end
			end
		end
	Citizen.Wait(waittime)
	end
end)

CreateThread(function()
    local pedmodel = GetHashKey(Config.Ped)
	local g = 0
	local t = 10
    RequestModel(pedmodel)
	while not HasModelLoaded(pedmodel) do
		Citizen.Wait(1)
	end
    for k, v in pairs(npcs) do
        npc = CreatePed(1, v.pedmodel, 813.84, -1644.92, 29.88, 264.12, false, true)

        FreezeEntityPosition(npc, true)
        SetEntityHeading(npc, 264.12)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
	    local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
		for k,v in pairs(Grapes) do
			local distance = #(playerCoords - v.coords)
			if distance < 3 and v.spawn == 100 then
			DrawText3D(v.coords.x, v.coords.y, v.coords.z, Config.Translation.grape_picking)
				if IsControlJustPressed(0, 51) then
                    TriggerServerEvent("hyon_winecellar:get_grape", player)
					v.spawn = 0
                end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
	local waittime = (Config.GrapeSpawnTime*1000)*0.6
	for k,v in pairs(Grapes) do
		if v.spawn < 100 then
			v.spawn = v.spawn+1
		end
	end
	Wait(waittime)
	end
end)

RegisterNetEvent("hyon_winecellar:updateClientData", function(cellars)
    Cellars = cellars
    updateBlip()
end)


Citizen.CreateThread(function()
    while true do
        local wait = 2000
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local closestCellar = getClosestCellar()
        		PlaceObjectOnGroundProperly(lamp,lamp2,lamp3,lamp4)
				FreezeEntityPosition(lamp,lamp2,lamp3,lamp4, true)
				SetEntityLights(lamp,lamp2,lamp3,lamp4, true)
        if closestCellar then
            wait = 3
            local text = "Loading..."
            if closestCellar.owner == PlayerIdentifier and not closestCellar.price.forsale then
                text = Config.Translation.owned_winecellar
            elseif closestCellar.owner == PlayerIdentifier and closestCellar.price.forsale then
                text = (Config.Translation.owned_winecellar_sell):format(closestCellar.price.saleprice)
            else
                if closestCellar.price.forsale then
                    text = (Config.Translation.free_winecellar):format(closestCellar.price.saleprice)
                else
                    text = ""
                end
            end
            DrawText3D(closestCellar.coords.x, closestCellar.coords.y, closestCellar.coords.z, text)
            if IsControlJustPressed(0, 51) then
                if closestCellar.owner == PlayerIdentifier and not closestCellar.price.forsale then
                    TriggerServerEvent("hyon_winecellar:enterCellar", closestCellar.id)
                    SetPlayerInCellar(closestCellar.id)
                elseif closestCellar.owner == PlayerIdentifier and closestCellar.price.forsale then
                    TriggerServerEvent("hyon_winecellar:removeSell", closestCellar.id)
                else
                    if closestCellar.price.forsale then
                        local onlyone = Config.OnlyOne
						local valid = true
						if onlyone == true then
							for k,v in pairs(Cellars) do
								if v.owner == PlayerIdentifier then 
									valid = false
								end
							end
						end
                        if not valid then
						ESX.ShowNotification(Config.Translation.onlyone, "error", 3000)
                        elseif valid then
							TriggerServerEvent("hyon_winecellar:buyCellar", closestCellar.id) 
                        end
                    end
                end
            end
        end
		local playerandnpc = #(playerCoords - wine_npc_coords)
		local textnpc = Config.Translation.wine_npc_info
		if playerandnpc < 3 then
		wait = 3
		DrawText3D(wine_npc_coords.x, wine_npc_coords.y, wine_npc_coords.z+0.25, textnpc)
			            if IsControlJustPressed(0, 29) then
						
						    local amount_bottle = KeyboardInput(Config.Translation.amountbuybottle, "", 7)
                            if tonumber(amount_bottle) then
                                TriggerServerEvent("hyon_winecellar:buybottles", player, amount_bottle)
                            end
						end			
			            if IsControlJustPressed(0, 51) then
						
						    local amount_wine = KeyboardInput(Config.Translation.amountsellwine, "", 7)
                            if tonumber(amount_wine) then
                                TriggerServerEvent("hyon_winecellar:sell_wine", player, amount_wine)
                            end
						end
--         SetEntityHeading(ped, 257.0)
 --        FreezeEntityPosition(ped, true)
 --        SetEntityInvincible(ped, true)

  --       SetBlockingOfNonTemporaryEvents(ped, true)
		end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 2000
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
		local cratedistance = #(playerCoords - cratecoord)
		if cratedistance < 1.5 then
			wait = 3
			if PlayerInCellar then
				local bought = Cellars[PlayerInCellar].crate
				local textcrate = nil
				if bought == 0 then
					local text = (Config.Translation.winecrate_buy):format(tostring(Config.CratePrice))
					DrawText3D(908.48,-3243.04,-97.48, text)
				elseif bought == 1 then
					DrawText3D(908.48,-3243.04,-97.48, Config.Translation.winecrate_info)
				end
				if IsControlJustPressed(0, 51) then
					if bought == 0 then
						TriggerServerEvent("hyon_winecellar:buycrate", PlayerInCellar)
					else
						TriggerServerEvent("hyon_winecellar:press_grape", PlayerInCellar)
                    end
                end
			end
		end
		 Citizen.Wait(wait)
	end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 2000
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local closestRig = getClosestRig()
		
        if closestRig then
            wait = 3
            local text = "["..closestRig.id.."]"
            if PlayerInCellar then
                local status = Cellars[PlayerInCellar]["barrels"][tostring(closestRig.id)]
                if status.created == 0 then 
                    text = (Config.Translation.buy_barrel):format(tostring(Config.BarrelsPrice))
					if IsControlJustPressed(0, 51) then
                    if status.created ~= 1 then
                    TriggerServerEvent("hyon_winecellar:upgradebarrel", PlayerInCellar, closestRig.id, status.created+1)
                    end
                end
                elseif status.created == 1 then
					if status.grape <100 then
					text = (Config.Translation.grape_level):format(status.grape)
					if IsControlJustPressed(0, 51) then
					TriggerServerEvent("hyon_winecellar:uploadbarrel",PlayerInCellar,closestRig.id,status.grape+10)
					end
					elseif status.grape == 100 and status.wine < 100 then
					text = (Config.Translation.grape_full..status.wine.."%")
					elseif status.wine == 100 then
					text = (Config.Translation.wine_finish):format(status.wine)
					if IsControlJustPressed(0, 51) then
					TriggerServerEvent("hyon_winecellar:winefinish",PlayerInCellar,closestRig.id,status.wine)
					end
					end
               end
            end
            DrawText3D(closestRig.coords.x, closestRig.coords.y, closestRig.coords.z-1, text)
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 2000
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local distance = #(playerCoords - vec3(897.44,-3245.92,-98.2))

        if distance < 1.5 then
            wait = 3
            DrawText3D(897.44,-3245.92,-98.2, Config.Translation.exit)
            if IsControlJustPressed(0, 51) then
                local coords = vec3(255.92,-783.72,30.52)
                for k, v in pairs(Cellars) do
                    if tonumber(PlayerInCellar) and Cellars[PlayerInCellar].coords then
                        coords = vec3(Cellars[PlayerInCellar].coords.x, Cellars[PlayerInCellar].coords.y, Cellars[PlayerInCellar].coords.z)
                        TriggerServerEvent("hyon_winecellar:exitCellar", PlayerInCellar)
                        local players = GetActivePlayers()
                        for k, v in pairs(players) do
                            local playerPed = GetPlayerPed(v)  
                            if player ~= playerPed then     
                                NetworkConcealPlayer(v, false, false)
                            end
                        end
                    end
                    for k, v in pairs(Barrels) do
                        DeleteEntity(v.prop)
                        Barrels[k] = nil
                    end
							DeleteEntity(cratecreate)
						DeleteEntity(wall)
						DeleteEntity(wall2)
                end
                DoScreenFadeOut(500)
                Citizen.Wait(550)
                SetEntityCoords(player, coords.x, coords.y, coords.z, 1, 0, 0, 1)
                DoScreenFadeIn(500)
            end
                local control = ""
                if IsControlJustPressed(0, 29) then
                            local price = KeyboardInput(Config.Translation.price, "", 7)
                            if tonumber(price) then
                                TriggerServerEvent("hyon_winecellar:sellCellar", PlayerInCellar, price)
                                local coords = vec3(Cellars[PlayerInCellar].coords.x, Cellars[PlayerInCellar].coords.y, Cellars[PlayerInCellar].coords.z)
                                DoScreenFadeOut(500)
                                Citizen.Wait(550)
                                TriggerServerEvent("hyon_winecellar:exitCellar", PlayerInCellar)
                                SetEntityCoords(player, coords.x, coords.y, coords.z, 1, 0, 0, 1)
                                local players = GetActivePlayers()
                                for k, v in pairs(players) do
                                    local playerPed = GetPlayerPed(v)  
                                    if player ~= playerPed then     
                                        NetworkConcealPlayer(v, false, false)
                                    end
                                end
                                DoScreenFadeIn(500)
                            end
                end
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 2000
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local distance = #(playerCoords - vec3(899.76,-3248.68,-98.0))

        if PlayerInCellar then
--            if distance < 3.0 then
--                wait = 3
--                local control = ""
--                DrawText3D(899.76,-3248.68,-98.0, (Config.Translation.cellar_stats))
--                if IsControlJustPressed(0, Config.Controls.sell_cellar) then
--                            local price = KeyboardInput(Config.Translation.keyboard_header, "", 7)
--                            if tonumber(price) then
--                                TriggerServerEvent("hyon_winecellar:sellCellar", PlayerInCellar, price)
--                                local coords = vec3(Cellars[PlayerInCellar].coords.x, Cellars[PlayerInCellar].coords.y, Cellars[PlayerInCellar].coords.z)
--                                DoScreenFadeOut(500)
--                                Citizen.Wait(550)
--                                TriggerServerEvent("hyon_winecellar:exitCellar", PlayerInCellar)
--                                SetEntityCoords(player, coords.x, coords.y, coords.z, 1, 0, 0, 1)
--                                local players = GetActivePlayers()
--                                for k, v in pairs(players) do
--                                    local playerPed = GetPlayerPed(v)  
--                                    if player ~= playerPed then     
--                                        NetworkConcealPlayer(v, false, false)
--                                    end
--                                end
--                                DoScreenFadeIn(500)
--                            end
--                        end
--            end
        end
        Citizen.Wait(wait)
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

RegisterNetEvent("hyon_winecellar:setPlayerInCellar", function(id)
    SetPlayerInCellar(id)
end)

RegisterNetEvent("hyon_winecellar:upgradebarrel", function(barrelId, upgrade)
    local player = PlayerPedId()
    local coords = Slots[barrelId].coords
  --  SetEntityCoords(player, coords.x, coords.y-1.2, coords.z, 1, 0, 0, 1)
 --   SetEntityHeading(player, 0.0)  
 --   FreezeEntityPosition(player, true)

    SetEntityCollision(Barrels[barrelId].prop, true, false)
    SetEntityAlpha(Barrels[barrelId].prop, 200, false)

    TaskStartScenarioInPlace(player, 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(5000)
    ClearPedTasks(player)
    FreezeEntityPosition(player, false)

    SetEntityCollision(Barrels[barrelId].prop, true, false)
    SetEntityAlpha(Barrels[barrelId].prop, 255, false)
end)

RegisterNetEvent("hyon_winecellar:nomoney", function(player)
	ESX.ShowNotification(Config.Translation.nomoney, "error", 3000)
end)

RegisterNetEvent("hyon_winecellar:nogrape", function(player)
	ESX.ShowNotification(Config.Translation.nogrape, "error", 3000)
end)

RegisterNetEvent("hyon_winecellar:nopressed", function(player)
	ESX.ShowNotification(Config.Translation.nopressed, "error", 3000)
end)


RegisterNetEvent("hyon_winecellar:nobottle", function(player)
	ESX.ShowNotification(Config.Translation.nobottle, "error", 3000)
end)

RegisterNetEvent("hyon_winecellar:nowine", function(player)
	ESX.ShowNotification(Config.Translation.nowine, "error", 3000)
end)

RegisterNetEvent("hyon_winecellar:buycrate", function(id)
    local player = PlayerPedId()
    local coords = cratecoord
--    SetEntityCoords(player, coords.x, coords.y-1.2, coords.z, 1, 0, 0, 1)
--    SetEntityHeading(player, 0.0)  
    FreezeEntityPosition(player, true)

    SetEntityCollision(cratecreate, true, false)
    SetEntityAlpha(cratecreate, 200, false)

    TaskStartScenarioInPlace(player, 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(5000)
    ClearPedTasks(player)
    FreezeEntityPosition(player, false)

    SetEntityCollision(cratecreate, true, false)
    SetEntityAlpha(cratecreate, 255, false)
end)

RegisterNetEvent("hyon_winecellar:get_grape", function(id)
    local player = PlayerPedId()
    FreezeEntityPosition(player, true)

    TaskStartScenarioInPlace(player, 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(5000)
    ClearPedTasks(player)
    FreezeEntityPosition(player, false)

end)

function SetPlayerInCellar(id)
    local player = PlayerPedId()
    PlayerInCellar = id
    DoScreenFadeOut(500)
    Citizen.Wait(550)
    SetEntityCoords(player, 899.5518,-3246.038, -98.04907, 1, 0, 0, 1)
    SetEntityHeading(player, 270.0)
    Citizen.Wait(500)
    local barrel = GetHashKey("prop_wooden_barrel")
		local wall = CreateObject(wallhash, 926.2,-3244.96,-97.24, false, false, false)
	local wall2 = CreateObject(wallhash, 926.2,-3244.96,-97.24, false, false, false)
					        		PlaceObjectOnGroundProperly(wall,wall2)
				FreezeEntityPosition(wall,wall2, true)
   SetEntityHeading(wall, -90.0)
      SetEntityHeading(wall2, 90.0)
			while Cellars == nil do Citizen.Wait(100) end
	 cratecreate = CreateObject(crate, 908.48,-3243.04,-97.48, false, false, false)
		PlaceObjectOnGroundProperly(cratecreate)
        FreezeEntityPosition(cratecreate, true)
		    if Cellars[id].crate == 0 then
                SetEntityCollision(cratecreate, false, false)
                SetEntityAlpha(cratecreate, 140, false)
            end
    for i = 1, 4 do
        if Barrels[i] == nil then
            Barrels[i] = {}
            Barrels[i].prop = CreateObject(barrel, Slots[i].coords.x, Slots[i].coords.y, Slots[i].coords.z, false, false, false)
            Barrels[i].coords = vec3(Slots[i].coords.x, Slots[i].coords.y, Slots[i].coords.z+1)
            Barrels[i].id = i
            PlaceObjectOnGroundProperly(Barrels[i].prop)
            FreezeEntityPosition(Barrels[i].prop, true)
            while Cellars == nil do Citizen.Wait(100) end
            if Cellars[id].barrels[tostring(i)].created == 0 then
                SetEntityCollision(Barrels[i].prop, false, false)
                SetEntityAlpha(Barrels[i].prop, 140, false)
            end
        end
    end

    local players = GetActivePlayers()
    for k, v in pairs(players) do
        local playerPed = GetPlayerPed(v)  
        local localPlayer = GetPlayerPed(-1)
        if localPlayer ~= playerPed then    
            NetworkConcealPlayer(v, true, false)
        end
    end
    DoScreenFadeIn(500)
end

function getClosestCellar()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local closest = nil
    local closestDist = 3
    for k, v in pairs(Cellars) do
        local distance = #(playerCoords - v.coords)
        if distance < closestDist then
            closest = v
            closestDist = distance
        end
    end
    return closest
end

function grape_time()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
	for k,v in pairs(Grapes) do
		if v.spawn < 100 then
			v.spawn = v.spawn+1
		end
	end
	Wait(1000)
end

RegisterNetEvent("hyon_winecellar:press_grape", function(id)
    local player = PlayerPedId()
    local coords = cratecoord
    SetEntityCoords(player, coords.x, coords.y, coords.z-1, 1, 0, 0, 1)
    SetEntityHeading(player, 0.0)  
    FreezeEntityPosition(player, true)

    SetEntityCollision(crate, true, false)
    SetEntityAlpha(crate, 200, false)
	    ESX.Progressbar("Press Grape...", 15000, {FreezePlayer = true, animation = {
		type = "Scenario",
		Scenario = "world_human_jog_standing",
		}, onFinish = function()
         end, onCancel = function()
         end})
	
    ClearPedTasks(player)
    FreezeEntityPosition(player, false)

    SetEntityCollision(crate, true, false)
    SetEntityAlpha(crate, 255, false)
end)

function getClosestRig()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local closest = nil
    local closestDist = 1.5
    for k, v in pairs(Barrels) do
        local distance = #(playerCoords - v.coords)
        if distance < closestDist then
            closest = v
            closestDist = distance
        end
    end
    return closest
end

function DrawText3D(x, y, z, text)
    SetDrawOrigin(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextEntry('STRING')
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(0.0, 0.0, 0.0)
    ClearDrawOrigin()
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        for k, v in pairs(Barrels) do
            DeleteEntity(v.prop)
        end
					DeleteEntity(cratecreate)
			DeleteEntity(wall)
			DeleteEntity(wall2)
    end
end)

blip = {}

function updateBlip()
    for k, v in pairs(Cellars) do
        if blip[k] then
            RemoveBlip(blip[k])
        end
        local color = 1
        if v.owner == PlayerIdentifier then 
            color = 2
			        blip[k] = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
			SetBlipSprite(blip[k], 569)
			SetBlipDisplay(blip[k], 4)
			SetBlipScale(blip[k], 0.75)
			SetBlipColour(blip[k], color)
			SetBlipAsShortRange(blip[k], true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Translation.blip_my)
			EndTextCommandSetBlipName(blip[k])
        elseif v.owner ~= PlayerIdentifier and v.price.forsale then
            color = 1
			        blip[k] = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
			SetBlipSprite(blip[k], 569)
			SetBlipDisplay(blip[k], 4)
			SetBlipScale(blip[k], 0.75)
			SetBlipColour(blip[k], color)
			SetBlipAsShortRange(blip[k], true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Translation.blip_for_sale)
			EndTextCommandSetBlipName(blip[k])
        end
	end
	local textpick = Config.Translation.grape_picking_name

			SetBlipSprite (blipPickup, 271)
			SetBlipDisplay(blipPickup, 4)
			SetBlipScale  (blipPickup, 0.9)
			SetBlipColour (blipPickup, 2)
			SetBlipAsShortRange(blipPickup, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(textpick)
			EndTextCommandSetBlipName(blipPickup)
	local textnpcblip = Config.Translation.wine_npc_blip
			SetBlipSprite (wine_npc, 467)
			SetBlipDisplay(wine_npc, 4)
			SetBlipScale  (wine_npc, 0.9)
			SetBlipColour (wine_npc, 5)
			SetBlipAsShortRange(wine_npc, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(textnpcblip)
			EndTextCommandSetBlipName(wine_npc)
end