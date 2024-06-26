// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navi/assets/LineLists.dart';
import 'package:navi/utils/Station_Services.dart';
import 'package:navi/utils/i_widgets.dart';
import 'package:navi/utils/location/sevice.dart';
import 'package:navi/utils/station.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navi/utils/style/Station_widget.dart';
import 'package:url_launcher/url_launcher.dart';


//define GetStation Object.
late GetStation getStation; 


class BusLine extends StatefulWidget {
  const BusLine({super.key});

  @override
  State<BusLine> createState() => _BusLineState();
}

class _BusLineState extends State<BusLine> {
  

  @override
  void initState() {
    super.initState();
    getLocation().then((postion){
      final line = checkLine(postion);
      getStation = GetStation(line!);
      
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ViewBusLine(line:getStation.theLine)),
    );
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






class ViewBusLine extends StatelessWidget {
  const ViewBusLine({super.key, required this.line});
  final Line line;
  

 
  @override
  Widget build(BuildContext context) {
    //EXp:
    return Scaffold(
      body: Center(
          child: CustomPaint(
        painter: BoxPainter(),
        child: StreamBuilder<Station?>(
          stream: getStation.station(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: line.stations.length,
              itemBuilder: (context, index) {
                print(snapshot.data?.name);
                final station = line.stations[index];
                // -------------------------------------
                //--get map url for station Loction
                final lat = station.stationLocation.latitude;
                final lng = station.stationLocation.longitude;
                final mapURL = Uri.parse('https://maps.google.com/?q=$lat,$lng');
                //---------------------------------
                final f;
                //get state of station to style Station Container
                
                return Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StationBox(station:station, getStation: getStation),
                    const SizedBox(height: 90),
                  ],
                );
              }
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
  ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5.0);

    final startX = size.width / 2;
    final startY = 0.0;
    final endY = size.height;

    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), glowingPaint);
    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), solidPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
