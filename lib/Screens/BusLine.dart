// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navi/assets/LineLists.dart';
import 'package:navi/utils/i_widgets.dart';
import 'package:navi/utils/location/get_url.dart';
import 'package:navi/utils/location/sevice.dart';
import 'package:navi/utils/station.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navi/utils/url_lancher.dart';

class BusLine extends StatefulWidget {
  const BusLine({super.key});

  @override
  State<BusLine> createState() => _BusLineState();
}

class _BusLineState extends State<BusLine> {

  Future<List<Station>> _checkLine(BuildContext context) async {
    Position location = await getLocation();
    for (final line in Lines ){
      for (final station in line){
        print(station);
        if ((near(location,station.stationLocation)) < 350){
          if (kDebugMode) {
            print('distance for nearest station');
            print(near(location,station.stationLocation));
          }
          return line;
        }
      }
    }; 
    return [];
  }
  @override
  void initState() {
    super.initState();
    _checkLine(context).then((value){
      if (value.isNotEmpty){
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _BusLine(Line:value)),
      );
      };
    });

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      ),
    );
  }
}

class _BusLine extends StatelessWidget {
  _BusLine({super.key, required this.Line});
  final List<Station>? Line;

  @override
  Widget build(BuildContext context) {
    //EXp:
    return Scaffold(
      body: Center(
          child: CustomPaint(
        painter: BoxPainter(),
        child: ListView.builder(
          itemCount: Line?.length,
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
                            launchInBrowser(Uri.parse(getMapUrl(Line![index].stationLocation)))
                          },child: Text(getMapUrl(Line![index].stationLocation))),
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
                          (Line![index].number.toString()+'B'),
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: 5),
                        Text(
                          (Line![index].name),
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
