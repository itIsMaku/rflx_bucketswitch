# rflx_bucketswitch
simple util for switching routing buckets with the vehicle and its passengers

## Usage
### Client
```lua
exports['rflx_bucketswitch']:switch(number bucket, vector4 coords)
```

### Server
```lua
exports['rflx_bucketswitch']:switch(number bucket, table vehiclePassengers, vector4 coords, number netVehicle, number client)
```
