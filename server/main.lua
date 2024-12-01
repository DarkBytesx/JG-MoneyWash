


RegisterNetEvent('JG-checkid', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getInventoryItem(Config.laundrycarditemname).count
    if count > 0 then
        xPlayer.removeInventoryItem(Config.laundrycarditemname, 1)
        TriggerClientEvent('JG-Getinput', source)
    else
        TriggerClientEvent('JG:notification',source,"Money Wash","Dont have Money wash card",'error')
    end
    
end)

RegisterNetEvent('JG-checkid2', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getInventoryItem(Config.laundrycarditemname).count
    if count > 0 then
        xPlayer.removeInventoryItem(Config.laundrycarditemname, 1)
        TriggerClientEvent('JG-Getinput2', source)
    else
        TriggerClientEvent('JG:notification',source,"Money Wash","Dont have Money wash card",'error')
    end
    
end)



local function sendToDiscord(title, description, color)
    local discordWebhook = Config.DiscordWebhook
    if not discordWebhook then return end

    local payload = {
        embeds = {
            {
                title = title,
                description = description,
                color = color,
                footer = {
                    text = os.date('%Y-%m-%d %H:%M:%S'),
                }
            }
        }
    }

    PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('JG-washmoney')
AddEventHandler('JG-washmoney', function(percentageInput, originalInput)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackmoney = xPlayer.getAccount('black_money')

    if blackmoney.money >= originalInput then
        xPlayer.removeAccountMoney('black_money', originalInput)
        xPlayer.addAccountMoney('money', percentageInput)
        sendToDiscord(
            "Money Laundering Successful",
            string.format("**Player:** %s\n**Original Input (Dirty):** $%d\n**Laundered Money:** $%d\n**Remaining Black Money:** $%d", 
                xPlayer.getName(), originalInput, percentageInput, blackmoney.money - originalInput),
            65280
        )
    else
        xPlayer.addInventoryItem(Config.laundrycarditemname, 1)
        sendToDiscord(
            "Money Laundering Failed",
            string.format("**Player:** %s\n**Attempted Input:** $%d\n**Black Money Available:** $%d", 
                xPlayer.getName(), originalInput, blackmoney.money),
            16711680
        )
    end
end)


RegisterNetEvent('JG-dirtmoney')
AddEventHandler('JG-dirtmoney', function(percentageInput, originalInput)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cleanMoney = xPlayer.getAccount('money') -- Clean money account

    if cleanMoney.money >= originalInput then
        xPlayer.removeAccountMoney('money', originalInput)
        xPlayer.addAccountMoney('black_money', percentageInput)
        sendToDiscord(
            "Money Dirtied Successfully",
            string.format("**Player:** %s\n**Original Input (Clean):** $%d\n**Dirty Money Added:** $%d\n**Remaining Clean Money:** $%d", 
                xPlayer.getName(), originalInput, percentageInput, cleanMoney.money - originalInput),
            65280
        )
        TriggerClientEvent('JG:notification', source, "Money Wash", "You successfully dirtied your clean money!", 'success')
    else
        TriggerClientEvent('JG:notification', source, "Money Wash", "You don't have enough clean money.", 'error')
        sendToDiscord(
            "Money Dirtying Failed",
            string.format("**Player:** %s\n**Attempted Input:** $%d\n**Clean Money Available:** $%d", 
                xPlayer.getName(), originalInput, cleanMoney.money),
            16711680
        )
    end
end)





RegisterNetEvent('JG-addcard' ,function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(Config.laundrycarditemname, 1)
end)


RegisterNetEvent('JG-checkblackmoney', function(percetageinput,originalinput,time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackmoney = xPlayer.getAccount('black_money')
    if blackmoney.money >= originalinput then
        TriggerClientEvent('JG-startproccess', source,percetageinput,originalinput,time ,function()
        end)
    else
        TriggerClientEvent('JG:notification',source,"Money Wash","Dont have enough black money",'error')
    end
end)

RegisterNetEvent('JG-checkcleanmoney', function(percentageInput, originalInput, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cleanMoney = xPlayer.getAccount('money')
    if cleanMoney.money >= originalInput then
        TriggerClientEvent('JG-startproccess2', source, percentageInput, originalInput, time)
    else
        TriggerClientEvent('JG:notification', source, "Money Wash", "You don't have enough clean money.", 'error')
    end
end)




RegisterNetEvent('JG-senddistress', function()
    for _, xPlayer in pairs(ESX.GetExtendedPlayers()) do
        if Config.PoliceJob[xPlayer.getJob().name] then
            TriggerClientEvent('JG:notification', xPlayer.source, "Dispatch", "Money laundering in progress! Find them.")
        end
    end
end)
