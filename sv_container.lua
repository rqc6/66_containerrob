function sendDiscordWebhook(message)
    local discordWebhookUrl = "https://discord.com/api/webhooks/1133500101856350319/YknIc2RTiXFktholzRE93R3qB72jcXyPqQaEHEf6y0Y7ETE9CrBLhg1HKMks2EzjDi9T"

    local data = {
        content = message
    }
    
    PerformHttpRequest(discordWebhookUrl, function(err, text, headers)
    end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

lib.callback.register('container:reward', function(source)
    local Config = {
        Items = {
            {item = 'tablet', minAmount = 1, maxAmount = 1, chance = 15}, -- Chanche 1%
            {item = 'lockpick', minAmount = 1, maxAmount = 1, chance = 25}, -- 50%
            {item = 'water', minAmount = 1, maxAmount = 1, chance = 50}, -- 25%
            {item = 'burger', minAmount = 1, maxAmount = 1, chance = 20}, -- 25%
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