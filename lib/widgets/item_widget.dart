import 'package:arduino_simulator_test/data/device.dart';
import 'package:arduino_simulator_test/styles/widgets_styles.dart';
import 'package:flutter/material.dart';


class ItemWidget extends StatelessWidget {
  final Device device;

  const ItemWidget({
    super.key,
    required this.device
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: device.image
          ),
          Expanded(
            child: Text(
              device.title,
              style: AppTextStyles.itemWidgetTitle,
            ), 
          )
        ],
      ),
    );
  }
}