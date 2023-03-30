--ESX = nil
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Cellars = {}

Citizen.CreateThread(function()
    local database = MySQL.Sync.fetchAll('SELECT * FROM wine_cellar')
    for k, v in pairs(database) do
        local coords = json.decode(v.coords)
        local vec = vec3(coords.x, coords.y, coords.z)
        Cellars[v.id] = {
            id = v.id,
            owner = v.owner,
            coords = vec,
            barrels = json.decode(v.barrels),
            price = json.decode(v.price),
			crate = v.crate
        }
    end

    Citizen.Wait(100)

    updateCellar()

    Citizen.Wait(50)

    for k, v in pairs(Cellars) do
        if v.price.players then
            local xPlayer = ESX.GetPlayerFromIdentifier(v.owner)
            if xPlayer then
                TriggerClientEvent("hyon_winecellar:setPlayerInCellar", xPlayer.source, v.id)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local database = MySQL.Sync.fetchAll('SELECT * FROM wine_cellar')
        for k, v in pairs(database) do
            local barrels = json.decode(v.barrels)
            MySQL.Async.execute('UPDATE wine_cellar SET barrels = @barrels WHERE id = @id',
            {['barrels'] = json.encode(Cellars[v.id].barrels), ['id'] = v.id },
            function(insertId) end)
        end

        Citizen.Wait(100)

        updateCellar()
    Citizen.Wait(59000)
    end
end)

RegisterCommand(Config.Command, function(source, args)
    if (source < 1) then return end

    if #args ~= 1 or not tonumber(args[1]) then return end

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() ~= Config.Admin then return end

    local coords = xPlayer.getCoords(true)

    local price = {
        players = false,
        forsale = true,
        saleprice = tonumber(args[1])
    }

    local barrels = {
        ["1"] = {created = 0, wine = 0, grape = 0},
        ["2"] = {created = 0, wine = 0, grape = 0},
        ["3"] = {created = 0, wine = 0, grape = 0},
        ["4"] = {created = 0, wine = 0, grape = 0}
    }
	
	local crate = 0

    MySQL.Async.insert('INSERT INTO wine_cellar (coords, barrels, price, crate) VALUES (@coords, @barrels, @price, @crate)',
        { ['coords'] = json.encode(coords), ['barrels'] = json.encode(barrels), ['price'] = json.encode(price), ['crate'] = json.encode(crate) },
    function(insertId) 
        Cellars[insertId] = {
            id = insertId,
            owner = nil,
            coords = coords,
            barrels = barrels,
            price = price,
			crate = crate,
        }
        updateCellar()
    end)
end)

Citizen.CreateThread(function()
    TriggerClientEvent('chat:addSuggestion', -1, '/'..Config.Command, 'create new wine cellar', {
		{ name = "price", help = "A price it will sell for" }
	})
end)

function updateCellar()
    TriggerClientEvent("hyon_winecellar:updateClientData", -1, _G["Cellars"])
end

RegisterNetEvent("esx:playerLoaded", function(source, xPlayer)
    TriggerClientEvent("hyon_winecellar:updateClientData", source, _G["Cellars"])

    Citizen.Wait(50)

    for k, v in pairs(Cellars) do
        if v.price.players and v.owner == xPlayer.getIdentifier() then
            TriggerClientEvent("hyon_winecellar:setPlayerInCellar", source, v.id)
        end
    end
end)

RegisterNetEvent("hyon_winecellar:enterCellar", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    if Cellars[id].owner ~= identifier then return end
    Cellars[id].price.players = true
    MySQL.Async.execute('UPDATE wine_cellar SET price = @price WHERE id = @id',
        { ['price'] = json.encode(Cellars[id].price), ['id'] = id },
    function(insertId) end)
    updateCellar()
end)

RegisterNetEvent("hyon_winecellar:exitCellar", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    if Cellars[id].owner ~= identifier then return end
    Cellars[id].price.players = false
    MySQL.Async.execute('UPDATE wine_cellar SET price = @price WHERE id = @id',
        { ['price'] = json.encode(Cellars[id].price), ['id'] = id },
    function(insertId) end)
    updateCellar()
end)

