local ESX = exports['es_extended']:getSharedObject()

-- Plant a plant in the garden
function PlantPlant(plantType)
    local playerData = ESX.GetPlayerData()
    local playerId = playerData.identifier

    ESX.TriggerServerCallback('garden_trading_hub:plant', function(success)
        if success then
            ESX.ShowNotification('You planted a ' .. plantType .. '!')
        else
            ESX.ShowNotification('Failed to plant the plant.')
        end
    end, plantType)
end

-- Check garden status
function CheckGarden()
    ESX.TriggerServerCallback('garden_trading_hub:check_garden', function(gardenData)
        if gardenData then
            for _, plant in ipairs(gardenData) do
                ESX.ShowNotification('Plant: ' .. plant.plant_type .. ', Growth Stage: ' .. plant.growth_stage)
            end
        else
            ESX.ShowNotification('No plants in your garden.')
        end
    end)
end

-- Claim a booth
function ClaimBooth()
    ESX.TriggerServerCallback('garden_trading_hub:claim_booth', function(success)
        if success then
            ESX.ShowNotification('You claimed a booth!')
        else
            ESX.ShowNotification('Failed to claim a booth.')
        end
    end)
end

-- Register commands
RegisterCommand('plant', function(source, args)
    if args[1] then
        PlantPlant(args[1])
    else
        ESX.ShowNotification('Please specify a plant type.')
    end
end, false)

RegisterCommand('checkgarden', function()
    CheckGarden()
end, false)

RegisterCommand('claimbooth', function()
    ClaimBooth()
end, false)