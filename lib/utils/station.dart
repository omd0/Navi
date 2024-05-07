import 'dart:math';

import 'package:navi/assets/LineLists.dart';

class Loc {
  double latitude;
  double longitude;

  Loc(this.latitude, this.longitude);
}

class Station {
  String name;
  int type;
  int number;
  String arName;
  Loc stationLocation;

  Station({
    required this.name,
    required this.arName,
    required this.number,
    required this.type,
    required this.stationLocation,
  });
}

class LocationChecker {
  static double calculateDistance(Loc location1, Loc location2) {
    const int earthRadiusKm = 6371; // Radius of the earth in kilometers

    double lat1 = location1.latitude;
    double lon1 = location1.longitude;
    double lat2 = location2.latitude;
    double lon2 = location2.longitude;

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadiusKm * c;

    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  static bool isLocationNearStation(
      Loc myLocation, List<Station> stations, double thresholdDistance) {
    return stations.any((station) =>
        calculateDistance(myLocation, station.stationLocation) <=
        thresholdDistance);
  }
}

void main() {
  // Example usage
  Loc myLocation = Loc(0.0, 0.0); // Replace with your actual location

  List<Station> stations = line11;

  double thresholdDistance =
      100.0; // Set your desired distance threshold in kilometers

  bool isNearStation = LocationChecker.isLocationNearStation(
      myLocation, stations, thresholdDistance);
  print('Is my location near a station? $isNearStation');
}




// 0 Not Working
// 1 one Way
// 2 two ways
// 3 Terminal


// عرض جميع المحطات
// الملك عبدالعزيز 03 أ
// الملك عبدالعزيز 04 أ
// الملك عبدالعزيز 06 أ
// الملك عبدالعزيز 07 أ
// صلاح الدين الأيوبي 11 أ
// صلاح الدين الأيوبي 12 أ
// صلاح الدين الأيوبي 13 أ
// صلاح الدين الأيوبي 14 أ
// صلاح الدين الأيوبي 15 أ
// صلاح الدين الأيوبي 16 أ
// علي بن أبي طالب 17 أ
// علي بن أبي طالب 18 أ
// علي بن أبي طالب 19 أ
// علي بن أبي طالب 20 أ
// الخالدية 22 ب
// الخرج 24 أ
// الخرج 26 أ
// الخرج