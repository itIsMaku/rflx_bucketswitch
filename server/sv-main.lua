local function switch(bucket, vehiclePassengers, coords, netVehicle, client)
    if client == nil then
        client = source
    end
    local passed = true
    local vehicle = NetworkGetEntityFromNetworkId(netVehicle)
    if vehiclePassengers ~= nil then
        for i, passenger in ipairs(vehiclePassengers) do
            if GetPedInVehicleSeat(vehicle, passenger.seat) ~= GetPlayerPed(passenger.serverId) then
                passed = false
            end
        end
    end
    if not passed then
        print('^1Switch failed', client)
        return
    end

    if DoesEntityExist(vehicle) then
        SetEntityCoords(vehicle, coords.x, coords.y, coords.z)
        SetEntityHeading(vehicle, coords.w)

        SetEntityRoutingBucket(vehicle, bucket)

        if vehiclePassengers ~= nil then
            for i, passenger in ipairs(vehiclePassengers) do
                local ped = GetPlayerPed(passenger.serverId)
                SetPlayerRoutingBucket(passenger.serverId, bucket)
                SetPedIntoVehicle(ped, vehicle, passenger.seat)
            end
        end
    else
        local ped = GetPlayerPed(client)
        SetEntityCoords(ped, coords.x, coords.y, coords.z)
        SetEntityHeading(ped, coords.w)

        SetPlayerRoutingBucket(client, bucket)
    end
end

RegisterNetEvent('rflx_bucketswitch:switch', switch)
exports('switch', switch)
