player = GetPlayerPed()
emotes = {
  'hands@out@generic@ds', 
  'hands@out@generic@ps', 
  'hands@out@low@ds', 
  'hands@out@low@ps'}
clips = {
  'hands@out@generic@ds@clip', 
  'hands@out@generic@ps@clip', 
  'hands@out@low@ds@clip', 
  'hands@out@low@ps@clip'}
  
Citizen.CreateThread(function()
  while true do
    if IsControlPressed(1, 289) then
      ClearPedTasks(player);
    end

    if IsControlJustPressed(1, 288) then
      if IsPedSittingInAnyVehicle(player) then
        RequestAnimDict(emotes[anim_type()])
        while not HasAnimDictLoaded(emotes[anim_type()]) do
          Wait(1)
        end
        TaskPlayAnim(player, emotes[anim_type()], clips[anim_type()], 4.0, 4.0, -1, 1, 0.0)
        RemoveAnimDict(emotes[anim_type()])
        TriggerEvent('chat:addMessage', {
          color = { 255, 0, 0},
          multiline = true,
          args = {emotes[anim_type()], clips[anim_type()]}
        })
      end
    end
    RemoveAnimDict(emotes[anim_type()])
    Citizen.Wait(1)
  end
end)



function anim_type()
  if player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), -1) then
    if GetVehicleClass(GetVehiclePedIsIn(player)) == 7 then
      return 3;
    end
    return 1;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 0) then
    if GetVehicleClass(GetVehiclePedIsIn(player)) == 7 then
      return 4;
    end
    return 2;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 1) then
    if GetVehicleClass(GetVehiclePedIsIn(player)) == 7 then
      return 3
    end
    return 1;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 2) then
    if GetVehicleClass(GetVehiclePedIsIn(player)) == 7 then
      return 4;
    end
    return 2;
  else
    return error
  end
end
