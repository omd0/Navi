// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navi/assets/LineLists.dart';
import 'package:navi/utils/location/sevice.dart';
import 'station.dart';
import 'package:navi/assets/LineLists.dart';



class GetStation {
  late Line theLine;
  late Station nearest;  //The nearst Station or the Currunt  
  late Station targetStation; //The Station to notificate when arrived
  bool isArrived = false; 


  Stream<Station?> station() async* {
    final loc = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    for(final station in theLine.stations){
        if(near(loc, station.stationLocation) < 500){
          if (station == targetStation){isArrived = true;}
          yield station;
        }
      }
  }
  
  // Stream<bool> arrived(){
  //   yield isArrived;
  // }

  GetStation(Line line){
    theLine = line;
  }

   
}







  Line? checkLine(location) { 
    for (final line in Lines ){
      for (final station in line.stations){
        if ((near(location,station.stationLocation)) < 350){
          if (kDebugMode) {
            print('Distance to nearest station');
            print(near(location,station.stationLocation));
            return line;
          }
        }
      }
    }; 
    return Line11;
  }