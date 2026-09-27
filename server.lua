local ESX = exports['es_extended']:getSharedObject()

-- Plant a plant in the garden
ESX.RegisterServerCallback('garden_trading_hub:plant', function(source, cb, plantType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    MySQL.Async.execute('INSERT INTO garden_trading_hub (player_id, plant_type, growth_stage, planted_at) VALUES (@player_id, @plant_type, 0, NOW())', {
        ['@player_id'] = playerId,
        ['@plant_type'] = plantType
    }, function(rowsChanged)
        if rowsChanged > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

-- Check garden status
ESX.RegisterServerCallback('garden_trading_hub:check_garden', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT * FROM garden_trading_hub WHERE player_id = @player_id', {
        ['@player_id'] = playerId
    }, function(result)
        if result and #result > 0 then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

-- Claim a booth
ESX.RegisterServerCallback('garden_trading_hub:claim_booth', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    if xPlayer.getAccount('bank').money >= Config.Market.BoothPrice then
        xPlayer.removeAccountMoney('bank', Config.Market.BoothPrice)

        MySQL.Async.execute('UPDATE garden_trading_hub SET booth_id = @booth_id, last_claimed = NOW() WHERE player_id = @player_id', {
            ['@booth_id'] = math.random(1, 100),
            ['@player_id'] = playerId
        }, function(rowsChanged)
            if rowsChanged > 0 then
                cb(true)
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end)

-- Auto-claim booths
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Market.AutoClaimDelay)

        MySQL.Async.fetchAll('SELECT player_id FROM garden_trading_hub WHERE booth_id IS NULL', {}, function(result)
            for _, row in ipairs(result) do
                local xPlayer = ESX.GetPlayerFromId(row.player_id)
                if xPlayer then
                    xPlayer.addAccountMoney('bank', Config.Market.BoothPrice)

                    MySQL.Async.execute('UPDATE garden_trading_hub SET booth_id = @booth_id, last_claimed = NOW() WHERE player_id = @player_id', {
                        ['@booth_id'] = math.random(1, 100),
                        ['@player_id'] = row.player_id
                    })
                end
            end
        end)
    end
end)