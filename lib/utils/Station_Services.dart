// ignore_for_file: unused_local_variable

//# Hundler for all changable value related to Station
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navi/assets/LineLists.dart';
import 'package:navi/utils/location/sevice.dart';
import 'station.dart';
import 'package:navi/assets/LineLists.dart';
import 'package:bloc/bloc.dart';



class StationBloc{}

class StationState {
  final Line theLine;
  final Station nearest;  //The nearst Station or the Currunt  
  final Station targetStation; //The Station to notificate when arrived
  final bool isArrived = false;
  StationState(this.theLine, this.nearest, this.targetStation);
}




class GetStation extends Bloc<StationBloc, StationState> {
  
  @override
  Blo

  Stream<Station?> station() async* {
    Geolocator.getPositionStream(locationSettings: LocationSettings(accuracy: LocationAccuracy.medium,distanceFilter: 10)).listen((postion){
       for(final station in theLine.stations){
          if(near(postion, station.stationLocation) < 500){
            if (station == targetStation){isArrived = true;}
            yield station;
          }
        }
    }}
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