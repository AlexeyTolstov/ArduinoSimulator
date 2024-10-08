import 'package:arduino_simulator_test/data/wire.dart';
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
      left: wire.firstCoord.x - (wire.sizeIcon / 2),
      top: wire.firstCoord.y - (wire.sizeIcon / 2),
      child: Transform.rotate(
        angle: wire.getAngle(),
        alignment: Alignment.topLeft,
        child: Container(
          width: wire.getHypotenuse(),
          height: 3,
          color: Colors.red,
        ),
      )
    );
  }
}