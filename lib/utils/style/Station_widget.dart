// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navi/utils/Station_Services.dart';
import 'package:navi/utils/station.dart';
import 'package:url_launcher/url_launcher.dart';


class StationContainerStyle extends BoxDecoration {
  final String type;
  StationContainerStyle({required this.type}) : super(
          color: Color(0xffd9d9d9),
          borderRadius: _vars(type)[0],
          border: Border.all(
          color: _vars(type)[2],
          width: _vars(type)[1])
        );
  static dynamic _vars(String type){
    switch (type){
      case '': return [BorderRadius.circular(10), 4.0, Colors.black];
      case 'target': return [BorderRadius.circular(15), 10.0, Color(0xff3BD433)];
      case 'arrived': return [BorderRadius.circular(10), 10.0, Color.fromARGB(255, 36, 85, 249)];
      case 'current': return [BorderRadius.circular(20), 6.0, const Color.fromARGB(255, 62, 62, 62)];

    }
  }
}






class StationBox extends StatefulWidget {
  final Station station;
  final GetStation getStation;
  const StationBox({super.key, required this.station, required this.getStation});

  @override
  State<StationBox> createState() => _StationBoxState();
}

class _StationBoxState extends State<StationBox> {
  @override
  Widget build(BuildContext context) {
    String state(){
        if(widget.station == widget.getStation.targetStation && widget.station == widget.getStation.nearest){
            return 'arrived';
          }else if(widget.station == widget.getStation.targetStation){
            return 'target';
          }else if(widget.station == widget.getStation.nearest){
            return 'current';
          }else{
            return '';
          }
      }
      if (kDebugMode) {
        print(state());
      }
    return GestureDetector(
                      onTap: () {setState((){widget.getStation.targetStation = widget.station;});},
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            
                            return AlertDialog(
                              title: const Text('Location'),
                              content: GestureDetector(onTap:() => launchUrl(Uri.base),child:
                              Column(  
                                mainAxisSize: MainAxisSize.min,
                                children: [Text('${widget.station.name} ${widget.station.number}')])),
                              actions: [
                                TextButton(
                                  child: const Text('Select'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    
                                  },
                                ),
                                TextButton(
                                  child: const Text('Close'),
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
                          decoration: StationContainerStyle(type: state()),
                          child: StationBoxColumn(
                            number: '${widget.station.number}B',
                            name: widget.station.name,
                          ),
                        ),
    );
  }
}



class StationBoxColumn extends StatelessWidget {
  final String number;
  final String name;

  const StationBoxColumn({
    super.key,
    required this.number,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
// class StationBox extends Container(
//   StationBox() : super(
//                         https://www.youtube.com/watch?v=L724cYJ7SZk #out of context