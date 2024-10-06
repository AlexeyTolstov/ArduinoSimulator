import 'package:arduino_simulator_test/data/wire.dart';
import 'package:flutter/material.dart';

class WireWidget extends StatelessWidget {
  final Wire wire;
  void Function(Wire) onTap;

  WireWidget({
    super.key,
    required this.wire,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: wire.firstCoord.x,
      top: wire.firstCoord.y,
      
      child: Transform.rotate(
        angle: wire.getAngle(),
        child: GestureDetector(
          onTap: () {
            onTap(wire);
          },
          child: Container(
            width: wire.getHypotenuse(),
            height: wire.strokeWidth,
            color: wire.wireColor,
          ),
        ),
      )
    );
  }
}