RegisterNetEvent("hyon_winecellar:buyCellar", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
   if Cellars[id].owner == identifier then return end


    if xPlayer.getMoney() >= tonumber(Cellars[id].price.saleprice) then
        xPlayer.removeMoney(tonumber(Cellars[id].price.saleprice))
        if Cellars[id].owner ~= nil then
                MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', 
                { ['identifier'] = Cellars[id].owner }, function(result)

                    local accounts = {}
                    for k,v in pairs(result) do 
                        accounts = json.decode(v.accounts)
                    end
        
                    accounts.bank = accounts.bank + Cellars[id].price.saleprice
                    
                    MySQL.Async.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier',
                    { ['accounts'] = json.encode(accounts), ['identifier'] = Cellars[id].owner },
                    function(insertId) end)
                end)
        end
        Cellars[id].price.forsale = false
        Cellars[id].owner = identifier
        MySQL.Async.execute('UPDATE wine_cellar SET owner = @owner, price = @price WHERE id = @id',
            { ['owner'] = identifier, ['price'] = json.encode(Cellars[id].price), ['id'] = id },
        function(insertId) end)
        updateCellar()
		else
	TriggerClientEvent("hyon_winecellar:nomoney", xPlayer.source)
    end
end)

RegisterNetEvent("hyon_winecellar:press_grape", function(id)
   local xPlayer = ESX.GetPlayerFromId(source)
   local item = "grape"
   local item2 = "pressed_grape"
    if xPlayer.getInventoryItem(item) and xPlayer.getInventoryItem(item).count >= 5 then
        xPlayer.removeInventoryItem(item, 5)
		xPlayer.addInventoryItem(item2, 5)
        TriggerClientEvent("hyon_winecellar:press_grape", xPlayer.source)
        updateCellar()
			else
	TriggerClientEvent("hyon_winecellar:nogrape", xPlayer.source)
    end
end)

RegisterNetEvent("hyon_winecellar:get_grape", function(id)
   local xPlayer = ESX.GetPlayerFromId(source)
   local item = "grape"
		xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent("hyon_winecellar:get_grape", xPlayer.source)
end)

RegisterNetEvent("hyon_winecellar:uploadbarrel", function(id, barrelId, upgrade)
    local xPlayer = ESX.GetPlayerFromId(source)
	local item = "pressed_grape"
    if Cellars[id].barrels[tostring(barrelId)].grape == 100 or Cellars[id].owner ~= xPlayer.getIdentifier() then return end
		if xPlayer.getInventoryItem(item) and xPlayer.getInventoryItem(item).count >= 5 then
        xPlayer.removeInventoryItem(item, 5)
        Cellars[id].barrels[tostring(barrelId)].grape = tonumber(upgrade)
        MySQL.Async.execute('UPDATE wine_cellar SET barrels = @barrels WHERE id = @id',
            { ['barrels'] = json.encode(Cellars[id].barrels), ['id'] = id },
        function(insertId) end)
        TriggerClientEvent("hyon_winecellar:upgradebarrel", xPlayer.source, barrelId, upgrade)
        updateCellar()
				else
	TriggerClientEvent("hyon_winecellar:nopressed", xPlayer.source)
		end
end)

RegisterNetEvent("hyon_winecellar:winefinish", function(id, barrelId, upgrade)
    local xPlayer = ESX.GetPlayerFromId(source)
	local item = "wine"
	local item2 = "bottle"
    if Cellars[id].barrels[tostring(barrelId)].wine < 100 or Cellars[id].owner ~= xPlayer.getIdentifier() then return end
	if xPlayer.getInventoryItem(item2) and xPlayer.getInventoryItem(item2).count >= 5 then
		xPlayer.removeInventoryItem(item, 5)
        xPlayer.addInventoryItem(item, 5)
        Cellars[id].barrels[tostring(barrelId)].grape = tonumber(0)
		Cellars[id].barrels[tostring(barrelId)].wine = tonumber(0)
        MySQL.Async.execute('UPDATE wine_cellar SET barrels = @barrels WHERE id = @id',
            { ['barrels'] = json.encode(Cellars[id].barrels), ['id'] = id },
        function(insertId) end)
        TriggerClientEvent("hyon_winecellar:upgradebarrel", xPlayer.source, barrelId, upgrade)
        updateCellar()
						else
	TriggerClientEvent("hyon_winecellar:nobottle", xPlayer.source)
	end
end)

