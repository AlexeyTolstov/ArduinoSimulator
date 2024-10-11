import 'package:arduino_simulator_test/data/contact.dart';
import 'package:arduino_simulator_test/styles/contact.dart';
import 'package:flutter/material.dart';


class ContactWidget extends StatelessWidget {
  final Contact contactData;

  final Color selectedContactColor;
  final Color unselectedContactColor;

  const ContactWidget({
    super.key,
    required this.contactData,
    required this.selectedContactColor,
    required this.unselectedContactColor
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: contactData.pos.left,
      right: contactData.pos.right,
      bottom: contactData.pos.bottom,
      top: contactData.pos.top,
      
      child: GestureDetector(
        onTap: contactData.onTap,

        child: Stack(
          children: [
            Icon(
              ContactStyle.shape,
              size: ContactStyle.size + ContactStyle.border,
              color: contactData.isSelected 
                ? selectedContactColor
                : unselectedContactColor,
            ),
            const Positioned(
              top: 2,
              left: 2,
              child: Icon(
                ContactStyle.shape,
                size: ContactStyle.size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}