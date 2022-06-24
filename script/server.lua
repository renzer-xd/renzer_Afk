ESX = nil
TriggerEvent(RZ.Base.getSharedObject, function(obj) ESX = obj end)

Register(true,GenName(':sv:KickPlayer'),function()
    DropPlayer(source, "You were AFK for too long.")
end)

Register(true,GenName(':sv:Giveitem'),function()
    local _sounce = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(RZ.Reward.Item.Name)
   
    xPlayer.addInventoryItem(xItem.name, RZ.Reward.Item.Count)
    sendToDiscord(_sounce,,xPlayer,xItem,RZ.Reward.Item.Count)
    for k,v in pairs(RZ.Reward.Item.Bonus) do
        local xItemBonus = xPlayer.getInventoryItem(v.Item)
        if xItemBonus.limit ~= -1 and xItemBonus.count < xItemBonus.limit then
            if math.random(1, 100) <= v.Percent then
                xPlayer.addInventoryItem(xItemBonus.name, v.Count)
                sendToDiscord(_sounce,,xPlayer,xItemBonus,v.Count)
            end
        end
    end
end)

Register(true,GenName(':sv:OffDuty'),function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local grade = xPlayer.job.grade
    xPlayer.setJob('off'..xPlayer.job.name, grade)
end)