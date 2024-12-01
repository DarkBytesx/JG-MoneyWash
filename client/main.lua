local alreadymarker = false
local menuopended = false



RegisterNetEvent('JG-startproccess', function (percetageinput,originalinput,time)
    if lib.progressCircle({
        duration = time*1000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
                car = true,
                combat = true,
                move = true,
                mouse = false
        },
    }) then
        TriggerServerEvent('JG-washmoney', percetageinput, originalinput)
        lib.notify({
            title = 'Money Wash',
            description = 'Transaction successful $'..percetageinput,
            type = 'success'
        })
        -----
        lib.progressCircle({
            duration = 1000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                combat = true,
                move = true,
                mouse = false
            },
            anim = {
                dict = 'amb@prop_human_atm@female@enter',
                clip = 'enter'
            },
        })
        -----
        TriggerServerEvent('JG-addcard')
     else 
        lib.notify({
            title = 'Money Wash',
            description = 'Cancelled',
            type = 'error'
        })
        TriggerServerEvent('JG-addcard')
     end    
end)

RegisterNetEvent('JG-startproccess2', function (percetageinput,originalinput,time)
    if lib.progressCircle({
        duration = time*1000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
                car = true,
                combat = true,
                move = true,
                mouse = false
        },
    }) then
        TriggerServerEvent('JG-dirtmoney', percetageinput, originalinput)
        lib.notify({
            title = 'Money Dirt',
            description = 'Transaction successful $'..percetageinput,
            type = 'success'
        })
        -----
        lib.progressCircle({
            duration = 1000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                combat = true,
                move = true,
                mouse = false
            },
            anim = {
                dict = 'amb@prop_human_atm@female@enter',
                clip = 'enter'
            },
        })
        -----
        TriggerServerEvent('JG-addcard')
     else 
        lib.notify({
            title = 'Money Dirt',
            description = 'Cancelled',
            type = 'error'
        })
        TriggerServerEvent('JG-addcard')
     end    
end)



local function getinput()
    local input = lib.inputDialog('Money Wash', {{type = 'number',label = 'Money to launder' }})
    if not input then
        lib.notify({
            title = 'Money Wash',
            description = 'Cancelled',
            type = 'error'
        })
        TriggerServerEvent('JG-addcard')
        return
    end
    local originalinput = math.floor(input[1])
    local percetageinput = math.floor(originalinput - (originalinput * Config.percentage / 100))
    local time = math.floor(originalinput * 0.003)
    if time == 0 then
        time = 1
    end
    local texttime =  tostring(time)
    local alert = lib.alertDialog({
        header = 'Money Wash',
        content = 'Time: '..texttime.. ' Seconds',
        centered = true,
        cancel = true
    })
    print(alert)
    if alert == 'confirm' then
        TriggerServerEvent('JG-checkblackmoney',percetageinput,originalinput,time,function ()
        end)
        TriggerServerEvent('JG-senddistress')
    else
        lib.notify({
            title = 'Money Wash',
            description = 'Cancelled',
            type = 'error'
        })
        TriggerServerEvent('JG-addcard')
    end
end

RegisterNetEvent('JG-Getinput', function ()
    if lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            combat = true,
            move = true,
            mouse = false
        },
        anim = {
            dict = 'amb@prop_human_atm@female@enter',
            clip = 'enter'
        },
    }) then 
        getinput()
     else
        TriggerServerEvent('JG-addcard')
        lib.notify({
            title = 'Money Wash',
            description = 'Cancelled',
            type = 'error'
        })
     end
    
end)

