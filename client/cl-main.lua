local function getVehiclePassengers(vehicle)
    local passengersTable = {}
    local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))
    for seat = -1, maxSeats - 1 do
        local passenger = GetPedInVehicleSeat(vehicle, seat)

        if passenger and passenger ~= 0 then
            local index = NetworkGetPlayerIndexFromPed(passenger)
            local serverId = GetPlayerServerId(index)
            table.insert(passengersTable, {
                seat = seat,
                serverId = serverId
            })
        end
    end
    return passengersTable
end

local function switch(bucket, coords)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local vehiclePassengers = nil
    local netVehicle = nil

    if DoesEntityExist(vehicle) then
        vehiclePassengers = getVehiclePassengers(vehicle)
        netVehicle = NetworkGetNetworkIdFromEntity(vehicle)
    end

    TriggerServerEvent('rflx_bucketswitch:switch', bucket, vehiclePassengers, coords, netVehicle)
end

exports('switch', switch)
