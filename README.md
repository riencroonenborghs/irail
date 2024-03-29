# Ruby implementation for the iRail API (http://project.irail.be/wiki/API/APIv1) #

## Stations ##
```
stations = Irail::Station.all
```

Returns list of stations.


## Connections ##
```
connections = Irail::Connection::Connection.departures('Diest', 'Oostende', Time.parse('2014 June 09, 08:00:00'))
```

Returns departures only.

See API documentation for details.

```
connections = Irail::Connection::Connection.arrivals('Diest', 'Oostende', Time.parse('2014 June 09, 08:00:00'))
```

Returns arrivals only.

See API documentation for details.


## Liveboard ##
```
boards = Irail::Liveboard::Liveboard.departures('Diest', Time.parse('2014 June 09, 08:00:00'))
```

Returns departures only.

See API documentation for details.

```
boards = Irail::Liveboard::Liveboard.arrivals('Diest', Time.parse('2014 June 09, 08:00:00'))
```

Returns arrivals only.

See API documentation for details.


## Vehicle ##
```
vehicle = Iral::Vehicle::Vehicle.find('BE.NMBS.IC1843')
```

Returns vehicule info with stops.

See API documentation for details.


## TODO ##
* connections needs a ; separated list of transport types
* language support


## Comments ##
* Liveboard only takes the name of a station, not the ID of a vehicle
* Vehicle and Liveboard calls are set with fast=true options. See API docs.

"Because of the recent changes in the internal system we were not able to link every station to a geolocation and internal id. Therefore we had to write a very slow workaround for this. If you 
don't need geocoordinates or the id, add: &fast=true to your URL."