import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:world_time/services/Locations.dart';

class loading extends StatefulWidget {

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading>
{
  
  void setUpWorldTime() async
  {
    Locations location = Locations();
    await location.initializationDone;
    WorldTime instance = await location.getLocationInfo();
    // WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDaytime': instance.isDaytime
    });
  }



  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
