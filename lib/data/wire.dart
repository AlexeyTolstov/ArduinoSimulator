import 'dart:math';

import 'package:flutter/material.dart';
import 'package:arduino_simulator_test/data/coord.dart';


class Wire {
  final Coordination firstCoord;
  final Coordination secondCoord;

  late final double deltaX;
  late final double deltaY;

  final Color wireColor;
  final double strokeWidth;
  final double sizeIcon;

  @override
  String toString() =>  "First coordination: $firstCoord\n"
                        "Second coordination:  $secondCoord";

  double getHypotenuse() => sqrt(pow(deltaX, 2) + pow(deltaY, 2));
  double getAngle() => atan2(deltaY, deltaX);

  Wire({
    required this.firstCoord,
    required this.secondCoord,
    this.wireColor = Colors.red,
    this.strokeWidth = 5,
    this.sizeIcon = 14,
  }){
    deltaX = secondCoord.x - firstCoord.x + sizeIcon;
    
    deltaY = secondCoord.y - firstCoord.y + sizeIcon;
    print("$deltaX");
  }
}