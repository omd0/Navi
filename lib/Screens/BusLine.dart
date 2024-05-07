// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navi/assets/LineLists.dart';
import 'package:navi/utils/i_widgets.dart';
import 'package:navi/utils/location/get_url.dart';
import 'package:navi/utils/station.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navi/utils/url_lancher.dart';

class BusLine extends StatefulWidget {
  // const BusLine(List<Station> list, {super.key});
  const BusLine({super.key});


  @override
  State<BusLine> createState() => _BusLineState();
}

class _BusLineState extends State<BusLine> {

  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

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

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
  void _checkLine(BuildContext context, Widget show) async {}
  @override
  void initState() {
    super.initState();
    if(_determinePosition() != Future.error('Location permissions are permanently denied, we cannot request permissions.')){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _BusLine(Line: line11)),
      );
    };
    double ra = Geolocator.distanceBetween(24.788842977639163, 46.664074350029, line11[0].stationLocation.latitude, line11[0].stationLocation.longitude);
      // double ra = calculateDistance(24.79540753186273, 46.671439275646435, line11[0].stationLocation);
    if (kDebugMode) {
      print('NERA:');
      print(ra);
    }
    // Perform any initialization tasks or data fetching here
    // You can use a Future.delayed or async function to simulate loading
  }

  @override
  Widget build(BuildContext contex) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      ),
    );
  }
}

class _BusLine extends StatelessWidget {
  _BusLine({super.key, required this.Line});
  final List<Station> Line;

  @override
  Widget build(BuildContext context) {
    //EXp:
    return Scaffold(
      body: Center(
          child: CustomPaint(
        painter: BoxPainter(),
        child: ListView.builder(
          itemCount: line11.length,
          itemBuilder: (context, index) {
            return Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Location'),
                          content: GestureDetector(onTap:()=>{
                            launchInBrowser(Uri.parse(getMapUrl(Line[index].stationLocation)))
                          },child: Text(getMapUrl(Line[index].stationLocation))),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                      color: Colors.black,
                      width: 2,),),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (Line[index].number.toString()+'B'),
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: 5),
                        Text(
                          (Line[index].name),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 90),
              ],
            );
          }
        ),
      )),
    );
  }
}

class BoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final solidPaint = Paint()
  ..color = Colors.blue // Set the color for the solid stroke
  ..strokeWidth = 10
  ..style = PaintingStyle.stroke;

final glowingPaint = Paint()
  ..color = Colors.yellow // Set the color for the glowing effect
  ..strokeWidth = 10
  ..style = PaintingStyle.stroke
  ..maskFilter = MaskFilter.blur(BlurStyle.solid, 5.0);

    final startX = size.width / 2;
    final startY = 0.0;
    final endY = size.height;

    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), glowingPaint);
    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), solidPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
