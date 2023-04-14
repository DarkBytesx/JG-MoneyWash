


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



RegisterNetEvent('JG-washmoney')
AddEventHandler('JG-washmoney', function (percetageinput,originalinput)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackmoney = xPlayer.getAccount('black_money')
    if blackmoney.money >= originalinput then
    xPlayer.removeAccountMoney('black_money', originalinput)
    xPlayer.addAccountMoney('money', percetageinput)
    else
        xPlayer.addInventoryItem(Config.laundrycarditemname, 1)
        return
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



RegisterNetEvent('JG-senddistress',function()
	for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', Config.policejob)) do
        TriggerClientEvent('JG:notification',xPlayer.source,"Disptach","Money laudring has been detected")
end
end)