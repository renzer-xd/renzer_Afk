ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
local sec = 1000
local minute = 60 * sec
local hour = 60 * minute
fontId = RegisterFontId(RZ.Font)
local display, forstatus = false, false
local playSec, playMinute = 0, 0
local hunger,thirst,stress,hp = nil,nil,nil,nil
-- Crate Blips
Citizen.CreateThread(function()
    local _Config = RZ.Zone.Blips
    if _Config.Enabel then
        local blip1 = AddBlipForCoord(RZ.Zone.Pos.x,RZ.Zone.Pos.y, RZ.Zone.Pos.z)
        SetBlipSprite (blip1, _Config.Id)
        SetBlipDisplay(blip1, 4)
        SetBlipScale  (blip1, _Config.Size)
        SetBlipColour (blip1, _Config.Color)
        SetBlipAsShortRange(blip1, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_Config.Text)
        EndTextCommandSetBlipName(blip1)
    end
end)

Citizen.CreateThread(function()
    while true do
        
        local sleepThread = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local playerHealth = GetEntityHealth(playerPed)
        local zone_status = false
        if (GetDistanceBetweenCoords(coords, RZ.Zone.Pos.x, RZ.Zone.Pos.y,RZ.Zone.Pos.z, true) < 50) then
            DrawMarker(RZ.Zone.Marker.Type, RZ.Zone.Pos.x, RZ.Zone.Pos.y,RZ.Zone.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,RZ.Zone.Marker.Size.x * RZ.Zone.Pos.Radius,RZ.Zone.Marker.Size.y * RZ.Zone.Pos.Radius,RZ.Zone.Marker.Size.z, RZ.Zone.Marker.Color.r,RZ.Zone.Marker.Color.g, RZ.Zone.Marker.Color.b,RZ.Zone.Marker.Color.a, false, true, 1, false, false,false, false)
            sleepThread = 0
        end
        if (GetDistanceBetweenCoords(coords, RZ.Zone.Pos.x, RZ.Zone.Pos.y,RZ.Zone.Pos.z, true) < RZ.Zone.Pos.Radius) then
            zone_status = true
            if RZ.EnableHeadText and not display then
                DrawTxt(0.960, 0.600, 1.1, 1.18, 0.60, RZ.R['TextZone'],255, 255, 255, 255)
            end
            if not display then
                DisplayHelpText(RZ.R[' DisplayHelpText'])
            else
                DisplayHelpText(RZ.R[' DisplayHelpText2'])
            end    
        end
        if zone_status then
            DisableControlAction(2, 37, true)
            DisablePlayerFiring(player,true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 80, true)
            DisablePlayerFiring(player,true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 140, true)
            IsDisabledControlJustPressed(2, 37)
            IsDisabledControlJustPressed(0, 106)
            IsDisabledControlJustPressed(0, 140)
            IsDisabledControlJustPressed(0, 45)
            IsDisabledControlJustPressed(0, 80)
            for k,v in pairs(RZ.DisableControl) do
                DisableControlAction(0, Key[v], true)
            end

            if IsControlJustPressed(0, Key['F']) then
                if not display then
                    display = true
                    if ESX.GetPlayerData().job.name == 'police' then
                        TriggerServerEvent(GenName(':sv:OffDuty'))
                    end
                    FreezeEntityPosition(playerPed, true) 
                    SetNuiFocus(true, true)
                    SendNUIMessage({type = "show-menu", enable = true})
                    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
                        hunger = status.val
                    end)
                    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
                        thirst = status.val
                    end)
                    TriggerEvent('esx_status:getStatus', 'stress', function(status)
                        stress = status.val
                    end)
                    hp = playerHealth

                    print(hunger,thirst,stress,hp)
                else
                    display = false
                    playSec = 0
                    playMinute = 0
                    hunger = nil 
                    thirst = nil
                    stress = nil
                    hp = nil
                    forstatus = false
                    ForStatus()
                    Run_CountDown()
                    FreezeEntityPosition(playerPed, false) 
                    SendNUIMessage({type = "show-countdown", enable = false})
                    ClearPedTasks(playerPed)
                end
            end
        else 
            display = false
            forstatus = false
            SendNUIMessage({type = "show-countdown", enable = false})
        end

        Citizen.Wait(sleepThread)
    end
end)

Citizen.CreateThread(function()
    while true do
        playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos and not display and RZ.EnabelAutoKick == true then
               
				if time > 0 then
                    print(time)
					if time == math.ceil(RZ.TimeKick*60 / 4) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1You'll be kicked in " .. time .. " seconds for being AFK!")
					end

					time = time - 1
				else
					TriggerServerEvent(GenName(':sv:KickPlayer'))
				end
			else
				time = RZ.TimeKick*60
			end

			prevPos = currentPos
		end
        Citizen.Wait(1*sec)
    end
end)

Run_CountDown = function()
    playSec = 60
    playMinute = RZ.Reward.TimeReward - 1
    if forstatus then
        SendNUIMessage({type = "show-countdown", enable = true})
    end
    
    while forstatus do
        Wait(1000)
        playSec = playSec - 1
        -- print(playSec)
        if playSec == 0 then
            if playMinute == 0 then
                playSec = 60
                playMinute = RZ.Reward.TimeReward - 1
                TriggerServerEvent(GenName(':sv:Giveitem'))
            else
                playSec = 59
                playMinute = playMinute - 1
            end

        end
        SendNUIMessage({
            type = "update",
            Sec = playSec,
            Minute = playMinute
        })
    end
end

ForStatus = function()
    Citizen.SetTimeout(5*1000,function()
        if forstatus then
            local playerPedId = PlayerPedId()
            TriggerEvent('esx_status:set', 'hunger', tonumber(hunger))
            TriggerEvent('esx_status:set', 'thirst', tonumber(thirst)) 
            TriggerEvent('esx_status:set', 'stress', tonumber(stress)) 
            SetEntityHealth(playerPedId, hp)  
            ForStatus()
        end
    end)
end

RegisterNUICallback('close', function()
    display = false
    forstatus = false
    playSec = 0
    playMinute = 0
    SetNuiFocus(false, false)
    FreezeEntityPosition(PlayerPedId(), false) 
end)

RegisterNUICallback('getstatus',function(data)
    SetNuiFocus(false, false)
    if data.key == 1 then
        local playerPed = PlayerPedId()
        local ran =  math.random(1,#RZ.Animation)
        LoadAnimDict(RZ.Animation[ran].lib)
        TaskPlayAnim(PlayerPedId(), RZ.Animation[ran].lib ,RZ.Animation[ran].anim ,2.0, 2.0, -1, 1, 0, false, false, false)
        RemoveAnimDict(RZ.Animation[ran].lib)
        forstatus = true
        ForStatus()
        Run_CountDown()
        
    elseif data.key == 2 then
        TriggerEvent('renzer_Afk:openmenu')
        forstatus = true
        ForStatus()
        Run_CountDown()
    elseif data.key == 3 then
        forstatus = true
        ForStatus()
        Run_CountDown()
    end
end)