import 'package:arduino_simulator_test/data/contact.dart';
import 'package:arduino_simulator_test/data/device.dart';
import 'package:arduino_simulator_test/styles/colors.dart';
import 'package:arduino_simulator_test/widgets/contact_widget.dart';
import 'package:flutter/material.dart';

class DeviceWidget extends StatelessWidget {
  final Device device;

  const DeviceWidget({
    super.key,
    required this.device
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Stack(
        children: [
          device.image,
          
          ...device.contacts.map((Contact c) {
            return ContactWidget(
              contactData: c,
              selectedContactColor: AppColors.selectedContactColor,
              unselectedContactColor: AppColors.unselectedContactColor
            );
          }),
        ],
      ),
    );
  }
}