local ESX = exports['es_extended']:getSharedObject()
local models = { `prop_truktrailer_01a` }

local function policeAlarm()
    local data = exports['cd_dispatch']:GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords = data.coords,
        title = 'Container-robbery',
        message = 'A person has been seen breaking into a trailer in: ' .. data.street,
        flash = 0,
        unique_id = data.unique_id,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 0.7,
            colour = 3,
            flashes = false,
            text = 'Container-robbery',
            time = 3,
            radius = 1
        }
    })
end

exports.ox_target:addModel(models, {
    {
        name = 'container',
        label = 'Break into the container',
        range = 1.5,
        icon = 'fa-solid fa-box',
        item = 'crowbar',
        canInteract = function() -- You can remove canInteract if you dont want use weapon to rob
            return GetSelectedPedWeapon(cache.ped) == `weapon_crowbar`
        end,
        onSelect = function()
            local success = lib.skillCheck({ 'medium', 'easy', { areaSize = 66, speedMultiplier = 1.0 }, 'medium' }, { '1', '2', '3', '4' })
            if not success then
                Citizen.Wait(1000)
                policeAlarm()
                return
            end


            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)

            if lib.progressCircle({
                duration = 15000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = false,
                },
            }) then print('Yes') else print('No') end
            ClearPedTasks(PlayerPedId())

            lib.callback.await('container:reward', source)
        end,
    }
})
