class Loca {
  double latitude;
  double longitude;

  Loca(this.latitude, this.longitude);
}

class Station {
  String name;
  int type;
  int number;
  String arName;
  Loca stationLocation;

  Station({
    required this.name,
    required this.arName,
    required this.number,
    required this.type,
    required this.stationLocation, required String Rd,
  });
}
// void main() {
//   // Example usage
//   Loca myLocation = Loca(0.0, 0.0); // Replace with your actual location

//   List<Station> stations = line11;

//   double thresholdDistance =
//       100.0; // Set your desired distance threshold in kilometers

//   bool isNearStation = LocationChecker.isLocationNearStation(
//       myLocation, stations, thresholdDistance);
//   print('Is my location near a station? $isNearStation');
// }




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