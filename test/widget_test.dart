// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navi/assets/LineLists.dart';

import 'package:navi/main.dart';

import 'dart:math';

import 'package:location/location.dart';
import 'package:navi/utils/station.dart';

void main() {
  double ra = calculateDistance(24.79540753186273, 46.671439275646435, line11[0].stationLocation);
  print(ra);

}



double calculateDistance(double lat1,double lon1,Loca target) {

    const int earthRadius = 6371000; // Radius of the Earth in meters
    // double? lat1 = currentLocation.latitude; 
    // double? lon1 = currentLocation.longitude;
    
    double? lat2 = target.latitude;
    double? lon2 = target.longitude;
    double latDistance = (lat2 - lat1!).abs();
    double lonDistance = (lon2 - lon1!).abs();

    double a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(lat1) * cos(lat2) * sin(lonDistance / 2) * sin(lonDistance / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
}