RegisterNetEvent("hyon_winecellar:make_wine", function(id, barrelId, winelevel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Cellars[id].barrels[tostring(barrelId)].grape < 100 or Cellars[id].owner ~= xPlayer.getIdentifier() then return end
        Cellars[id].barrels[tostring(barrelId)].wine = tonumber(winelevel)
        MySQL.Async.execute('UPDATE wine_cellar SET barrels = @barrels WHERE id = @id',
            { ['barrels'] = json.encode(Cellars[id].barrels), ['id'] = id },
        function(insertId) end)
        updateCellar()
end)

RegisterNetEvent("hyon_winecellar:upgradebarrel", function(id, barrelId, upgrade)
    local xPlayer = ESX.GetPlayerFromId(source)
    if upgrade - Cellars[id].barrels[tostring(barrelId)].created ~= 1 or not tonumber(Config.BarrelsPrice) or upgrade >= 4 or Cellars[id].owner ~= xPlayer.getIdentifier() then return end
    if xPlayer.getMoney() >= Config.BarrelsPrice then
        xPlayer.removeMoney(Config.BarrelsPrice)
        Cellars[id].barrels[tostring(barrelId)].created = tonumber(upgrade)
        MySQL.Async.execute('UPDATE wine_cellar SET barrels = @barrels WHERE id = @id',
            { ['barrels'] = json.encode(Cellars[id].barrels), ['id'] = id },
        function(insertId) end)
        TriggerClientEvent("hyon_winecellar:upgradebarrel", xPlayer.source, barrelId, upgrade)
        updateCellar()
	else
	TriggerClientEvent("hyon_winecellar:nomoney", xPlayer.source)
    end
end)

RegisterNetEvent("hyon_winecellar:buycrate", function(id)
   local xPlayer = ESX.GetPlayerFromId(source)
   if Cellars[id].crate == 1 or not tonumber(Config.CratePrice) or Cellars[id].owner ~= xPlayer.getIdentifier() then return end
    if xPlayer.getMoney() >= Config.CratePrice then
        xPlayer.removeMoney(Config.CratePrice)
        Cellars[id].crate = 1
        MySQL.Async.execute('UPDATE wine_cellar SET crate = @crate WHERE id = @id',
            { ['crate'] = json.encode(Cellars[id].crate), ['id'] = id },
        function(insertId) end)
        TriggerClientEvent("hyon_winecellar:buycrate", xPlayer.source)
        updateCellar()
			else
	TriggerClientEvent("hyon_winecellar:nomoney", xPlayer.source)
    end
end)


RegisterNetEvent("hyon_winecellar:sellCellar", function(id, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Cellars[id].owner ~= xPlayer.getIdentifier() or not tonumber(price) then return end
    Cellars[id].price.forsale = true
    Cellars[id].price.saleprice = tonumber(price)
    MySQL.Async.execute('UPDATE wine_cellar SET price = @price WHERE id = @id',
        { ['price'] = json.encode(Cellars[id].price), ['id'] = id },
    function(insertId) end)
    updateCellar()
end)

RegisterNetEvent("hyon_winecellar:removeSell", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Cellars[id].owner ~= xPlayer.getIdentifier() then return end
    Cellars[id].price.forsale = false
    Cellars[id].price.saleprice = 0
    MySQL.Async.execute('UPDATE wine_cellar SET price = @price WHERE id = @id',
        { ['price'] = json.encode(Cellars[id].price), ['id'] = id },
    function(insertId) end)
    updateCellar()
end)

RegisterNetEvent("hyon_winecellar:buybottles", function(id, amount_bottle)
   local xPlayer = ESX.GetPlayerFromId(source)
   local item = "bottle"
   local amount = tonumber(amount_bottle)
    if xPlayer.getMoney() >= Config.BottlesPrice*amount then
        xPlayer.removeMoney(Config.BottlesPrice*amount)
		xPlayer.addInventoryItem(item, amount)
        updateCellar()
		else
	TriggerClientEvent("hyon_winecellar:nomoney", xPlayer.source)
    end
end)

RegisterNetEvent("hyon_winecellar:sell_wine", function(id, amount_wine)
   local xPlayer = ESX.GetPlayerFromId(source)
   local item = "wine"
   local amount = tonumber(amount_wine)
    if xPlayer.getInventoryItem(item) and xPlayer.getInventoryItem(item).count >= amount then
        xPlayer.removeInventoryItem(item, amount)
		xPlayer.addMoney(Config.WinePrice*amount)
        updateCellar()
				else
	TriggerClientEvent("hyon_winecellar:nowine", xPlayer.source)
    end
end)

