import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navi/utils/station.dart';

Future<Position> getLocation() async {
  bool serviceEnabled;
  // Test if location services are enabled.
  serviceEnabled = await getPremision();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');

  }

 
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


Future<bool> getPremision() async{
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 


    return serviceEnabled;

}

double near(dynamic position1, dynamic position2, {double max = 200}){
  double startLatitude,startLongitude, endLatitude,endLongitude;
  startLatitude = position1.latitude;
  startLongitude = position1.longitude;

  endLatitude = position2.latitude;
  endLongitude = position2.longitude;

  // if (kDebugMode) {
  //   print(startLongitude);
  //   print(startLatitude);

  // }
  
  double distance = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  return distance;
}