local function getinput2()
    local input = lib.inputDialog('Money Dirt', {{type = 'number',label = 'Money to Dirt' }})
    if not input then
        lib.notify({
            title = 'Money Dirt',
            description = 'Cancelled',
            type = 'error'
        })
        TriggerServerEvent('JG-addcard')
        return
    end
    local originalinput = math.floor(input[1])
    local percetageinput = math.floor(originalinput - (originalinput * Config.percentage / 100))
    local time = math.floor(originalinput * 0.003)
    if time == 0 then
        time = 1
    end
    local texttime =  tostring(time)
    local alert = lib.alertDialog({
        header = 'Money Dirt',
        content = 'Time: '..texttime.. ' Seconds',
        centered = true,
        cancel = true
    })
    print(alert)
    if alert == 'confirm' then
        TriggerServerEvent('JG-checkcleanmoney',percetageinput,originalinput,time,function ()
        end)
        TriggerServerEvent('JG-senddistress')
    else
        lib.notify({
            title = 'Money Dirt',
            description = 'Cancelled',
            type = 'error'
        })
        TriggerServerEvent('JG-addcard')
    end
end

RegisterNetEvent('JG-Getinput2', function ()
    if lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            combat = true,
            move = true,
            mouse = false
        },
        anim = {
            dict = 'amb@prop_human_atm@female@enter',
            clip = 'enter'
        },
    }) then 
        getinput2()
     else
        TriggerServerEvent('JG-addcard')
        lib.notify({
            title = 'Money Dirt',
            description = 'Cancelled',
            type = 'error'
        })
     end
    
end)






local function openmenu(v)
    
    lib.registerContext({
        id = 'moneywash',
        title = 'Money Wash',
        options = {
            {
            title = 'Insert the Card',
            description = 'Enter your money laundering card',
            icon = 'id-card',
            onSelect = function ()
                TriggerServerEvent('JG-checkid')
                SetEntityHeading(PlayerPedId(), v.heading)
            end
            }
        }
    })
    lib.showContext('moneywash')
end

local function openmenu2(v)
    
    lib.registerContext({
        id = 'moneydirt',
        title = 'Money Dirt',
        options = {
            {
            title = 'Insert the Card',
            description = 'Enter your money laundering card',
            icon = 'id-card',
            onSelect = function ()
                TriggerServerEvent('JG-checkid2')
                SetEntityHeading(PlayerPedId(), v.heading)
            end
            }
        }
    })
    lib.showContext('moneydirt')
end


Citizen.CreateThread( function()
    while true do
        local inmarker = false
        local sleep = 1000
        local ped = PlayerPedId()
        local pedcoord = GetEntityCoords(ped)
        for k,v in pairs(Config.zones) do
            local zonecoords = #(v.coords -pedcoord)
            if zonecoords < 2 then
                sleep = 0
                inmarker = true
                if menuopended == false then
                if IsControlJustPressed(0,38) then
                    openmenu(v)
                    menuopended = true
                end
            end
            end
            if inmarker == true and alreadymarker == false then
                alreadymarker = true
                lib.showTextUI("[E] Access Dirty -> Clean")
            end 
            if inmarker == false and alreadymarker == true then
                alreadymarker = false
                menuopended = false
                lib.hideTextUI()
            end
        end
        Wait(sleep)
    end
end)

Citizen.CreateThread( function()
    while true do
        local inmarker = false
        local sleep = 1000
        local ped = PlayerPedId()
        local pedcoord = GetEntityCoords(ped)
        for k,v in pairs(Config.zones2) do
            local zonecoords = #(v.coords -pedcoord)
            if zonecoords < 2 then
                sleep = 0
                inmarker = true
                if menuopended == false then
                if IsControlJustPressed(0,38) then
                    openmenu2(v)
                    menuopended = true
                end
            end
            end
            if inmarker == true and alreadymarker == false then
                alreadymarker = true
                lib.showTextUI("[E] Access Clean -> Dirty")
            end 
            if inmarker == false and alreadymarker == true then
                alreadymarker = false
                menuopended = false
                lib.hideTextUI()
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('JG:notification')
AddEventHandler('JG:notification', function (title, description, alertType)
	lib.notify({
		title = title,
		description = description,
		type = alertType,
        position = 'top',
	})
end)
