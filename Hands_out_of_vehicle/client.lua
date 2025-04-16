RegisterCommand("hands_out_of_vehicle", function(source)
	local allowed_veh_class = {
		[0] = true, --Compacts
		[1] = true, --Sedans
		[2] = true, --SUVs
		[3] = true, --Coupes
		[4] = true, --Muscle
		[5] = true, --Sports Classics
		[6] = true, --Sports
		[7] = true, --Super
		--8, --Motorcycles
		[9] = true, --Off-Road
		[10] = true, --Industrial
		[11] = true, --Utility
		[12] = true, --Vans
		--13, --Cycles
		--14, --Boats
		--15, --Helicopters
		--16, --Planes
		[17] = true, --Service
		[18] = true, --Emergency
		[19] = true, --Military
		[20] = true, --Commercial
		--21, --Trains
		--22 --Open Wheels
	}
	local seat_anim_by_index = {
		[1] = "hands@out@low@ds@clip",
		[0] = "hands@out@low@ps@clip"
	}
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  if veh == 0 then return end
  if not allowed_veh_class[GetVehicleClass(veh)] then return end

  local i = 0
  RequestAnimDict("hands_out_of_vehicle")
  while not HasAnimDictLoaded("hands_out_of_vehicle") and i < 30 do
    i = i + 1
    Citizen.Wait(100)
  end
  if not HasAnimDictLoaded("hands_out_of_vehicle") then return end

  local seat_anim_index
  for _i = -1, GetVehicleMaxNumberOfPassengers(veh) - 1 do
    if GetPedInVehicleSeat(veh, _i) == ped then
      seat_anim_index = _i % 2
      break
    end
  end
  if not seat_anim_index then return end

  TaskPlayAnim(ped, "hands_out_of_vehicle", seat_anim_by_index[seat_anim_index], 4.0, 4.0, -1, 17, 0.0)
  RemoveAnimDict("hands_out_of_vehicle")
end)
