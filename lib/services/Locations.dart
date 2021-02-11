import 'package:world_time/services/world_time.dart';
import 'package:world_time/services/DBAccess.dart';

class Locations
{
  List<WorldTime> _locations;
  String _currLocation;
  WorldTime _curr;
  Future _initDone;

  Locations()
  {
    _locations = [
      WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
      WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
      WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
      WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
      WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
      WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
      WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
      WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
      WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin'),

    ];

    _initDone = _getCurrLocation();
    // Future get initializationDone
  }

  Future<void> updateLocation(String new_location)
  {
    DBAccess.db.update(_currLocation, {"location": new_location});
  }

  Future<WorldTime> getLocationInfo() async
  {
    return await _curr;
  }

  Future _getCurrLocation() async
  {
    List<Map<String, dynamic>> list = await DBAccess.db.getAllRows();
    _currLocation = list[0]['location'];

    for(int i = 0; i < _locations.length; ++i)
    {
      if(_currLocation == _locations[i].location)
        {
          _currLocation = _locations[i].location;
          _curr = _locations[i];
          // return _locations[i];
        }
    }
  }

  List<WorldTime> getList()
  {
    return _locations;
  }

  void dummy()
  {
    print(_currLocation);
  }

  Future get initializationDone => _initDone;
}
