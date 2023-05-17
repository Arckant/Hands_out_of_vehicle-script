RegisterCommand('anim', function(player, source)
  local dictName = 'hands@out@generic@ps'
  local animName = 'clip'
  print('1')
  -- Request animation dictionary.
  RequestAnimDict(dictName)
  while not HasAnimDictLoaded(dictName) do
    Wait(1)
  end

  -- Play animation on player ped.
  local playerPed = PlayerPedId()
  TaskPlayAnim(playerPed, dictName, animName, 4.0, 4.0, -1, 1, 0.0)

  -- Unload animation dictionary.
  RemoveAnimDict(dictName)
end, false)

player = GetPlayerPed()
emotes = {
          'hands@out@generic@ds', 
          'hands@out@generic@ps', 
          'hands@out@low@ds', 
          'hands@out@low@ps'}

Citizen.CreateThread(function()
  while true do
    if IsControlPressed(1, 289) then
      ClearPedTasks(player);
    end

    if IsControlJustPressed(1, 288) then
      if IsPedSittingInAnyVehicle(player) then
        TaskPlayAnim(player, emotes[anim_type()], 'clip', 4.0, 4.0, -1, 1, 0.0)
      end
    end
    Citizen.Wait(0)
  end
end)



function anim_type()
  if player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), -1) then
    if GetVehicleClass(GetVehiclePedIsIn(player)) == 'super' then
      return 3;
    end
    return 1;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 0) then
    if GetVehicleClass(GetVehiclePedIsIn(player)) == 'super' then
      return 4;
    end
    return 2;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 1) then
    if GetVehicleClass(GetVehiclePedIsIn(player)) == 'super' then
      return 3
    end
    return 1;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 2) then
    if GetVehicleClass(GetVehiclePedIsIn(player)) == 'super' then
      return 4;
    end
    return 2;
  else
    return error
  end
end
