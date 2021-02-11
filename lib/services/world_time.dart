import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime
{
  String location; //location name for UI
  String time; //time in location
  String flag; //url to asset flag icon
  String url; //location url for api end point
  bool isDaytime;


  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async
  {

    try
    {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // print(datetime);
      // print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));


      //set time property
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false  ;//This is a ternary operator btw
      time = DateFormat.jm().format(now);
    }catch(e)
    {
      print('caught error $e');
      time = 'could not get time data';
    }

  }
}

