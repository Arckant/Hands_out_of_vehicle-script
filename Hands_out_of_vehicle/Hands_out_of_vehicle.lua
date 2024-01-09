local veh_class = {
	'0', --Compacts
	'1', --Sedans
	'2', --SUVs
	'3', --Coupes
	'4', --Muscle
	'5', --Sports Classics
	'6', --Sports
	'7', --Super
	--'8', --Motorcycles
	'9', --Off-Road
	'10', --Industrial
	'11', --Utility
	'12', --Vans
	--'13', --Cycles
	--'14', --Boats
	--'15', --Helicopters
	--'16', --Planes
	'17', --Service
	'18', --Emergency
	'19', --Military
	'20', --Commercial
	--'21', --Trains
	--'22' --Open Wheels
}

local seat_anim = {
	[-1] = 'hands@out@low@ds@clip',
	[0] = 'hands@out@low@ps@clip',
	[1] = 'hands@out@low@ds@clip',
	[2] = 'hands@out@low@ps@clip',
}

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function seat(player)
  if player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), -1) then
    return -1;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 0) then
    return 0;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 1) then
    return 1;
  elseif player == GetPedInVehicleSeat(GetVehiclePedIsIn(player), 2) then
    return 2;
  else
    return nil
  end
end

RegisterCommand('Hands_out_of_vehicle', function(source)
	if IsControlJustPressed(1, 288) then --F1 - Start animation
		if IsPedSittingInAnyVehicle(GetPlayerPed(source)) and table.contains(veh_class, tostring(GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(source))))) then
			RequestAnimDict('hands_out_of_vehicle')
			while not HasAnimDictLoaded('hands_out_of_vehicle') do
				Wait(1)
			end
			TaskPlayAnim(GetPlayerPed(source), 'hands_out_of_vehicle', seat_anim[seat(GetPlayerPed(source))], 4.0, 4.0, -1, 17, 0.0)
			RemoveAnimDict('hands_out_of_vehicle')
		end
end)
