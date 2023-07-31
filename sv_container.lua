function sendDiscordWebhook(message)
    local discordWebhookUrl = "PUT_YOUR_WEBHOOK_HERE"

    local data = {
        content = message
    }
    
    PerformHttpRequest(discordWebhookUrl, function(err, text, headers)
    end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

lib.callback.register('container:reward', function(source)
    local Config = {
        Items = {
            {item = 'tablet', minAmount = 1, maxAmount = 1, chance = 15}, --  15%
            {item = 'lockpick', minAmount = 1, maxAmount = 1, chance = 25}, -- 25%
            {item = 'water', minAmount = 1, maxAmount = 1, chance = 50}, -- 50%
            {item = 'burger', minAmount = 1, maxAmount = 1, chance = 20}, -- 20%
        }
    }


    for _, itemData in ipairs(Config.Items) do
        if math.random(1, 100) <= itemData.chance then
            local itemAmount = math.random(itemData.minAmount, itemData.maxAmount)
            exports.ox_inventory:AddItem(source, itemData.item, itemAmount, nil, nil, nil)

            local playerName = GetPlayerName(source)
            local dateAndTime = os.date("%d.%m.%Y at %H:%M")
            local discordMessage = string.format("Player %s looted container and got %s x %s %s.", playerName, itemAmount, itemData.item, dateAndTime)
            sendDiscordWebhook(discordMessage)
        end
    end
end)
