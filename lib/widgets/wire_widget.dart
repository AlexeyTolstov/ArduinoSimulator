import 'package:arduino_simulator_test/data/wire.dart';
import 'package:arduino_simulator_test/styles/contact.dart';
import 'package:flutter/material.dart';

class WireWidget extends StatelessWidget {
  final Wire wire;
  final void Function(Wire) onTap;

  const WireWidget({
    super.key,
    required this.wire,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: wire.firstCoord.x + (ContactStyle.borderSize / 2),
      top: wire.firstCoord.y + (ContactStyle.borderSize / 2),
      child: Transform.rotate(
        angle: wire.getAngle(),
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () => onTap(wire),
          child: Container(
            width: wire.getHypotenuse(),
            height: 3,
            color: Colors.red,
          ),
        ),
      )
    );
  }
}