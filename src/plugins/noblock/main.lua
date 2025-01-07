AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end
    if player:IsFirstSpawn() then return end
    NextTick(function()
        local playerPawn = player:CBasePlayerPawn()
        if not playerPawn:IsValid() then return end
        CBaseEntity(playerPawn:ToPtr()).Collision.CollisionGroup = 16
        player:SetVar("noblock", 1)
    end)
    return EventResult.Continue
end)

AddEventHandler("OnPluginStart", function(event)
    local players = FindPlayersByTarget("@all", true)
    for i = 1, #players do
        local player = players[i]
        if not player then return end
        if not player:CBaseEntity():IsValid() then return end
        player:CBaseEntity().Collision.CollisionGroup = 16
        player:SetVar("noblock", 1)
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    local players = FindPlayersByTarget("@all", true)
    for i = 1, #players do
        local player = players[i]
        if not player then return end
        if not player:CBaseEntity():IsValid() then return end
        player:CBaseEntity().Collision.CollisionGroup = 5
        player:SetVar("noblock", 0)
    end
    return EventResult.Continue
end)
