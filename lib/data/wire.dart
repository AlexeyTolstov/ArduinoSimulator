import 'dart:math';

import 'package:arduino_simulator_test/data/contact_id.dart';
import 'package:arduino_simulator_test/styles/contact.dart';
import 'package:flutter/material.dart';
import 'package:arduino_simulator_test/data/coord.dart';

class WireContacts {
  final ContactId first;
  final ContactId second;

  bool isRemovingDevice(String nameDevice) {
    return first.nameDevice == nameDevice || second.nameDevice == nameDevice;
  }

  @override
  bool operator ==(covariant WireContacts other) {
    return (other.first == first && other.second == second) ||
        (other.first == second && other.second == first);
  }

  @override
  String toString() => "$first $second";

  WireContacts({required this.first, required this.second});  
}

class Wire {
  final Coordination firstCoord;
  final Coordination secondCoord;

  late final double deltaX;
  late final double deltaY;

  final Color wireColor;
  final double strokeWidth;
  final double sizeIcon;

  @override
  String toString() => "First coordination: $firstCoord\n"
      "Second coordination:  $secondCoord";

  double getHypotenuse() => sqrt(pow(deltaX, 2) + pow(deltaY, 2));
  double getAngle() => atan2(deltaY, deltaX);

  Wire({
    required this.firstCoord,
    required this.secondCoord,
    this.wireColor = Colors.red,
    this.strokeWidth = 3,
    this.sizeIcon = ContactStyle.borderSize,
  }) {
    deltaX = secondCoord.x - firstCoord.x;
    deltaY = secondCoord.y - firstCoord.y;
  }
}
