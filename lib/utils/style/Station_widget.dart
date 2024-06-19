// ignore_for_file: unused_import

import 'package:flutter/material.dart';


class StationContainerStyle extends BoxDecoration {
  final String type;
  StationContainerStyle({required this.type}) : super(
          color: Color(0xffd9d9d9),
          borderRadius: _vars(type)[0],
          border: Border.all(
          color: _vars(type)[2],
          width: 4,)
        );
  static dynamic _vars(String type){
    switch (type){
      case '': return [BorderRadius.circular(10), 4, Colors.black];
      case 'selected': return [BorderRadius.circular(15), 4, Color(0xff3BD433)];
      case 'target': []; 

    }
  }
}
