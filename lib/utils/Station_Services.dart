// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navi/assets/LineLists.dart';
import 'package:navi/utils/location/sevice.dart';
import 'station.dart';
import 'package:navi/assets/LineLists.dart';



class GetStation {
  late Position currntLocation;
  late Station nearest;  
  late Line theLine;

  GetStation(this.currntLocation){
    theLine = checkLine(currntLocation)!;
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
}



Future<Station?> station(Line line) async {
  final _loc = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
  for(final station in line.stations){
    if(near(_loc, station.stationLocation) < 500){
      return station;
      }else{
      return null;
     }
    }
  return null;
  }